<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Orderrate.ascx.cs" Inherits="GoGetIt.Orderrate" %>

<div class="container">
  <form id="review">
  <img src="http://letusgogetit.com/images/gogetmail.png" alt="gogetit" class="logo">
  <h2>THANK YOU FOR CHOOSING GOGETIT <br>
TO DELIVER YOUR ITEMS.</h2>
<img src="http://letusgogetit.com/images/emailsepa.png" alt="gogetit" class="linea">
<h3>We want to hear from you...Please rate your experience!</h3>
    <div class="form-group">
      <input id="rating-input" type="number" />
      <span class="num">1 2 3 4 5</span>
    </div>
    <div class="form-group">

      <textarea class="form-control" rows="5" id="comment" placeholder="Any other feedback or suggestions?"></textarea>
    </div>
    <input type="hidden" id="orderid">
    <button type="button" id="but" class="btn btn-defaulto">SEND</button>
  </form>
  <a href="/"><span class="glyphicon glyphicon-chevron-left azulito" aria-hidden="true"></span></a>
</div>
<div class="modal fade" id="modalOrderThankyou" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">

            <div class="modal-body">

                <h1>THANK YOU!</h1>
                <div class="dvThankyouText">For rating your experience</div>

            </div>

        </div>
    </div>
</div>

<script>
    var getUrlParameter = function getUrlParameter(sParam) {
            var sPageURL = decodeURIComponent(window.location.search.substring(1)),
                sURLVariables = sPageURL.split('&'),
                sParameterName,
                i;

            for (i = 0; i < sURLVariables.length; i++) {
                sParameterName = sURLVariables[i].split('=');

                if (sParameterName[0] === sParam) {
                    return sParameterName[1] === undefined ? true : sParameterName[1];
                }
            }
        };
    jQuery(document).ready(function () {

        var rat = getUrlParameter('rating');
        var id = getUrlParameter('id');
        $('#rating-input').rating({
              min: 0,
              max: 5,
              step: 1,
              size: 'md',
              showClear: false
           });
        $('#rating-input').rating('update', rat);
        $('#orderid').val(id);

    });
$( "#but" ).click(function() {


  var id = $('#orderid').val();
      var rat =  $('#rating-input').val();
      var com = $('#comment').val();
      var url = "/DesktopModules/GoGetIt/API/Order/SaveComent?OrderID="+id+"&star="+rat+"&coment="+com; // the script where you handle the form input.

      $.ajax({
             type: "GET",
             url: url,
             success: function(data)
             {
                 $('#modalOrderThankyou').modal('show');
                 window.setTimeout(function() {
                    window.location.href = '/';
                }, 5000);

             }
           });

      e.preventDefault();  //avoid to execute the actual submit of the form.
});

</script>
<style>
.caption
{
  display: none !important;
}
 #modalOrderThankyou .modal-dialog {
        width: 700px;
        max-width: 100%;
    }

    #modalOrderThankyou .modal-body {
        border-top: 5px solid #FDE700;
    }

    #modalOrderThankyou .modal-content {
        border-radius: 0px;
    }

    #modalOrderThankyou h1 {
        font-size: 56px;
        font-weight: 300;
        color: #252525;
        font-family: roboto;
        text-align: center;
    }

    #modalOrderThankyou .dvThankyouText {
        color: #7e7e7e;
        font-family: roboto;
        font-size: 20px;
        text-align: center;
        margin: 15px 0;
    }

    @media all and (max-width: 720px) {
        #modalOrderThankyou .modal-dialog {
            width: 500px;
            max-width: 100%;
        }
    }

    @media all and (max-width: 520px) {
        #modalOrderThankyou .modal-dialog {
            width: 400px;
            max-width: 100%;
        }
    }

    @media all and (max-width: 410px) {
        #modalOrderThankyou .modal-dialog {
            width: 330px;
            max-width: 100%;
        }
    }

    @media all and (max-width: 340px) {
        #modalOrderThankyou .modal-dialog {
            width: 300px;
            max-width: 100%;
        }
    }

</style>