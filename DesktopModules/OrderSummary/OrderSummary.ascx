<%@  Control Language="C#" AutoEventWireup="true" CodeBehind="OrderSummary.ascx.cs" Inherits="GoGetIt.OrderSummary" %>

<script src="/js/jquery.validator.min.js" type="text/javascript"></script>

<script src="/js/jquery.maskMoney.min.js" type="text/javascript"></script>

<link href="/js/AlertModal.css" rel="stylesheet" type="text/css" />
<script src="/js/GoGetIt.js"></script>

<!-- Google Code for Order Conversion Page
In your html page, add the snippet and call
goog_report_conversion when someone clicks on the
chosen link or button. -->
<script type="text/javascript">
  /* <![CDATA[ */
  goog_snippet_vars = function() {
    var w = window;
    w.google_conversion_id = 930883339;
    w.google_conversion_label = "mpo5CJ6cumoQi87wuwM";

    w.google_remarketing_only = false;
  }
  // DO NOT CHANGE THE CODE BELOW.
  goog_report_conversion = function(url) {
    goog_snippet_vars();
    window.google_conversion_format = "3";
    var opt = new Object();
    opt.onload_callback = function() {
    if (typeof(url) != 'undefined') {
      window.location = url;
    }
  }
  var conv_handler = window['google_trackConversion'];
  if (typeof(conv_handler) == 'function') {
    conv_handler(opt);
  }
}
/* ]]> */
</script>
<script type="text/javascript"
  src="//www.googleadservices.com/pagead/conversion_async.js">
</script>

<!-- Google Code for Purchase Conversion Page -->
<script type="text/javascript">
/* <![CDATA[ */
var google_conversion_id = 918621252;
var google_conversion_language = "en";
var google_conversion_format = "3";
var google_conversion_color = "ffffff";
var google_conversion_label = "QkPHCOax6GUQxJiEtgM";
var google_remarketing_only = false;
/* ]]> */
</script>
<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
</script>

<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="//www.googleadservices.com/pagead/conversion/918621252/?label=QkPHCOax6GUQxJiEtgM&amp;guid=ON&amp;script=0"/>
</div>
</noscript>
<!--End Google Code -->


