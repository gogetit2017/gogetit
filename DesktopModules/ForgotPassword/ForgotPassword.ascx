<%@  Control Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.ascx.cs" Inherits="GoGetIt.ForgotPassword" %>
<script src="/js/jquery.validator.js"></script>
<script src="/js/GoGetIt.js"></script>

<style>
    .form-control {
        max-width:300px;
    }
    .divRow > span {
    color: red;
}
</style>


<div class="container well">
    <div class="form-group">
        <div class="divRedTitle"></div>
    </div>

    <div class="form-group">
        To request a password reset link, please enter the email address you used when you registered.
    </div>

    <div class="form-horizontal" role="form">
        <div class="form-group">
            <label class="control-label col-sm-2" for="email">Enter Email:</label>
            <div class="col-sm-10">
                <div class="divRow">
                    <asp:textbox id="txtUserName" runat="server" cssclass="form-control"></asp:textbox>
                    <asp:requiredfieldvalidator id="rfvUserName" runat="server" errormessage="*" validationgroup="Password"
                        controltovalidate="txtUserName"></asp:requiredfieldvalidator>
                    <asp:regularexpressionvalidator id="revUserName" validationgroup="Password" runat="server"
                        errormessage="**" controltovalidate="txtUserName" validationexpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:regularexpressionvalidator>
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <asp:linkbutton id="lnkSendPassword" runat="server" text="Send Password" cssclass="linkText"
                    onclick="lnkSendPassword_Click" validationgroup="Password"></asp:linkbutton>
            </div>
        </div>
        <div class="dvRow alert-success">
            <asp:label id="lblMsg" cssclass="" runat="server"></asp:label>
        </div>
    </div>
</div>



