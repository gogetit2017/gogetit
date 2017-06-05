<%@  Control Language="C#" AutoEventWireup="true" CodeBehind="MyAccount.ascx.cs" Inherits="GoGetIt.MyAccount" %>

<script src="/js/GoGetit.js"></script>



<script type="text/javascript">
    var vrOrderID = '<%=GetFromQueryString("OrderID") %>';
    var vrUserID = '<%=LOGGEDINUSERID %>';
    $(document).ready(function () {
        LoadCreditCard();
        LoadUserInformation();
        LoadUserOrderhistory();
        LoadUserOrder();
        $('a[href="#paymentMethod"]').on('shown.bs.tab', function (e) { $("#dvPaymentInformation").hide(); });
        $('#password').keypress(function (e) {
            if (e.keyCode == '13') {
                ChangePassword();
                return false;
            }
        });
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

<script type="text/javascript">
    function EditMyAccount() {
        $('#dvEditPhone').show();
        $('#dvSavePhoneBtn').show();
        $('#dvEditPhoneLabel').hide();
    }
</script>

<script type="text/javascript">
    function EditPaymentMethod() {
        $('#dvPaymentInformation').show();
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
            $("#UserName").html(o.data.firstName + " " + o.data.lastName);
            $("#UserEmail").html(o.data.email);
            $("#userPhoneLabel").html(o.data.registeredUser.PhoneNumber);
            $("#userPhone").val(o.data.registeredUser.PhoneNumber);
            // $("#UserAddress").html(o.data[0].ExpirationYear);
        }

    }
    function onErrorLoadUserInformation(result) {
        if (result.status == 200) {
            onSuccessLoadUserInformation(result);
        }
    }
</script>

<!--Phone No. Format-->
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

<script type="text/javascript">
    function UpdateUserInformation() {
        var validate = new Validator({ validation_group: 'UpdateUserInfo', error_class: 'error' });
        validate.validate({
            userPhone: 'Phone no. is required.'
        });
        if (validate.error == undefined) {
            $("#dvUpdateUserAlertDiv").html('');
            document.getElementById("btnUpdateAccount").disabled = true;
        }
        else {
            $("#dvUpdateUserAlertDiv").html('<div class="alert alert-error">' + validate.error + '</div>');
            return false;
        }

        $.ajax({
            type: "PUT",
            url: "/DesktopModules/GoGetIt/API/RegisteredUser/UpdatePhone?Phone=" + $('#userPhone').val(),
            cache: false,
            contentType: "application/json",
            success: onSuccessUpdateUserInformation,
            error: onErrorUpdateUserInformation
        });
    }
    function onSuccessUpdateUserInformation(result) {
        var o = eval(result);
        if (o == true) {
            $("#dvUpdateUserAlertDiv").html('<div class="alert alert-success">Your account information has been updated.</div>');
            document.getElementById("btnUpdateAccount").disabled = false;
        }
        else {
            $("#dvUpdateUserAlertDiv").html('<div class="alert alert-error">There was an error while updating account.</div>');
            document.getElementById("btnUpdateAccount").disabled = false;
        }
    }
    function onErrorUpdateUserInformation(result) {
        if (result.status == 200) {
            onSuccessUpdateUserInformation(result);
        }
    }
</script>


<script type="text/javascript">
    function LoadUserOrder(PageIndexOrderList, SortBy) {
        var mcontact = {
            pageIndex: PageIndexOrderList,
            pageSize: '10',
            data: 'All',
            ascending: false,
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
                veData += '<div class="dvOrderDateLeft">' + o.data[i].PickupName + '</div>';
                veData += '</div>';
                veData += '<div class="dvRow">';
                veData += '<div class="dvOrderReorder ">';
                veData += '<input type="button" value="REORDER" class="YellowBtn" onclick="ReOrder(' + o.data[i].OrderID + ');" /></div>';
                veData += '<div class="dvOrderDes">' + o.data[i].Detail + '</div>';
                veData += '</div>';

                veData += '<div class="dvBorderTop"></div>';
                veData += '</div>';
            }
            $("#dvCountList").html('');
            $("#dvCountList").html(LoadPageCountList(o.pageIndex, o.count, 'OrderList', o.pageSize, "", Math.floor(o.pageIndex / 10)));
            $('#dvOrderList').html(veData);
        }
    }
    function onErrorLoadUserOrder(result) {
        if (result.status == 200) {
            onSuccessLoadUserOrder(result);
        }
    }