<style>
    #custom-templates .empty-message {
        padding: 5px 10px;
        text-align: center;
    }

    .OrderSummaryBG .form-control {
    width: 100%;
    float: left;
    max-width: 150px;
    margin: auto auto 20px 10px;
    background-color: #fff;
    border-radius: 0px;
    color: #999;
    opacity: 1;
    border-radius: 15px;
    border: 1px solid #929090;
}
    input[type="text"], textarea {

        /*color: #fff !important;*/

    }
    .osCCNumberTextBox
    {
    color: #cecece;
    }
    .osPointYellowText {
        clear: both;
    }

    #txtOrderDescription {
        width: 100%;
        float: left;
        max-width: 225px;
    }

    .osPointYellowText a {
        cursor: pointer;
    }

    #ddlCCExpMonth, #ddlCCExpYear {
    border-radius: 15px;
    appearance: none;
    -moz-appearance: none;
    -webkit-appearance: none;
    background: #fff url(/images/OrderPageDropdown.png) no-repeat scroll right center;
    border: 1px solid #929090;
    opacity: 1;
    color: #999;
    width: 90px;
    height: 42px;
    float: left;
}

    #ddlPickUpZip {
    appearance: none;
    -moz-appearance: none;
    -webkit-appearance: none;
    background: url(/images/OrderPageDropdown.png) no-repeat scroll right center;
    background-color: #fff;
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
            if(o.data.Distance==0){
                /*location.reload();*/
            }

            //vrUserID = o.data.UserID;
            LoadCreditCard();
            $("#txtPickUpName").val(o.data.PickUpName);
            $("#txtPickUpAddress").val(o.data.GRI_Address.Address1);
            $("#txtPickUpApt").val(o.data.GRI_Address.Address2);
            $("#ddlPickUpZip").val(o.data.GRI_Address.GRI_ZipCode.ZipCodeID);

            //PickUpTime and PickUpDate
            if (o.data.PickupDate == 'ASAP')
            {
                $("#dvDeliveryPickUpDateTime").html("As Soon As Possible");
            } else {
                $("#dvDeliveryPickUpDateTime").html(o.data.PickupDate+", "+o.data.PickupTime);
            }
            

            $("#txtOrderDescription").val(o.data.Details);
            $("#txtDeliveryName").val(o.data.DeliveryName);
            $("#txtDeliveryAddress").val(o.data.GRI_Address1.Address1);
            $("#txtDeliveryApt").val(o.data.GRI_Address1.Address2);
            $("#txtDeliveryZip").val(o.data._DeliverZip);

            /*$("#dvDeliveryType").html(o.data.DeliveryType);
            var vrText = o.data.DeliveryType.toLowerCase().trim();
            if (vrText == 'pick-up and drop off') {
                $('#divTotalPersent').hide();
                $('#divPlush').hide();
            }
            else {
                $('#divTotalPersent').show();
                $('#divPlush').show();
            }*/
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
        LoadReview();
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


     function SaveCreditCard()
     {
       
        // $("#dvSaveOrderBtn").hide();
        
        if ($('#dvEditPaymentMethod').css('display') == "block") 
        {
            var validate = new Validator({ validation_group: 'SaveCreditCard', error_class: 'error' });
            
            validate.validate({
                txtCCNumber: 'Credit card number is required.',
                ddlCCExpYear: 'Expiry year is required.',
                ddlCCExpMonth: 'Expiry month is required',
                txtCCCVV: 'CVV no. is required.'
            });

            
            if (validate.error == undefined) {
                jQuery("#CCErrorModal").modal(open);
                $("#dvCreditCardAlertDiv").html('');

            }   
            else {
                jQuery("#CCErrorModal").modal(open);
                $("#dvCreditCardAlertDiv").html('<div class="alert alert-error">' + validate.error + '</div>');
                $("#dvSaveOrderBtn").show();
                return false;
            }



            var vCardNumber = $("#txtCCNumber").val();
            var vExpiryYear = $("#ddlCCExpYear").val();
            var vExpiryMonth = $("#ddlCCExpMonth").val();
            var vCVV = $("#txtCCCVV").val();

            /* var vrCardType = "";*/
            if (vCardNumber.startsWith('3') == true) {
                vrCardType = 'American Express';
            }
            if (vCardNumber.startsWith('4') == true) {
                vrCardType = 'Visa';
            }
            if (vCardNumber.startsWith('5') == true) {
                vrCardType = 'MasterCard';
            }
            /*if (vCardNumber.startsWith('6') == true) {
                vrCardType = 'Discover';
            }*/


            var mcontact = {
                IsPreferredCard: false,
                UserID: vrUserID,
                CardLastFourDigit: vCardNumber,
                CardType: vrCardType,
                ExpirationMonth: vExpiryMonth,
                ExpirationYear: vExpiryYear,
                /* ZipCode: vCardZip,*/
                CVV: vCVV
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
                         CheckCard();
                    }
                    else {
                        jQuery("#CCErrorModal").modal(open);
                        $("#dvCreditCardAlertDiv").html('<div class="alert alert-error">' + result.msg + '</div>');
                    }
                },
                error: function (result) {
                    jQuery("#CCErrorModal").modal(open);
                    $("#dvCreditCardAlertDiv").html('<div class="alert alert-error">There was an error submitting the form.</div>');
                },
            });
        }
        else {
             CheckCard();
        }
    }

        $(document).ready(function(){
        $("#txtCCNumber").keyup(function(){
        firsletter=$(this).val();
        console.log(firsletter);
        var cardvisa = /^(?:4[0-9]{12}(?:[0-9]{3})?)$/;  
        var cardmast = /^(?:5[1-5][0-9]{14})$/; 
        /*if(firsletter.match(cardvisa) || firsletter.match(cardmast))
        {
             $(".alert-visa-master").remove();
        }
        else
        {
            $("#dv-alert-card").html('<div class="alert-visa-master"><ul><li>Please Enter a Visa or MasterCard</li></ul></div>');
        }*/
    //Visa
    // /^4\d{3}-?\d{4}-?\d{4}-?\d{4}$/
    //MasterCard
    // /^5[1-5]\d{2}-?\d{4}-?\d{4}-?\d{4}$/
        
       /* if(firsletter != '4' ){

            $("#dv-alert-card").html('<div class="alert-visa-master"><ul><li>Please Enter a Visa or MasterCard</li></ul></div>');
                
               }else if (firsletter =='4' ){

                $(".alert-visa-master").remove();

                    }*/
            
            });

    
 });

