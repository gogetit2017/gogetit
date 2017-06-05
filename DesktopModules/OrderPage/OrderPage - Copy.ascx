<%@  Control Language="C#" AutoEventWireup="true" CodeBehind="OrderPage.ascx.cs" Inherits="GoGetIt.OrderPage" %>


<script src="/js/jquery.validator.min.js" type="text/javascript"></script>

<link href="/js/AlertModal.css" rel="stylesheet" type="text/css" />
  
	<style>
	#OrderDescription{  height:189px;}
	</style>

<script type="text/javascript">
    var vrUserID = '<%=LOGGEDINUSERID %>';
       var vrDeliveryType = '<%=GetFromQueryStringStringFormat("DeliveryType")%>';
       var vrZipcode = '<%=GetFromQueryString("Zipcode")%>';
       var vrZipcodeID = '<%=GetFromQueryString("ZipcodeID")%>';
    $(document).ready(function () {
		$('#txtPickUpZip').val(vrZipcode);
		$('#txtDeliveryZip').val(vrZipcode);
		$('#dvFoodDelivery').html(vrDeliveryType);
    });
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
    function SaveOrder() {
        var validate = new Validator({ validation_group: 'SaveOrder', error_class: 'error' });
        validate.validate({
            txtPickUpName: 'Name is required.',
            txtPickUpAddress: 'Address is required.',
            txtPickUpApt: 'Apt/Unit is required.',            
            txtPickUpZip: 'Zip code is required',
            OrderDescription: 'Order description is required.',
            txtDeliveryName: 'Name is required.',
            txtDeliveryAddress: 'Delivery Address is required.',
            txtDeliveryApt: 'Delivery Apt/Unit is required.',             
            txtDeliveryZip: 'Delivery Zip code is required',
        });
        if (validate.error == undefined) {
            $("#dvSaveOrderAlertDiv").html('');
        }
        else {
            $("#dvSaveOrderAlertDiv").html('<div class="alert alert-error">' + validate.error + '</div>');
            return false;
        }
        var vPickUpName = $("#txtPickUpName").val();
        var vPickUpAddress = $("#txtPickUpAddress").val();
        var vPickUpApt = $("#txtPickUpApt").val();       
       
        var vDescription = $("#OrderDescription").val();
        var vDeliveryName = $("#txtDeliveryName").val();
        var vDeliveryAddress = $("#txtDeliveryAddress").val();
        var vDeliveryApt = $("#txtDeliveryApt").val();        
         
			
		var vrhfDeliveryZip = parseInt($('#hfDeliveryZip').val());
		var vrDeliveryZipID=vrZipcodeID;		
		if(vrhfDeliveryZip>0){
			vrDeliveryZipID=vrhfDeliveryZip;
		}
		
		var vrhfPickUpZip = parseInt($('#hfPickUpZip').val());
		var vrPickUpZipID=vrZipcodeID;
		if(vrhfPickUpZip>0){
			vrPickUpZipID=vrhfPickUpZip;
		}
        var mcontact = {
            UserID: vrUserID,
            DeliveryType: vrDeliveryType,
            GRI_Address: { Address1: vPickUpAddress, Address2: vPickUpApt, ZipCodeID: vrPickUpZipID },
            PickUpName: vPickUpName,
            DeliveryName: vDeliveryName,
            GRI_Address1: { Address1: vDeliveryAddress, Address2: vDeliveryApt, ZipCodeID: vrDeliveryZipID },
            Details: vDescription,

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
            $("#dvSaveOrderAlertDiv").html('<div class="alert alert-success">Thank you for your order.</div>');
            window.location.href = '/OrderSummary?OrderID=' + o.data;
        }
        else {
            $("#dvSaveOrderAlertDiv").html('<div class="alert alert-error">There was an error submitting the order.</div>');
        }
    }
    function onErrorSaveOrder(result) {
        if (result.status == 200) {
            onSuccessSaveOrder(result);
        }
    }

</script>