</script>

</script>

<script type="text/javascript">
    function LoadUserOrderhistory(PageIndexOrderListhis, SortBy) {
        var mcontact1 = {
            pageIndex: PageIndexOrderListhis,
            pageSize: '10',
            data: 'All',
            ascending: false,
        };
        var objectAsJson = JSON.stringify(mcontact1);
        $.ajax({
            type: "Post",
            url: "/DesktopModules/GoGetIt/API/Order/Listorder",
            cache: false,
            data: objectAsJson,
            contentType: "application/json",
            success: onSuccessLoadUserOrderhistory,
            error: onErrorLoadUserOrderhistory
        });
    }
    function onSuccessLoadUserOrderhistory(result) {
        var d = eval(result);
      
            if(d.success == true){
                veData1 ='';

                   for (var i = 0; i < d.data.length; i++) {
                     
                                veData1 += '<tr class="rows-style">';
                                veData1 += '<td>'+ new Date(d.data[i].PickupDate).format("MM/dd/yyyy") + '</td>';
                                veData1 += '<td>'+ d.data[i].Address1 + '</td>';
                                veData1 += '<td>'+ d.data[i].Address2 + '</td>';
                                veData1 += '<td>'+ d.data[i].Detail + '</td>';
                                veData1 += '<td>$'+ d.data[i].Amount + '</td></tr>';
                            }
            
            $("#dvhistorial").html('');
            $("#dvhistorial").html(LoadPageCountListhistori( d.pageIndex,  d.count, 'Listorder',  d.pageSize, "", Math.floor( d.pageIndex / 10)));
            $('#infohistorial').html(veData1);

        }

       
       
    }
    function onErrorLoadUserOrderhistory(result) {
        if (result.status == 200) {
            onSuccessLoadUserOrderhistory(result);
        }
    }

   
</script>

<%--Save Credit Card--%>
<script type="text/javascript">

    function ValidateCreaditCardDate() {
        var date = new Date();
        var getCurrentMonth = date.getMonth() + 1;
        var getCurrentYear = date.getFullYear();

        var vrCCMonth = $("#ddlMonth").val();
        var vrCCYear = $("#ddlYear").val();

        if (vrCCMonth < getCurrentMonth || vrCCYear < getCurrentYear) {
            $("#dvCreditCardAlertDiv").html('<div class="alert alert-error">Please select correct date.</div>');
            return false;
        }
    }

    function SaveCreditCard() {
        var validate = new Validator({ validation_group: 'SaveCreditCard', error_class: 'error' });
        validate.validate({
            txtCardNumber: 'Credit card number is required.',
            ddlMonth: 'Card expiry month is required.',
            ddlYear: 'Card expiry year is required.',
            txtSecurityCode: 'Security code is required.' 
        });

        if (validate.error == undefined) {
            $("#dvCreditCardAlertDiv").html('');
        }
        else {
            $("#dvCreditCardAlertDiv").html('<div class="alert alert-error">' + validate.error + '</div>');
            return false;
        }

        var vCardNumber = $("#txtCardNumber").val();
        var vExpiryYear = $("#ddlYear").val();
        var vExpiryMonth = $("#ddlMonth").val();
        var vCVV = $("#txtSecurityCode").val();
         
        var vrCardType = "";
        if (vCardNumber.startsWith('3') == true) {
            vrCardType = 'American Express';
        }
        if (vCardNumber.startsWith('4') == true) {
            vrCardType = 'Visa';
        }
        if (vCardNumber.startsWith('5') == true) {
            vrCardType = 'MasterCard';
        }
        if (vCardNumber.startsWith('6') == true) {
            vrCardType = 'Discover';
        }



        var mcontact = {
            IsPreferredCard: false,
            UserID: vrUserID,
            CardLastFourDigit: vCardNumber,
            CardType: vrCardType,
            ExpirationMonth: vExpiryMonth,
            ExpirationYear: vExpiryYear,
            /*ZipCode: vCardZip,*/
            CVV: vCVV,
        };
        var objectAsJson = JSON.stringify(mcontact);



        $.ajax({
            type: "POST",
            url: "/DesktopModules/GoGetIt/API/CreditCard/Save",
            cache: false,
            data: objectAsJson,
            contentType: "application/json",
            success: function (result) {
                if (result.success) {
                    $("#dvCreditCardAlertDiv").html('<div class="alert alert-success"> Payment method save sucessfully.</div>');
                    LoadCreditCard();
                }
                else {
                    $("#dvCreditCardAlertDiv").html('<div class="alert alert-error">' + result.msg + '</div>');
                }
            },
            error: function (result) {
                $("#dvCreditCardAlertDiv").html('<div class="alert alert-error">There was an error submitting the form.</div>');
            },
        });

    }

