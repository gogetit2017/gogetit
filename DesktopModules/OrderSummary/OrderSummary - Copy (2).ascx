﻿<%@  Control Language="C#" AutoEventWireup="true" CodeBehind="OrderSummary.ascx.cs" Inherits="GoGetIt.OrderSummary" %>

<script src="/js/jquery.validator.min.js" type="text/javascript"></script>

<link href="/js/AlertModal.css" rel="stylesheet" type="text/css" />
<script src="/js/GoGetIt.js"></script>



<style>
    .OrderSummaryBG .form-control {
        width: 100%;
        float: left;
        max-width: 150px;
        margin: auto auto 20px 10px;
        background-color: transparent;
        color: #fff;
        border-radius: 0px;
    }
    .osPointYellowText {
        clear:both;
    }

    #txtOrderDescription {
        width: 100%;
        float: left;
        max-width: 225px;
    }

    .osPointYellowText a {
        cursor: pointer;
    }

    #ddlCCExpMonth,
    #ddlCCExpYear {
        appearance: none;
        -moz-appearance: none;
        -webkit-appearance: none;
        background: url("/images/OrderPageDropdown.png") no-repeat scroll right center;
        background-color: #413E3F;
        width: 90px;
        height: 42px;
        float: left;
    }

    #ddlPickUpZip {
        appearance: none;
        -moz-appearance: none;
        -webkit-appearance: none;
        background: url("/images/OrderPageDropdown.png") no-repeat scroll right center;
        background-color: #413E3F;
    }
</style>



<script type="text/javascript">
    var vrOrderID = '<%=GetFromQueryString("OrderID") %>';
    var vrUserID = '<%=LOGGEDINUSERID %>';

    $(document).ready(function () {
        $("#dvSaveOrderBtn").show();
        LoadOrderDetails();
        document.getElementById("aTOS").setAttribute("href", "/TOS?OrderID=" + vrOrderID);
        document.getElementById("aPrivacyPolicy").setAttribute("href", "/PrivacyPolicy?OrderID=" + vrOrderID);
    });


</script>

<%--Load  Order Details--%>
<script type="text/javascript">
    function LoadOrderDetails() {
        $.ajax({
            type: "GET",
            url: "/DesktopModules/GoGetIt/API/Order/Get?OrderID=" + vrOrderID,
            cache: false,
            contentType: "application/json",
            success: onSuccessLoadOrderDetails,
            error: onErrorLoadOrderDetails
        });
    }
    function onSuccessLoadOrderDetails(result) {
        var o = eval(result);
        if (o.success == true) {
            //vrUserID = o.data.UserID;
            LoadCreditCard();
            $("#txtPickUpName").val(o.data.PickUpName);
            $("#txtPickUpAddress").val(o.data.GRI_Address.Address1);
            $("#txtPickUpApt").val(o.data.GRI_Address.Address2);
            $("#ddlPickUpZip").val(o.data.GRI_Address.GRI_ZipCode.ZipCodeID);

            $("#txtOrderDescription").val(o.data.Details);
            $("#txtDeliveryName").val(o.data.DeliveryName);
            $("#txtDeliveryAddress").val(o.data.GRI_Address1.Address1);
            $("#txtDeliveryApt").val(o.data.GRI_Address1.Address2);
            $("#txtDeliveryZip").val(o.data._DeliverZip);

            $("#dvDeliveryType").html(o.data.DeliveryType);
            $("#dvPickUpLocation").html(GetLowerCharacters(o.data.PickUpName + " " + o.data.GRI_Address.Address1 + " " + o.data.GRI_Address.Address2 + ", " + o.data.GRI_Address.GRI_ZipCode.GRI_City.Name) + ", " + o.data.GRI_Address.GRI_ZipCode.GRI_City.GRI_State.Abbreviation + " " + GetLowerCharacters(o.data.GRI_Address.GRI_ZipCode.ZipCode));

            $("#dvDeliveryDetail").html(o.data.Details);
            $("#dvDeliveryAddress").html(GetLowerCharacters(o.data.DeliveryName + " " + o.data.GRI_Address1.Address1 + " " + o.data.GRI_Address1.Address2 + ", " + o.data.GRI_Address1.GRI_ZipCode.GRI_City.Name) + ", " + o.data.GRI_Address1.GRI_ZipCode.GRI_City.GRI_State.Abbreviation + " " + GetLowerCharacters(o.data.GRI_Address1.GRI_ZipCode.ZipCode));

        }
        else {
            $("#dvDeliveryType").html('<div>could not load delivery type.</div>');
            $("#dvPickUpLocation").html('<div>could not load pickup location.</div>');
            $("#dvDeliveryDetail").html('<div>could not load delivery detail.</div>');
            $("#dvDeliveryAddress").html('<div>could not load delivery address.</div>');
        }
    }
    function onErrorLoadOrderDetails(result) {
        if (result.status == 200) {
            onSuccessLoadOrderDetails(result);
        }
    }

