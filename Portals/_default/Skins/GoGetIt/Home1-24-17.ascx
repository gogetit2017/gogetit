<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Home.ascx.cs" Inherits="Christoc.Skins.HammerFlex.Home" %><%@ Register TagPrefix="dnn" TagName="USER" Src="~/Admin/Skins/User.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %>

<%@ Register TagPrefix="dnn" TagName="PRIVACY" Src="~/Admin/Skins/Privacy.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TERMS" Src="~/Admin/Skins/Terms.ascx" %>
<%@ Register TagPrefix="dnn" TagName="COPYRIGHT" Src="~/Admin/Skins/Copyright.ascx" %>
<%@ Register TagPrefix="dnn" TagName="JQUERY" Src="~/Admin/Skins/jQuery.ascx" %>
<%@ Register TagPrefix="dnn" TagName="META" Src="~/Admin/Skins/Meta.ascx" %>
<%@ Register TagPrefix="dnn" TagName="MENU" Src="~/DesktopModules/DDRMenu/Menu.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<dnn:META ID="mobileScale" runat="server" Name="viewport" Content="width=device-width,initial-scale=1" />

<dnn:JQUERY ID="dnnjQuery" runat="server" jQueryHoverIntent="true" />
<dnn:DnnJsInclude ID="bootstrapJS" runat="server" FilePath="js/bootstrap.min.js" PathNameAlias="SkinPath" Priority="10" />
<dnn:DnnCssInclude ID="bootStrapCSS" runat="server" FilePath="css/bootstrap.min.css" PathNameAlias="SkinPath" Priority="14" />
<dnn:DnnJsInclude ID="bluImpJS" runat="server" FilePath="js/jquery.blueimp-gallery.min.js" PathNameAlias="SkinPath" />

<dnn:dnncssinclude id="goGetItCSS" runat="server" filepath="css/GoGetIt.css" pathnamealias="SkinPath" priority="15" />
<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Oswald" />
<link href='//fonts.googleapis.com/css?family=Roboto:400,100,300,200' rel='stylesheet' type='text/css'>
 <link href="/js/AlertModal.css" rel="stylesheet" type="text/css" />
    <script src="/js/bootstrap.min.js"></script>

<script>
 (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
 (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
 m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
 })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

 ga('create', 'UA-78971492-1', 'auto');
 ga('send', 'pageview');

</script>

<script>
    $(document).ready(function(){
        var url      = window.location.href;

    if(url == "http://letusgogetit.com/"){
        /*$("#myModalAnuncion").modal('show');*/

    } 
        });
</script> 


<!-- Facebook Pixel Code -->
<script>
!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
document,'script','https://connect.facebook.net/en_US/fbevents.js');

fbq('init', '865806620209175');
fbq('track', "PageView");
fbq('track', 'Purchase', {value: '0.00', currency: 'USD'});
fbq('track', 'CompleteRegistration');
</script>
<noscript><img height="1" width="1" style="display:none"
src="https://www.facebook.com/tr?id=865806620209175&ev=PageView&noscript=1"
/></noscript>
<!-- End Facebook Pixel Code -->
<style type="text/css">
    
    ul.nav li.dropdown:hover > ul.dropdown-menu {
        display: block;    
    }

    .dropdown-menu>li>a {
    display: block;
    padding: 3px 20px;
    clear: both;
    font-weight: normal;
    line-height: 1.42857143;
    color: white;
    white-space: nowrap;
    }

    .dropdown-menu>li>a:hover, .dropdown-menu>li>a:focus {
    text-decoration: none;
    color: #ffe800;
    }

    .dropdown-menu {
    position: absolute;
    top: 100%;
    left: 0;
    z-index: 1000;
    display: none;
    float: left;
    min-width: 160px;
    padding: 5px 0;
    margin: 2px 0 0;
    list-style: none;
    font-size: 14px;
    text-align: left;
    background-color: transparent; 
    border: 1px solid #cccccc;
    border: 1px solid rgba(0,0,0,0.15);
    border-radius: 4px;
    -webkit-box-shadow: 0 6px 12px rgba(0,0,0,0.175);
    box-shadow: 0 6px 12px rgba(0,0,0,0.175);
    -webkit-background-clip: padding-box;
    background-clip: padding-box;
}

