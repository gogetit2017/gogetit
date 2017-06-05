<%@  Control Language="C#" AutoEventWireup="true" CodeBehind="OrderList.ascx.cs" Inherits="GoGetIt.OrderList" %>
<script src="/js/GoGetIt.js"></script>


<style type="text/css">
    #ddlOrderStatus {
        max-width: 300px;
    }

    .col-sm-9 > div {
        padding-top: 10px;
    }
</style>
<script type="text/javascript">
    function LoadOrderDetails(vrOrderID) {
        if (vrOrderID > 0) {
            $('#detailModal').modal('show');
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
            if (o.data.DriverUserID != null && o.data.DriverUserID != undefined) {
                $("#lblDriverID").html(o.data.DriverUserID);
                $("#lblDriverName").html(o.data.DriverName);
            } else {
                $("#lblDriverID").html("N/A");
                $("#lblDriverName").html("N/A");
            }
            var TimeAccept = 'N/A';
            if (o.data.TimeDriverAccepted != null && o.data.TimeDriverAccepted != undefined) {
                TimeAccept = new Date(o.data.TimeDriverAccepted);
            }
            var TimeComplete = 'N/A';
            if (o.data.TimeDriverCompleted != null && o.data.TimeDriverCompleted != undefined) {
                TimeAccept = new Date(o.data.TimeDriverCompleted);
            }
            $("#lblTimeDriverAccepted").html(TimeAccept);
            $("#lblTimeDriverCompleted").html(TimeComplete);
            $("#lblPickUpName").html(o.data.PickUpName);
            $("#lblPickUpAddress").html(o.data.PickupAddress);
            $("#lblDeliveryName").html(o.data.DeliveryName);
            $("#lblDeliveryAddress").html(o.data.DeliveryAddress);
            $("#lblDetails").html(o.data.Details);
			$('#Receipts').html('');
            if (o.data.Receipts != null && o.data.Receipts.length > 0) {
                for (var i = 0; i < o.data.Receipts.length; i++) {
                    $('#Receipts').append('<a href="/handler/FileDownload.ashx?FileName=' + o.data.Receipts[i] + '"  > <img src="/userfiles/' + o.data.Receipts[i] + '" /></a>');
                }
            }
        }
    }
	
    function onErrorLoadOrderDetails(result) {
        if (result.status == 200) {
            onSuccessLoadOrderDetails(result);
        }
    }
</script>
<script type="text/javascript">
    function LoadUserOrder(PageIndexOrderList, SortBy, asc) {
        document.getElementById('dvOrderList').innerHTML += ' <div class="blur"></div><div class="progress"><img src="/Images/Loader.gif" /></div>';
        if ($('#ddlOrderStatus').val() != '') {
            var mcontact = {
                pageIndex: PageIndexOrderList,
                orderBy: SortBy,
                pageSize: '10',
                ascending: asc,
                data: $('#ddlOrderStatus').val(),
            };
            var objectAsJson = JSON.stringify(mcontact);
            $.ajax({
                type: "Post",
                url: "/DesktopModules/GoGetIt/API/Order/AdminList",
                cache: false,
                data: objectAsJson,
                contentType: "application/json",
                success: onSuccessLoadUserOrder,
                error: onErrorLoadUserOrder
            });
        }
    }
    function onSuccessLoadUserOrder(result) {
        var o = eval(result);
        if (o.success == true) {
            if (o.count != 0) {
                var vrData = ''
                vrData += '<table class="table table-bordered">';
                vrData += '<thead>';
                vrData += '<tr>';
                vrData += '<th>Order # <span><img src="/images/up-icn.png" alt="Up" onclick=\'LoadUserOrder(0,"OrderID",true);\' ></span><span><img src="/images/down-icn.png" alt="Down" onclick=\'LoadUserOrder(0,"OrderIDReverse", false);\' ></span></th>';
                vrData += '<th>Customer Name <span><img src="/images/up-icn.png" alt="Up" onclick=\'LoadUserOrder(0,"CustomerName",true);\' ></span><span><img src="/images/down-icn.png" alt="Down" onclick=\'LoadUserOrder(0,"CustomerNameReverse", false);\' ></span></th>';
                vrData += '<th>Time Placed <span><img src="/images/up-icn.png" alt="Up" onclick=\'LoadUserOrder(0,"DateCreated",true);\' ></span><span><img src="/images/down-icn.png" alt="Down" onclick=\'LoadUserOrder(0,"DateCreatedReverse", false);\' ></span></th>';
                vrData += '<th>Delivery Type <span><img src="/images/up-icn.png" alt="Up" onclick=\'LoadUserOrder(0,"DeliveryType",true);\' ></span><span><img src="/images/down-icn.png" alt="Down" onclick=\'LoadUserOrder(0,"DeliveryTypeReverse", false);\' ></span></th>';
                vrData += '<th>Delivery Status</th>';
                vrData += '<th>View Details</th>';
                vrData += '<th>Cancel Order</th>';
                vrData += '</tr>';
                vrData += '</thead>';
                vrData += '<tbody>';
                for (var i = 0; i < o.data.length; i++) {
                    vrData += '<tr>';

                    vrData += '<td>';
                    vrData += o.data[i].OrderID;
                    vrData += '</td>';

                    vrData += '<td>';
                    vrData += o.data[i].CustomerName;
                    vrData += '</td>';

                    vrData += '<td>';
                    vrData += new Date(o.data[i].DateCreated).format("MM/dd/yyyy");
                    vrData += '</td>';

                    vrData += '<td>';
                    vrData += o.data[i].Deliverytype;
                    vrData += '</td>';

                    vrData += '<td>';
                    vrData += o.data[i].DeliveryStatus;
                    vrData += '</td>';

                    vrData += '<td>';
                    vrData += '<input type="button" value="Detail" class="btn btn-default YellowBtn" onclick="LoadOrderDetails(' + o.data[i].OrderID + ');" />';
                    vrData += '</td>';

                    vrData += '<td>';
                    if (o.data[i].DeliveryStatus == 'Assigned' || o.data[i].DeliveryStatus == 'Unassigned') {
                        vrData += '<input type="button" value="Cancel" class="btn btn-default GreyBtn" onclick="ConfirmCancelOrder(' + o.data[i].OrderID + ');" />';
                    }
                    vrData += '</td>';

                    vrData += '</tr>';


                }
                vrData += '</tbody>';
                vrData += '</table>';
                $("#dvCountList").html('');

                $("#dvCountList").html(LoadPageCountList(o.pageIndex, o.count, 'OrderList', o.pageSize, o.orderBy, Math.floor(o.pageIndex / 10)));
                $('#dvOrderList').html(vrData);
            }
            else {
                $('#dvOrderList').html('No record found.');
            }
        }
        else {
            $('#dvOrderList').html('No record found.');
        }
    }
    function onErrorLoadUserOrder(result) {
        if (result.status == 200) {
            onSuccessLoadUserOrder(result);
        }
    }