</script>
<style type="text/css">
    .imgUserAccount {
        float: left;
        padding: 6px;
        vertical-align: sub;
    }

    .MailIcn {
    }

    .PhoneIcn {
        padding: 0 10px;
    }

    .LocationIcn {
    }

    .dvBorderTop {
        border-bottom: 1px solid #ebebeb;
        padding: 10px 0 0 0;
        clear: both;
    }

    .dvOrderDate {
        font-weight: bold;
        float: left;
        max-width: 100px;
		width:100%;
    }

    .dvOrderDateLeft {
        font-weight: bold;
        float: left;
        max-width: 380px;
		width:100%;
    }

    .dvOrderReorder {
        float: left;
        max-width: 100px;
		width:100%;
    }

    .dvOrderDes {
        float: left;
        max-width: 300px;
		width:100%;
    }

    #dvOrderList {
        height: 435px;
        overflow: auto;
        width: 100%;
    }

    .dvOrderMain {
        height: 77px;
        display: inline-block;
        padding: 10px 0;
    }

    .displayNone {
        display: none;
    }

    #accountInfo .form-group {
        margin-bottom: 35px;
        overflow: auto;
    }

     .head-talbe-order{
    font-weight: normal;
    background-color: #000000;
    color: #ffffff;
    text-align: center;

    }

    .rows-style{

    font-family: roboto;
    font-size: 15px;
    color: black;
    }

    .table-striped>tbody>tr:nth-of-type(odd) {
    background-color: #f1f1f1;
    }

    td, th {
    padding: 4px;
    padding-bottom: 12px;
    padding-left: 24px;
    }
</style>

<script type="text/javascript">
    function ReOrder(OrderID) {
        $('#confirmReOrder').modal('show');
        vrOrderID = OrderID;
    }
    var vrOrderID = 0;
    function ReDirectToOrderStep2() {
        window.location = '/Order?OrderID=' + vrOrderID;
    }
</script>
<script type="text/javascript">
    function BackToOrder() {
        $(location).attr('href', '/Order');
    }
</script>
<script type="text/javascript">
    function DeactivateAccount() {
        $('#confirmDeActivate').modal('hide');
        $.ajax({
            type: "PUT",
            url: "/DesktopModules/GoGetIt/API/RegisteredUser/DeActivate",
            cache: false,
            dataType: "json",
            success: onSuccessDeactivateAccount,
            error: onErrorDeactivateAccount
        });
    }
    function onSuccessDeactivateAccount(result) {
        var o = eval(result);
        if (o == true) {
            $("#dvDeactivateAlertDiv").html('<div class="alert alert-success"> Account deactivated sucessfully.</div>');
            location.reload();
        }
        else {
            $("#dvDeactivateAlertDiv").html('<div class="alert alert-error"> There was an error while deactivating account.</div>');
        }
    }


    function onErrorDeactivateAccount(result) {
        if (result.status == 200) {
            onSuccessDeactivateAccount(result);
        }
    }

