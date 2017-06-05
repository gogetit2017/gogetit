<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OrderPage.ascx.cs" Inherits="GoGetIt.OrderPage" %>


<!------------------------------- Google Code for Registrations Conversion Page ------------------------------->
<%
    int registered = 0;
    
    if(Request.QueryString["registered"]!=null)
    {
       registered = Int32.Parse(Request.QueryString["registered"]);
    }

    if (registered == 1)
    {
%>
    <!-- Google Code for Registrations Conversion Page -->
    <script type="text/javascript">
    /* <![CDATA[ */
    var google_conversion_id = 918621252;
    var google_conversion_language = "en";
    var google_conversion_format = "3";
    var google_conversion_color = "ffffff";
    var google_conversion_label = "ZLCQCMTg72UQxJiEtgM";
    var google_remarketing_only = false;
    /* ]]> */
    </script>
    <script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
    </script>
    <noscript>
    <div style="display:inline;">
    <img height="1" width="1" style="border-style:none;" alt="" src="//www.googleadservices.com/pagead/conversion/918621252/?label=ZLCQCMTg72UQxJiEtgM&amp;guid=ON&amp;script=0"/>
    </div>
    </noscript>


<%
    }
    else {

    }
%>
<!------------------------------- Google Code for Registrations Conversion Page ------------------------------->


<script src="/js/jquery.validator.min.js" type="text/javascript"></script>

<link href="/js/AlertModal.css" rel="stylesheet" type="text/css" />

<style>
    #OrderDescription {
        height: 189px;
    }
</style>

<script type="text/javascript">
    var vrUserID = '<%=LOGGEDINUSERID %>';

    $(document).ready(function () {
        $( "#txtPickUpAddress" ).focusout(function() {
        google.maps.event.trigger(this, 'keydown', {keyCode:40});
        google.maps.event.trigger(this, 'keydown', {keyCode:13});
        var searchTextField = $("#txtPickUpAddress").val();
          $.ajax({
                            url: 'http://maps.google.com/maps/api/geocode/json?components=administrative_area:FL|country:US',
                            dataType: 'json',
                            data: { address: searchTextField },

                            success: function(response) {
                                
                                var myAddress = response.results[0].formatted_address;
                                var myPostcode;

                                for (var i = 0; i < response.results[0].address_components.length; i++) {
                                    for (var j = 0; j < response.results[0].address_components[i].types.length; j++) {
                                        if (response.results[0].address_components[i].types[j] == "postal_code") {
                                            myPostcode = response.results[0].address_components[i].long_name;
                                            break;
                                        }
                                    }
                                }
                                console.log(myPostcode );
                                if (myPostcode > 0)
                                {
                                    var valuedo = $('#ddlPickUpZip option').filter(function () { return $(this).html() == myPostcode; }).val();
                                     $(".msg").text("");
                                    console.log(valuedo );
                                    $("#ddlPickUpZip").val(valuedo).change();
                                }
                               

                            }

                        })
   
    }); 

     $( "#txtDeliveryAddress" ).focusout(function() {
         google.maps.event.trigger(this, 'keydown', {keyCode:40});
        google.maps.event.trigger(this, 'keydown', {keyCode:13});
        var searchTextField = $("#txtDeliveryAddress").val();
          $.ajax({
                            url: 'http://maps.google.com/maps/api/geocode/json?components=administrative_area:FL|country:US',
                            dataType: 'json',
                            data: { address: searchTextField },

                            success: function(response) {
                                
                                var myAddress = response.results[0].formatted_address;
                                var myPostcode;

                                for (var i = 0; i < response.results[0].address_components.length; i++) {
                                    for (var j = 0; j < response.results[0].address_components[i].types.length; j++) {
                                        if (response.results[0].address_components[i].types[j] == "postal_code") {
                                            myPostcode = response.results[0].address_components[i].long_name;
                                            break;
                                        }
                                    }
                                }
                                console.log(myPostcode );
                                if (myPostcode > 0)
                                {
                                    
                                    $("#txtDeliveryZip").val(myPostcode);
                                }

                            }

                        })
   
    }); 

  
        var vrZipcodeID = '<%=GetFromQueryString("ZipcodeID")%>';
        $("#dvSaveOrderBtn").show();
        LoadOrderDetails();
        if (vrZipcodeID != undefined) {
            $('#ddlPickUpZip').val(vrZipcodeID);
            var ddlPickUpZipSelected = $("#ddlPickUpZip").find(":selected").text();
            //$('#txtDeliveryZip').val(ddlPickUpZipSelected);
        }

        var _vrAddress = '<%=Request.QueryString["Address"]%>';

        if (_vrAddress != undefined) {
            $('#txtPickUpAddress').val(_vrAddress);
            //$('#txtDeliveryAddress').val(_vrAddress);
        }

        if(vrUserID < 1)
        {
            //$('#loginModal').modal('show');
            $('#modalOrderLoginError').modal('show');
        }

    });

