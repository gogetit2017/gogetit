<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BecomeGoGetter.ascx.cs" Inherits="GoGetIt.BecomeGoGetter" %>


<script src="//code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">

<!--Datepicker-->
<script type="text/javascript">
    $(function () {
        $("#" + "txtGetterDOB").datepicker();
        $("#" + "txtGetterExpirationDate").datepicker();

        /* $('#txtGetterVehicleYear').datepicker({
             dateFormat: 'yy'
         });*/


    });
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

<!--Step One Function-->
<script type="text/javascript">
    function StepOne() {
        var validate = new Validator({ validation_group: 'StepOne', error_class: 'error' });
        validate.validate({
            txtGetterFirstName: 'First name is required.',
            txtGetterLastName: 'Last name is required',
            txtGetterEmail: 'Email is required.',
            txtGetterPhone: 'Phone no. is required.',
            txtGetterAddress: 'Address is required.',
            txtGetterZip: 'Zip code is required.',
            txtGetterDOB: 'Date of birth is required.',
            txtGetterSSN: 'SSN is required.',
        });
        if (validate.error == undefined) {
            $("#dvStepOneAlertDiv").html('');
        }
        else {
            $("#dvStepOneAlertDiv").html('<div class="alert alert-error">' + validate.error + '</div>');
            return false;
        }

        $('#dvStep1').hide();
        $('#dvStep2').show();
        $('#dvStep3').hide();

        $('#StepOneImg_Normal').show();
        $('#StepOneImg_Hover').hide();
        $('#StepTwoImg_Normal').hide();
        $('#StepTwoImg_Hover').show();
    }
    function BackStep2() {
        $('#dvStep2').show();
        $('#dvStep3').hide();

        $('#StepOneImg_Normal').show();
        $('#StepOneImg_Hover').hide();
        $('#StepTwoImg_Normal').hide();
        $('#StepTwoImg_Hover').show();
        $('#StepThreeImg_Normal').show();
        $('#StepThreeImg_Hover').hide();

    }
    function BackStep1() {
        $('#dvStep1').show();
        $('#dvStep2').hide();
        $('#StepOneImg_Normal').hide();
        $('#StepOneImg_Hover').show();
        $('#StepTwoImg_Normal').show();
        $('#StepTwoImg_Hover').hide();
        $('#StepThreeImg_Normal').show();
        $('#StepThreeImg_Hover').hide();
    }
</script>

<!--Step Two Function-->
<script type="text/javascript">
    function StepTwo() {
        var validate = new Validator({ validation_group: 'StepTwo', error_class: 'error' });
        validate.validate({
            ddlVehicleType: 'Vehicle type is required.',
            txtGetterLicenseNumber: 'Vehicle license no. is required',
            txtGetterVehicleMake: 'Vehicle make required.',
            ddlGetterStateIssued: 'State issued is required.',
            txtGetterVehicleModal: 'Vehicle modal is required.',
            txtGetterExpirationDate: 'Expiration date is required.',
            txtGetterVehicleYear: 'Vehicle year is required.',
            txtGetterVehicleInsurance: 'Vehicle insurance required.',
        });
        if (validate.error == undefined) {
            $("#dvStepTwoAlertDiv").html('');
        }
        else {
            $("#dvStepTwoAlertDiv").html('<div class="alert alert-error">' + validate.error + '</div>');
            return false;
        }

        $('#dvStep1').hide();
        $('#dvStep2').hide();
        $('#dvStep3').show();

        $('#StepOneImg_Normal').show();
        $('#StepOneImg_Hover').hide();
        $('#StepTwoImg_Normal').show();
        $('#StepTwoImg_Hover').hide();
        $('#StepThreeImg_Normal').hide();
        $('#StepThreeImg_Hover').show();
    }
</script>