</script>

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
                    <li><a data-toggle="tab" href="#seereceipt">Invoice History</a></li>
                    <li><a data-toggle="tab" href="#deactivatedAccount">Deactivate Account</a></li> <br>
                    <li><a href="/Order" style="background-color: #afafaf !important;  width: 160px; color: white; margin-left: 15px; ">ORDER NOW</a></li>
                    <!-- <button id="BacktoOrder" type="button" class="btn btn-default YellowBtn" onclick="BackToOrder();">ORDER NOW</button><br> -->
                    
                </ul>
            </div>
            <div class="" id="TabMid"></div>
            <div class="" id="TabRight">
                <div class="tab-content">
                    <div id="accountInfo" class="tab-pane fade in active">
                        <div class="text-right">
                            <img src="/images/EditIcn.png" onclick="EditMyAccount();" />
                        </div>
                        <h3 id="UserName"></h3>
                        <div class="dvRow">
                            <div class="form-group">
                                <div class="col-md-1">
                                    <img class="imgUserAccount MailIcn" src="images/MailIcn.png" />
                                </div>
                                <div class="col-md-11">
                                    <div id="UserEmail"></div>
                                </div>
                            </div>
                        </div>
                        <div class="dvRow" id="dvEditPhoneLabel">
                            <div class="form-group">
                                <div class="col-md-1">
                                    <img class="imgUserAccount PhoneIcn" src="images/PhoneIcn.png" />
                                </div>
                                <div class="col-md-11">
                                    <div id="userPhoneLabel"></div>
                                </div>
                            </div>
                        </div>
                        <div class="dvRow displayNone" id="dvEditPhone">
                            <div class="form-group">
                                <div class="col-md-1">
                                    <img class="imgUserAccount PhoneIcn" src="images/PhoneIcn.png" />
                                </div>
                                <div class="col-md-11">
                                    <input type="text" id="userPhone" class="form-control UpdateUserInfo validate-phone" onkeypress="FormatPhone(event,userPhone);" />
                                </div>
                            </div>
                        </div>
                        <div class="dvRow displayNone">
                            <div class="form-group">
                                <div class="col-md-8">
                                    <img class="imgUserAccount LocationIcn" src="images/LocationIcn.png" />
                                    <div id="UserAddress"></div>
                                </div>
                            </div>
                        </div>
                        <div class="dvRow displayNone" id="dvSavePhoneBtn">
                            <div class="form-group">
                                <div class="col-md-1">
                                </div>
                                <div class="col-md-11">
                                    <input class="btn btn-default YellowBtn" type="button" id="btnUpdateAccount" onclick="UpdateUserInformation();" value="Save">
                                </div>
                            </div>
                        </div>
                        <div class="dvRow" id="dvUpdateUserAlertDiv"></div>

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
                        <div class="text-right">
                            <img src="/images/EditIcn.png" onclick="EditPaymentMethod();" />
                        </div>
                        <h3>Payment Method</h3>
                        <div class="form-group">
                            <label for="txtCardNumber" class="col-md-2">Existing:</label>
                            <div class="col-md-8" id="lblCardNumber"></div>
                        </div>

                        <div class="dvRow">
                            <div class="form-group">
                                <input type="button" class="btn btn-default YellowBtn" value="Edit" onclick="EditPaymentMethod();" />
                            </div>
                        </div>

                        <div id="dvPaymentInformation" class="displayNone">
                            <div class="form-group">
                                <label for="txtCardNumber">Card Number</label>
                                <input type="text" class="form-control SaveCreditCard validate-int" id="txtCardNumber" maxlength="16" />
                            </div>
                            <div class="form-group">
                                <label for="txtSecurityCode">Expiration Date</label>
                                <div class="DateTotal">
                                    <div class="Month">
                                        <select class="form-control SaveCreditCard" id="ddlMonth">
                                            <option value="01">1</option>
                                            <option value="02">2</option>
                                            <option value="03">3</option>
                                            <option value="04">4</option>
                                            <option value="05">5</option>
                                            <option value="06">6</option>
                                            <option value="07">7</option>
                                            <option value="08">8</option>
                                            <option value="09">9</option>
                                            <option value="10">10</option>
                                            <option value="11">11</option>
                                            <option value="12">12</option>
                                        </select>
                                    </div>
                                    <div class="Slah">/ </div>
                                    <div class="Year">
                                        <select class="form-control SaveCreditCard" id="ddlYear">
                                            
                                            <option value="2017">2017</option>
                                            <option value="2018">2018</option>
                                            <option value="2019">2019</option>
											<option value="2020">2020</option>
											<option value="2021">2021</option>
                                            <option value="2022">2022</option>
                                            <option value="2023">2023</option>
                                            <option value="2024">2024</option>
                                            <option value="2025">2025</option>
                                            <option value="2026">2026</option>
                                            <option value="2027">2027</option>
                                            <option value="2028">2028</option>											
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="txtSecurityCode">Security Code</label>
                                <input type="text" class="form-control SaveCreditCard" id="txtSecurityCode">
                            </div>
                             
                            <div class="form-group">
                                <input type="button" class="btn btn-default GreyBtn" value="Cancel" onclick="HidePaymentMethod()" />
                                <input type="button" class="btn btn-default YellowBtn" id="btnUpdatePaymentMethod" value="Save" onclick="SaveCreditCard();" />
                            </div>
                            <div class="dvRow" id="dvCreditCardAlertDiv"></div>
                        </div>
                    </div>
                    <div id="orderHistory" class="tab-pane fade">
                        <h3>Order History</h3>
                        <div class="form-group">
                            <label for="txtCardNumber" class="col-md-3">My Orders:</label>
                            <div class="col-md-8" id="dvOrderCount"></div>
                        </div>
                        <div class="dvRow form-group">
                            <div class="col-md-8" id="dvOrderList">
                            </div>                            
                        </div>
                        <div class="dvRow dvPagerTotal" id="dvCountList"></div>
                    </div>
                    <div id="deactivatedAccount" class="tab-pane fade">
                        <h3>Deactivate Account</h3>
                        <p>Once you've deactivated your account, you will no longer be able to</p>
                        <p>log into the Go Get It website. This action cannot be undone.</p>
                        <p>&nbsp;</p>                        
                        <button id="DeactivateAccountButton" type="button" class="btn btn-default YellowBtn" onclick="$('#confirmDeActivate').modal('show');">Deactivate</button>
                        <div id="dvDeactivateAlertDiv" class="dvRow"></div>
                    </div>

                    <div id="seereceipt" class="tab-pane fade">
                        <h3>Invoice History</h3>
                            <div class="table-responsive">
                                <table id="historial" class="table-striped">
                                    <thead class="head-talbe-order">
                                        <tr>
                                            <td>ORD. DATE</td>
                                            <td>DELIVERY ADDRESS</td>
                                             <td>PICKUP ADDRESS</td>
                                            <td>DETAIL</td>
                                            <td>TOTAL COST</td>
                                        </tr>
                                    </thead>
                                    <tbody id="infohistorial">
                                    </tbody>
                                </table>
                                <div class="dvRow dvPagerTotal" id="dvhistorial"></div>
                            </div>
                    </div>



                </div>
                <br><br>
                
            </div>
        </div>
    </div>