.dropdown-menu>li>a:hover, .dropdown-menu>li>a:focus {
    text-decoration: none;
    color: ##ffe800;
    background-color: transparent;
}

.dropdown-menu>.active>a, .dropdown-menu>.active>a:hover, .dropdown-menu>.active>a:focus {
    color: #ffffff;
    text-decoration: none;
    outline: 0;
    background-color: transparent;
    
}
/*modal home anuncio*/
.modal-tex-1{
    text-align: center;
    font-size: 28px;
    color: #fde700;
    text-transform: uppercase;

}

.modal-text-2{
    text-align: center;
    font-size: 14px;
    color: #707070;
        padding-top: 10px;

}
.modal-text-3{
    font-size: 24px;
    text-transform: uppercase;
    text-align: center;
        padding-top: 10px;

}
.modal-text-4{
        text-align: center;
    color: #a70e0e;
    font-size: 24px;
        padding-top: 10px;

}
.modal-text-5{
           text-align: center;
    color: #383838;
    font-size: 16px;
        padding-top: 10px;

}
.modal-text-6{
    text-align: center;
    color: #383838;
    font-size: 24px;
        padding-top: 10px;

}
#myModalAnuncion .modal-content {
    /*border: 5px solid #fde700;*/
    background-image: url(http://www.letusgogetit.com/images/avisoth.jpg);
    height: 314px;
    }

    #myModalAnuncion .modal-header {
    /*padding: 15px;*/
    border-bottom: 0px solid #e5e5e5;
    /*min-height: 16.42857143px;*/
}

#myModalAnuncion .modal-footer {
    /*padding: 20px;
    text-align: right;*/
    border-top: 0px solid #e5e5e5;
}

#myModalAnuncion .modal-dialog  {
    
    margin-top: 11%;
}
/*modal home anuncio fin*/
</style>      

<div class="navbar navbar-default" role="navigation">
  
    <div class="container">
	  
	<div id="SignUpPane" runat="server" class="col-md-12" />
		
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <div class="navbar-brand">
			
                <div class="dvLogoPane" id="logopane" >
				<a href="/home.aspx" ><img src="/images/Logo.png" class="imgLogoDiv img-responsive"/></a>
				</div>
            </div>
        </div>
        <div class="navbar-collapse collapse">
	
            <dnn:MENU MenuStyle="BootStrapNav" runat="server"></dnn:MENU>
			

            <ul class="nav navbar-nav navbar-right">
               
            </ul>
        </div>
        <!--/.nav-collapse -->
         </div>
</div>

                <div class="container">
                    <div class="col-md-12 img-call-now " >
                        <a href="tel:+18669489506" class="link_tel"><img src="/images/Call-Now.png" class="img-responsive" style="float: right;"/></a>
                    </div>
                </div>


<div id="CarouselPane" runat="server" class="carousel slide" containertype="G" containername="HammerFlex" containersrc="Blank.ascx" />



 <div class="container">


    <div id="TopContent" class="row">
        <div id="TopPane" runat="server" class="col-md-12" />
    </div>

    <div id="Content" class="row">
        <div id="ContentPane" runat="server" class="col-md-9" />
        <div id="RightPane" runat="server" class="col-md-3" />
    </div>
    <div id="MidContent" class="row">
        <div id="ThirdRowLeft" runat="server" class="col-md-4" />
        <div id="ThirdRowMiddle" runat="server" class="col-md-4" />
        <div id="ThirdRowRight" runat="server" class="col-md-4" />
    </div>
    <div id="ContentLeftCol" class="row">
        <div id="LeftPane" runat="server" class="col-md-3" />
        <div id="ContentPaneRight" runat="server" class="col-md-9" />
    </div>
    <div id="UserProfile" class="row">
        <div id="UserProfileLeft" runat="server" class="col-md-2" />
        <div id="UserProfileContent" runat="server" class="col-md-10" />
    </div>
    <div id="BottomContent" class="row">

        <div id="BottomPane" runat="server" class="col-md-12" />
    </div>    
</div>

