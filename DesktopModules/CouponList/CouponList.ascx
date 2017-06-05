<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CouponList.ascx.cs" Inherits="GoGetIt.CouponList" %>
<script src="/js/jquery.paginate.min.js"></script>

<style>
	input[type=date] {
		padding: 8px 9px;
	    background: #f3f3f3;
	    border: 1px solid #bfbfbf;
	    -webkit-border-radius: 0px;
	    border-radius: 0px;
	    -webkit-box-shadow: 0px 1px 0px 0px rgba(255, 255, 255, 0.8), inset 0px 1px 2px 0px rgba(0, 0, 0, 0.1);
	    box-shadow: 0px 1px 0px 0px rgba(255, 255, 255, 0.8), inset 0px 1px 2px 0px rgba(0, 0, 0, 0.1);
	    color: #666;
	    font-size: 12px;
	}

	.table-responsive {
	    overflow-x: auto;
    	min-height: 0.01%;
	}
	.table {
		border-collapse: collapse;
		width: 100%;
		margin-bottom: 20px;
	}
	.table>caption+thead>tr:first-child>th, .table>colgroup+thead>tr:first-child>th, .table>thead:first-child>tr:first-child>th, .table>caption+thead>tr:first-child>td, .table>colgroup+thead>tr:first-child>td, .table>thead:first-child>tr:first-child>td {
	    border-top: 0;
	}
	.table-bordered>thead>tr>th, .table-bordered>thead>tr>td {
	    border-bottom-width: 2px;
	}
	.table-bordered>thead>tr>th, .table-bordered>tbody>tr>th, .table-bordered>tfoot>tr>th, .table-bordered>thead>tr>td, .table-bordered>tbody>tr>td, .table-bordered>tfoot>tr>td {
	    border: 1px solid #dddddd;
	}
	.table-condensed>thead>tr>th, .table-condensed>tbody>tr>th, .table-condensed>tfoot>tr>th, .table-condensed>thead>tr>td, .table-condensed>tbody>tr>td, .table-condensed>tfoot>tr>td {
	    padding: 5px;
	}
	.table>thead>tr>th {
	    vertical-align: bottom;
	    border-bottom: 2px solid #dddddd;
	}
	.table>thead>tr>th, .table>tbody>tr>th, .table>tfoot>tr>th, .table>thead>tr>td, .table>tbody>tr>td, .table>tfoot>tr>td {
	    padding: 8px;
	    line-height: 1.42857143;
	    vertical-align: top;
	    border-top: 1px solid #dddddd;
	}
	th {
	    text-align: center;
	}
	.text-center {
		text-align: center;
	}
	.text-left {
		text-align: left;
	}
	.text-right {
		text-align: right;
	}

	.btn-success {
	    color: #fff;
	    background-color: #5cb85c;
	    border-color: #4cae4c;
	}
	.btn {
	    display: inline-block;
	    padding: 6px 12px;
	    margin-bottom: 0;
	    font-size: 14px;
	    font-weight: 400;
	    line-height: 1.42857143;
	    text-align: center;
	    white-space: nowrap;
	    vertical-align: middle;
	    -ms-touch-action: manipulation;
	    touch-action: manipulation;
	    cursor: pointer;
	    -webkit-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    user-select: none;
	    background-image: none;
	    border: 1px solid transparent;
	    border-radius: 4px;
	}

	.createButtonWrapper {
		margin-bottom: 20px;
	}

	.dnnFormMessage {
		max-width: 1170px;
	}

	.tblCreateUser {
		margin-bottom: 25px;
		width: 100%;
		background: #F2F2F2;
	}

	.tblCreateUser tr td {
		padding: 10px;
		vertical-align: top;
	}

	.tblCreateUser tr td input, select {
		margin-bottom: 0;
	}

	.table {
		background: #F2F2F2;
	}

	.invalid {
		border: 1px solid #f00 !important;
	}

	#tblCouponListItem tbody tr td { text-align: center; }

	.error {
		display: block;
	    color: #f00;
	    font-size: 10px;
	}
	#myPagination, #myPagination-pagination {
		display: none;
	}
	#myPagination-pagination {
		text-align: right
	}
	a.disabled {
	    text-decoration: none;
	    color: black;
	    cursor: default;
	}

	.txtState {
		margin-bottom: 0 !important;
		max-width: 120px;
		text-align: center;
		padding: 3px !important;
	}