</div>


<div id="confirmReOrder" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
			  <div class="form-group">
                <h4>Are you sure you want to reorder?<h4>
				</div>
				<div class="form-group">
				  <button class="btn btn-default GreyBtn" type="button" data-dismiss="modal">Cancel</button>
                  <button type="button" onclick="ReDirectToOrderStep2();" class="btn btn-default YellowBtn">YES</button>
				  </div>
            </div>
        </div>
    </div>
</div>


<div id="confirmDeActivate" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
			  <div class="form-group">
                <h4>Are you sure you want to deactivate?<h4>
				</div>
				<div class="form-group">
				  <button class="btn btn-default GreyBtn" type="button" data-dismiss="modal">Cancel</button>
                  <button type="button" onclick="DeactivateAccount();" class="btn btn-default YellowBtn">YES</button>
				  </div>
            </div>
        </div>
    </div>
</div>

<style>
    #confirmReOrder .modal-dialog{
		width:100%;
		max-width:400px;
	}
	#confirmDeActivate .modal-dialog{
		width:100%;
		max-width:400px;
	}
    #modalUpdateAccountInfo .modal-dialog {
        width: 700px;
        max-width: 100%;
    }

    #modalUpdateAccountInfo .modal-body {
        border-top: 5px solid #FDE700;
    }

    #modalUpdateAccountInfo .modal-content {
        -moz-border-radius: 0px;
        -webkit-border-radius: 0px;
        border-radius: 0px;
    }

    #modalUpdateAccountInfo h1 {
        font-size: 56px;
        font-weight: 300;
        color: #252525;
        font-family: roboto;
        text-align: center;
    }

    #modalUpdateAccountInfo .dvThankyouText {
        color: #7e7e7e;
        font-family: roboto;
        font-size: 20px;
        text-align: center;
        margin: 15px 0;
    }

    @media all and (max-width: 720px) {
        #modalUpdateAccountInfo .modal-dialog {
            width: 300px;
            max-width: 100%;
        }
    }
</style>