<div id="FooterRow" class="" style="">

         <div id="FooterRowLeft" runat="server" class="col-md-4" />
        <div id="FooterRowMiddle" runat="server" class="col-md-4" />
        <div id="FooterRowRight" runat="server" class="col-md-4" />

        <div id="FooterPane" runat="server" class="col-md-12" />
        <div id="CopyRightPane" class="SkinLink col-md-12 center">                      
        </div>
		
		<div class="col-md-12">
    <div class="container" id="drFooter">
       <!-- <div class="col-md-2">
            <div style="font-size:12px;color:#999999;text-transform:uppercase;font-weight:100;">&nbsp;</div>
        </div>-->
		<div class="col-md-8 col-md-offset-2">
            <div class="dvFooterLinks" style="display:none;"><a href="/whatweare.aspx" >Who we are</a></div>
			<div class="dvFooterLinks" style="padding:4px; width:initial;"><a href="/whatwedo.aspx" >About us</a></div>
			<div class="dvFooterLinks" style="padding:4px; width:initial;"><a href="/faq.aspx" >faq</a></div>
			<div class="dvFooterLinks" style="padding:4px; width:initial;"><a href="/featured-gets.aspx" >Featured gets</a></div>
			<div class="dvFooterLinks" style="padding:4px; width:initial;"><a href="/Become-A-Go-Getter" >Become a getter</a></div>
			<div class="dvFooterLinks" style="padding:4px; width:initial;"><a href="/Contact-Us" >contact us</a></div>
			<div class="dvFooterLinks" style="padding:4px; width:initial;"><a href="/home.aspx" >Home</a></div>			
			<div class="dvFooterLinks" style="padding:4px; width:initial;"><a href="/PrivacyPolicy" >Privacy Policy</a></div>
			<div class="dvFooterLinks" style="padding:4px; width:initial;"><a href="/TOS" >Terms of Service</a></div>
        </div>
		<div class="col-md-2">
		  <div class="dvFooterIcon">
		      <a target="_blank" href="https://twitter.com/letusgogetit">
		          <img src="/images/icon-twitter.png" />
		      </a>
		  </div>
		  
          <div class="dvFooterIcon">
		      <a target="_blank" href="https://www.facebook.com/LETUSGOGETIT">
		          <img src="/images/icon-facebook.png" />
		      </a>
		  </div>

            <div class="dvFooterIcon">
		      <a target="_blank" href="https://www.instagram.com/letusgogetit">
		          <img src="/images/icon-instagram.png" />
		      </a>
		    </div>
		</div>
        <div class="col-md-12 text-center">
			<!-- <div style="font-size:12px;color:#999999;text-transform:uppercase;font-weight:100;">© 2015 letusGoGetIt.com, All Rights Reserved.</div>			-->
			<div class="dvFooterLinks" style="width:100%;float:none;">© 2015 letusGoGetIt.com, All Rights Reserved.</div>
            <br>
        </div>
    </div>
</div>
 </div>
 
    <div class="modal fade" id="modalHomeError" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <%-- <div class="modal-header">
                       
                        <h4 class="modal-title">Modal Header</h4>
                    </div>--%>
                    <div class="modal-body">
                        <button style="padding: 7px;" type="button" class="close" data-dismiss="modal">&times;</button>
                        <div id="dvHomeError"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>


<!-- Modal anuncios -->
<div class="modal fade margen-lightbox" id="myModalAnuncion" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog " role="document">
    <div class="modal-content fondo-new">
        <div class="modal-header">
        </div>
    <div class="modal-body ">
        



    </div>
      <div class="modal-footer">
        </div>
    </div>

    </div>
</div>
<!-- Modal anucios-->





<div class="modal fade" id="modalOrderLoginError" role="dialog">
<div class="modal-dialog">
<!-- Modal content-->
<div class="modal-content">

<div class="modal-body">
<div class="modalOrderLoginErrorInner">
<div class="loginLogo">
<img src="/images/LoginLogo.png">
</div>
<div class="dvRow">
<div class="form-group">
<a href="#" title="Export Data" onclick="OrderLoginClose();" class=" loginModalOrder" data-target="#loginModal" data-toggle="modal" data-dismiss="modal">Log In</a>
</div>
<div class="form-group text-center" style="font-weight: bold;">OR</div>
<div class="form-group">
<a href="#" title="Export Data" onclick="OrderLoginClose();" class=" signupModalOrder" data-target="#signupModal" data-toggle="modal" data-dismiss="modal">Sign Up</a>
</div>
</div>
</div>

</div>

