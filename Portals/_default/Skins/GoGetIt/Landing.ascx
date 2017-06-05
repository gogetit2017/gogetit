<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Home.ascx.cs" Inherits="Christoc.Skins.HammerFlex.Home" %>
<%@ Register TagPrefix="dnn" TagName="JQUERY" Src="~/Admin/Skins/jQuery.ascx" %>
<%@ Register TagPrefix="dnn" TagName="META" Src="~/Admin/Skins/Meta.ascx" %>

<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<dnn:meta id="mobileScale" runat="server" name="viewport" content="width=device-width,initial-scale=1" />

<dnn:jquery id="dnnjQuery" runat="server" jqueryhoverintent="true" />
<dnn:dnnjsinclude id="bootstrapJS" runat="server" filepath="js/bootstrap.min.js" pathnamealias="SkinPath" priority="10" />
<dnn:dnncssinclude id="bootStrapCSS" runat="server" filepath="css/bootstrap.min.css" pathnamealias="SkinPath" priority="14" />


<link href="/js/AlertModal.css" rel="stylesheet" type="text/css" />
 <link rel="stylesheet" href="/js/star-rating.css" media="all" rel="stylesheet" type="text/css"/>
    <script src="/js/star-rating.js" type="text/javascript"></script>
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">





<div class="dvCommingSoonBackground">
    
        <div class="navbar navbar-default" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <div class="navbar-brand">
                    </div>
                </div>
                <div class="navbar-collapse collapse">


                    <ul class="nav navbar-nav navbar-right">
                    </ul>
                </div>
                <!--/.nav-collapse -->
            </div>
        </div>

        <div id="CarouselPane" runat="server" class="carousel slide" containertype="G" containername="HammerFlex" containersrc="Blank.ascx" />

        <div class="container">
            <!--/Logo-->

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
            <div id="FooterRow" class="row">

                <div id="FooterRowLeft" runat="server" class="col-md-4" />
                <div id="FooterRowMiddle" runat="server" class="col-md-4" />
                <div id="FooterRowRight" runat="server" class="col-md-4" />

                <div id="FooterPane" runat="server" class="col-md-12" />
                <div id="CopyRightPane" class="SkinLink col-md-12 center">
                </div>
            </div>
        </div>
   
</div>

