<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SendNotification.ascx.cs" Inherits="GoGetIt.SendNotification" %>


<script src="/js/jquery.validator.js"></script>

<script type="text/javascript">

    $(document).ready(function () {
	
    });
</script>

<!--AddNotification-->
<script type="text/javascript">
    function AddNotification() {
	  var validate = new Validator({ validation_group: 'SendNotification', error_class: 'error' });
        validate.validate({
         
            txtEmail: 'Please enter valid email address.',
           
        });
        if (validate.error == undefined) {
            $("#dvContactUsAlertDiv").html('');
        }
        else {
            $("#dvContactUsAlertDiv").html('<div class="alert alert-danger">' + validate.error + '</div>');
            $("#myModalContact").modal('show');
            return false;
        }
        var objectAsJson = JSON.stringify({ NotificationID: 0, Email: $('#txtEmail').val().trim() });
        $.ajax({
            type: "POST",
            url: "/DesktopModules/GoGetIT/API/Notification/PostGRI_Category",
            cache: false,
            data: objectAsJson,
            contentType: "application/json",
            dataType: "application/json",
            success: onSuccessAddNotification,
            error: onErrorAddNotification
        });
    }
    function onSuccessAddNotification(result) {
        var o = eval(result);
        if (o.success) {
            $('#txtEmail').val('');
            $("#dvContactUsAlertDiv").html('<div class="alert alert-success">Thank You for Your Interest In GOGETIT!</div>');
        }
        else {
            $("#dvContactUsAlertDiv").html('<div class="alert alert-error">There was an error while submitting a form.</div>');
        }
        $("#myModalContact").modal('show');
    } 

    function onErrorAddNotification(result) {
        if (result.status == 200) {
            onSuccessAddNotification(result);
        }
    }

</script>
<div class="dvCommingSoon">
    <div class="dvCommingSoonForm">
        <div class="dvCommingSoonFormLogo">
            <img src="/images/Logo.png" />
        </div>
        <div class="dvCommingSoonFormBox">
            <div class="dvHeadingFirst">
                Delivering Anything, From Anywhere.
            </div>
            <div class="dvHeadingSecond">
                Website Coming Soon!
            </div>
            <div class="dvHeadingThird">
                Drop your email address below & we will notify you once we are live.
            </div>
            <div class="form-group dvCommingSoonFormEmail">
                <input type="text" id="txtEmail" placeholder="Enter Your Email Address" class="form-control SendNotification validate-email" />
               
                <button class="btnNotifiyMe" onclick="AddNotification();return false;">Notify Me<img src="/images/RightArrowIcn.png" class="dvRightArrowImage" style="" /></button>
            </div>
        </div>
    </div>
</div>

<div id="myModalContact" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <a href="#" class="close" data-dismiss="modal" style="padding: 7px;">&times;</a>
                <div id="dvContactUsAlertDiv">
                </div>
            </div>
        </div>
    </div>
</div>
