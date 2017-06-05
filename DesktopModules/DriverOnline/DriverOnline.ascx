<%@  Control Language="C#" AutoEventWireup="true" CodeBehind="DriverOnline.ascx.cs" Inherits="GoGetIt.DriverOnline" %>

<script src="/js/GoGetIt.js"></script>
<link href="/Portals/_default/Skins/GoGetIt/css/bootstrap.min.css" rel="stylesheet" />


<style type="text/css">
    #ddlOrderStatus {
        max-width: 300px;
    }

    .col-sm-9 > div {
        padding-top: 10px;
    }
</style>

<script type="text/javascript">
    $(document).ready(function () {
        LoadDriverList();
    });
    window.setInterval(function () {
        LoadDriverList();
    }, 30000);
</script>

<script type="text/javascript">
    function LoadDriverList() {
        document.getElementById('dvDriverList').innerHTML += ' <div class="blur"></div><div class="progress"><img src="/Images/Loader.gif" /></div>';       
        var mcontact = '';
        var objectAsJson = JSON.stringify(mcontact);
        $.ajax({
            type: "GET",            
            url: "/DesktopModules/GoGetIt/API/driver/List?type=On",
            cache: false,
            data: objectAsJson,
            contentType: "application/json",
            success: onSuccessLoadDriverList,
            error: onErrorLoadDriverList
        });

    }
    function onSuccessLoadDriverList(result) {
        var o = eval(result);
        if (o.length != 0) {
            var vrData = ''
            vrData += '<table class="table table-bordered">';
            vrData += '<thead>';
            vrData += '<tr>';
            vrData += '<th>First Name<span></th>';
            vrData += '<th>Last Name</th>';            
            vrData += '<th>Email</th>';
            vrData += '<th>Phone Number</th>';
            vrData += '</tr>';
            vrData += '</thead>';
            vrData += '<tbody>';
            for (var i = 0; i < o.length; i++) {
                vrData += '<tr>';

                vrData += '<td>';
                vrData += o[i].firstName;
                vrData += '</td>';

                vrData += '<td>';
                vrData += o[i].lastName;
                vrData += '</td>';

                vrData += '<td>';
                vrData += o[i].email;
                vrData += '</td>';

                vrData += '<td>';
                vrData += o[i].registeredUser.PhoneNumber;
                vrData += '</td>';

                vrData += '</tr>';
            }
            vrData += '</tbody>';
            vrData += '</table>';
            $('#dvDriverList').html(vrData);
        }
        else {
            $('#dvDriverList').html('No record found.');
        }

    }
    function onErrorLoadDriverList(result) {
        if (result.status == 200) {
            onSuccessLoadDriverList(result);
        }
    }
</script>

<div class="container">
    <div class="well">
        <div class="form-group">
            <div class="dvRow" id="dvDriverList"></div>
        </div>
    </div>
</div>


