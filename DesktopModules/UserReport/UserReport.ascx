<%@  Control Language="C#" AutoEventWireup="true" CodeBehind="UserReport.ascx.cs" Inherits="GoGetIt.UserReport" %>
<link href="/js/bootstrap-datepicker.css" rel="stylesheet" />
<script src="/js/bootstrap-datepicker.js"></script>

<style>
    #dvOrderReportAlertDiv{
        margin:20px auto;
        width:70%;
    }
</style>

<script type="text/javascript">
    $(document).ready(function () {
        $('#txtStartDate').datepicker();
        $('#txtEndDate').datepicker()
    });
</script>

<script type="text/javascript">
    function ValidateDate() {


        var vrStartDate = $("#txtStartDate").data('datepicker').getFormattedDate('mm-dd-yyyy');
        var vrEndDate = $("#txtEndDate").data('datepicker').getFormattedDate('mm-dd-yyyy');

        if (vrStartDate == '') {
            $("#dvOrderReportAlertDiv").html('<div class="alert alert-error">Please select start date.</div>');            
        }        
        else if (vrEndDate == '') {
            $("#dvOrderReportAlertDiv").html('<div class="alert alert-error">Please select end date.</div>');            
        }
        else if (vrStartDate && vrEndDate != '') {
            $("#dvOrderReportAlertDiv").html('');
            window.location = "/handler/userreport.ashx?startdate=" + vrStartDate + "&enddate=" + vrEndDate;
        }
        else {           
            alert('Exit');
        }       

    }
</script>




<div class="container">
    <div class="well" style="overflow: auto;">
        <div class="form-inline">
            <div class="dvRow">
                <div class="col-md-5">
                    <div class="form-group">
                        <label for="txtStartDate">Start Date :</label>
                        <div class='input-group date' id='txtStartDate'>
                            <input type='text' class="form-control" />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-md-5">
                    <div class="form-group">
                        <label for="txtEndDate">End Date :</label>
                        <div class='input-group date' id='txtEndDate'>
                            <input type='text' class="form-control" />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <input type="button" class="btn btn-default" value="Submit" onclick="ValidateDate();" />
                </div>                
            </div>
        </div>
        <div class="dvRow" id="dvOrderReportAlertDiv"></div>
    </div>
</div>