</style>

<script>
	$(document).ready(function(){



		$(document).on("click", "#btnAddNow", function(event){
			event.preventDefault();

			var CouponCode;
			var DiscountType;
			var CouponValue;
			var StartDate;
			var EndDate;
			var State;

			if ($("#txtCouponCode").val() != "")
			{
				$("#txtCouponCode").removeClass("invalid");
				CouponCode = $("#txtCouponCode").val();
			} else {
				$("#txtCouponCode").addClass("invalid");
				$("#txtCouponCode").focus();
				return false;
			}

			if ($("#optDiscount").val().length > 0)
			{
				$("#optDiscount").removeClass("invalid");
				DiscountType = $("#optDiscount").val();
			} else {
				$("#optDiscount").addClass("invalid");
				$("#optDiscount").focus();
				return false;
			}

			if (DiscountType == "percentage")
			{
				if ($("#txtCouponValue").val() != "" && Number($("#txtCouponValue").val()) > 0.00 && Number($("#txtCouponValue").val()) < 100.00)
				{
					$("#txtCouponValue").removeClass("invalid");
					CouponValue = $("#txtCouponValue").val();
				} else {
					$("#txtCouponValue").addClass("invalid");
					$("#txtCouponValue").focus();
					return false;
				}
			}
			else {
				if ($("#txtCouponValue").val() != "" && Number($("#txtCouponValue").val()) > 0.00)
				{
					$("#txtCouponValue").removeClass("invalid");
					CouponValue = $("#txtCouponValue").val();
				} else {
					$("#txtCouponValue").addClass("invalid");
					$("#txtCouponValue").focus();
					return false;
				}
			}

			if ($("#txtStartDate").val() != "" && isValidDate($("#txtStartDate").val()))
			{
				$("#txtStartDate").removeClass("invalid");
				StartDate = $("#txtStartDate").val();
			} else {
				$("#txtStartDate").addClass("invalid");
				$("#txtStartDate").focus();
				return false;
			}

			if ($("#txtEndDate").val() != "" && isValidDate($("#txtEndDate").val()) && $("#txtEndDate").val() > $("#txtStartDate").val())
			{
				$("#txtEndDate").removeClass("invalid");
				$("#txtEndDate").parent().find(".error").remove();
				EndDate = $("#txtEndDate").val();
			} else {
				$("#txtEndDate").parent().append("<span class='error'>EndDate must be higher than StartDate</span>");
				$("#txtEndDate").addClass("invalid");
				$("#txtEndDate").focus();
				return false;
			}

			if ($("#optState").val() != "")
			{
				$("#optState").removeClass("invalid");
				State = $("#optState").val();
			} else {
				$("#optState").addClass("invalid");
				$("#optState").focus();
				return false;
			}

			if ( CouponCode != "" && DiscountType != "" && CouponValue != "" && StartDate != "" && EndDate != "" && State != "")
			{
				var myJSON = { 
					CouponCode: CouponCode, 
					CouponValue: CouponValue,
					StartDate: StartDate,
					EndDate: EndDate,
					State: State,
					DiscountType: DiscountType
				};
        		
        		var objectAsJson = JSON.stringify(myJSON);
				
				$.ajax({
				    type: "POST",
		            url: "/DesktopModules/GoGetIt/API/Coupon/CouponInsert",
		            cache: false,
		            data: objectAsJson,
		            contentType: "application/json",
		            
		            beforeSend: function(){
		            	$("#alert_action").html("<center><img src='/images/ajax-loader.gif'></center>");
		            },
		            success: function(response){

		            	if (response == true)
		            	{
		            		$("#alert_action").html("<center>Coupon added successfully!</center>");

		            		setTimeout(function(){
		            		  $("#alert_action").html('');
		            		}, 2000);

		            		$(".tblCreateUser").find("input").val("");
		            		loadCouponListItem();
		            	}
		            }

				})

			} else {
				alert("Please, fill all fields...");
			}

		});

		loadCouponListItem();

		$(document).on("click", ".delete", function(event){
			event.preventDefault();

			var r = confirm("Are you sure to delete this record?");
			
			if (r == true)
			{
				var id = $(this).data("id");

				if (Number(id) > 0)
				{
					$.ajax({
					    type: "PUT",
			            url: "/DesktopModules/GoGetIt/API/Coupon/CouponDelete?CouponID="+Number(id),
			            cache: false,
			            contentType: "application/json",
			            success: function(response){
			            	
			            	if (response == true)
			            	{
			            		$("#alert_action").html("<center>Coupon deleted successfully!</center>");
			            		
			            		setTimeout(function(){
			            		  $("#alert_action").html('');
			            		}, 2000);

			            		loadCouponListItem();

			            	}
			            }

					});
				}
				else {

				}
			}

		});

		$(document).on("click", ".linkChangeState", function(event){
			event.preventDefault();

			var r = confirm("Are you sure to update state this record?");
			
			if (r == true)
			{
				var id = $(this).data("id");
				var state = $(this).parent().parent().find(".txtState").val();

				if ( Number(id) > 0 && $.isNumeric(state) && Number(state) >= 0 )
				{
					var myJSON = { 
						CouponID: Number(id),
						State: state
					};
	        		
	        		var objectAsJson = JSON.stringify(myJSON);

					$.ajax({
					    type: "POST",
					    data: objectAsJson,
			            url: "/DesktopModules/GoGetIt/API/Coupon/UpdateSingleCoupon",
			            cache: false,
			            contentType: "application/json",
			            success: function(response){
			            	
			            	if (response == true)
			            	{
			            		$("#alert_action_update").html("<center>Coupon updated successfully!</center>");
			            		
			            		setTimeout(function(){
			            		  $("#alert_action_update").html('');
			            		  loadCouponListItem();
			            		}, 1000);

			            		

			            	}
			            }

					});
				}
				else {
					alert("Please enter number 0-1");
				}
			}

		});
		

	});

	function loadCouponListItem()
	{
		$.ajax({
		    type: "GET",
            url: "/DesktopModules/GoGetIt/API/Coupon/CouponList",
            cache: false,
            contentType: "application/json",
            
            beforeSend: function(){
            	$("#tblCouponListItem tbody tr").remove();
            	$("#tblCouponListItem tbody").html("<tr><td colspan='7'><center><img src='/images/ajax-loader.gif'></center></td></tr>");
            },
            
            success: function(result) {

            	var json = eval(result);
            	
            	if (json.success == true)
            	{
            		var data = {items: json.data};

            		$("#tblCouponListItem tbody tr").remove();
            		
            			var items = [];

            			$.each(data.items, function(i, item) {
            				//console.log(item.CouponID);	
            				var arr_StartDate = item.StartDate.split("-");
            				var StartDateDay = arr_StartDate[2].split("T");
            				var StartDateF = arr_StartDate[0]+"-"+arr_StartDate[1]+"-"+StartDateDay[0];

            				var arr_EndDate = item.EndDate.split("-");
            				var _EndDateDay = arr_EndDate[2].split("T");
            				var EndDateF = arr_EndDate[0]+"-"+arr_EndDate[1]+"-"+_EndDateDay[0];

            				//Create rows | columns and fill data
            				items.push("<tr><td>"+item.CouponCode+"</td><td>"+item.DiscountType+"</td><td>"+item.CouponValue+"</td><td>"+StartDateF+"</td><td>"+EndDateF+"</td><td><select class='txtState'><option "+((item.State == 0) ? 'selected=""' : '')+" value='0'>Disabled</option><option "+((item.State == 1) ? 'selected=""' : '')+" value='1'>Enable</option></select></td><td><a class='linkChangeState' href='#' data-id='"+item.CouponID+"'>Change State</a></td><td><a href='#' class='delete' data-id='"+item.CouponID+"'>Delete</a></td></tr>");

            			});

            			$('#myPagination').append(items.join(''));
            			$('#myPagination').paginate({itemsPerPage: 10});

            		/*
            		$.each(json.data, function(index, value){
            			
            			var arr_StartDate = value.StartDate.split("-");
            			var StartDateDay = arr_StartDate[2].split("T");
            			var StartDateF = arr_StartDate[0]+"-"+arr_StartDate[1]+"-"+StartDateDay[0];

            			var arr_EndDate = value.EndDate.split("-");
            			var _EndDateDay = arr_EndDate[2].split("T");
            			var EndDateF = arr_EndDate[0]+"-"+arr_EndDate[1]+"-"+_EndDateDay[0];

            			//Create rows | columns and fill data
            			$("#tblCouponListItem tbody").append("<tr><td>"+value.CouponCode+"</td><td>"+value.CouponValue+"</td><td>"+StartDateF+"</td><td>"+EndDateF+"</td><td>"+value.State+"</td><td><a href='#' class='delete' data-id='"+value.CouponID+"'>Delete</a></td></tr>");

            		});
            		*/
            	}
            	else {
            		$("#tblCouponListItem #myPagination").fadeIn();
            		$("#tblCouponListItem tbody tr td").html("<center>No record matches...</center>");
            	}
            }

		});
	}


	function isValidDate(dateString)
	{
		var regEx = /^\d{4}-\d{2}-\d{2}$/;
		return dateString.match(regEx) != null;
	}