<div class="dvOrderFormBG">
    <div class="dvOrderFormOuter">
        <div class="dvOrderBottomBigText">
            Delivery Type: <span class="dvOrderBottomSmallText" id="dvFoodDelivery">Food Delivery</span>
        </div>
        <div class="dvOrderFormRow">
            <div class="dvOrderFormCol1">
                <div class="dvOrderBottomBigText">
                    Pick-Up Location:
                </div>
                <div class="form-group">
                    <input type="text" class="form-control SaveOrder" id="txtPickUpName" placeholder="Name">
                </div>
                <div class="form-group">
                    <input type="text" class="form-control SaveOrder" id="txtPickUpAddress" placeholder="Address 1">
                </div>
                <div class="form-group">
                    <input type="text" class="form-control SaveOrder" id="txtPickUpApt" placeholder="Apt/Unit">
                </div>
               
                <div class="form-group">                    
                        <input type="text" class="form-control SaveOrder validate-int"  id="txtPickUpZip" maxlength="5" placeholder="Zip" />					
                   
                </div>
            </div>

            <div class="dvOrderFormCol2">
                <div class="dvOrderBottomBigText">
                    Specify & Describe Order:
                </div>
                <div class="form-group">
                    <textarea class="form-control SaveOrder" id="OrderDescription" placeholder="Please enter full details of your order..."></textarea>
                </div>
            </div>

            <div class="dvOrderFormCol3">
                <div class="dvOrderBottomBigText">
                    Delivery Address:
                </div>
                <div class="form-group">
                    <input type="text" class="form-control SaveOrder" id="txtDeliveryName" placeholder="Name">
                </div>
                <div class="form-group">
                    <input type="text" class="form-control SaveOrder" id="txtDeliveryAddress" placeholder="Address 1">
                </div>
                <div class="form-group">
                    <input type="text" class="form-control SaveOrder" id="txtDeliveryApt" placeholder="Apt/Unit">
                </div>
                 
                <div class="form-group">                    
                    <input type="text" class="form-control SaveOrder validate-int" id="txtDeliveryZip" maxlength="5" placeholder="Zip">
                </div>
            </div>

            <div class="dvReciveOrderBtn">
                <img src="/images/ReviewOrderBtn.png" class="CursorPointer" onclick="SaveOrder();" />
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="hfPickUpZip" />
<input type="hidden" id="hfDeliveryZip" />
<div class="" style="width: 85%; clear: both; margin: 10px auto;">
    <div id="dvSaveOrderAlertDiv"></div>
</div>

    <link href="/js/bootstrap.min.css" rel="stylesheet" />
    <script src="http://code.jquery.com/jquery-1.8.0.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/bootstrap-typeahead.js"></script>
	
	<script>
    $(function () {
        function displayResultPickUpZip(item) {
            $('.alert').show().html('You selected <strong>' + item.value + '</strong>: <strong>' + item.text + '</strong>');
			$('#hfPickUpZip').val(item.value);
        }
		
        $('#txtPickUpZip').typeahead({             
			ajax: {
			url: "/DesktopModules/GoGetIt/API/ZipCode/GetZipByZipCodeForTypeaHead",
			 method: 'get',
			triggerLength: 2,				 
			 },
			  scrollBar:true,
			displayField: 'name',
            valueField: 'id',
            onSelect: displayResultPickUpZip
        });  
		
		function displayResultDeliveryZip(item) {
            $('.alert').show().html('You selected <strong>' + item.value + '</strong>: <strong>' + item.text + '</strong>');
			$('#hfDeliveryZip').val(item.value);
        }
		
        $('#txtDeliveryZip').typeahead({             
			ajax: {
				url: "/DesktopModules/GoGetIt/API/ZipCode/GetZipByZipCodeForTypeaHead",
				method: 'get',
				triggerLength: 2	
			 },
			  scrollBar:true,
			displayField: 'name',
            valueField: 'id',
            onSelect: displayResultDeliveryZip
        }); 
         
    });
	
	 
	
        </script>
		
		 