</script>

<script type="text/javascript">
    function LoadOrderDetails() {
        var vrOrderID = '<%=GetFromQueryString("OrderID")%>';
        if (vrOrderID > 0) {
            $.ajax({
                type: "GET",
                url: "/DesktopModules/GoGetIt/API/Order/Get?OrderID=" + vrOrderID,
                cache: false,
                contentType: "application/json",
                success: onSuccessLoadOrderDetails,
                error: onErrorLoadOrderDetails
            });
        }
    }
    function onSuccessLoadOrderDetails(result) {
        var o = eval(result);
        if (o.success == true) {

            $("#txtPickUpName").val(o.data.PickUpName);
            $("#txtPickUpAddress").val(o.data.GRI_Address.Address1);
            $("#ddlPickUpZip").val(o.data.GRI_Address.GRI_ZipCode.ZipCodeID);

            $("#txtPickUpApt").val(o.data.GRI_Address.Address2);

            $("#OrderDescription").val(o.data.Details);

            $("#txtDeliveryName").val(o.data.DeliveryName);
            $("#txtDeliveryAddress").val(o.data.GRI_Address1.Address1);
            $("#txtDeliveryApt").val(o.data.GRI_Address1.Address2);
            $("#txtDeliveryZip").val(o.data._DeliverZip);            

        }

    }
    function onErrorLoadOrderDetails(result) {
        if (result.status == 200) {
            onSuccessLoadOrderDetails(result);
        }
    }

</script>


<%--Load ZipCode Dropdown--%>
<script type="text/javascript">
    function LoadStateDropdown() {
        $.ajax({
            type: "GET",
            url: "/DesktopModules/GoGetIt/API/State/List?CountryID=" + 1,
            cache: false,
            contentType: "application/json",
            dataType: "application/json",
            success: onSuccessLoadStateDropdown,
            error: onErrorLoadStateDropdown
        });

    }
    function onSuccessLoadStateDropdown(result) {
        try {
            if (result.status == 200) {
                var o = eval(result.responseText);
                var vrdata = '';
                vrdata += '<select id="ddlState" class="form-control" >';
                vrdata += ' <option value=" " >State</option>';
                for (var i = 0; i < o.length; i++) {
                    vrdata += ' <option  value="' + o[i].StateID + '"  >' + o[i].Name + '</option>';
                }
                vrdata += "</select>";
                $("#dvStateDropdown").html(vrdata);
            }
            else {
                $("#dvStateDropdown").html("Could not load state list.");
            }
        }
        catch (e) {
            $("#dvStateDropdown").html("Could not load state list.");
        }
    }
    function onErrorLoadStateDropdown(result) {
        if (result.status == 200) {
            onSuccessLoadStateDropdown(result);
        }
    }
</script>