</script>

<div class="table-responsive">
	<table class="tblCreateUser">
		<tr>
			<td colspan="7">
				<label style="color: #000; font-weight: bold; font-size: 18px;">Register Coupon</lable>
				<div id="alert_action"></div>
			</td>
		</tr>
		<tr>
			<td><span>Coupon Code (Max 20 Char).</span></td>
			<td><span>Discount Type</span></td>
			<td><span>Coupon Value</span></td>
			<td><span>Start Date </span></td>
			<td><span>End Date </span></td>
			<td><span>State</span></td>
			<td></td>
		</tr>
		
		<tr>
			<td><input type="text" maxlength="20" placeholder="Coupon Code" id="txtCouponCode"></td>
			<td>
				<select id="optDiscount">
					<option value="">Select option</option>
					<option value="percentage">Discount Percentage</option>
					<option value="cash">Discount Cash</option>
					<option value="fixed">Fixed</option>
				</select>
			</td>
			<td><input type="text" maxlength="5" placeholder="Coupon Value" id="txtCouponValue"></td>
			<td><input type="date" maxlength="10" placeholder="YYYY-MM-DD" id="txtStartDate"></td>
			<td><input type="date" maxlength="10" placeholder="YYYY-MM-DD" id="txtEndDate"></td>
			<td>
				<select id="optState">
					<option value="0">Disabled</option>
					<option value="1">Enable</option>
				</select>
			</td>
			<td><button type="button" class="btn btn-success" id="btnAddNow">Add coupon</button></td>
		</tr>
	</table>
</div>

<hr style="border-color: #E5E5E5;">

<div class="table-responsive">
	<table id="tblCouponListItem" class="table table-striped table-hover table-bordered table-condensed">
		<thead>
			<tr>
				<td colspan="8">
					<label style="color: #000; font-weight: bold; font-size: 18px;">Coupon List</lable>
					<div id="alert_action_update"></div>
				</td>
			</tr>
			<tr>
				<th>Coupon Code</th>
				<th>Discount Type</th>
				<th>Coupon Value</th>
				<th>Start Date</th>
				<th>End Date</th>
				<th>State</th>
				<th colspan="2">Action</th>
			</tr>
		</thead>
		
		<tbody id="myPagination">
			<tr>
				<td colspan="7" class="text-center">
					No record matches...
				</td>
			</tr>	
		</tbody>

	</table>
	 <div id="myPagination-pagination">
        <a id="myPagination-previous" href="#">&laquo; Previous</a> 
        <a id="myPagination-next" href="#">Next &raquo;</a> 
    </div>
</div>