<!--Step Three Function-->
<script type="text/javascript">
    function StepThree() {
        var validate = new Validator({ validation_group: 'StepThree', error_class: 'error' });
        validate.validate({
            ddlHowYouHear: 'How did you hear about us is required.',
            ddlWorkAsDriver: 'Have you ever worked as driver is required.',
            ddlHowManyYouWork: 'How many hour do you work is required.',
            ddlPlanToWork: 'Do you plan to work week days or weekends? is required.',
            ddlWorkDayOrNight: 'Do you plan to work in the day or in the night? is required.',
            txtDescribeYourself: 'Describe yourself in one sentence is required.',
        });
        if (validate.error == undefined) {
            $("#dvStepThreeAlertDiv").html('');
        }
        else {
            $("#dvStepThreeAlertDiv").html('<div class="alert alert-error">' + validate.error + '</div>');
            return false;
        }
        var vFirstName = $("#txtGetterFirstName").val();
        var vLastName = $("#txtGetterLastName").val();
        var vEmail = $("#txtGetterEmail").val();
        var vPhone = $("#txtGetterPhone").val();
        var vAddress = $("#txtGetterAddress").val();
        var vZip = $("#txtGetterZip").val();
        var vDOB = $("#txtGetterDOB").val();
        var vSSN = $("#txtGetterSSN").val();

        var vVehicleType = $("#ddlVehicleType").val();
        var vLicenseNumber = $("#txtGetterLicenseNumber").val();
        var vVehicleMake = $("#txtGetterVehicleMake").val();
        var vStateIssued = $("#ddlGetterStateIssued").val();
        var vVehicleModal = $("#txtGetterVehicleModal").val();
        var vExpirationDate = $("#txtGetterExpirationDate").val();
        var vVehicleYear = $("#txtGetterVehicleYear").val();
        var vVehicleInsurance = $("#txtGetterVehicleInsurance").val();

        var vHowYouHear = $("#ddlHowYouHear").val();
        var vWorkAsDriver = $("#ddlWorkAsDriver").val();
        var vHowManyYouWork = $("#ddlHowManyYouWork").val();
        var vPlanToWork = $("#ddlPlanToWork").val();
        var vWorkDayOrNight = $("#ddlWorkDayOrNight").val();
        var vDescribeYourself = $("#txtDescribeYourself").val();

        var mcontact = {
            roleID: 5,
            firstName: vFirstName,
            lastName: vLastName,
            email: vEmail,
            password: ' ',
            address: vAddress,
            zip:vZip,


            registeredUser: {
                PhoneNumber: vPhone

            },
            driverDetail: {

                SSN: vSSN,
                TypeOfVehicle: vVehicleType,
                LicenseNumber: vLicenseNumber,
                VehicleMake: vVehicleMake,
                StateIssued: vStateIssued,
                VehicleModel: vVehicleModal,
                _ExpirationDate: vExpirationDate,
                _DateOfBirth: vDOB,
                VehicleYear: vVehicleYear,
                VehicleInsurance: vVehicleInsurance,
                HearAboutUs: vHowYouHear,
                WorkedAsDriver: vWorkAsDriver,
                HoursAWeek: vHowManyYouWork,
                WorkWeekDaysOrWeekends: vPlanToWork,
                WorkInDayOrNight: vWorkDayOrNight,
                DescribeYourself: vDescribeYourself

            }
        };
        var objectAsJson = JSON.stringify(mcontact);

        $.ajax({
            type: "POST",
            url: "/DesktopModules/GoGetIt/API/RegisteredUser/CreateUser",
            cache: false,
            data: objectAsJson,
            contentType: "application/json",
            success: onSuccessStepThree,
            error: onErrorStepThree
        });
    }
    function onSuccessStepThree(result) {
        var o = eval(result);
        if (o.success == true) {
            //$("#dvStepThreeAlertDiv").html('<div class="alert alert-success">Thank you for contacting us.</div>');
            //window.location.href = '/ThankYouApplication';
            $('#modalThankyou').modal('show');
        }
        else {
            $("#dvStepThreeAlertDiv").html('<div class="alert alert-error">The email you entered is already taken. Please use a different email.</div>');
        }
    }
    function onErrorStepThree(result) {
        if (result.status == 200) {
            onSuccessStepThree(result);
        }
    }

</script>