</script>

<%--Load Credit Card--%>
<script type="text/javascript">
    function LoadCreditCard() {
        $.ajax({
            type: "Get",
            url: "/DesktopModules/GoGetIt/API/CreditCard/List?UserID=" + vrUserID,
            cache: false,
            contentType: "application/json",
            success: onSuccessLoadCreditCard,
            error: onErrorLoadCreditCard
        });
    }
    function onSuccessLoadCreditCard(result) {
        var o = eval(result);
        if (o.success == true) {
            $('#dvEditPaymentMethod').hide();
            $('.dvPaymentMethod').show();
            $("#dvCreditCardList").html(o.data[0].CardType + ': xxxx xxxx xxxx ' + o.data[0].CardLastFourDigit);
        }
        else {
            $('#dvEditPaymentMethod').show();
            $('.dvPaymentMethod').hide();
            $("#dvCreditCardList").html('');
            $('#dvUseExistingCC').hide();

        }
    }
    function onErrorLoadCreditCard(result) {
        if (result.status == 200) {
            onSuccessLoadCreditCard(result);
        }
    }
</script>

<%--Save Credit Card--%>
<script type="text/javascript">

    function SaveCreditCard() {
        $("#dvSaveOrderBtn").hide();
        if ($('#dvEditPaymentMethod').css('display') == "block") {
            var validate = new Validator({ validation_group: 'SaveCreditCard', error_class: 'error' });
            validate.validate({
                txtCCNumber: 'Credit card number is required.',
                ddlCCExpYear: 'Expiry year is required.',
                ddlCCExpMonth: 'Expiry month is required',
                txtCCCVV: 'CVV no. is required.',
                txtCCZip: 'Billing Zip code is required.',
            });
            if (validate.error == undefined) {
                $("#dvCreditCardAlertDiv").html('');
            }
            else {
                $("#dvCreditCardAlertDiv").html('<div class="alert alert-error">' + validate.error + '</div>');
                $("#dvSaveOrderBtn").show();
                return false;
            }
            var vCardNumber = $("#txtCCNumber").val();
            var vExpiryYear = $("#ddlCCExpYear").val();
            var vExpiryMonth = $("#ddlCCExpMonth").val();
            var vCVV = $("#txtCCCVV").val();
            var vCardZip = $("#txtCCZip").val();
            var vrCardType = "";
            if (vCardNumber.startsWith('3') == true) {
                vrCardType = 'American Express';
            }
            if (vCardNumber.startsWith('4') == true) {
                vrCardType = 'Visa';
            }
            if (vCardNumber.startsWith('5') == true) {
                vrCardType = 'MasterCard';
            }
            if (vCardNumber.startsWith('6') == true) {
                vrCardType = 'Discover';
            }


            var mcontact = {
                IsPreferredCard: false,
                UserID: vrUserID,
                CardLastFourDigit: vCardNumber,
                CardType: vrCardType,
                ExpirationMonth: vExpiryMonth,
                ExpirationYear: vExpiryYear,
                ZipCode: vCardZip,
                CVV: vCVV,
            };
            var objectAsJson = JSON.stringify(mcontact);

            $.ajax({
                type: "POST",
                url: "/DesktopModules/GoGetIt/API/CreditCard/Save",
                cache: false,
                data: objectAsJson,
                contentType: "application/json",
                success: function (result) {
                    if (result.success) {
                        SaveOrder();
                    }
                    else {
                        $("#dvCreditCardAlertDiv").html('<div class="alert alert-error">' + result.msg + '</div>');
                    }
                },
                error: function (result) {
                    $("#dvCreditCardAlertDiv").html('<div class="alert alert-error">There was an error submitting the form.</div>');
                },
            });
        }
        else {
            SaveOrder();
        }
    }

