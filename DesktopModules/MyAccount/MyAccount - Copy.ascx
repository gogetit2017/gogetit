<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MyAccount.ascx.cs" Inherits="GoGetIt.MyAccount" %>




<script type="text/javascript">
    var vrOrderID = '<%=GetFromQueryString("OrderID") %>';
    var vrUserID = '<%=LOGGEDINUSERID %>';
    $(document).ready(function () {
        LoadCreditCard();
        LoadUserInformation();
        LoadUserOrder();
    });
    function ChangePassword() {

        var validate = new Validator({ validation_group: 'ChangePassword', error_class: 'error' });
        validate.validate({
            txtCurrentPassword: 'Current Password is required.',
            txtNewPassword: 'New Password is required',
        });
        if (validate.error == undefined) {
            $("#PwdError").html('');
        }
        else {
            $("#PwdError").html('<div class="alert alert-error">' + validate.error + '</div>');
            return false;
        }
        var newPwd = $('#txtNewPassword').val();
        var newConfirmPassword = $('#txtConfirmPassword').val();
        if (newPwd !== newConfirmPassword) {
            $("#PwdError").html('<div class="alert alert-error">Confirm password not match.</div>');
            return false;
        }
        else {
            $.ajax({
                type: "POST",
                url: '/DesktopModules/GoGetIt/API/ResetPassword/UpdatePassword?UserID=' + vrUserID + '&OldPassword=' + $('#txtCurrentPassword').val() + '&NewPassword=' + $('#txtNewPassword').val() + '',
                cache: false,
                contentType: "application/json",
                success: onSuccessChangePassword,
                error: onErrorChangePassword
            });
        }
    }
    function onSuccessChangePassword(result) {
        var o = eval(result);
        if (o.success == true) {
            $("#PwdError").html('<div class="alert alert-success">Password Changed.</div>');

        }
        else {
            $("#PwdError").html('<div class="alert alert-error">' + o.data + '</div>');
        }
    }
    function onErrorChangePassword(result) {
        if (result.status == 200) {
            onSuccessChangePassword(result);
        }
    }
</script>
<%--Load Credit Card--%>
<script type="text/javascript">
    function LoadCreditCard() {
        $.ajax({
            type: "Get",
            url: "/DesktopModules/GoGetIt/API/CreditCard/List?UserID=" + vrUserID,
            cache: false,
            contentType: "application/json",
            success: onSuccessLoadCreditCard,
            error: onErrorLoadCreditCard
        });
    }
    function onSuccessLoadCreditCard(result) {
        var o = eval(result);
        if (o.success == true) {
            $("#lblCardNumber").html(o.data[0].CardType + ' ending is ' + o.data[0].CardLastFourDigit);
            //$("#lblExpirationDate").html(o.data[0].ExpirationMonth);
            //$("#ddlYear").html(o.data[0].ExpirationYear);
            //$("#lblZipCode").html(o.data[0].ZipCode);
            //$("#lblSecurityCode").html(o.data[0].CVV);
            //$('#lblCardType').html(o.data[0].CardType);
        }

    }
    function onErrorLoadCreditCard(result) {
        if (result.status == 200) {
            onSuccessLoadCreditCard(result);
        }
    }
</script>
<%--Load Credit Card--%>
<script type="text/javascript">
    function LoadUserInformation() {
        $.ajax({
            type: "Get",
            url: "/DesktopModules/GoGetIt/API/RegisteredUser/get?UserID=" + vrUserID,
            cache: false,
            contentType: "application/json",
            success: onSuccessLoadUserInformation,
            error: onErrorLoadUserInformation
        });
    }
    function onSuccessLoadUserInformation(result) {
        var o = eval(result);
        if (o.success == true) {
            $("#UserName").html(o.data.firstName + o.data.lastName);
            $("#UserEmail").html(o.data.email);
            $("#userPhone").html(o.data.registeredUser.PhoneNumber);
            // $("#UserAddress").html(o.data[0].ExpirationYear);
        }

    }
    function onErrorLoadUserInformation(result) {
        if (result.status == 200) {
            onSuccessLoadUserInformation(result);
        }
    }