</script>

<%--Valid Credit Card--%>
<script type="text/javascript">
    function CheckCard() {
         $.ajax({
                type: "Get",
                url: "/DesktopModules/GoGetIt/API/CreditCard/ValidateCard?UserID=" + vrUserID,
                cache: false,
                contentType: "application/json",
                success: function (result) {
                    if (result.success) {
                        SaveOrder();
                    }
                    else {
                        jQuery("#CCErrorModal").modal(open);
                        $("#dvCreditCardAlertDiv").html('<div class="alert alert-error">Your card has been declined! Please update your payment method.</div>');
                    }
                },
                error: function (result) {
                    jQuery("#CCErrorModal").modal(open);
                    $("#dvCreditCardAlertDiv").html('<div class="alert alert-error">There was an error submitting the form.</div>');
                },
            });
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
            jQuery("#CCErrorModal").modal(open);
            $("#dvCreditCardAlertDiv").html('');
        }
        else {
            jQuery("#CCErrorModal").modal(open);
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

        var Tip = Number($("#txtTip").val().replace(/,/g,'')).toFixed(2);
        var CouponCode = $("#txtPromoCode").val();

        var mcontact = {
            OrderID: parseInt(vrOrderID),
            UserID: vrUserID,
            _DeliverZip: $('#txtDeliveryZip').val(),
            GRI_Address: { Address1: vPickUpAddress, Address2: vPickUpApt, ZipCodeID: vtxtPickUpZip },
            GRI_Address1: { Address1: vDeliveryAddress, Address2: vDeliveryApt },
            Details: vDescription,
            DeliveryName: vDeliverName,
            PickUpName: vPickUpName,
            Tip: Tip,
            CouponCode: CouponCode
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
            jQuery("#CCErrorModal").modal(open);
            $("#dvCreditCardAlertDiv").html('<div class="alert alert-success">Thank you for your order.</div>');

            $('#modalOrderThankyou').modal('show');
            setTimeout("BackOrderFromSummary();", 5000);
        }
        else {
            jQuery("#CCErrorModal").modal(open);
            $("#dvCreditCardAlertDiv").html('<div class="alert alert-error">There was an error submitting the order.</div>');
        }
    }
    function onErrorSaveOrder(result) {
        if (result.status == 200) {
            onSuccessSaveOrder(result);
        }
    }
    function BackOrderFromSummary() {
        $("#oculto").click();
        //window.location = "/order";
    }
</script>

<%--Load Review--%>
<script type="text/javascript">
    function LoadReview() {
        $.ajax({
            type: "Get",
            url: "/DesktopModules/GoGetIt/API/Order/GetEstimate?OrderID=" + vrOrderID,
            cache: false,
            contentType: "application/json",
            success: onSuccessLoadReview,
            error: onErrorLoadReview
        });
    }
    function onSuccessLoadReview(result) {
        var o = eval(result);
        if (o.success == true) {
            $('#divfeeEstimate').html('$' + o.data.toFixed(2));
            $('#idfaresti').html('$' + o.data.toFixed(2) + '');
            $('#estimado').val(o.data.toFixed(2));
            //$('#idfarecondi').html('*Applicable only when items are purchased by GOGETIT.');
        }

    }
    function onErrorLoadReview(result) {
        if (result.status == 200) {
            onSuccessLoadReview(result);
        }
    }
</script>