</script>



<%--Save Order--%>
<script type="text/javascript">
    function SaveOrder() {
        $("#dvSaveOrderBtn").hide();
        var validate = new Validator({ validation_group: 'SaveOrder', error_class: 'error' });
        validate.validate({
            txtPickUpAddress: 'Address is required.',
            txtPickUpName: 'Pickup Name is required.',
            ddlPickUpZip: 'Zip code is required',
            txtOrderDescription: 'Order description is required.',
            txtDeliveryAddress: 'Delivery Address is required.',
            txtDeliveryName: 'Delivery Name is required.',
            txtDeliveryZip: 'Delivery Zip code is required',
        });
        if (validate.error == undefined) {
            $("#dvCreditCardAlertDiv").html('');
        }
        else {
            $("#dvCreditCardAlertDiv").html('<div class="alert alert-error">' + validate.error + '</div>');
            $("#dvSaveOrderBtn").show();
            return false;
        }
        var vPickUpAddress = $("#txtPickUpAddress").val();
        var vPickUpName = $("#txtPickUpName").val();
        var vPickUpApt = $("#txtPickUpApt").val();
        var vtxtPickUpZip = $("#ddlPickUpZip").val();
        var vDescription = $("#txtOrderDescription").val();
        var vDeliveryAddress = $("#txtDeliveryAddress").val();

        var vDeliverName = $("#txtDeliveryName").val();
        var vDeliveryApt = $("#txtDeliveryApt").val();

        var mcontact = {
            OrderID: parseInt(vrOrderID),
            UserID: vrUserID,
            _DeliverZip: $('#txtDeliveryZip').val(),
            GRI_Address: { Address1: vPickUpAddress, Address2: vPickUpApt, ZipCodeID: vtxtPickUpZip },
            GRI_Address1: { Address1: vDeliveryAddress, Address2: vDeliveryApt },
            Details: vDescription,
            DeliveryName: vDeliverName,
            PickUpName: vPickUpName,
        };
        var objectAsJson = JSON.stringify(mcontact);

        $.ajax({
            type: "PUT",
            url: "/DesktopModules/GoGetIt/API/Order/Save?Operation=Edit",
            cache: false,
            data: objectAsJson,
            contentType: "application/json",
            success: onSuccessSaveOrder,
            error: onErrorSaveOrder
        });
    }
    function onSuccessSaveOrder(result) {
        var o = eval(result);
        if (o.success == true) {
            $("#dvCreditCardAlertDiv").html('<div class="alert alert-success">Thank you for your order.</div>');

            $('#modalOrderThankyou').modal('show');
            setTimeout("BackOrderFromSummary();", 3000);
        }
        else {
            $("#dvCreditCardAlertDiv").html('<div class="alert alert-error">There was an error submitting the order.</div>');
        }
    }
    function onErrorSaveOrder(result) {
        if (result.status == 200) {
            onSuccessSaveOrder(result);
        }
    }
    function BackOrderFromSummary() {
        window.location = "/order";
    }
</script>

