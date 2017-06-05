<%@  Control Language="C#" AutoEventWireup="true" CodeBehind="CreateAccount.ascx.cs" Inherits="GoGetIt.CreateAccount" %>




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
            validate.checkMinLength('txtPassword', 7, 'password must be a mínimum 7 characters.');
        }
        else {
            $("#dvSignUpAlertDiv").html('');
        }

        if (validate.error == undefined) {

            if ($('#txtPassword').val() != $('#txtConfirmPassword').val()) {
                $("#dvSignUpAlertDiv").html('<div class="alert alert-error">Password do not match.</div>');
                return true;
            }

            $("#dvSignUpAlertDiv").html('');
            document.getElementById("btnCreateAccountBtn").disabled = true;
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
        var vacio= "NULL";

        var mcontact = {
            roleID: 6,
            firstName: vFirstName,
            lastName: vLastName,
            email: vEmail,
            password: vPassword,

            registeredUser: {
                PhoneNumber: vPhone,
                CompanyName: vacio,
                CompanyType: vacio

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

            if ('<%=TabId%>' != 108) {
                /*window.location = "/order";*/

                /*Modificado por web informatica*/
                window.location = "/order?registered=1";
            }
            else {
                $('#signupModal').modal('hide');
                vrUserID = o.data.userID;
                SaveOrder();
            }
            $("#txtFirstName").val("");
            $("#txtLastName").val("");
            $("#txtEmail").val("");
            $("#txtPassword").val("");
            $("#txtConfirmPassword").val("");
            $("#txtPhoneNumber").val("");
        }
        else {
            $("#dvSignUpAlertDiv").html('<div class="alert alert-error">The email you entered is already taken. Please use a different email.</div>');
            document.getElementById("btnCreateAccountBtn").disabled = false;
        }
    }
    function onErrorSignUp(result) {
        if (result.status == 200) {
            onSuccessSignUp(result);
        }
    }


    function SignUpCompany() {
        var validate = new Validator({ validation_group: 'SignupCompany', error_class: 'error' });
        validate.validate({
            txtFNcompany: 'First name is required.',
            txtLNcompany: 'Last name is required.',
            txtcompanyN: 'Company is required.',
            txtcompanytype: 'Company Type is required.',
            txtPhoneNumbercompany: 'Phone no. is required.',
            txtEmailcompany: 'Email is required.',
            txtPasswordcompany: 'Password is required.',
            txtConfirmPasswordcompany: 'Confirm Password is required.'
            
        });

        if (validate.error == undefined) {
            $("#dvSignUpAlertDivCompany").html('');
            validate.checkMinLength('txtPasswordcompany', 7, 'password must be a mínimum 7 characters.');
        }
        else {
            $("#dvSignUpAlertDivCompany").html('');
        }

        if (validate.error == undefined) {

            if ($('#txtPasswordcompany').val() != $('#txtConfirmPasswordcompany').val()) {
                $("#dvSignUpAlertDivCompany").html('<div class="alert alert-error">Password do not match.</div>');
                return true;
            }

            $("#dvSignUpAlertDivCompany").html('');
            document.getElementById("btnCreateAccountBtn").disabled = true;
        }
        else {
            $("#dvSignUpAlertDivCompany").html('<div class="alert alert-error">' + validate.error + '</div>');
            return false;
        }

        var vFirstNameCompany = document.getElementById("txtFNcompany").value;
        var vLastNameCompany = document.getElementById("txtLNcompany").value;
        var vNameCompany = document.getElementById("txtcompanyN").value;
        var vCompanytype = document.getElementById("txtcompanytype").value;
        var vEmailCompany = document.getElementById("txtEmailcompany").value;
        var vPasswordCompany = document.getElementById("txtPasswordcompany").value;
        var vConfirmPasswordCompany = document.getElementById("txtConfirmPasswordcompany").value;
        var vPhoneCompany = document.getElementById("txtPhoneNumbercompany").value;
       
        

       

        var mcontact = {
            roleID: 6,
            firstName: vFirstNameCompany,
            lastName: vLastNameCompany,
            email: vEmailCompany,
            password: vPasswordCompany,
             

            registeredUser: {
                PhoneNumber: vPhoneCompany,
                CompanyName: vNameCompany,
                CompanyType: vCompanytype

            },

        };
        var objectAsJson = JSON.stringify(mcontact);

        $.ajax({
            type: "POST",
            url: "/DesktopModules/GoGetIt/API/RegisteredUser/CreateUser",
            cache: false,
            data: objectAsJson,
            contentType: "application/json",
            success: onSuccessSignUpCompany,
            error: onErrorSignUpCompany
        });
    }
    function onSuccessSignUpCompany(result) {
        var o = eval(result);
        if (o.success == true) {
            $("#dvSignUpAlertDivCompany").html('<div class="alert alert-success">Thank you for signing up.</div>');

            if ('<%=TabId%>' != 108) {
                window.location = "/order";
            }
            else {
                $('#signupModal').modal('hide');
                vrUserID = o.data.userID;
                SaveOrder();
            }
            $("#txtFNcompany").val("");
            $("#txtLNcompany").val("");
            $("#txtcompanyN").val("");
            $("#vCompanytype").val("");
            $("#txtEmailcompany").val("");
           
            $("#txtPasswordcompany").val("");
            $("#txtConfirmPasswordcompany").val("");
            $("#txtPhoneNumbercompany").val("");
        }
        else {
            $("#dvSignUpAlertDivCompany").html('<div class="alert alert-error">The email you entered is already taken. Please use a different email.</div>');
            document.getElementById("btnCreateAccountBtn").disabled = false;
        }
    }
    function onErrorSignUpCompany(result) {
        if (result.status == 200) {
            onSuccessSignUpCompany(result);
        }
    }

</script>

<script type="text/javascript">

    $(function () {


        $('#signupModal').keypress(function (e) {
            if (e.keyCode == '13') {
                $(this).find('#btnCreateAccountBtn').click();
                return false;
            }
        });

    });

</script>



<script type="text/javascript">
    function FormatPhone(e, input) {
        /* to prevent backspace, enter and other keys from  
         interfering w mask code apply by attribute  
         onkeydown=FormatPhone(control) 
        */
        evt = e || window.event; /* firefox uses reserved object e for event */
        var pressedkey = evt.which || evt.keyCode;
        var BlockedKeyCodes = new Array(8, 27, 13, 9); //8 is backspace key 
        var len = BlockedKeyCodes.length;
        var block = false;
        var str = '';
        for (i = 0; i < len; i++) {
            str = BlockedKeyCodes[i].toString();
            if (str.indexOf(pressedkey) >= 0) block = true;
        }
        if (block) return true;

        s = input.value;
        if (s.charAt(0) == '+') return false;
        filteredValues = '"`!@#$%^&*()_+|~-=\QWERT YUIOP{}ASDFGHJKL:ZXCVBNM<>?qwertyuiop[]asdfghjkl;zxcvbnm,./\\\'';
        var i;
        var returnString = '';
        /* Search through string and append to unfiltered values  
           to returnString. */
        for (i = 0; i < s.length; i++) {
            var c = s.charAt(i);
            if ((filteredValues.indexOf(c) == -1) & (returnString.length < 11)) {
                if (returnString.length == 3) returnString += '-';
                if (returnString.length == 7) returnString += '-';
                returnString += c;
            }
        }
        input.value = returnString;

        return false;
    }
</script>

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
                
                <ul class="nav nav-tabs nav-justified" id="singupcompany">
                  <li class="active"><a data-toggle="tab" href="#company">COMPANY SIGN UP</a></li>
                  <li><a data-toggle="tab" href="#individual">INDIVIDUAL SIGN UP</a></li>
                </ul>


                 <div class="tab-content">
                    <div id="company" class="tab-pane fade in active">
                            <div class="dvPopUpBG">
                   
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtFNcompany">First Name</label>
                                <input type="text" class="form-control SignupCompany" id="txtFNcompany" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtLNcompany">Last Name</label>
                                <input type="text" class="form-control SignupCompany" id="txtLNcompany" />
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="txtcompanyN">Company Name</label>
                        <input type="text" class="form-control SignupCompany " id="txtcompanyN" />
                    </div>
                    
                    <div class="form-group">
                        <label for="txtcompanytype">Company Type</label>
                        <select name="txtcompanytype" class="form-control SignupCompany" id="txtcompanytype">
                            <option value="0" class="active">Select Type</option>
                            <option value="Bakery">Bakery</option>
                            <option value="Print Shop">Print Shop</option>
                            <option value="Sign Shop">Sign Shop</option>
                            <option value="Fashion Boutique">Fashion Boutique</option>
                            <option value="Restaurant">Restaurant</option>
                            <option value="Catering">Catering</option>
                            <option value="Law Firm">Law Firm</option>
                            <option value="PR Firm">PR Firm</option>
                            <option value="Real Estate Firm">Real Estate Firm</option>
                            <option value="Event Agency">Event Agency</option>
                            <option value="Chocolatier">Chocolatier</option>
                            <option value="Other">Other</option>
                            
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="txtPhoneNumbercompany">Phone Number</label>
                        <input type="text" class="form-control SignupCompany validate-phone" id="txtPhoneNumbercompany" onkeypress="FormatPhone(event,txtPhoneNumbercompany);" />
                    </div>
                    <div class="form-group">
                        <label for="txtEmailcompany">Email Address</label>
                        <input type="email" class="form-control SignupCompany validate-email" id="txtEmailcompany" />
                    </div>
                    
                    <div class="form-group">
                        <label for="txtPasswordcompany">Password</label>
                        <input type="password" class="form-control SignupCompany" id="txtPasswordcompany" />
                    </div>
                    <div class="form-group">
                        <label for="txtConfirmPasswordcompany">Confirm Password</label>
                        <input type="password" class="form-control SignupCompany" id="txtConfirmPasswordcompany" />
                    </div>
                    <div class="form-group">
                        <input type="button" id="btnCreateAccountBtn" class="CreateAccountBtn" onclick="SignUpCompany();" value="Create My Account" />
                    </div>
                    <div class="dvRow">
                        <div id="dvSignUpAlertDivCompany"></div>
                    </div>
                </div>
                        
                    </div>
                  
                   
                  
                  <div id="individual" class="tab-pane fade">

                            <div class="dvPopUpBG">
                    
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
                        <input type="text" class="form-control SignupUser validate-phone" id="txtPhoneNumber" onkeypress="FormatPhone(event,txtPhoneNumber);" />
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
                        <input type="button" id="btnCreateAccountBtn" class="CreateAccountBtn" onclick="SignUp();" value="Create My Account" />
                    </div>
                    <div class="dvRow">
                        <div id="dvSignUpAlertDiv"></div>
                    </div>
                </div>
                    
                  </div>

                </div>
             </div>
        </div>
    </div>
</div>


<!--<div class="modal fade" id="signupModal" tabindex="-1" role="dialog" aria-labelledby="signupModalLabel" aria-hidden="true">
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
                        <input type="text" class="form-control SignupUser validate-phone" id="txtPhoneNumber" onkeypress="FormatPhone(event,txtPhoneNumber);" />
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
                        <input type="button" id="btnCreateAccountBtn" class="CreateAccountBtn" onclick="SignUp();" value="Create My Account" />
                    </div>
                    <div class="dvRow">
                        <div id="dvSignUpAlertDiv"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>-->