<script>
    $(document).ready(function(){
        
        $("#txtTip").maskMoney({thousands:',', decimal:'.', allowZero:true});

        $(document).on('keydown', '#txtTip', function(e){
            
            // Allow: backspace, delete, tab, escape, enter and .
            if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
                 // Allow: Ctrl+A, Command+A
                (e.keyCode == 65 && ( e.ctrlKey === true || e.metaKey === true ) ) || 
                 // Allow: home, end, left, right, down, up
                (e.keyCode >= 35 && e.keyCode <= 40)) {
                     // let it happen, don't do anything
                     return;
            }
            // Ensure that it is a number and stop the keypress
            if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                e.preventDefault();
            }

        });

        $(document).on("click", "#ValidatePromoCode", function(event){
            event.preventDefault();
            
            var PromoCodeVal = $("#txtPromoCode").val();

            if (PromoCodeVal != "" && PromoCodeVal.length <= 20)
            {
                $(".statusPromoCode").html('');
               
                $.ajax({
                    type: 'GET',
                    url: 'DesktopModules/GoGetIt/API/Coupon/ValidateOrderByCouponCode?CouponCode='+PromoCodeVal+'&UserID='+vrUserID,
                    cache: false,
                    contentType: "application/json",

                    beforeSend: function(){
                        $(".statusPromoCode").html("Verifying, please wait...");
                    },
                    success: function(response){
                        //console.log(response);

                        
                        if (response.success == false) //false : no existe una orden con el promocode ingresado
                        {
                            var myData = { CouponCode : PromoCodeVal }
                            
                            $.ajax({
                                type: 'GET',
                                url: 'DesktopModules/GoGetIt/API/Coupon/GetSingleCoupon',
                                data: myData,
                                
                                beforeSend: function(){
                                    $(".statusPromoCode").html("Applying, please wait...");
                                },
                                success: function(response){
                                    console.log(response);

                                    if (response != null && Object.keys(response).length > 0)
                                    {
                                        $("#txtPromoCode").attr("disabled", true);
                                        $("#ValidatePromoCode").fadeOut();
                                        var nuevofee = 0 ;
                                        if (response.DiscountType == "percentage")
                                        {
                                            $(".statusPromoCode").html("Congratulation you have "+response.CouponValue+"% off!");
                                            nuevofee = $('#estimado').val() - (( $('#estimado').val()) * ( response.CouponValue / 100));

                                        }
                                        else if (response.DiscountType == "cash") {
                                            $(".statusPromoCode").html("Congratulation you have $ "+response.CouponValue+" off!");
                                            nuevofee = $('#estimado').val() - (response.CouponValue);
                                        }
                                        else {
                                            $(".statusPromoCode").html("Congratulation you have a $ "+response.CouponValue+" fixed rate!");
                                            nuevofee = response.CouponValue;
                                        }
                                        console.log(nuevofee);
                                        $('#idfaresti').html('$' + nuevofee.toFixed(2) + '');
                                    }
                                    else {
                                        $(".statusPromoCode").html("The discount code entered does not exist.");
                                    }

                                }
                            })
                        } else {
                            $(".statusPromoCode").html("The discount code entered does not exist");
                        }
                    }
                })
                .done(function() {
                    //console.log("success");
                })
                .fail(function() {
                    //console.log("error");
                })
                .always(function() {
                    //console.log("complete");
                });

            } else {
                $(".statusPromoCode").html("The length of Promo Code is invalid");
                $("#txtPromoCode").focus();
            }

        });

    });
        
</script>