</div>
</div>
</div>
<style>
#modalOrderLoginError .modal-dialog {
max-width: 420px;
width: 420px;
}

#modalOrderLoginError .modalOrderLoginErrorInner {
background: #fff none repeat scroll 0 0;
border-radius: 0;
margin: auto;
max-width: 350px;
padding: 0 25px 15px;
width: 100%;
}

#modalOrderLoginError .loginModalOrder, #modalOrderLoginError .loginModalOrder:hover {
background-color: #fde700;
border: medium none;
color: #333;
font-size: 16px;
padding: 6px 12px;
text-align: center;
text-transform: uppercase;
width: 100%;
display: inline-block;
text-decoration: none;
}

#modalOrderLoginError .signupModalOrder, #modalOrderLoginError .signupModalOrder:hover {
background-color: #fde700;
border: medium none;
color: #333;
font-size: 16px;
padding: 6px 12px;
text-align: center;
text-transform: uppercase;
width: 100%;
display: inline-block;
text-decoration: none;
}

@media all and (max-width: 440px) {
#modalOrderLoginError .modal-dialog {
width: 300px;
}

#modalOrderLoginError .modalOrderLoginErrorInner {
padding: 0px;
}
}
</style>		 
    <script src="/js/jquery.validator.min.js"></script>
<script type="text/javascript">

<!--Go Get it-->
/*
$('.dvHomeBannerRight').click(function(event){
	 var validate = new Validator({ validation_group: 'OrderHomeForm', error_class: 'error' });
        validate.validate({ 
			ddlHomeDeliveryType: 'Delivery type is required.', 
			ddlZipCode: 'Zipcode is required.' });
        if (validate.error == undefined) {
            $("#dvHomeError").html('');
			var Link="DeliveryType="+encodeURIComponent($('#ddlHomeDeliveryType').val())+"&Zipcode="+ jQuery('#ddlZipCode option:selected').text() +"&ZipcodeID="+ jQuery('#ddlZipCode option:selected').val();
			
			//window.location="/order?"+Link;
            window.location="http://letusgogetit.com/order?"+Link;
        }
        else {
            $("#dvHomeError").html('<div class="alert alert-danger">' + validate.error + '</div>');
            $("#modalHomeError").modal('show');
            return false;
        }
}); 
*/

/*SEARCHBOX GOOGLE*/
var arr_zipcode = [
    "33010","33012","33013","33014","33015",
    "33016","33018","33019","33030","33031","33032",
    "33033","33034","33035","33039","33090",
    "33092","33101","33106","33112","33122",
    "33125","33126","33127","33128","33129",
    "33130","33131","33132","33133","33134",
    "33135","33136","33137","33138","33142",
    "33143","33144","33145","33146","33147",
    "33149","33150","33151","33152","33153",
    "33155","33156","33157","33158","33160",
    "33161","33162","33165","33166","33167",
    "33168","33169","33170","33172","33173",
    "33174","33175","33176","33177","33178",
    "33179","33180","33181","33182","33183",
    "33184","33185","33186","33187","33188",
    "33189","33190","33193","33194","33196",
    "33199","33109","33139","33140","33141",
    "33154","33054","33055","33056"];


$("#searchTextField").bind("cut copy paste",function(e) {
    e.preventDefault();
});

