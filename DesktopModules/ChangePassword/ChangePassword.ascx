<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.ascx.cs" Inherits="GoGetIt.ChangePassword" %>
<script src="/js/jquery.validator.js"></script>
<script src="/js/GoGetIt.js"></script>
<style>
.form-control{
  width:300px;
}
</style>
<%--Change Password--%>
<script type="text/javascript">
    var vrGuid = '<%=GetFromQueryStringStringFormat("SecureID")%>';
    function ChangePassword() {

        var validate = new Validator({ validation_group: 'insertChangeYourPassword', error_class: 'error' });
        validate.validate({
            txtEmailReset: 'Email is required.', txtChangeNewPassword: 'New Password is required.', txtChangeConfirmPassword: 'Confirm Password is required.'

        });
        if (validate.error == undefined) {
            validate.checkMinLength('txtChangeNewPassword', 6, 'Please insert at least 6 characters.');
            if (validate.error == undefined) {
                if ($('#txtChangeNewPassword').val() != $('#txtChangeConfirmPassword').val()) {
                    $("#dvAlertValidation").html('<div class="alert alert-danger">Passwords do not match</div>');
                    $("#myModalValidation").modal('show');
                    return;
                }
                else {
                    $("#dvAlertValidation").html('');
                }
            }
            else {
                $("#dvAlertValidation").html('<div class="alert alert-danger">' + validate.error + '</div>');
                $("#myModalValidation").modal('show');
                return;
            }
            $('#dvLoader').html('<div class="blurLoading"></div><div class="progressLoading"><img src="/Images/Loading.gif" /></div>');
            $.ajax({
                type: "POST",
                url: "/DesktopModules/GoGetIt/API/ResetPassword/Save?Guid=" + vrGuid + "&Email=" + $('#txtEmailReset').val() + "&NewPassword=" + $('#txtChangeNewPassword').val(),
                cache: false,
                contentType: "application/json",
                success: onSuccessChangePassword,
                error: onErrorChangePassword
            });


        }
        else {
            $("#dvAlertValidation").html('<div class="alert alert-danger">' + validate.error + '</div>');
            $("#myModalValidation").modal('show');
            return;
        }
    }
    function onSuccessChangePassword(result) {
        try {
            var o = eval(result);
            if (o.success == true) {
                window.location = "/Order";
            }
            else {
                $("#dvAlertValidation").html('<div class="alert alert-danger">' + o.msg + '</div>');
                $("#myModalValidation").modal('show');
                $('#txtEmailReset').val("");
                $('#txtChangeNewPassword').val("");
                $('#txtChangeConfirmPassword').val("");
            }
        }
        catch (e) {
        }
    }
    function onErrorChangePassword(result) {
        if (result.status == 200) {
            onSuccessChangePassword(result);
        }
    }
</script>
<div class="divRow" id="dvLoader"></div>
<div class="container">
<div class="dvRow">
    <div class="form-group">
        *Email:
            <input type="text" id="txtEmailReset" class="insertChangeYourPassword form-control" />
    </div>
    <div class="form-group">
        *New Password:
            <input type="password" id="txtChangeNewPassword" class="insertChangeYourPassword form-control" />
    </div>
    <div class="form-group">
        *Confirm Password:
            <input type="password" id="txtChangeConfirmPassword" class="insertChangeYourPassword form-control" />
    </div>
    <div class="form-group">
        <input type="button" style="background-image: none; border: medium none; background-color: #79C844;" value="Change Password" class="btn btn-primary"
            id="btnChangePassword" onclick="ChangePassword();" />
    </div>
</div>
</div>


<div id="myModalValidation" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <a href="#" class="close" data-dismiss="modal" style="padding: 7px;">&times;</a>
                <div id="dvAlertValidation">
                </div>
            </div>
        </div>
    </div>
</div>