<div class="OrderSummaryBG">
    
    <div class="osPointTotal">
        <div class="osPointLeft">
            <div class="numberClassOS">
                1
            </div>

        </div>
        <div class="osPointRight">
            <div class="osPointBigText">Pick-up Date and Time:</div>
            <div class="osCCNumberCol" id="pickup_time_wrapper">
                <div class="osPointSmallText" id="dvDeliveryPickUpDateTime">

                </div>
            </div>
        </div>
    </div>
    <div class="osPointTotal">
        <div class="osPointLeft">
            <div class="numberClassOS">
                2
            </div>
        </div>
        <div class="osPointRight">
            <div class="osPointBigText"><strongg>Pick-Up Location:</strongg></div>
            <div class="dvPickUpLocation">
                <div class="osPointSmallText">
                    <div id="dvPickUpLocation"></div>
                </div>
                <div class="osPointYellowText"><a onclick="$('#dvEditPickUpAddress').show();$('.dvPickUpLocation').hide();$('#dvEditPickUpAddresssaved').html('');">Edit Pick Up Location</a></div>
            </div>
            <div class="dvRow" id="dvEditPickUpAddress" style="display: none;">
                <div class="form-group">
                    <input type="text" class="form-control SavePickUp SaveOrder" id="txtPickUpName" placeholder="Pickup Name">
                    <input type="text" class="form-control SavePickUp SaveOrder" id="txtPickUpAddress" placeholder="Address 1" >
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
                        <option value="6775">33054</option>
                        <option value="6776">33055</option>
                        <option value="6777">33056</option>
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
                        
                    </select>
                </div>
                <div class="osPointYellowText"><a onclick="$('#dvEditPickUpAddress').hide();$('.dvPickUpLocation').show();">Cancel</a></div>
                <div id="dvEditPickUpAddresssaved"></div>
            </div>
            
        </div>
    </div>


    <script>
    var weastico = $('#dvEditPickUpAddress').find('.form-control');
    weastico.focusout(function(event) {
        $('#dvEditPickUpAddresssaved').html('New Data Saved.');
    });
</script>
    

    <div class="osPointTotal">
        <div class="osPointLeft">
            <div class="numberClassOS">
                3
            </div>
        </div>
        <div class="osPointRight">
            <div class="osPointBigText"><strongg>ORDER DETAILS:</strongg></div>
            <div class="dvDeliveryDetail">
                <div class="osPointSmallText">
                    <div id="dvDeliveryDetail"></div>
                </div>
                <div class="osPointYellowText"><a onclick="$('#dvEditDeliveryDetails').show();$('.dvDeliveryDetail').hide();$('#dvEditDeliveryDetailssaved').html('');">Edit Delivery Details</a></div>
            </div>
            <div class="dvRow" id="dvEditDeliveryDetails" style="display: none;">
                <div class="form-group">
                    <textarea class="form-control SaveDeliveryDetails SaveOrder" id="txtOrderDescription" placeholder="Please enter full details of your order..."></textarea>
                </div>
                <div class="osPointYellowText"><a onclick="$('#dvEditDeliveryDetails').hide();$('.dvDeliveryDetail').show();">Cancel</a></div>
                <div id="dvEditDeliveryDetailssaved"></div>
            </div>
        </div>
    </div>
<script>
    var weastico2 = $('#dvEditDeliveryDetails').find('.form-control');
    weastico2.focusout(function(event) {
        $('#dvEditDeliveryDetailssaved').html('New Data Saved.');
    });
</script>
    <div class="osPointTotal">
        <div class="osPointLeft">
            <div class="numberClassOS">
                4
            </div>
        </div>
        <div class="osPointRight">
            <div class="osPointBigText"><strongg>Delivery Address:</strongg></div>
            <div class="dvDeliveryAddress">
                <div class="osPointSmallText">
                    <div id="dvDeliveryAddress"></div>
                </div>
                <div class="osPointYellowText"><a onclick="$('#dvEditDeliveryAddress').show();$('.dvDeliveryAddress').hide();$('#dvEditDeliveryAddresssaved').html('');">Edit Delivery Destination</a></div>
            </div>
            <div class="dvRow" id="dvEditDeliveryAddress" style="display: none;">
                <div class="form-group">
                    <input type="text" class="form-control SaveDeliveryAddress SaveOrder" id="txtDeliveryName" placeholder="Delivery Name">
                    <input type="text" class="form-control SaveDeliveryAddress SaveOrder" id="txtDeliveryAddress" placeholder="Address 1">
                    <input type="text" class="form-control SaveDeliveryAddress " id="txtDeliveryApt" placeholder="Apt/Unit">
                    <input type="text" class="form-control SaveDeliveryAddress SaveOrder" id="txtDeliveryZip" placeholder="Zip code">
                </div>
                <div class="osPointYellowText"><a onclick="$('#dvEditDeliveryAddress').hide();$('.dvDeliveryAddress').show();">Cancel</a></div>
                <div id="dvEditDeliveryAddresssaved"></div>
            </div>
        </div>
    </div>
