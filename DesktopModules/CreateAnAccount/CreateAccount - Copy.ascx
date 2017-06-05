<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CreateAccount.ascx.cs" Inherits="GoGetIt.CreateAccount" %>

<script src="/js/jquery.fancybox.js" type="text/javascript"></script>
<script src="/js/jquery.validator.min.js" type="text/javascript"></script>
<link href="/js/jquery.fancybox.css" rel="stylesheet" type="text/css" />
<link href="/js/AlertModal.css" rel="stylesheet" type="text/css" />


<!--Check Valid Expression-->
<script type="text/javascript">
    $(document).ready(function () {
        
    });
</script>

<!--Create An Account-->
<script type="text/javascript">
    function SignUp() {
        var validate = new Validator({ validation_group: 'SignupUser', error_class: 'error' });
        validate.validate({
            txtFirstName: 'First name is required.',
            txtLastName: 'Last name is required.',
            txtEmail: 'Email is required.',
            txtPassword: 'Password is required.',
			txtConfirmPassword: 'Confirm Password is required.',
            txtPhoneNumber: 'Phone no. is required.'
        });
        if (validate.error == undefined) {
            $("#dvSignUpAlertDiv").html('');
        }
        else {
            $("#dvSignUpAlertDiv").html('<div class="alert alert-error">' + validate.error + '</div>');            
            return false;
        }
        var vFirstName = document.getElementById("txtFirstName").value;
        var vLastName = document.getElementById("txtLastName").value;
        var vEmail = document.getElementById("txtEmail").value;
        var vPassword = document.getElementById("txtPassword").value;
		var vConfirmPassword = document.getElementById("txtConfirmPassword").value;
        var vPhone = document.getElementById("txtPhoneNumber").value;

        var mcontact = {
            roleID: 6,
            firstName: vFirstName,
            lastName: vLastName,
            email: vEmail,
            password: vPassword,
		
            registeredUser :{PhoneNumber: vPhone 
			
			},

        };
        var objectAsJson = JSON.stringify(mcontact);

        $.ajax({
            type: "POST",
            url: "/DesktopModules/GoGetIt/API/RegisteredUser/CreateUser",
            cache: false,
            data: objectAsJson,
            contentType: "application/json",
            success: onSuccessSignUp,
            error: onErrorSignUp
        });
    }
    function onSuccessSignUp(result) {
        var o = eval(result);
        if (o.success == true) {
            $("#dvSignUpAlertDiv").html('<div class="alert alert-success">Thank you for signing up.</div>');            
            window.location = "/Home.aspx";
            $("#txtFirstName").val("");
            $("#txtLastName").val("");
            $("#txtEmail").val("");
            $("#txtPassword").val("");
			$("#txtConfirmPassword").val("");
            $("#txtPhoneNumber").val("");
        }
        else {
            $("#dvSignUpAlertDiv").html('<div class="alert alert-error">There was an error in sign up.</div>');            
        }
    }
    function onErrorSignUp(result) {
        if (result.status == 200) {
            onSuccessSignUp(result);
        }
    }

</script>


<!--SignUp Modal -->
<div class="modal fade" id="signupModal" tabindex="-1" role="dialog" aria-labelledby="signupModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Close</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="dvPopUpBG">
                    <h2>Create Account</h2>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtFirstName">First Name</label>
                                <input type="text" class="form-control SignupUser" id="txtFirstName" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtLastName">Last Name</label>
                                <input type="text" class="form-control SignupUser" id="txtLastName" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtEmail">Email Address</label>
                        <input type="email" class="form-control SignupUser validate-email" id="txtEmail" />
                    </div>
                    <div class="form-group">
                        <label for="txtPhoneNumber">Phone Number</label>
                        <input type="text" class="form-control SignupUser validate-phone" id="txtPhoneNumber" />
                    </div>
                    <div class="form-group">
                        <label for="txtPassword">Password</label>
                        <input type="password" class="form-control SignupUser" id="txtPassword" />
                    </div>
                    <div class="form-group">
                        <label for="txtConfirmPassword">Confirm Password</label>
                        <input type="password" class="form-control SignupUser" id="txtConfirmPassword" />
                    </div>
                    <div class="form-group">
                        <input type="button" class="CreateAccountBtn" onclick="SignUp();" value="Create My Account" />
                    </div>
                    <div class="dvRow">
                        <div id="dvSignUpAlertDiv"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>