<%--Save Order--%>
<script type="text/javascript">

    function OrderLoginClose() {
        $('#modalOrderLoginError').modal('hide');
        document.getElementById("btnCreateAccountBtn").disabled = false;
    }
    function SaveOrder() {
        $("#dvSaveOrderBtn").hide();
        var validate = new Validator({ validation_group: 'SaveOrder', error_class: 'error' });
        validate.validate({
            txtPickUpName: "Sender's Name is required.",
            txtPickUpAddress: 'Address is required.',
            ddlPickUpZip: 'Zip code is required',
            OrderDescription: 'Order description is required.',
            txtDeliveryName: "Recipient's Name is required.",
            txtDeliveryAddress: 'Delivery Address is required.',
            txtDeliveryZip: 'Delivery Zip code is required',
            PickUpDate: 'Pick-up date is required',
            PickUpTime: 'Pick-up time is required',
        });

        if (validate.error == undefined) {
            $("#dvSaveOrderAlertDiv").html('');
        }
        else {
            jQuery("#OrderErrorModal").modal(open);
            $("#dvSaveOrderAlertDiv").html('<div class="alert alert-error">' + validate.error + '</div>');
            $("#dvSaveOrderBtn").show();
            return false;
        }

        if (validate.error == undefined) {
            $('#dvSaveOrderAlertDiv').html('');
            validate.checkMinLength('txtDeliveryZip', 5, 'Please enter the valid zip code.');
            $("#dvSaveOrderBtn").show();
        }
        else {
            $('#dvSaveOrderAlertDiv').html('');
        }


        if (vrUserID < 1) {
            $('#modalOrderLoginError').modal('show');
            return false;
        }

        var vPickUpName = $("#txtPickUpName").val();
        var vPickUpAddress = $("#txtPickUpAddress").val();
        var vPickUpApt = $("#txtPickUpApt").val();

        var vDescription = $("#OrderDescription").val();
        var vDeliveryName = $("#txtDeliveryName").val();
        /*var vDeliveryPhone = $("#txtDeliveryPhone").val();*/
        var vDeliveryAddress = $("#txtDeliveryAddress").val();
        var vDeliveryApt = $("#txtDeliveryApt").val();

        var _PickUpTime = $("#PickUpTime").val();
        var _PickUpDate = $("#PickUpDate").val();

        var mcontact = {
            UserID: vrUserID,            
            _DeliverZip: $('#txtDeliveryZip').val(),
            GRI_Address: { Address1: vPickUpAddress, Address2: vPickUpApt, ZipCodeID: parseInt(jQuery('#ddlPickUpZip').val()) },
            PickUpName: vPickUpName,
            DeliveryName: vDeliveryName,
            /*Deliveryphone: vDeliveryPhone,*/
            GRI_Address1: { Address1: vDeliveryAddress, Address2: vDeliveryApt },
            Details: vDescription,
            PickUpTime: _PickUpTime,
            PickUpDate: _PickUpDate

        };
        var objectAsJson = JSON.stringify(mcontact);
        //if (vrUserID > 1) {
        $.ajax({
            type: "POST",
            url: "/DesktopModules/GoGetIt/API/Order/Save",
            cache: false,
            data: objectAsJson,
            contentType: "application/json",
            success: onSuccessSaveOrder,
            error: onErrorSaveOrder
        });
        //}
    }
    function onSuccessSaveOrder(result) {
        var o = eval(result);
        if (o.success == true) {
            jQuery("#OrderErrorModal").modal(open);
            $("#dvSaveOrderAlertDiv").html('<div class="alert alert-success">Thank you for your order.</div>');
            window.location.href = '/OrderSummary?OrderID=' + o.data;
        }
        else {
            jQuery("#OrderErrorModal").modal(open);
            $("#dvSaveOrderAlertDiv").html('<div class="alert alert-error">"' + o.msg + '"</div>');
        }
    }
    function onErrorSaveOrder(result) {
        if (result.status == 200) {
            onSuccessSaveOrder(result);
        }
    }

</script>