<script>
    var weastico3 = $('#dvEditDeliveryAddress').find('.form-control');
    weastico3.focusout(function(event) {
        $('#dvEditDeliveryAddresssaved').html('New Data Saved.');
    });


</script>

    <div class="osPointTotal">
        <div class="osPointLeft">
            <div class="numberClassOS">
                5
            </div>

        </div>
        <div class="osPointRight">
            <div class="osPointBigText"><strongg>Promo Code:</strongg></div>
            <span style="display: block; color: #444; font-size:11px">Enter code (if applicable) then click apply.</span>
            <div class="osCCNumberCol promocode-wrapper-input">
                <input type="text" class="osCCNumberTextBox" id="txtPromoCode" maxlength="20" />
                <div class="osPointYellowText">
                    <a href="#" id="ValidatePromoCode">Apply</a>
                    <span class="statusPromoCode" style="float: right;margin-right: 18px;font-size: 10px;margin-top: 4px;"></span>
                </div>
            </div>
        </div>
    </div>


    
    <div class="osPointTotal">
        <div class="osPointLeft">
            <div class="numberClassOS">
                6
            </div>

        </div>
        <div class="osPointRight">
            <div class="osPointBigText"><strongg>Tip:</strongg></div>
            <div class="osCCNumberCol tip-wrapper-input">
                <input type="text" class="osCCNumberTextBox validate-int" id="txtTip" maxlength="16" placeholder="Tip Amount: e.g. 10" />
                <span style="color: #444; font-size:11px">Optional</span>
            </div>
        </div>
    </div>

    <div class="osPointTotal">
        <div class="osPointLeft">
            <div class="numberClassOS">
                7
            </div><!--<img src="/images/OrderSummaryPointFour.png" />-->
        </div>
        <div class="osPointRight">
            <div class="osPointBigText"><strongg>Payment Method:</strongg></div>
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
                         
                         <option>2017</option>
                         <option>2018</option>
                         <option>2019</option>
                         <option>2020</option>
                         <option>2021</option> 
                         <option>2022</option>
                         <option>2023</option>
                         <option>2024</option>
                         <option>2025</option>
                         <option>2026</option>
                         <option>2027</option>
                         <option>2028</option>                        
                     </select>

                </div>
                <div class="osCCCVVCol">
                    <input type="text" class="osCCCVVTextBox SaveCreditCard validate-int" maxlength="4" id="txtCCCVV" placeholder="CVV" />
                </div>

                <div class="dvRow">
                    <div class="osPointYellowText" id="dvUseExistingCC"><a onclick="$('#dvEditPaymentMethod').hide();$('.dvPaymentMethod').show();">Use Existing Card</a></div>
                </div>
            </div>
                <div class="master-div"><img src="/images/master-card.png"></div>
                <div class="visa-div"><img src="/images/visa-card.png"></div>
                <div class="master-div"><img src="/images/Americanexpress.png"></div>
                <div id="dv-alert-card"></div>
        </div>

    </div>

    <div class="osPointTotal">
        <div class="osPointLeft">
            <div class="numberClassOS">
                8
            </div>

        </div>
        <div class="osPointRight">
            <div class="osPointBigText"><strongg>Delivery Fee:</strongg></div>
            <div id="idfaresti"></div>
           <input type="hidden" name="estimado" id="estimado" >
            <div id="idfarecondi"></div>
        </div>
    </div>

    <div class="dvGoBtnLastRow">
        <div class="osGoBtn">
            <img src="/images/GoGetItIcn.png" class="CursorPointer" id="dvSaveOrderBtn" onclick="SaveCreditCard();" />
            <a onclick="goog_report_conversion('/Order')"  href="/Order" id= "oculto" ></a>
        </div>
        <div class="osPrivacyText" style="margin-top: 15px;">
            By continuing, I agree to the terms and conditions of the <a id="aTOS" href="/TOS">Terms of Service</a>
            and  <a id="aPrivacyPolicy" href="/PrivacyPolicy">Privacy Policy</a>
        </div>
    </div>

