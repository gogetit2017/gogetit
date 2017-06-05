<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Contact.ascx.cs" Inherits="GoGetIt.Contact" %>



<script src="/js/jquery.validator.min.js" type="text/javascript"></script>
<link href="/js/AlertModal.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
function openModalAddModalDiv(divName) {
    $('#' + divName).trigger('click');
}

function CloseAlertModal() {
    openModalAlertDiv();
    setTimeout("$.fancybox.close();", 2000);
}

function CloseAlertValidation() {
    setTimeout("$('#dvAlertValidation').html('');", 2000);
}

function openModalAlertDiv() {
    $('#aAlertModal').trigger('click');
}
</script>

<script type="text/javascript">
    $(document).ready(function () {
            $("#txtName").val("");
            $("#txtEmail").val("");
			$("#txtPhone").val("");
            $("#txtSubject").val("");
            $("#txtMessage").val("");
			$("#dvContactAlertDiv").html('');
    });
</script>

<%--Insert Contact--%>
<script type="text/javascript">
    function InsertContact() {
        var validate = new Validator({ validation_group: 'InsertContactUs', error_class: 'error' });
        validate.validate({
            txtName: 'Full Name is required.',
            txtEmail: 'Email is required.',
			txtPhone: 'Phone no. is required.',			
            txtSubject: 'Subject is required.',            
        });
        if (validate.error == undefined) {
            $("#dvContactAlertDiv").html('');
        }
        else {
            $("#dvContactAlertDiv").html('<div class="alert alert-error">' + validate.error + '</div>');            
            return false;
        }
        var vName = $("#txtName").val();       
        var vEmail = $("#txtEmail").val();
		var vPhone = $("#txtPhone").val();
        var vSubject = $("#txtSubject").val();
        var vMessage = $("#txtMessage").val();

        var mcontact = { FullName: vName,  Email: vEmail, Phone: vPhone, Subject: vSubject, Message: vMessage };
        var objectAsJson = JSON.stringify(mcontact);

        $.ajax({
            type: "POST",            
			url: "/DesktopModules/GoGetIt/API/Contact/Save",
            cache: false,
            data: objectAsJson,
            contentType: "application/json",
            success: onSuccessInsertContact,
            error: onErrorInsertContact
        });
    }
    function onSuccessInsertContact(result) {
        var o = eval(result);
        if (o.success == true) {
            $("#dvContactAlertDiv").html('<div class="alert alert-success">Thank you for contacting us.</div>');            
            window.location.href="/ThankYouContact";
        }
        else  {
            $("#dvContactAlertDiv").html('<div class="alert alert-error">There was an error submitting the form.</div>');            
        }
    }
    function onErrorInsertContact(result) {
        if (result.status == 200) {
            onSuccessInsertContact(result);
        }
    }

</script>



<div style="background:#F0F0F0;width:100%;">
    <div class="container">
        <div class="dvContactGreyBG">
            <div class="dvContactTitleText"> If you are a customer with an injury, or a business owner interested in partnering with us, submit a request today. </div>
            <div class="dvContactFormBG">
                <div class="dvPersonalInfo"> PERSONAL INFORMATION </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <input type="text" class="form-control InsertContactUs" id="txtName" placeholder="Your Name" /> </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <input type="email" class="form-control InsertContactUs validate-email" id="txtEmail" placeholder="Email" /> </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <input type="text" class="form-control InsertContactUs validate-phone" id="txtPhone" placeholder="Phone" /> </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <input type="text" class="form-control InsertContactUs" id="txtSubject" placeholder="Subject" /> </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <textarea class="form-control" placeholder="Message" id="txtMessage"></textarea>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group"> <img src="/images/GoSentItImg.png" class="ContactGoBtn" onclick="InsertContact();" /> </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <div id="dvContactAlertDiv"> </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="dvContactPreferText"> Prefer to call us? </div>
            <div class="dvContactInfoText"> For immediate assistance call<a href="tel:(561)910-0672">(561)910-0672</a>.
                <br />We can also be reached at <a href="mailto:customersupport@gogetit.com">customersupport@gogetit.com</a>, or to the company's Fax Number(561)939-1751
                <br />We are available to assist you from 10:00 AM - 1:00 AM the seven days of the week
                <br />
            </div>
        </div>
    </div>
</div>
