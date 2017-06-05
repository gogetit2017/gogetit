<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AccountLogin.ascx.cs" Inherits="GoGetIt.AccountLogin" %>
<script src="/js/jquery.validator.js"></script>
<script src="/js/GoGetIt.js"></script>
<link href="/js/bootstrap.min.css" rel="stylesheet" />
   

<style type="text/css">
    
</style>

<script type="text/javascript">
    var Tabid = '<%=TabId%>';
    var vrReturnUrl = '<%=GetFromQueryStringStringFormat("returnurl")%>';
    var vars = "";
    $(document).ready(function () {
        
        $('#txtUserNameForm').val(getUrlVarsUsername());
         
          
  
          if ($('#txtUserNameForm').val() == null || $('#txtUserNameForm').val() == "") {
              if (getCookie("user") != "Empty" && getCookie("pwd") != "Empty") {
                  $('#txtUserNameForm').val(getCookie("user"));
                
              }
          }
        $('#dvUserLoginForm').keypress(function (e) {
            if (e.keyCode == '13') {
                $(this).find('#btnLoginModalFormSubmit').click();
                return false;
            }
        });
    });

</script>

<%--User Login--%>
<script type="text/javascript">
    function UserLoginForm() {

        var validate = new Validator({ validation_group: 'loginModalUserForm', error_class: 'error' });
        validate.validate({ txtUserNameForm: 'User name is required.', txtUserPasswordForm: 'Password is required.' });
        if (validate.error == undefined) {
            $("#dvAlertValidation").html('');
        }
        else {
            $("#dvAlertValidation").html('<div class="alert alert-danger">' + validate.error + '</div>');
            $("#myModalValidation").modal('show');
            return false;
        }
        $('#dvLoader').html('<div class="blurLoading"></div><div class="progressLoading"><img src="/Images/Loading.gif" /></div>');
        var objectAsJson = JSON.stringify({ username: $("#txtUserNameForm").val(), password: $("#txtUserPasswordForm").val() });
        $.ajax({
            type: "POST",
            url: "/DesktopModules/GoGetIt/API/RegisteredUser/UserLogin",
            cache: false,
            data: objectAsJson,
            contentType: "application/json",
            success: onSuccessLoginUserForm,
            error: onErrorLoginUserForm
        });
    }

    function onSuccessLoginUserForm(result) {
        var o = eval(result);
        document.getElementById('dvLoader').innerHTML = "";
        if (o.success == true) {
          
            setCookie('user', $('#txtUserNameForm').val(), 365);
            if (vrReturnUrl.length > 0) {
                window.location = vrReturnUrl;
            }
            window.location = "/home.aspx";
        }
        else {
            $("#dvAlertValidation").html('<div class="alert alert-danger">' + o.msg + '</div>');
            $("#myModalValidation").modal('show');
            $("#txtUserPasswordForm").val("");
        }
    }

    function onErrorLoginUserForm(result) {
        if (result.status == 200) {
            onSuccessLoginUserForm(result);
        }
    }

</script>
<div class="divRow" id="dvLoader"></div>
<div class="dvRow">
<div id="dvUserLoginForm" style="max-width:400px;">
    <div class="dvRow">
        <div class="">
            <div style="">
                <div class="dvLoginBG">
                    <div class="dvAccountText">
				
                    </div>
                   
                        <div class="form-group">
						Username:
                            <input type="email" id="txtUserNameForm" placeholder="Email Address" class="form-control loginModalUserForm" />
                        </div>
                        <div class="form-group">
						Password:
                            <input type="password" id="txtUserPasswordForm" placeholder="Password" class="form-control loginModalUserForm" />
                        </div>
                        <div class="form-group">
                            <div><a class="dvForgotText" href="/Forgotpassword.aspx">Forgot Password?</a></div>
                        </div>
                        <div class="form-group">
                            <input type="button" style="" value="Sign In" class="form-control btn btn-primary" onclick="UserLoginForm(); return false;" id="btnLoginModalFormSubmit" />
                        </div>
                   
                </div>
            </div>
        </div>
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