</script>

<script type="text/javascript">

    function ConfirmCancelOrder(vrOrderID) {
        $("#dvCancelAlert").html('');
        $('#cancelOrderModal').modal('show');
        $('#hdOrderID').val(vrOrderID);
    }

    function CancelOrder() {
        var vrOrderID = $('#hdOrderID').val();
        if (vrOrderID > 0) {
            $.ajax({
                type: "PUT",
                url: "/DesktopModules/GoGetIt/API/Order/AdminCancel?OrderID=" + vrOrderID,
                cache: false,
                contentType: "application/json",
                success: onSuccessCancelOrder,
                error: onErrorLoadCancelOrder
            });
        }
    }
    function onSuccessCancelOrder(result) {
        var o = eval(result);
        if (o == true) {
            $("#dvCancelAlert").html('<div class="alert alert-success">Order cancelled successfully.</div>');
            $('#hdOrderID').val('');
            setTimeout(function () { $('#cancelOrderModal').modal('hide'); }, 3000);
            LoadUserOrder();
        }
        else {
            $("#dvCancelAlert").html('<div class="alert alert-error">Could not cancel order.</div>');
        }

    }
    function onErrorLoadCancelOrder(result) {
        if (result.status == 200) {
            onSuccessCancelOrder(result);
        }
    }

</script>

<input type="hidden" id="hdOrderID" value="0" />

<div class="container">
    <div class="well">
        <div class="form-horizontal">
            <div class="form-group">
                <label class="control-label col-sm-2">Order Status:</label>
                <div class="col-sm-10">
                    <select class="form-control" id="ddlOrderStatus" onchange="LoadUserOrder();">
                        <option value="">Please select</option>
                        <option value="Unassigned">Open</option>
                        <option value="Assigned">In Progress</option>
                        <option value="Complete">Complete</option>
                        <option value="Expired">Expired</option>
                        <option value="Cancelled">Cancelled</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="dvRow" id="dvOrderList"></div>
            <div class="dvRow dvPagerTotal" id="dvCountList"></div>
        </div>		 
    </div>
</div>

<!-- Detail Modal -->
<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="detailModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="form-horizontal">
                    <div class="form-group">
                        <label class="control-label col-sm-3">Driver ID:</label>
                        <div class="col-sm-9">
                            <div id="lblDriverID"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3">Driver Name:</label>
                        <div class="col-sm-9">
                            <div id="lblDriverName"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3">Claim Time:</label>
                        <div class="col-sm-9">
                            <div id="lblTimeDriverAccepted"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3">Delivered Time:</label>
                        <div class="col-sm-9">
                            <div id="lblTimeDriverCompleted"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3">PickUp Name:</label>
                        <div class="col-sm-9">
                            <div id="lblPickUpName"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3">PickUp Address:</label>
                        <div class="col-sm-9">
                            <div id="lblPickUpAddress"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3">Delivery Name:</label>
                        <div class="col-sm-9">
                            <div id="lblDeliveryName"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3">Delivery Address:</label>
                        <div class="col-sm-9">
                            <div id="lblDeliveryAddress"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3">Delivery Details:</label>
                        <div class="col-sm-9">
                            <div id="lblDetails"></div>
                        </div>
                    </div>
                     <div id="Receipts" class="form-group">

                         </div>
                    
                </div>
                <div class="form-group">
                    <button type="button" class="btn btn-default GreyBtn" data-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Cancel Order Modal -->
<div class="modal fade" id="cancelOrderModal" tabindex="-1" role="dialog" aria-labelledby="cancelOrderModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="form-group">
                    <h4>Are you want to sure cancel this order?</h4>
                </div>
                <div class="form-group">
                    <button type="button" class="btn btn-default GreyBtn" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-default YellowBtn" onclick="CancelOrder()">Cancel Order</button>
                </div>
                <div class="form-group">
                    <div class="dvRow" id="dvCancelAlert"></div>
                </div>
            </div>
        </div>
    </div>
</div>