</script>

<script type="text/javascript">
    function LoadUserOrder() {
        var mcontact = {
            pageIndex: '0',
            pageSize: '250',
            data: 'All',
        };
        var objectAsJson = JSON.stringify(mcontact);
        $.ajax({
            type: "Post",
            url: "/DesktopModules/GoGetIt/API/Order/List",
            cache: false,
            data: objectAsJson,
            contentType: "application/json",
            success: onSuccessLoadUserOrder,
            error: onErrorLoadUserOrder
        });
    }
    function onSuccessLoadUserOrder(result) {
        var o = eval(result);
        if (o.success == true) {
            var veData = '';
            $('#dvOrderCount').html(o.count);

            for (var i = 0; i < o.data.length; i++) {
                veData += '<div class="dvRow">';
                veData += '<div class="dvRow">';
                veData += ' <div class="dvOrderDate">' + new Date(o.data[i].Deadline).format("MM/dd/yyyy") + '</div>';
                veData += '<div class="dvOrderDateLeft">' + o.data[i].DeliveryName + '</div>';
                veData += '</div>';
                veData += '<div class="dvRow">';
                veData += '<div class="dvOrderReorder ">';
                veData += '<input type="button" value="REORDER" class="YellowBtn" /></div>';
                veData += '<div class="dvOrderDes">' + o.data[i].Detail + '</div>';
                veData += '</div>';

                veData += '<div class="dvBorderTop"></div>';
                veData += '</div>';

            }
            $('#dvOrderList').html(veData);
        }
    }
    function onErrorLoadUserOrder(result) {
        if (result.status == 200) {
            onSuccessLoadUserOrder(result);
        }
    }