<div class="OrderSummaryBG">
    <div class="osTopText">Your Order Summary</div>

    <div class="osPointTotal">
        <div class="osPointLeft">
            <img src="/images/OrderSummaryPointOne.png" />
        </div>
        <div class="osPointRight">
            <div class="osPointBigText">Delivery Type:</div>
            <div class="osPointSmallText">
                <div id="dvDeliveryType"></div>
            </div>
        </div>
    </div>

    <div class="osPointTotal">
        <div class="osPointLeft">
            <img src="/images/OrderSummaryPointTwo.png" />
        </div>
        <div class="osPointRight">
            <div class="osPointBigText">Pick-Up Location:</div>
            <div class="dvPickUpLocation">
                <div class="osPointSmallText">
                    <div id="dvPickUpLocation"></div>
                </div>
                <div class="osPointYellowText"><a onclick="$('#dvEditPickUpAddress').show();$('.dvPickUpLocation').hide();">Edit Pick Up Location</a></div>
            </div>
            <div class="dvRow" id="dvEditPickUpAddress" style="display: none;">
                <div class="form-group">
                    <input type="text" class="form-control SavePickUp SaveOrder" id="txtPickUpName" placeholder="Pickup Name">
                    <input type="text" class="form-control SavePickUp SaveOrder" id="txtPickUpAddress" placeholder="Address 1">
                    <input type="text" class="form-control SavePickUp" id="txtPickUpApt" placeholder="Apt/Unit">
                    <select class="form-control SavePickUp SaveOrder" id="ddlPickUpZip">
						<option value="6607">33010</option>
						<option value="6609">33012</option>
						<option value="6610">33013</option>
						<option value="6611">33014</option>
						<option value="6612">33015</option>
						<option value="6613">33016</option>
						<option value="6615">33018</option>
						<option value="6632">33030</option>
						<option value="6633">33031</option>
						<option value="6634">33032</option>
						<option value="6635">33033</option>
						<option value="6636">33034</option>
						<option value="6637">33035</option>
						<option value="6638">33039</option>
						<option value="6639">33090</option>
						<option value="6640">33092</option>
						<option value="6669">33101</option>
						<option value="6671">33106</option>
						<option value="6673">33112</option>
						<option value="6676">33122</option>
						<option value="6678">33125</option>
						<option value="6679">33126</option>
						<option value="6680">33127</option>
						<option value="6681">33128</option>
						<option value="6682">33129</option>
						<option value="6683">33130</option>
						<option value="6684">33131</option>
						<option value="6685">33132</option>
						<option value="6686">33133</option>
						<option value="6687">33134</option>
						<option value="6688">33135</option>
						<option value="6689">33136</option>
						<option value="6690">33137</option>
						<option value="6691">33138</option>
						<option value="6692">33142</option>
						<option value="6693">33143</option>
						<option value="6694">33144</option>
						<option value="6695">33145</option>
						<option value="6696">33146</option>
						<option value="6697">33147</option>
						<option value="6698">33149</option>
						<option value="6699">33150</option>
						<option value="6700">33151</option>
						<option value="6701">33152</option>
						<option value="6702">33153</option>
						<option value="6703">33155</option>
						<option value="6704">33156</option>
						<option value="6705">33157</option>
						<option value="6706">33158</option>
						<option value="6708">33160</option>
						<option value="6709">33161</option>
						<option value="6710">33162</option>
						<option value="6713">33165</option>
						<option value="6714">33166</option>
						<option value="6715">33167</option>
						<option value="6716">33168</option>
						<option value="6717">33169</option>
						<option value="6718">33170</option>
						<option value="6719">33172</option>
						<option value="6720">33173</option>
						<option value="6721">33174</option>
						<option value="6722">33175</option>
						<option value="6723">33176</option>
						<option value="6724">33177</option>
						<option value="6725">33178</option>
						<option value="6726">33179</option>
						<option value="6727">33180</option>
						<option value="6728">33181</option>
						<option value="6729">33182</option>
						<option value="6730">33183</option>
						<option value="6731">33184</option>
						<option value="6732">33185</option>
						<option value="6733">33186</option>
						<option value="6734">33187</option>
						<option value="6735">33188</option>
						<option value="6736">33189</option>
						<option value="6737">33190</option>
						<option value="6738">33193</option>
						<option value="6739">33194</option>
						<option value="6740">33196</option>
						<option value="6742">33199</option>
						<option value="6764">33109</option>
						<option value="6766">33139</option>
						<option value="6767">33140</option>
						<option value="6768">33141</option>
						<option value="6769">33154</option>
						<option value="6775">33054</option>
						<option value="6776">33055</option>
						<option value="6777">33056</option>
                    </select>
                </div>
                <div class="osPointYellowText"><a onclick="$('#dvEditPickUpAddress').hide();$('.dvPickUpLocation').show();">Cancel</a></div>
            </div>
        </div>
    </div>

    <div class="osPointTotal">
        <div class="osPointLeft">
            <img src="/images/OrderSummaryPointThree.png" />
        </div>
        <div class="osPointRight">
            <div class="osPointBigText">Delivery Details:</div>
            <div class="dvDeliveryDetail">
                <div class="osPointSmallText">
                    <div id="dvDeliveryDetail"></div>
                </div>
                <div class="osPointYellowText"><a onclick="$('#dvEditDeliveryDetails').show();$('.dvDeliveryDetail').hide();">Edit Delivery Details</a></div>
            </div>
            <div class="dvRow" id="dvEditDeliveryDetails" style="display: none;">
                <div class="form-group">
                    <textarea class="form-control SaveDeliveryDetails SaveOrder" id="txtOrderDescription" placeholder="Please enter full details of your order..."></textarea>
                </div>
                <div class="osPointYellowText"><a onclick="$('#dvEditDeliveryDetails').hide();$('.dvDeliveryDetail').show();">Cancel</a></div>
            </div>
        </div>
    </div>

    <div class="osPointTotal">
        <div class="osPointLeft">
            <img src="/images/OrderSummaryPointFour.png" />
        </div>
        <div class="osPointRight">
            <div class="osPointBigText">Delivery Address:</div>
            <div class="dvDeliveryAddress">
                <div class="osPointSmallText">
                    <div id="dvDeliveryAddress"></div>
                </div>
                <div class="osPointYellowText"><a onclick="$('#dvEditDeliveryAddress').show();$('.dvDeliveryAddress').hide();">Edit Delivery Destination</a></div>
            </div>
            <div class="dvRow" id="dvEditDeliveryAddress" style="display: none;">
                <div class="form-group">
                    <input type="text" class="form-control SaveDeliveryAddress SaveOrder" id="txtDeliveryName" placeholder="Delivery Name">
                    <input type="text" class="form-control SaveDeliveryAddress SaveOrder" id="txtDeliveryAddress" placeholder="Address 1">
                    <input type="text" class="form-control SaveDeliveryAddress " id="txtDeliveryApt" placeholder="Apt/Unit">
                    <input type="text" class="form-control SaveDeliveryAddress SaveOrder" id="txtDeliveryZip" placeholder="Zip code">
                </div>
                <div class="osPointYellowText"><a onclick="$('#dvEditDeliveryAddress').hide();$('.dvDeliveryAddress').show();">Cancel</a></div>
            </div>
        </div>
    </div>

    <div class="osPointTotal">
        <div class="osPointLeft">
            <img src="/images/OrderSummaryPointFive.png" />
        </div>
        <div class="osPointRight">
            <div class="osPointBigText">Payment Method:</div>

            <div class="dvPaymentMethod">
                <div class="osPointSmallText">
                    <div id="dvCreditCardList"></div>
                </div>
                <div class="osPointYellowText"><a onclick="$('#dvEditPaymentMethod').show();$('.dvPaymentMethod').hide();">Edit Payment Method</a></div>
            </div>
            <div class="osCCTextBoxRow" id="dvEditPaymentMethod" style="display: none;">
                <div class="osCCNumberCol">
                    <input type="text" class="osCCNumberTextBox SaveCreditCard validate-int" id="txtCCNumber" maxlength="16" placeholder="Credit Card Number" />
                </div>
                <div class="osCCExpDateCol">
                    <select class="form-control SaveCreditCard" id="ddlCCExpMonth">
                        <option value=" ">Month</option>
                        <option value="01">1</option>
                        <option value="02">2</option>
                        <option value="03">3</option>
                        <option value="04">4</option>
                        <option value="05">5</option>
                        <option value="06">6</option>
                        <option value="07">7</option>
                        <option value="08">8</option>
                        <option value="09">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                    </select>
                    &nbsp;
                     <select class="form-control SaveCreditCard" id="ddlCCExpYear">
                         <option value=" ">Year</option>
                         <option>2015</option>
                         <option>2016</option>
                         <option>2017</option>
                         <option>2018</option>
                         <option>2019</option>
                         <option>2020</option>
                         <option>2021</option>

                     </select>

                </div>
                <div class="osCCCVVCol">
                    <input type="text" class="osCCCVVTextBox SaveCreditCard validate-int" maxlength="5" id="txtCCCVV" placeholder="CVV" />
                </div>
                <div class="osCCZipCol">
                    <input type="text" class="osCCZipTextBox SaveCreditCard validate-int" id="txtCCZip" maxlength="5" placeholder="Billing Zip Code" />
                </div>
                <div class="dvRow">
                    <div class="osPointYellowText" id="dvUseExistingCC"><a onclick="$('#dvEditPaymentMethod').hide();$('.dvPaymentMethod').show();">Use Existing Card</a></div>
                </div>
            </div>

            <div class="osGoBtn">
                <img src="/images/GoGetItIcn.png" class="CursorPointer" id="dvSaveOrderBtn" onclick="SaveCreditCard();" />
            </div>
            <div class="osPrivacyText" style="margin-top: 15px;">
                By continuing, I agree to the terms and conditions of the <a id="aTOS" href="/TOS">Terms of Service</a>
                and  <a id="aPrivacyPolicy" href="/PrivacyPolicy">Privacy Policy</a>
            </div>

            <div class="dvRow" style="margin-top: 10px;">
                <div id="dvCreditCardAlertDiv"></div>
            </div>
        </div>
    </div>