<script>
    $(document).ready(function(){
        /**********************************************************************************************/
        
        /* datetime check*/
        var comparisonAM = '<%=DateTime.Compare(DateTime.Now, Convert.ToDateTime("10:00:00 AM")) %>';
        var comparisonPM = '<%=DateTime.Compare(DateTime.Now, Convert.ToDateTime("07:00:00 PM")) %>';
        
        var current = new Date();
        var validTime = false;
        var cd = current.getDay();
        console.log(cd);
        if(comparisonAM == 1 && comparisonPM == -1 && cd != 0)
        {
            validTime = true;
        }
        $('#comparisontimePM').val(validTime);
        $('#comparisontimeAM').val(validTime);
        /*end datetime check*/



        var days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];

        var current_day = current.getDay(); //return day of the week -> 0-6
        var current_d = current.getDate(); //return day of the month -> 1-31
        
        var current_month = current.getMonth()+1; //return months -> 0-11
        var current_year = current.getFullYear(); //return full year -> 2016
        
        if (current_month < 10) {
            var mask_month = "0"+current_month;
        } else {
            var mask_month = current_month;
        }

        var j=0;
        var mask_day;
        var mask_today;

        var current_hour = current.getHours()+":"+current.getMinutes()+":"+current.getSeconds();
        
        console.log(current_hour);

        if (current_d < 10)
        {
            mask_today = mask_month+"-0"+current_d+"-"+current_year;
        } else {
            mask_today = mask_month+"-"+current_d+"-"+current_year;
        }
        console.log(mask_today);

        for (var i = 0; i <= 10; i++)
        {   
            d1 = current_day + j;
            
            if (d1 == 7 ) {
                d1 = 0;
                j = 0;
                current_day = 0;
            }

            if (current_d < 10) {
                mask_day = "0"+current_d;
            } else {
                mask_day = current_d;
            }

            if(days[d1] != "Sunday")
            {
                var tomorrow = new Date();
                tomorrow.setDate(current.getDate()+i);
                mask_month = tomorrow.getMonth()+1;
                current_month = tomorrow.getMonth()+1;
                current_d = tomorrow.getDate();
                if (mask_month < 10)
                {
                    mask_month = "0"+mask_month;
                } else {
                    mask_month = mask_month;
                }
                if (current_d < 10) {
                    mask_day = "0"+current_d;
                } else {
                    mask_day = current_d;
                }
                $("#PickUpDate").append('<option value="'+mask_month+"-"+mask_day+"-"+current_year+'">'+current_month+"/"+(current_d)+" "+days[d1]+'</option>');
            }
            current_d+=1;
            j++;
        }

        var clone_PickUpTime = $("#PickUpDate").clone();

        /*logica 2*/
        
        $(document).on('change', '#PickUpDate', function(event) {
            event.preventDefault();
            var _val = $(this).val();

            if (_val == "ASAP")
            {
                $('#PickUpTime option').hide();
                $('#PickUpTime option').attr('disabled', 'disabled');
                $('#PickUpTime option').removeAttr('selected');

                $('#PickUpTime').removeClass('SaveOrder');
            
            }
            else 
            {
                if ($('#PickUpTime').hasClass('SaveOrder'))
                {

                } else {
                    $('#PickUpTime').addClass('SaveOrder');
                }

                if (_val == mask_today)
                {
                    
                    $('#PickUpTime option').show();
                    $('#PickUpTime option').removeAttr('disabled');
                    $('#PickUpTime').val("");

                    $("#PickUpTime option").each(function() {
                        
                        if ($(this).val() == "")
                        {

                        }
                        else {
                            
                            if (dateCompare(current_hour, $(this).val()) == 1)
                            {
                                $(this).prop('disabled', true);
                                $(this).addClass("black_disabled");
                                $(this).hide();
                                $(this).removeAttr('selected');
                            }

                        }

                    });

                }

                else {
                    $('#PickUpTime option').show();
                    $('#PickUpTime option').removeAttr('disabled');
                    $('#PickUpTime option').removeClass("black_disabled");
                }

            }

        });
        
        /****************************** Pickup Address Autocomplete *******************************/
        
        $("#txtDeliveryAddress").bind("cut copy paste",function(e) {
            e.preventDefault();
        });
        $("#txtPickUpAddress").bind("cut copy paste", function(e){
            e.preventDefault();
        });
        var myPostcodeBool = false;

        $(document).on("click", "#dvSaveOrderBtn", function(event) {
            event.preventDefault();
             $(".msg2").text("");
             $(".msg3").text("");
             $(".msg").text("");
            //SaveOrder()
            
            var searchTextField = $("#txtPickUpAddress").val();
            var validTimeSchedchule = $("#comparisontimeAM").val();
            var asap = $("#PickUpDate").val();

            if(validTimeSchedchule == "false" && asap == "ASAP")
            {
                $(".msg2").append("<strong>Sorry we are closed! </strong>Please schedule your order for pickup anytime during our hours of operation.");
                $(".msg3").text("We are open 10:00 AM – 07:00 PM, Monday thru Saturday.");
                $("#PickUpDate").focus();
            }
            else
            {
                //METODO 2 GOOGLE WEB SERVICES
                if (searchTextField != "") {

                    $.ajax({
                        url: 'http://maps.google.com/maps/api/geocode/json?components=administrative_area:FL|country:US',
                        dataType: 'json',
                        data: { address: searchTextField },

                        success: function(response) {
                            
                            var myAddress = response.results[0].formatted_address;
                            var myPostcode;

                            for (var i = 0; i < response.results[0].address_components.length; i++) {
                                for (var j = 0; j < response.results[0].address_components[i].types.length; j++) {
                                    if (response.results[0].address_components[i].types[j] == "postal_code") {
                                        myPostcode = response.results[0].address_components[i].long_name;
                                        break;
                                    }
                                }
                            }
                            console.log(myPostcode );
                                //metodo para validar que la direccion solo sea de ciertos zip codes
                            if ( myPostcode != undefined )
                            {

                            

                                $.each(arr_zipcode, function(index, val) {
                                    
                                    if ( val == myPostcode )
                                    {
                                        
                                        $(".msg").hide();
                                        
                                        $.each($("#ddlPickUpZip option"), function() {
                                                     
                                            if ($(this).text() == myPostcode)
                                            {
                                                myPostcodeBool = true;
                                                SaveOrder();
                                            }

                                        });
                                        
                                    }
                                    else {
                                        $(".msg").text("We´re sorry, our delivery range at this time is Miami-Dade County");
                                    }

                                });  

                            } else {
                                $(".msg").text("We´re sorry, our delivery range at this time is Miami-Dade County");
                            }
                            
                        //SaveOrder();
                        }

                    })
                    
                }
                else {
                    $(".msg").text("Please fill this field");
                    $("#txtPickUpAddress").focus(); 
                }
                //fin metodo 2 google web services
            }
            

        });

    });

    function dateCompare(time1,time2)
    {
        var t1 = new Date();
        var parts = time1.split(":");
        t1.setHours(parts[0],parts[1],parts[2],0);
        var t2 = new Date();
        parts = time2.split(":");
        t2.setHours(parts[0],parts[1],parts[2],0);

        // returns 1 if greater, -1 if less and 0 if the same
        if (t1.getTime()>t2.getTime()) return 1;
        if (t1.getTime()<t2.getTime()) return -1;
        return 0;
    }

