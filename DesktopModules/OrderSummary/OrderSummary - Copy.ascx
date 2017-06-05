<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OrderSummary.ascx.cs" Inherits="GoGetIt.OrderSummary" %>

<script src="/js/jquery.fancybox.js" type="text/javascript"></script>
<script src="/js/jquery.validator.min.js" type="text/javascript"></script>
<link href="/js/jquery.fancybox.css" rel="stylesheet" type="text/css" />
<link href="/js/AlertModal.css" rel="stylesheet" type="text/css" />
<script src="/js/GoGetIt.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />


<style>
    .form-control {
        width: 100%;
        float: left;
        max-width: 150px;
        margin: auto auto 20px 10px;
        background-color: transparent;
        color: #fff;
        border-radius: 0px;
    }

    #txtOrderDescription {
        width: 100%;
        float: left;
        max-width: 225px;
    }
</style>

<!--Datepicker-->
<script type="text/javascript">
    $(function () {
        $('#txtCCExpDate').datepicker({
            dateFormat: 'mm/yy'
        });
    });
</script>

<script type="text/javascript">
    var vrOrderID = '<%=GetFromQueryString("OrderID") %>';
    var vrUserID = '<%=LOGGEDINUSERID %>';
    $(document).ready(function () {
        LoadOrderDetails();
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
            vrUserID = o.data.UserID;
            LoadCreditCard();
            $("#txtPickUpAddress").val(o.data.GRI_Address.Address1);
            $("#txtPickUpApt").val(o.data.GRI_Address.Address2);
            $("#txtPickUpCity").val(o.data.GRI_Address.GRI_ZipCode.GRI_City.Name);
            $("#ddlPickUpState").val(o.data.GRI_Address.GRI_ZipCode.GRI_City.GRI_State.Abbreviation);
            $("#txtPickUpZip").val(o.data.GRI_Address.GRI_ZipCode.ZipCode);
            $("#txtOrderDescription").val(o.data.Details);
            $("#txtDeliveryAddress").val(o.data.GRI_Address1.Address1);
            $("#txtDeliveryApt").val(o.data.GRI_Address1.Address2);
            $("#txtDeliveryCity").val(o.data.GRI_Address1.GRI_ZipCode.GRI_City.Name);
            $("#ddlDeliveryState").val(o.data.GRI_Address1.GRI_ZipCode.GRI_City.GRI_State.Abbreviation);
            $("#txtDeliveryZip").val(o.data.GRI_Address1.GRI_ZipCode.ZipCode);
            //$("#txtCCNumber").val(o.data.);
            //$("#txtCCExpDate").val(o.data.);
            //$("#txtCCCVV").val(o.data.);
            //$("#txtCCZip").val(o.data.);
            $("#dvDeliveryType").html(o.data.DeliveryType);
            $("#dvPickUpLocation").html(GetLowerCharacters(o.data.GRI_Address.Address1 + " " + o.data.GRI_Address.Address2 + ", " + o.data.GRI_Address.GRI_ZipCode.GRI_City.Name) + ", " + o.data.GRI_Address.GRI_ZipCode.GRI_City.GRI_State.Abbreviation + " " + GetLowerCharacters(o.data.GRI_Address.GRI_ZipCode.ZipCode));
            $("#dvPickUpLocation2").html(o.data.GRI_Address.Address2);
            $("#dvDeliveryDetail").html(o.data.Details);
            $("#dvDeliveryAddress").html(GetLowerCharacters(o.data.GRI_Address1.Address1 + " " + o.data.GRI_Address1.Address2 + ", " + o.data.GRI_Address1.GRI_ZipCode.GRI_City.Name) + ", " + o.data.GRI_Address1.GRI_ZipCode.GRI_City.GRI_State.Abbreviation + " " + GetLowerCharacters(o.data.GRI_Address1.GRI_ZipCode.ZipCode));

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
        if ($('#dvEditPaymentMethod').css('display') == "block") {
            var validate = new Validator({ validation_group: 'SaveCreditCard', error_class: 'error' });
            validate.validate({
                txtCCNumber: 'Credit card number is required.',
                txtCCExpDate: 'Expiry date is required.',
                txtCCCVV: 'CVV no. is required.',
                txtCCZip: 'Billing Zip code is required.',
            });
            if (validate.error == undefined) {
                $("#dvCreditCardAlertDiv").html('');
            }
            else {
                $("#dvCreditCardAlertDiv").html('<div class="alert alert-error">' + validate.error + '</div>');
                return false;
            }
            var vCardNumber = $("#txtCCNumber").val();
            var vExpiryDate = $("#txtCCExpDate").val();
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
                ExpirationMonth: $("#txtCCExpDate").val().split('/')[0],
                ExpirationYear: $("#txtCCExpDate").val().split('/')[1],
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

        var validate = new Validator({ validation_group: 'SaveOrder', error_class: 'error' });
        validate.validate({
            txtPickUpAddress: 'Address is required.',
            txtPickUpApt: 'Apt/Unit is required.',
            txtPickUpCity: 'City is required.',
            ddlPickUpState: 'State is required',
            txtPickUpZip: 'Zip code is required',
            txtOrderDescription: 'Order description is required.',
            txtDeliveryAddress: 'Delivery Address is required.',
            txtDeliveryApt: 'Delivery Apt/Unit is required.',
            txtDeliveryCity: 'Delivery City is required.',
            ddlDeliveryState: 'Delivery State is required',
            txtDeliveryZip: 'Delivery Zip code is required',
        });
        if (validate.error == undefined) {
            $("#dvCreditCardAlertDiv").html('');
        }
        else {
            $("#dvCreditCardAlertDiv").html('<div class="alert alert-error">' + validate.error + '</div>');
            return false;
        }
        var vPickUpAddress = $("#txtPickUpAddress").val();
        var vPickUpApt = $("#txtPickUpApt").val();
        var vPickUpCity = $("#txtPickUpCity").val();
        var vPickUpState = $("#ddlPickUpState").val();
        var vtxtPickUpZip = $("#txtPickUpZip").val();

        var vDescription = $("#txtOrderDescription").val();

        var vDeliveryAddress = $("#txtDeliveryAddress").val();
        var vDeliveryApt = $("#txtDeliveryApt").val();
        var vDeliveryCity = $("#txtDeliveryCity").val();
        var vDeliveryState = $("#ddlDeliveryState").val();
        var vDeliveryZip = $("#txtDeliveryZip").val();

        var mcontact = {
            OrderID: parseInt(vrOrderID),
            UserID: vrUserID,
            GRI_Address: { Address1: vPickUpAddress, Address2: vPickUpApt, ZipCodeID: 1 },
            GRI_Address1: { Address1: vDeliveryAddress, Address2: vDeliveryApt, ZipCodeID: 1 },
            Details: vDescription,
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
            window.location = "/ThankyouOrder.aspx";
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
                    <input type="text" class="form-control SavePickUp SaveOrder" id="txtPickUpAddress" placeholder="Address 1">
                    <input type="text" class="form-control SavePickUp SaveOrder" id="txtPickUpApt" placeholder="Apt/Unit">
                    <input type="text" class="form-control SavePickUp SaveOrder" id="txtPickUpCity" placeholder="City">
                    <select class="form-control SavePickUp" id="ddlPickUpState">
                        <option value=" ">State</option>
                        <option value="Florida">Florida</option>
                    </select>
                    <input type="text" class="form-control SavePickUp SaveOrder validate-int" id="txtPickUpZip" maxlength="5" placeholder="Zip">
                </div>
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
                    <input type="text" class="form-control SaveDeliveryAddress SaveOrder" id="txtDeliveryAddress" placeholder="Address 1">
                    <input type="text" class="form-control SaveDeliveryAddress SaveOrder" id="txtDeliveryApt" placeholder="Apt/Unit">
                    <input type="text" class="form-control SaveDeliveryAddress SaveOrder" id="txtDeliveryCity" placeholder="City">
                    <select class="form-control SaveDeliveryAddress" id="ddlDeliveryState">
                        <option value=" ">State</option>
                        <option value="Florida">Florida</option>
                    </select>
                    <input type="text" class="form-control SaveDeliveryAddress SaveOrder validate-int" id="txtDeliveryZip" maxlength="5" placeholder="Zip">
                </div>
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
                    <input type="text" class="osCCExpDateTextBox SaveCreditCard" id="txtCCExpDate" placeholder="Expiration Date (mm/yy)" />
                </div>
                <div class="osCCCVVCol">
                    <input type="text" class="osCCCVVTextBox SaveCreditCard validate-int" maxlength="5" id="txtCCCVV" placeholder="CVV" />
                </div>
                <div class="osCCZipCol">
                    <input type="text" class="osCCZipTextBox SaveCreditCard validate-int" id="txtCCZip" maxlength="5" placeholder="Billing Zip Code" />
                </div>
            </div>

            <div class="osPrivacyText">By continuining, I agree to the terms and conditions of the <a href="#">Terms of Service</a>  and  <a href="#">Privacy Policy</a></div>
            <div class="osGoBtn">
                <img src="/images/GoGetItIcn.png" class="CursorPointer" onclick="SaveCreditCard();" />
            </div>
            <div class="dvRow" style="margin-top: 10px;">
                <div id="dvCreditCardAlertDiv"></div>
            </div>
        </div>
    </div>

</div>