var _error = "";
var zipcodeid = "";
function MakeClickHome(){
    var searchTextField = $("#searchTextField").val();
    //METODO 2 GOOGLE WEB SERVICES
    if (searchTextField != "") {

        $.ajax({
            url: 'http://maps.google.com/maps/api/geocode/json?components=administrative_area:FL|country:US',
            dataType: 'json',
            data: { address: searchTextField },

            success: function(response) {
                
                var myAddress = response.results[0].formatted_address;
                var myPostcode;

                for (var i = 0; i < response.results[0].address_components.length; i++) {
                    for (var j = 0; j < response.results[0].address_components[i].types.length; j++) {
                        if (response.results[0].address_components[i].types[j] == "postal_code") {
                            myPostcode = response.results[0].address_components[i].long_name;
                            break;
                        }
                    }
                }


                if ( myPostcode != undefined )
                {

                    $.each(arr_zipcode, function(index, val) {
                        
                        if ( val == myPostcode )
                        {
                            
                            $(".msg").hide();
                            
                            $.each($("#ddlZipCode option"), function() {
                                         
                                if ($(this).text() == myPostcode)
                                {
                                    myPostcodeID = $(this).val();
                                    
                                    var Link="DeliveryType="+encodeURIComponent($('#ddlHomeDeliveryType').val())+"&Zipcode="+myPostcode+"&ZipcodeID="+myPostcodeID+"&Address="+myAddress;
                                    window.location="http://letusgogetit.com/order?"+Link;
                                }

                            });
                            
                        }
                        else {
                            $(".msg").text("We´re sorry, our delivery range at this time is Miami-Dade County");
                        }

                    });

                } else {
                    $(".msg").text("We´re sorry, our delivery range at this time is Miami-Dade County");
                }
                

            }

        })
        
    }
    else {
        $(".msg").text("Please fill this field");
        $("#searchTextField").focus();
    }

}
$(document).on('click', '.dvHomeBannerRight', function(event) {
    event.preventDefault();
    
    var searchTextField = $("#searchTextField").val();
    var dato = $('#uname').val();
    
    //METODO 1
    /*
    if (searchTextField != "")
    {
        $.each(arr_zipcode, function(index, val) {

            if (searchTextField.indexOf(val) >= 0 && (searchTextField.indexOf("FL") >= 0 || searchTextField.indexOf("Florida") >= 0))
            {
                zipcode = val;
                
                $.each($("#ddlZipCode option"), function() {
                             
                    if ($(this).text() == zipcode)
                    {
                        zipcodeid = $(this).val();
                        var Link="DeliveryType="+encodeURIComponent($('#ddlHomeDeliveryType').val())+"&Zipcode="+zipcode+"&ZipcodeID="+zipcodeid+"&Address="+($("#searchTextField").val());
                        $(".msg").hide();
                        window.location="http://letusgogetit.com/order?"+Link;
                    }

                });

            }
            else {
                _error = "We´re sorry, our delivery range at this time is Miami-Dade County";
            }

        });

    }
    else {
        _error = "Please enter a valid zip code";
    }

    if (_error != "")
    {
        $(".msg").text(_error);
    }
    */

    //METODO 2 GOOGLE WEB SERVICES
    if (searchTextField != "") {
        
        $.ajax({
            url: 'http://maps.google.com/maps/api/geocode/json?components=administrative_area:FL|country:US',
            dataType: 'json',
            data: { address: searchTextField },

            success: function(response) {
                
                var myAddress = response.results[0].formatted_address;
                var myPostcode;

                for (var i = 0; i < response.results[0].address_components.length; i++) {
                    for (var j = 0; j < response.results[0].address_components[i].types.length; j++) {
                        if (response.results[0].address_components[i].types[j] == "postal_code") {
                            myPostcode = response.results[0].address_components[i].long_name;
                            break;
                        }
                    }
                }


                if ( myPostcode != undefined )
                {

                    $.each(arr_zipcode, function(index, val) {
                        
                        if ( val == myPostcode )
                        {
                            
                            $(".msg").hide();
                            
                            $.each($("#ddlZipCode option"), function() {
                                         
                                if ($(this).text() == myPostcode)
                                {
                                    if (dato != "") {
                                        $('#modalOrderLoginError').modal('show');
                                        return false;
                                    }
                                    myPostcodeID = $(this).val();
                                    
                                    var Link="DeliveryType="+encodeURIComponent($('#ddlHomeDeliveryType').val())+"&Zipcode="+myPostcode+"&ZipcodeID="+myPostcodeID+"&Address="+myAddress;
                                    window.location="http://letusgogetit.com/order?"+Link;
                                }

                            });
                            
                        }
                        else {
                            $(".msg").text("We´re sorry, our delivery range at this time is Miami-Dade County");
                        }

                    });

                } else {
                    $(".msg").text("We´re sorry, our delivery range at this time is Miami-Dade County");
                }
                

            }

        })
        
    }
    else {
        $(".msg").text("Please fill this field");
        $("#searchTextField").focus();
    }

});
/*END SEARCHBOX GOOGLE*/