</script>

<script>
    $(document).ready(function(){

        function initialize()
        {

            var options = {
                types: ['geocode'],
                componentRestrictions: {country: "us"}
            };

            var input = document.getElementById('txtDeliveryAddress');
            var pinput = document.getElementById('txtPickUpAddress');
            var autocomplete = new google.maps.places.Autocomplete(input, options);
            var pautocomplete = new google.maps.places.Autocomplete(pinput, options);
        }
        google.maps.event.addDomListener(window, 'load', initialize);
        
    })
</script>

<div class="dvOrderFormBG">
    <div class="dvOrderFormOuter">
        
        <div class="dvOrderFormRow">
           
            <div class="col-md-3 text-center">
                <div class="dvOrderBottomBigText text-center">
                    Pick-up Date and Time:
                </div>
                
                <div class="form-group">

                    <select class="SaveOrder select_style" id="PickUpDate">
                        <option value="">Date</option>
                        <option value="ASAP">As Soon As Possible</option>
                    </select>
                    <select class="SaveOrder select_style" id="PickUpTime">
                        <option value="">Time</option>
                        <option value="10:0:00">10:00 AM</option>
                        <option value="10:15:00">10:15 AM</option>
                        <option value="10:30:00">10:30 AM</option>
                        <option value="10:45:00">10:45 AM</option>
                        <option value="11:0:00">11:00 AM</option>
                        <option value="11:15:00">11:15 AM</option>
                        <option value="11:30:00">11:30 AM</option>
                        <option value="11:45:00">11:45 AM</option>
                        <option value="12:0:00">12:00 PM</option>
                        <option value="12:15:00">12:15 PM</option>
                        <option value="12:30:00">12:30 PM</option>
                        <option value="12:45:00">12:45 PM</option>
                        <option value="13:0:00">01:00 PM</option>
                        <option value="13:15:00">01:15 PM</option>
                        <option value="13:30:00">01:30 PM</option>
                        <option value="13:45:00">01:45 PM</option>
                        <option value="14:0:00">02:00 PM</option>
                        <option value="14:15:00">02:15 PM</option>
                        <option value="14:30:00">02:30 PM</option>
                        <option value="14:45:00">02:45 PM</option>
                        <option value="15:0:00">03:00 PM</option>
                        <option value="15:15:00">03:15 PM</option>
                        <option value="15:30:00">03:30 PM</option>
                        <option value="15:45:00">03:45 PM</option>
                        <option value="16:0:00">04:00 PM</option>
                        <option value="16:15:00">04:15 PM</option>
                        <option value="16:30:00">04:30 PM</option>
                        <option value="16:45:00">04:45 PM</option>
                        <option value="17:0:00">05:00 PM</option>
                        <option value="17:15:00">05:15 PM</option>
                        <option value="17:30:00">05:30 PM</option>
                        <option value="17:45:00">05:45 PM</option>
                        <option value="18:0:00">06:00 PM</option>
                        <option value="18:15:00">06:15 PM</option>
                        <option value="18:30:00">06:30 PM</option>
                        <option value="18:45:00">06:45 PM</option>
                        <option value="19:0:00">07:00 PM</option>
                        <!--<option value="19:15:00">07:15 PM</option>
                        <option value="19:30:00">07:30 PM</option>
                        <option value="19:45:00">07:45 PM</option>
                        <option value="20:0:00">08:00 PM</option>
                        <option value="20:15:00">08:15 PM</option>
                        <option value="20:30:00">08:30 PM</option>
                        <option value="20:45:00">08:45 PM</option>
                        <option value="21:0:00">09:00 PM</option>
                        <option value="21:15:00">09:15 PM</option>
                        <option value="21:30:00">09:30 PM</option>
                        <option value="21:45:00">09:45 PM</option>
                        <option value="22:0:00">10:00 PM</option>-->
                    </select>
                    <br><br>
                </div>
                <p class="text-center msg2" style="color: #444;margin-top: -30px;"></p>
                <p class="text-center msg3" style="color: #444;"></p>
            </div>

            <div class="col-md-3">
                <div class="dvOrderBottomBigText text-center">
                    Pick-Up Location:
                </div>
                
                <div class="form-group">
                    <input type="text" class="form-control SaveOrder" id="txtPickUpAddress" placeholder="Address " >
                    <p class="text-center msg" style="color: #444;margin-top: 15px;"></p>
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" id="txtPickUpApt" placeholder="Apt/Unit">
                </div>

                <div class="form-group">

                    <select class="form-control SaveOrder " id="ddlPickUpZip" >
                        <option value=" ">Zip code </option>
                        <option value = "6607">33010</option>
                        <option value = "6609">33012</option>
                        <option value = "6610">33013</option>
                        <option value = "6611">33014</option>
                        <option value = "6612">33015</option>
                        <option value = "6613">33016</option>
                        <option value = "6615">33018</option>
                        <option value = "6618">33019</option>
                        <option value = "6632">33030</option>
                        <option value = "6633">33031</option>
                        <option value = "6634">33032</option>
                        <option value = "6635">33033</option>
                        <option value = "6636">33034</option>
                        <option value = "6637">33035</option>
                        <option value = "6638">33039</option>
                        <option value = "6775">33054</option>
                        <option value = "6776">33055</option>
                        <option value = "6777">33056</option>
                        <option value = "6639">33090</option>
                        <option value = "6640">33092</option>
                        <option value = "6669">33101</option>
                        <option value = "6671">33106</option>
                        <option value = "6764">33109</option>
                        <option value = "6673">33112</option>
                        <option value = "6676">33122</option>
                        <option value = "6678">33125</option>
                        <option value = "6679">33126</option>
                        <option value = "6680">33127</option>
                        <option value = "6681">33128</option>
                        <option value = "6682">33129</option>
                        <option value = "6683">33130</option>
                        <option value = "6684">33131</option>
                        <option value = "6685">33132</option>
                        <option value = "6686">33133</option>
                        <option value = "6687">33134</option>
                        <option value = "6688">33135</option>
                        <option value = "6689">33136</option>
                        <option value = "6690">33137</option>
                        <option value = "6691">33138</option>
                        <option value = "6766">33139</option>
                        <option value = "6767">33140</option>
                        <option value = "6768">33141</option>
                        <option value = "6692">33142</option>
                        <option value = "6693">33143</option>
                        <option value = "6694">33144</option>
                        <option value = "6695">33145</option>
                        <option value = "6696">33146</option>
                        <option value = "6697">33147</option>
                        <option value = "6698">33149</option>
                        <option value = "6699">33150</option>
                        <option value = "6700">33151</option>
                        <option value = "6701">33152</option>
                        <option value = "6702">33153</option>
                        <option value = "6769">33154</option>
                        <option value = "6703">33155</option>
                        <option value = "6704">33156</option>
                        <option value = "6705">33157</option>
                        <option value = "6706">33158</option>
                        <option value = "6708">33160</option>
                        <option value = "6709">33161</option>
                        <option value = "6710">33162</option>
                        <option value = "6713">33165</option>
                        <option value = "6714">33166</option>
                        <option value = "6715">33167</option>
                        <option value = "6716">33168</option>
                        <option value = "6717">33169</option>
                        <option value = "6718">33170</option>
                        <option value = "6719">33172</option>
                        <option value = "6720">33173</option>
                        <option value = "6721">33174</option>
                        <option value = "6722">33175</option>
                        <option value = "6723">33176</option>
                        <option value = "6724">33177</option>
                        <option value = "6725">33178</option>
                        <option value = "6726">33179</option>
                        <option value = "6727">33180</option>
                        <option value = "6728">33181</option>
                        <option value = "6729">33182</option>
                        <option value = "6730">33183</option>
                        <option value = "6731">33184</option>
                        <option value = "6732">33185</option>
                        <option value = "6733">33186</option>
                        <option value = "6734">33187</option>
                        <option value = "6735">33188</option>
                        <option value = "6736">33189</option>
                        <option value = "6737">33190</option>
                        <option value = "6738">33193</option>
                        <option value = "6739">33194</option>
                        <option value = "6740">33196</option>
                        <option value = "6742">33199</option>
                        
                        </select>
                </div>

                <div class="form-group">
                    <input type="text" class="form-control SaveOrder" id="txtPickUpName" placeholder="Sender's Name">
                </div>
            </div>

            

           

            <div class="col-md-3">
                <div class="dvOrderBottomBigText text-center" >
                    ORDER DETAILS:
                    
                </div>
                <div class="form-group">
                    <textarea class="form-control SaveOrder" id="OrderDescription" placeholder=" Example: 