</div>

<div id="dvOrder"></div>

<div class="modal fade" id="modalOrderThankyou" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">

            <div class="modal-body">

                <h1>THANK YOU!</h1>
                <div class="dvThankyouText">Your order has been successfully placed..</div>
                <div class="dvThankyouText">You will receive a confirmation email shortly.</div>

            </div>

        </div>
    </div>
</div>
<style>
    #modalOrderThankyou .modal-dialog {
        width: 700px;
        max-width: 100%;
    }

    #modalOrderThankyou .modal-body {
        border-top: 5px solid #FDE700;
    }

    #modalOrderThankyou .modal-content {
        border-radius: 0px;
    }

    #modalOrderThankyou h1 {
        font-size: 56px;
        font-weight: 300;
        color: #252525;
        font-family: roboto;
        text-align: center;
    }

    #modalOrderThankyou .dvThankyouText {
        color: #7e7e7e;
        font-family: roboto;
        font-size: 20px;
        text-align: center;
        margin: 15px 0;
    }

    @media all and (max-width: 720px) {
        #modalOrderThankyou .modal-dialog {
            width: 500px;
            max-width: 100%;
        }
    }

    @media all and (max-width: 520px) {
        #modalOrderThankyou .modal-dialog {
            width: 400px;
            max-width: 100%;
        }
    }

    @media all and (max-width: 410px) {
        #modalOrderThankyou .modal-dialog {
            width: 330px;
            max-width: 100%;
        }
    }

    @media all and (max-width: 340px) {
        #modalOrderThankyou .modal-dialog {
            width: 300px;
            max-width: 100%;
        }
    }
</style>
<script type="text/javascript">
$(function () {
        function displayResult(item) {
            $('.alert').show().html('You selected <strong>' + item.value + '</strong>: <strong>' + item.text + '</strong>');
			$('#zipcode').val(item.value);
        }        

       
        $('#txtHomeZipcode').typeahead({
            ajax: {
			url: "/DesktopModules/GoGetIt/API/ZipCode/GetZipByZipCodeForTypeaHead",
			 method: 'get',
			triggerLength: 2			 
			 },
			 scrollBar:true,
			displayField: 'name',
            valueField: 'id',
            onSelect: displayResult
        });
         
         
    });
</script>