</div>

<div id="dvOrder"></div>


<!--Error Modal-->
<div class="modal fade" id="CCErrorModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="dvRow">
                    <div id="dvCreditCardAlertDiv"></div>
                </div>                
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="ModalReview" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
          margin-top: 10%;  <div class="modal-content">
            <div class="modal-body">
                <h1>Delivery Fee Estimate</h1>
                <div class="dvThankyouText" id="divfeeEstimate">$8.00</div>
                <!--<div id="divPlush" class="dvThankyouText">+</div>-->
                
                <!--<div class="dvThankyouText" id="divTotalPersent">(5% of cost of item*)</div>-->
                <!--<div class="dvcondition_small_text">*Applicable only when items are purchased by GOGETIT.</div>-->
                <div class="dvThankyouText">
                    <button type="button" class="btn btn-default YellowBtn" data-dismiss="modal">OK</button>
                </div>
            </div>

        </div>
    </div>
</div>

<div class="modal fade" id="modalOrderThankyou" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">

            <div class="modal-body">

                <h1>THANK YOU!</h1>
                <div class="dvThankyouText">Your order has been successfully placed.</div>
                <div class="dvThankyouText">You will receive a confirmation email shortly.</div>

            </div>

        </div>
    </div>
</div>
<style>
    .visa-div{

    float: left;
    padding-left: 10px;
    padding-right: 13px;
    }

    .master-div{
    float: left;

    }

    .dv-alert-card{

    float: left;
    padding-left: 10px;
    }

    .alert-visa-master{
    background-color: #f2dede;
    border-color: #eed3d7;
    color: #b94a48;
    width: 291px;
    height: 30px;
    float: left;
    padding-left: 10px;
    padding-top: 4px;
    border-radius: 4px;
        
    }

    .dvGoBtnLastRow {
        display: inline-block;
        margin: 0 0 0 51px;
    }
    .dvcondition_small_text{
         text-align:center;
         font-size:10px;
    }
    #modalOrderThankyou .modal-dialog {
        width: 700px;
        max-width: 100%;
        margin-top: 10%;
    }

    #modalOrderThankyou .modal-body {
        border-top: 5px solid #020202;
    }

    #modalOrderThankyou .modal-content {
        border-radius: 0px;
    }

    #modalOrderThankyou h1 {
        font-size: 56px;
        font-weight: 300;
        color: #000;
        bacground-color: #000;
        margin-top: 0px;
        font-family: roboto;
        text-align: center;
         font-family: 'Montserrat', sans-serif;
    }

    #modalOrderThankyou .dvThankyouText {
     font-family: 'Montserrat', sans-serif;
        color: #7e7e7e;

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
    /*Review Modal */

    #ModalReview .modal-dialog {
        width: 700px;
        max-width: 100%;
    }

    #ModalReview .modal-body {
        border-top: 5px solid #FDE700;
    }

    #ModalReview .modal-content {
        border-radius: 0px;
    }

    #ModalReview h1 {
        font-size: 56px;
        font-weight: 300;
        color: #252525;
        font-family: roboto;
        text-align: center;
    }

    #ModalReview .dvThankyouText {
        color: #7e7e7e;
        font-family: roboto;
        font-size: 20px;
        text-align: center;
        margin: 15px 0;
    }

    @media all and (max-width: 720px) {
        #ModalReview .modal-dialog {
            width: 500px;
            max-width: 100%;
        }
    }

    @media all and (max-width: 520px) {
        #ModalReview .modal-dialog {
            width: 400px;
            max-width: 100%;
        }
    }

    @media all and (max-width: 410px) {
        #ModalReview .modal-dialog {
            width: 330px;
            max-width: 100%;
        }
    }

    @media all and (max-width: 340px) {
        #ModalReview .modal-dialog {
            width: 300px;
            max-width: 100%;
        }
    }

    .numberClassOS {
        background: url(./images/numbercircle.png) no-repeat;
        height: 40px;
        width: 40px;
        padding: 5px;
        color: #282526;
        font-family: roboto;
        font-size: 20px;
        text-align: center;
    }
</style>