'Be careful, it´s fragile',
'Pickup two white bags',
'Recipient will be at the front desk of the building'."></textarea>
                </div>
            </div>

            <div class="col-md-3">
                <div class="dvOrderBottomBigText text-center">
                    Delivery Address:
                </div>
                
                <div class="form-group">
                    <input type="text" class="form-control SaveOrder" id="txtDeliveryAddress" placeholder="Address">
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" id="txtDeliveryApt" placeholder="Apt/Unit">
                </div>

                
                
                <!--<div class="form-group">
                    <input type="text" class="form-control SaveOrder" id="txtDeliveryPhone" placeholder="Recipients phone">
                </div>-->
                <div class="form-group">
                    <input type="text" class="form-control SaveOrder validate-int"  maxlength="5" id="txtDeliveryZip" placeholder="Zip code">
                </div>
               <div class="form-group">
                    <input type="text" class="form-control SaveOrder" id="txtDeliveryName" placeholder="Recipient's Name">
                </div>
            </div>

            <div class="dvReciveOrderBtn">
                <!--<img src="/images/ReviewOrderBtn.png" class="CursorPointer" id="dvSaveOrderBtn" onclick="SaveOrder();" />-->
                <!--<img src="/images/ReviewOrderBtn.png" class="CursorPointer" id="dvSaveOrderBtn" />-->
                <div class="btn-calcular" style="margin-top: 0px;margin-left: 0px;width: 250px;">
    <div class="texto-boton" style="text-transform: none;">
        <a style="text-decoration: none;color: #fff;" class="CursorPointer" id="dvSaveOrderBtn">Review Order Summary</a>
    </div>