<div class="dvOuterGrey">
    <div class="container">
        <div class="dvBecomeGetterGreyBG">
            <div class="dvBecomeGetterTitleText">
                If this sounds like the opportunity 
					you have been looking for, Apply Now.
            </div>

            <div class="StepImgRow">
                <div class="dvStepsCircle">
                    <img src="/images/OneIcn.png" id="StepOneImg_Normal" />
                    <img src="/images/OneIcn_Hover.png" id="StepOneImg_Hover" />
                </div>
                <div class="dvStepsCircle">
                    <img src="/images/TwoIcn.png" id="StepTwoImg_Normal" />
                    <img src="/images/TwoIcn_Hover.png" id="StepTwoImg_Hover" />
                </div>
                <div class="dvStepsCircle">
                    <img src="/images/ThreeIcn.png" id="StepThreeImg_Normal" />
                    <img src="/images/ThreeIcn_Hover.png" id="StepThreeImg_Hover" />
                </div>
            </div>

            <!--Step 1-->
            <div class="dvBecomeGetterFormBG" id="dvStep1">
                <div class="dvPersonalInfo">
                    PERSONAL INFORMATION
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class=" form-group">
                            <input type="text" class="form-control StepOne" id="txtGetterFirstName" placeholder="First Name" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class=" form-group">
                            <input type="text" class="form-control StepOne" id="txtGetterLastName" placeholder="Last Name" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class=" form-group">
                            <input type="email" class="form-control StepOne validate-email" id="txtGetterEmail" placeholder="Email" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class=" form-group">
                            <input type="text" class="form-control StepOne validate-phone" id="txtGetterPhone" placeholder="Phone" onkeypress="FormatPhone(event,txtGetterPhone);" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class=" form-group">
                            <input type="text" class="form-control StepOne" id="txtGetterAddress" placeholder="Street Address" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class=" form-group">
                            <input type="text" class="form-control StepOne validate-int" id="txtGetterZip" placeholder="Zip" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class=" form-group">
                            <input type="text" class="form-control StepOne" id="txtGetterDOB" placeholder="Date of Birth (MM/DD/YYYY)" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class=" form-group">
                            <input type="text" class="form-control StepOne validate-int" id="txtGetterSSN" placeholder="SSN (455884455)" maxlength="10" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">

                            <img src="/images/BecomeGoGetterNextIcn.png" class="NextBtn" onclick="StepOne();" />

                        </div>
                    </div>
                </div>
                <div class="dvRow">
                    <div id="dvStepOneAlertDiv"></div>
                </div>
            </div>
            <!--Step 2-->
            <div class="dvBecomeGetterFormBG" id="dvStep2" style="display: none;">
                <div class="dvPersonalInfo">
                    TRANSPORTATION INFORMATION
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class=" form-group">
                            <select class="form-control StepTwo" id="ddlVehicleType">
                                <option value=" ">Type of Vehicle</option>
                                <option value="Car">Car</option>
                                <option value="Motorcycle">Motorcycle</option>
                                <option value="Scooter">Scooter</option>
                                <option value="Pickup Truck">Pickup Truck</option>
                                <option value="SUV">SUV</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class=" form-group">
                            <input type="text" class="form-control StepTwo" id="txtGetterLicenseNumber" placeholder="Driver's License Number" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class=" form-group">
                            <input type="text" class="form-control StepTwo" id="txtGetterVehicleMake" placeholder="Vehicle Make (e.g. Honda)" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class=" form-group">
                            <select id="ddlGetterStateIssued" class="form-control StepTwo">
                                <option value=" ">State Issued</option>
                                <option value="Alabama">Alabama</option>
                                <option value="Alaska">Alaska</option>
                                <option value="Arizona">Arizona</option>
                                <option value="Arkansas">Arkansas</option>
                                <option value="California">California</option>
                                <option value="Colorado">Colorado</option>
                                <option value="Connecticut">Connecticut</option>
                                <option value="Delaware">Delaware</option>
                                <option value="District of Columbia">District of Columbia</option>
                                <option value="Florida">Florida</option>
                                <option value="Georgia">Georgia</option>
                                <option value="Hawaii">Hawaii</option>
                                <option value="Idaho">Idaho</option>
                                <option value="Illinois">Illinois</option>
                                <option value="Indiana">Indiana</option>
                                <option value="Iowa">Iowa</option>
                                <option value="Kansas">Kansas</option>
                                <option value="Kentucky">Kentucky</option>
                                <option value="Louisiana">Louisiana</option>
                                <option value="Maine">Maine</option>
                                <option value="Maryland">Maryland</option>
                                <option value="Massachusetts">Massachusetts</option>
                                <option value="Michigan">Michigan</option>
                                <option value="Minnesota">Minnesota</option>
                                <option value="Mississippi">Mississippi</option>
                                <option value="Missouri">Missouri</option>
                                <option value="Montana">Montana</option>
                                <option value="Nebraska">Nebraska</option>
                                <option value="Nevada">Nevada</option>
                                <option value="New Hampshire">New Hampshire</option>
                                <option value="New Jersey">New Jersey</option>
                                <option value="New Mexico">New Mexico</option>
                                <option value="New York">New York</option>
                                <option value="North Carolina">North Carolina</option>
                                <option value="North Dakota">North Dakota</option>
                                <option value="Ohio">Ohio</option>
                                <option value="Oklahoma">Oklahoma</option>
                                <option value="Oregon">Oregon</option>
                                <option value="Pennsylvania">Pennsylvania</option>
                                <option value="Rhode Island">Rhode Island</option>
                                <option value="South Carolina">South Carolina</option>
                                <option value="South Dakota">South Dakota</option>
                                <option value="Tennessee">Tennessee</option>
                                <option value="Texas">Texas</option>
                                <option value="Utah">Utah</option>
                                <option value="Vermont">Vermont</option>
                                <option value="Virginia">Virginia</option>
                                <option value="Washington">Washington</option>
                                <option value="West Virginia">West Virginia</option>
                                <option value="Wisconsin">Wisconsin</option>
                                <option value="Wyoming">Wyoming</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class=" form-group">
                            <input type="text" class="form-control StepTwo" id="txtGetterVehicleModal" placeholder="Vehicle Model (e.g. Civic)" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class=" form-group">
                            <input type="text" class="form-control StepTwo" id="txtGetterExpirationDate" placeholder="Expiration Date" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class=" form-group">
                            <input type="text" class="form-control validate-int StepTwo" id="txtGetterVehicleYear" placeholder="Vehicle Year" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class=" form-group">
                            <input type="text" class="form-control StepTwo" id="txtGetterVehicleInsurance" placeholder="Vehicle Insurance #" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div onclick="BackStep1();" style="cursor: pointer;"><b>Back</b></div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <img src="/images/BecomeGoGetterNextIcn.png" class="NextBtn" onclick="StepTwo();" />
                        </div>
                    </div>
                </div>
                <div class="dvRow">
                    <div id="dvStepTwoAlertDiv"></div>
                </div>
            </div>
            <!--Step 3-->
            <div class="dvBecomeGetterFormBG" id="dvStep3" style="display: none;">
                <div class="dvPersonalInfo">
                    EXTRA INQUIRIES
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class=" form-group">
                            <select id="ddlHowYouHear" class="form-control StepThree">
                                <option value=" ">How Did You Hear About Us</option>
                                <option value="Friend">Friend</option>
                                <option value="Flyers">Flyers</option>
                                <option value="Post on Job Board">Post on Job Board</option>
                                <option value="Instagram">Instagram</option>
                                <option value="Facebook">Facebook</option>
                                <option value="LinkedIn">LinkedIn</option>
                                <option value="Saw a Go Getter performing services">Saw a Go Getter performing services</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class=" form-group">
                            <select id="ddlWorkAsDriver" class="form-control StepThree">
                                <option value=" ">Have you/have ever worked as a driver/messanger?</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class=" form-group">
                            <select id="ddlHowManyYouWork" class="form-control StepThree">
                                <option value=" ">How many hours a week do you plan to work?</option>
                                <option value="less than 10 hours">less than 10 hours</option>
                                <option value="10 - 20 hours">10 - 20 hours</option>
                                <option value="20 - 30 hours">20 - 30 hours</option>
                                <option value="30 - 40 hours">30 - 40 hours</option>
                                <option value="more than 40 hours">more than 40 hours</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class=" form-group">
                            <select id="ddlPlanToWork" class="form-control StepThree">
                                <option value=" ">Do you plan to work week days or weekends?</option>
                                <option value="Week Days">Week Days</option>
                                <option value="Weekends">Weekends</option>
                                <option value="Both">Both</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class=" form-group">
                            <select id="ddlWorkDayOrNight" class="form-control StepThree">
                                <option value=" ">Do you plan to work in the day or in the night?</option>
                                <option value="Day">Day</option>
                                <option value="Night">Night</option>
                                <option value="Both">Both</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class=" form-group">
                            <input type="text" class="form-control StepThree" id="txtDescribeYourself" placeholder="Describe yourself in one sentence." />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div onclick="BackStep2();" style="cursor: pointer;"><b>Back</b></div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <img src="/images/BecomeGoGetterNextIcn.png" class="NextBtn" onclick="StepThree();" />
                        </div>
                    </div>
                </div>
                <div class="dvRow">
                    <div id="dvStepThreeAlertDiv"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalThankyou" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">

            <div class="modal-body">

                <h1>THANK YOU!</h1>
                <div class="dvThankyouText">We have received your application.</div>
                <div class="dvThankyouText">You will receive communication from one<br />
of our representatives shortly.</div>

            </div>

        </div>
    </div>
</div>
<style>
    #modalThankyou .modal-dialog {
        width: 500px;
        max-width: 100%;
    }

    #modalThankyou .modal-body {
        border-top: 5px solid #FDE700;
    }

    #modalThankyou .modal-content {
        border-radius: 0px;
    }

    #modalThankyou h1 {
        font-size: 56px;
        font-weight: 300;
        color: #252525;
        font-family: roboto;
        text-align: center;
    }

    #modalThankyou .dvThankyouText {
        color: #7e7e7e;
        font-family: roboto;
        font-size: 20px;
        text-align: center;
        margin: 15px 0;
    }

    @media all and (max-width: 520px) {
        #modalThankyou .modal-dialog {
            width: 400px;
            max-width: 100%;
        }
    }

    @media all and (max-width: 390px) {
        #modalThankyou .modal-dialog {
            width: 370px;
            max-width: 100%;
        }
    }
</style>