</script>
<style type="text/css">
    .imgUserAccount { float: left; padding: 6px; vertical-align: sub; }
    .MailIcn { }
    .PhoneIcn { padding: 0 10px; }
    .LocationIcn { }
    .dvBorderTop { border-bottom: 1px solid #ebebeb; padding: 10px 0 0 0; clear: both; }
    .dvOrderDate { font-weight: bold; float: left; width: 100px; }
    .dvOrderDateLeft { font-weight: bold; float: left; width: 380px; }
    .dvOrderReorder { float: left; width: 100px; }
    .dvOrderDes { float: left; width: 300px; }
    #dvOrderList { height: 500px; overflow: auto; width: 100%; }
    .dvOrderMain { height: 77px; display: inline-block; padding: 10px 0; }
</style>
<div class="myAccountOuter">
    <div class="container">
        <div class="" id="MyAccount">
            <div class="" id="TabLeft">
                <h2>My Account</h2>
                <ul class="nav nav-pills nav-stacked">
                    <li class="active"><a data-toggle="tab" href="#accountInfo">Account Information</a></li>
                    <li><a data-toggle="tab" href="#password">Password</a></li>
                    <li><a data-toggle="tab" href="#paymentMethod">Payment Method</a></li>
                    <li><a data-toggle="tab" href="#orderHistory">Order History</a></li>
                    <li><a data-toggle="tab" href="#deactivatedAccount">Deactivate Account</a></li>
                </ul>
            </div>
            <div class="" id="TabMid"></div>
            <div class="" id="TabRight">
                <div class="tab-content">
                    <div id="accountInfo" class="tab-pane fade in active">
                        <h3 id="UserName"></h3>
                        <div class="dvRow">
                            <div class="form-group">
                                <div class="col-md-8">
                                    <img class="imgUserAccount MailIcn" src="images/MailIcn.png" />
                                    <div id="UserEmail"></div>
                                </div>
                            </div>
                        </div>
                        <div class="dvRow">
                            <div class="form-group">
                                <div class="col-md-8">
                                    <img class="imgUserAccount PhoneIcn" src="images/PhoneIcn.png" />
                                    <div id="userPhone"></div>
                                </div>
                            </div>
                        </div>
                        <div class="dvRow">
                            <div class="form-group">
                                <div class="col-md-8">
                                    <img class="imgUserAccount LocationIcn" src="images/LocationIcn.png" />
                                    <div id="UserAddress"></div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div id="password" class="tab-pane fade">
                        <h3>Password</h3>
                        <div class="form-group">
                            <label for="txtCurrentPassword">Enter current password</label>
                            <input type="password" class="form-control ChangePassword" id="txtCurrentPassword">
                        </div>
                        <div class="form-group">
                            <label for="txtNewPassword">Enter new password</label>
                            <input type="password" class="form-control ChangePassword" id="txtNewPassword">
                        </div>
                        <div class="form-group">
                            <label for="txtConfirmPassword">Confirm password</label>
                            <input type="password" class="form-control" id="txtConfirmPassword">
                        </div>
                        <button type="submit" class="btn btn-default GreyBtn">Cancel</button>
                        <input type="button" class="btn btn-default YellowBtn" value="Save" onclick="ChangePassword()" />
                        <div class="form-group">
                            <div id="PwdError"></div>
                        </div>
                    </div>
                    <div id="paymentMethod" class="tab-pane fade">
                        <h3>Payment Method</h3>
                        <div class="form-group">
                            <label for="txtCardNumber" class="col-md-2">Existing:</label>
                            <div class="col-md-8" id="lblCardNumber"></div>
                        </div>
                        <!--  <div class="form-group">
                            <label for="txtCardNumber">Card Type:</label>
                            <label id="lblCardType"></label>
                        </div>-->
                        <!--    <div class="form-group">
                            <label for="txtCardNumber">Expiration Date:</label>
                            <label id="lblExpirationDate"></label>
                        </div>
                        <div class="form-group">
                            <label for="txtCardNumber">Security Code:</label>
                            <label id="lblSecurityCode"></label>
                        </div>
                        <div class="form-group">
                            <label for="txtCardNumber">Zip Code:</label>
                            <label id="lblZipCode"></label>
                        </div>-->

                        <!--  <div class="form-group">
                            <label for="txtCardNumber">Card Number</label>
                            <input type="text" class="form-control" id="txtCardNumber">
                        </div>
                        <div class="form-group">
                            <label for="txtSecurityCode">Expiration Date</label>
                            <div class="DateTotal">
                                <div class="Month">
                                    <select class="form-control" id="ddlMonth">
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                    </select>
                                </div>
                                <div class="Slah">/ </div>
                                <div class="Year">
                                    <select class="form-control" id="ddlYear">
                                        <option value="2015">2015</option>
                                        <option value="2016">2016</option>
                                        <option value="2017">2017</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="txtSecurityCode">Security Code</label>
                            <input type="text" class="form-control" id="txtSecurityCode">
                        </div>
                        <div class="form-group">
                            <label for="txtZipCode">Zip Code</label>
                            <input type="text" class="form-control" id="txtZipCode">
                        </div>
                        <button type="submit" class="btn btn-default GreyBtn">Cancel</button>
                        <button type="submit" class="btn btn-default YellowBtn">Save</button>-->
                    </div>
                    <div id="orderHistory" class="tab-pane fade">
                        <h3>Order History</h3>
                        <div class="form-group">
                            <label for="txtCardNumber" class="col-md-3">My Order:</label>
                            <div class="col-md-8" id="dvOrderCount"></div>
                        </div>
                        <div class="dvRow">
                            <div class="col-md-8" id="dvOrderList">
                            </div>


                        </div>
                    </div>
                    <div id="deactivatedAccount" class="tab-pane fade">
                        <h3>Deactivated Account</h3>
                        <p>Once you've deactivated your account, you will no longer be able to</p>
                        <p>log into the Go Get It website. This action cannot be undone.</p>
                        <p>&nbsp;</p>
                        <button type="submit" class="btn btn-default GreyBtn">Cancel</button>
                        <button type="submit" class="btn btn-default YellowBtn">Deactivate</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>