</div>
                <input type="hidden" id="comparisontimePM" name="comparisontimePM">
                <input type="hidden" id="comparisontimeAM" name="comparisontimeAM">
            </div>
        </div>
    </div>
</div>



<!--Error Modal-->
<div class="modal fade" id="OrderErrorModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="dvRow">
                    <div id="dvSaveOrderAlertDiv"></div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="modalOrderLoginError" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">

            <div class="modal-body">
                <div class="modalOrderLoginErrorInner">
                    <div class="loginLogo">
                        <img src="/images/LoginLogo.png">
                    </div>
                    <div class="dvRow">
                        <div class="form-group">
                            <a href="#" title="Export Data" onclick="OrderLoginClose();" class=" loginModalOrder" data-target="#loginModal" data-toggle="modal">Log In</a>
                        </div>
                        <div class="form-group text-center" style="font-weight: bold;">OR</div>
                        <div class="form-group">
                            <a href="#" title="Export Data" onclick="OrderLoginClose();" class=" signupModalOrder" data-target="#signupModal" data-toggle="modal">Sign Up</a>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>
</div>
<style>
    #modalOrderLoginError .modal-dialog {
        max-width: 420px;
        width: 420px;
    }

    #modalOrderLoginError .modalOrderLoginErrorInner {
        background: #fff none repeat scroll 0 0;
        border-radius: 0;
        margin: auto;
        max-width: 350px;
        padding: 0 25px 15px;
        width: 100%;
    }


    #modalOrderLoginError .signupModalOrder, #modalOrderLoginError .signupModalOrder:hover {
    background-color: #020202 /* amariillo*/;
    border: medium none;
    color: #fff;
    font-size: 16px;
    padding: 6px 12px;
    text-align: center;
    text-transform: uppercase;
    width: 100%;
    display: inline-block;
    text-decoration: none;
}
.dvReciveOrderBtn {
    margin-top: 12px;
    float: right;
    clear: both;
    padding: 0px 15px;
}
    @media all and (max-width: 440px) {
        #modalOrderLoginError .modal-dialog {
            width: 300px;
        }

        #modalOrderLoginError .modalOrderLoginErrorInner {
            padding: 0px;
        }
    }
</style>
