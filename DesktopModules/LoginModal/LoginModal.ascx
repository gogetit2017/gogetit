<%@  Control Language="C#" AutoEventWireup="true" CodeBehind="LoginModal.ascx.cs" Inherits="GoGetIt.LoginModal" %>

<script src="/js/jquery.validator.min.js" type="text/javascript"></script>
<link href="/js/AlertModal.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">

    $(function () {
        /*$("#loginModal").on('show', function () {
            $("#txtLoginEmail").val("");
            $("#txtLoginPassword").val("");
            $("#dvAlertDiv").html('');
        });
*/
        $('#loginModal').keypress(function (e) {

            if (e.keyCode == '13') {
                $(this).find('#BtnLogin').click();
                return false;
            }
        });

    });

</script>

 
<script type="text/javascript">
    function LoginUser() {
        var validate = new Validator({ validation_group: 'LoginUser', error_class: 'error' });
        validate.validate({
            txtLoginEmail: 'Email is required.',
            txtLoginPassword: 'Password. is required.',
        });
        if (validate.error == undefined) {
            $("#dvAlertDiv").html('');
        }
        else {
            $("#dvAlertDiv").html('<div class="alert alert-error">' + validate.error + '</div>');
            return false;
        }

        var vEmail = $("#txtLoginEmail").val();
        var vPassword = $("#txtLoginPassword").val();

        var mcontact = { username: vEmail, password: vPassword };
        var objectAsJson = JSON.stringify(mcontact);

        $.ajax({
            type: "POST",
            url: "/DesktopModules/GoGetIt/API/RegisteredUser/UserLogin",
            cache: false,
            data: objectAsJson,
            contentType: "application/json",
            success: onSuccessLoginUser,
            error: onErrorLoginUser
        });
    }
    function onSuccessLoginUser(result) {
        var o = eval(result);
        if (o.success == true) {

            /*if('<%=TabId%>' == 118){
                $('#loginModal').modal('hide');
                vrUserID = o.data.userID;
                MakeClickHome();
            }
            else */
            if ('<%=TabId%>' != 108) {
                window.location.href = '/order';
            }
            else {
                $('#loginModal').modal('hide');
                vrUserID = o.data.userID;
                //location.reload();
                //SaveOrder();
            }
            $("#txtLoginEmail").val("");
            $("#txtLoginPassword").val("");
        }
        else {
            $("#dvAlertDiv").html('<div class="alert alert-error">' + o.msg + '</div>');
        }
    }
    function onErrorLoginUser(result) {
        if (result.status == 200) {
            onSuccessLoginUser(result);
        }
    }

</script>

<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Close</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="dvLoginPopUpBG">
                   
                    <div class="form-group">
                        <label for="txtEmail">Email Address</label>
                        <input type="text" class="form-control LoginUser" id="txtLoginEmail" />
                    </div>
                    <div class="form-group">
                        <label for="txtPassword">Password</label>
                        <input type="password" class="form-control LoginUser" id="txtLoginPassword" />
                    </div>
                    <div class="form-group">
                        <input type="button" id="BtnLogin" onclick="LoginUser();" class="LoginBtn" value="Login" />
                    </div>
                    <div class="form-group">
                      <div class="col-xs-6 nopadding">
                        <a style="color: rgb(2,139,255);" data-toggle="modal" data-target="#signupModal" data-dismiss="modal" href="#signupModal">Create an Account</a>
                      </div>
                      <div class="col-xs-6 text-right nopadding">
                        <a href="http://letusgogetit.com/ForgotPassword">Forgot Password</a>
                      </div>
                    </div>
                    <div class="dvRow">
                        <div id="dvAlertDiv"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