function toUpper(obj) {
    var mystring = obj;
	mystring = mystring.substring(0, 1).toUpperCase() + mystring.substring(1);
	return mystring;
}
// Adding class to body
$(document).ready(function (e) {
    var pathname = window.location.pathname;
    var fullPageName = pathname.substring((pathname.lastIndexOf("/") + 1));
    var className = fullPageName.replace(".aspx", "");
    $('body').addClass(' '+className+' '+className.toLowerCase() +' ' + toUpper(className.toLowerCase()));
	if (className==""){
		$('body').addClass('home');	
	}
	  $('.ModDNNFAQsC a').click();
    $('.ModDNNFAQsC a').attr('onclick', '');
	
    /*NAVBAR*/
    if (!$(".dnnEditState").length > 0)
    {
        $('.navbar-default').affix({
              offset: {
                top: $('.navbar-default').height()
              }
        });
    }

    var footer_icons = $(".dvFooterIcon").clone();
    $(".dvLoginTextTop").prepend(footer_icons);
    //$(".dvFooterIcon").prependTo($(".dvLoginTextTop"));
    $(".dvLoginTextTop .dvFooterIcon").eq(2).css('marginRight', 40 + 'px');

});

</script>
<style  >
.dvHomeBannerRight{cursor:pointer;}
</style>


<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places&callback=initMap"></script> 
<script> 
    
    $(document).ready(function(){

        function initialize()
        {

            var options = {
                types: ['geocode'],
                componentRestrictions: {country: "us"}
            };

            var input = document.getElementById('searchTextField');
            var estimatepick = document.getElementById('txtpick');
            var estimatedevl = document.getElementById('txtdelive');
            
            var autocomplete =    new google.maps.places.Autocomplete(input, options);
            var autocompletpick = new google.maps.places.Autocomplete(estimatepick, options);
            var autocompletedev = new google.maps.places.Autocomplete(estimatedevl, options);
        }
        google.maps.event.addDomListener(window, 'load', initialize);
        
    })
    
</script>

<script type="text/javascript">
    function Farestimate(){




var vzippick = document.getElementById("txtpick").value;

var vzipdeliv = document.getElementById("txtdelive").value;

if(vzippick=="" &&  vzipdeliv==""){
    
   
        $("#vacios_campos").html("Please fill these fields");
            return false;
        }else{
        $("#vacios_campos").html("");
            var mcontact = {
            zipPick:vzippick,

            zipDeliver:vzipdeliv

        };
        var objectAsJson = JSON.stringify(mcontact);

     $.ajax({
            type: "GET",
            url: "/DesktopModules/GoGetIt/API/Order/GetcalEstimate?zipPick="+vzippick+"&zipDeliver="+vzipdeliv,
            contentType: "application/json",
            success: onSuccessFarestimate,
            error: onErrorFarestimate
        });
    

}



}

/*document.getElementById("resultado").value=document.getElementById("txtpick").value  + " to "+ document.getElementById("txtdelive").value + " is "+ o.data;*/
/*$("#direccion").html("Your Estimate from" +" "+ document.getElementById("txtpick").value + "," + "to " + " " +document.getElementById("txtdelive").value +" "+ "is:" );*/

function onSuccessFarestimate(result) {

            var o = eval(result);

                    if (o.success == true) {
                    $("#direccion").html("Your Estimate is:<br>");

                    $("#resultado").html("$"+o.data.toFixed(2));
                    
            }
        
        }

        function onErrorFarestimate(result) {
        alert('error');
    }


</script>


 <script type="text/javascript">

var map;
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 25.7616798, lng: -80.19179020000001},
    
    zoom: 10
  });

var routes = [
        new google.maps.LatLng(25.953846020220826, -80.43966922832033)
        , new google.maps.LatLng(25.97977376045923, -80.10801944804689)
            , new google.maps.LatLng(25.67135916058594, -80.13891849589845)
                , new google.maps.LatLng(25.426035587987634, -80.3064599998047)
                ,  new google.maps.LatLng(25.434717196369046, -80.4822412498047)
                ,  new google.maps.LatLng(25.892708039101777, -80.49460086894533)
                ,  new google.maps.LatLng(25.953846020220826, -80.43966922832033)
                
    ];
 
       var polygon = new google.maps.Polygon({
        path: routes
        , map: map
        , strokeColor: '#FF0000' 
        , strokeWeight: 2
        , strokeOpacity: 0.8
        , fillColor: '#FF0000'
        , fillOpacity: 0.35
        , clickable: false
    });


}

    </script>

    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places&callback=initMap"></script> 
   