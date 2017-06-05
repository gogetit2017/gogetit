

$(document).ready(function () {

    


});
function GetLowerCharacters(value) {
    value = value.toLowerCase();
    return value.replace(/(?:^|\s)\w/g, function (match) {
        return match.toUpperCase();
    });
}
function SkipPhone(value) {
    return true;
    var raw_number = value.value;
    var regex1 = /^\d{3}\-?\d{3}\-?\d{4}$/;
    var regex2 = /^[(]{0,1}[0-9]{3}[)]{0,1}[-\s\.]{0,1}[0-9]{3}[-\s\.]{0,1}[0-9]{4}$/;
    if (regex1.test(raw_number) || regex2.test(raw_number)) {
        $("#dvAlertValidationTutor").html('<div class="alert alert-error">Please do not include personal contact information in your bio.  To track tutor requests, we need all first contacts from students to tutors to go directly through the system.  After the student contacts you, you are free to provide them your personal information and communicate how you choose.  Thank you for your understanding. </div>');
        value.value = "";
        return false;
    }
    else {
        $("#dvAlertValidationTutor").html('');
        return true;
    }
}

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

    return false
}
/*
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
*/

function getUrlVars() {
    //<script src="http://code.jquery.com/jquery-migrate-1.0.0.js"></script>
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < hashes.length; i++) {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
}

function loadjscssfile(filename, filetype) {
    if (filetype == "js") { //if filename is a external JavaScript file
        var fileref = document.createElement('script')
        fileref.setAttribute("type", "text/javascript")
        fileref.setAttribute("src", filename)
    } else if (filetype == "css") { //if filename is an external CSS file
        var fileref = document.createElement("link")
        fileref.setAttribute("rel", "stylesheet")
        fileref.setAttribute("type", "text/css")
        fileref.setAttribute("href", filename)
    }
    if (typeof fileref != "undefined")
        document.getElementsByTagName("head")[0].appendChild(fileref)
}

function LoadPageCountList(PageIndex, TotalCount, Load, PageSize, SortBy, StartIndex) {

    var TotalPage = Math.ceil(TotalCount / PageSize);
    var vrLoadPageCountList = '<nav>';
    var HasNext = (PageIndex + 1) < TotalPage ? '1' : '0';
    var HasPrevious = PageIndex > 0 ? '1' : '0';
    if (TotalPage > 0) {
        // vrLoadPageCountList += '<ul class="pagination pagination-sm">';
        if (TotalPage > 1) {
            vrLoadPageCountList += '<li style="list-style: outside none none;">';
            vrLoadPageCountList += "Page " + (PageIndex + 1) + " of " + TotalPage;
            vrLoadPageCountList += '</li>';
            vrLoadPageCountList += CreatePager(PageIndex, TotalPage, Load, PageSize, SortBy, StartIndex);
        }
        //  vrLoadPageCountList += '</ul>';
    }
    vrLoadPageCountList += '</nav>';

    return vrLoadPageCountList;

}

function LoadPageCountListhistori(PageIndex, TotalCount, Load, PageSize, SortBy, StartIndex) {

    var TotalPage = Math.ceil(TotalCount / PageSize);
    var vrLoadPageCountListhis = '<nav>';
    var HasNext = (PageIndex + 1) < TotalPage ? '1' : '0';
    var HasPrevious = PageIndex > 0 ? '1' : '0';
    if (TotalPage > 0) {
        // vrLoadPageCountList += '<ul class="pagination pagination-sm">';
        if (TotalPage > 1) {
            vrLoadPageCountListhis += '<li style="list-style: outside none none;">';
            vrLoadPageCountListhis += "Page " + (PageIndex + 1) + " of " + TotalPage;
            vrLoadPageCountListhis += '</li>';
            vrLoadPageCountListhis += CreatePagerh(PageIndex, TotalPage, Load, PageSize, SortBy, StartIndex);
        }
        //  vrLoadPageCountList += '</ul>';
    }
    vrLoadPageCountListhis += '</nav>';

    return vrLoadPageCountListhis;

}

function CreatePager(PageIndex, TotalPage, Load, PageSize, SortBy, StartIndex) {
    var replace = false;
    try {
        document.getElementById(Load + 'Pager').innerHTML = '';
        replace = true;
    }
    catch (e) { }
    var HasNext = (PageIndex + 1) < TotalPage ? '1' : '0';
    var HasPrevious = PageIndex > 0 ? '1' : '0';
    var vrPager = '';
    if (!replace)
        vrPager += '<ul id="' + Load + 'Pager" class="pagination pagination-sm">';

    if (StartIndex > 0) {

        vrPager += '<li>';
        vrPager += '<a onclick="javascript:CreatePager(' + PageIndex + ',' + TotalPage + ',' + "'" + Load + "'" + ',' + PageSize + ',' + "'" + SortBy + "'" + ',' + (StartIndex - 1) + ');" aria-label="Previous">';
        vrPager += '<span aria-hidden="true">&laquo;</span>';
        vrPager += '</a>'
        vrPager += '</li>';

    }
    if (HasPrevious == 1) {
        vrPager += '<li>';
        vrPager += '<a onclick="javascript:ShowNextPrevious(' + (PageIndex - 1) + ',' + "'" + Load + "'" + ',' + "'" + SortBy + "'" + ');" aria-label="Previous">';
        vrPager += '<span aria-hidden="true">Previous</span>';
        vrPager += '</a>'
        vrPager += '</li>';
    }


    var i = StartIndex * 10;

    for (; i < TotalPage && i < (StartIndex + 1) * 10; i++) {
        if (PageIndex == i) {
            vrPager += '<li class="active"><a onclick="javascript:ShowNextPrevious(' + (i) + ',' + "'" + Load + "'" + ',' + "'" + SortBy + "'" + ');">' + (i + 1) + '</a></li>';
        }
        else {
            vrPager += '<li ><a onclick="javascript:ShowNextPrevious(' + (i) + ',' + "'" + Load + "'" + ',' + "'" + SortBy + "'" + ');">' + (i + 1) + '</a></li>';
        }
    }

    if (HasNext == 1) {
        vrPager += '<li>';
        vrPager += '<a  onclick="javascript:ShowNextPrevious(' + (PageIndex + 1) + ',' + "'" + Load + "'" + ',' + "'" + SortBy + "'" + ');" aria-label="Next">';
        vrPager += '<span aria-hidden="true">Next</span>';
        vrPager += '</a>'
        vrPager += '</li>';
    }

    if ((StartIndex + 1) * 10 < TotalPage) {
        vrPager += '<li>';
        vrPager += '<a onclick="javascript:CreatePager(' + PageIndex + ',' + TotalPage + ',\'' + Load + '\',' + PageSize + ',' + "'" + SortBy + "'" + ',' + (StartIndex + 1) + ');" aria-label="Next">';
        vrPager += '<span aria-hidden="true">&raquo;</span>';
        vrPager += '</a>'
        vrPager += '</li>';
    }

    if (!replace) {
        vrPager += '</ul>';
        return vrPager;
    }
    else {
        document.getElementById(Load + 'Pager').innerHTML = vrPager;
        return '<ul id="' + Load + 'Pager">' + vrPager + '</ul>';
    }

}

function CreatePagerh(PageIndex, TotalPage, Load, PageSize, SortBy, StartIndex) {
    var replace = false;
    try {
        document.getElementById(Load + 'Pager').innerHTML = '';
        replace = true;
    }
    catch (e) { }
    var HasNext = (PageIndex + 1) < TotalPage ? '1' : '0';
    var HasPrevious = PageIndex > 0 ? '1' : '0';
    var vrPager = '';
    if (!replace)
        vrPager += '<ul id="' + Load + 'Pager" class="pagination pagination-sm">';

    if (StartIndex > 0) {

        vrPager += '<li>';
        vrPager += '<a onclick="javascript:CreatePagerh(' + PageIndex + ',' + TotalPage + ',' + "'" + Load + "'" + ',' + PageSize + ',' + "'" + SortBy + "'" + ',' + (StartIndex - 1) + ');" aria-label="Previous">';
        vrPager += '<span aria-hidden="true">&laquo;</span>';
        vrPager += '</a>'
        vrPager += '</li>';

    }
    if (HasPrevious == 1) {
        vrPager += '<li>';
        vrPager += '<a onclick="javascript:ShowNextPrevious(' + (PageIndex - 1) + ',' + "'" + Load + "'" + ',' + "'" + SortBy + "'" + ');" aria-label="Previous">';
        vrPager += '<span aria-hidden="true">Previous</span>';
        vrPager += '</a>'
        vrPager += '</li>';
    }


    var i = StartIndex * 10;

    for (; i < TotalPage && i < (StartIndex + 1) * 10; i++) {
        if (PageIndex == i) {
            vrPager += '<li class="active"><a onclick="javascript:ShowNextPrevious(' + (i) + ',' + "'" + Load + "'" + ',' + "'" + SortBy + "'" + ');">' + (i + 1) + '</a></li>';
        }
        else {
            vrPager += '<li ><a onclick="javascript:ShowNextPrevious(' + (i) + ',' + "'" + Load + "'" + ',' + "'" + SortBy + "'" + ');">' + (i + 1) + '</a></li>';
        }
    }

    if (HasNext == 1) {
        vrPager += '<li>';
        vrPager += '<a  onclick="javascript:ShowNextPrevious(' + (PageIndex + 1) + ',' + "'" + Load + "'" + ',' + "'" + SortBy + "'" + ');" aria-label="Next">';
        vrPager += '<span aria-hidden="true">Next</span>';
        vrPager += '</a>'
        vrPager += '</li>';
    }

    if ((StartIndex + 1) * 10 < TotalPage) {
        vrPager += '<li>';
        vrPager += '<a onclick="javascript:CreatePagerh(' + PageIndex + ',' + TotalPage + ',\'' + Load + '\',' + PageSize + ',' + "'" + SortBy + "'" + ',' + (StartIndex + 1) + ');" aria-label="Next">';
        vrPager += '<span aria-hidden="true">&raquo;</span>';
        vrPager += '</a>'
        vrPager += '</li>';
    }

    if (!replace) {
        vrPager += '</ul>';
        return vrPager;
    }
    else {
        document.getElementById(Load + 'Pager').innerHTML = vrPager;
        return '<ul id="' + Load + 'Pager">' + vrPager + '</ul>';
    }

}




function ShowNextPrevious(PageIndex, load, SortBy) {
    if (load == 'OrderList') {
        
        LoadUserOrder(PageIndex,SortBy);
    }

    if (load == 'Listorder') {
        
       LoadUserOrderhistory(PageIndex,SortBy);
    }
}





function SelectedPaggingPage(PageIndex) {
    $('span[id^=tdSelected]').removeClass('dvPageNumberSelected');
    $('span[id=tdSelected' + PageIndex + ']').addClass('dvPageNumberSelected');
}

function LoadPageCountList1(PageIndex, TotalCount, Load, PageSize, SortBy, StartIndex) {

    var TotalPage = Math.ceil(TotalCount / PageSize);

    var vrLoadPageCountList = '<div class="divRow" style="position:relative;">';
    var HasNext = (PageIndex + 1) < TotalPage ? '1' : '0';
    var HasPrevious = PageIndex > 0 ? '1' : '0';
    if (TotalPage > 0) {
        vrLoadPageCountList += '<div class="divRow">';

        if (TotalPage > 1) {
            vrLoadPageCountList += CreatePager(PageIndex, TotalPage, Load, PageSize, SortBy, StartIndex);
        }
        vrLoadPageCountList += '<div class="" style="float:right;width:90px;padding:2px 0px 0px 0px;">';
        vrLoadPageCountList += "Page " + (PageIndex + 1) + " of " + TotalPage;
        vrLoadPageCountList += '</div>';

        vrLoadPageCountList += '</div>';
    }

    vrLoadPageCountList += '</div>';

    return vrLoadPageCountList;

}

function CreatePager1(PageIndex, TotalPage, Load, PageSize, SortBy, StartIndex) {
    var replace = false;
    try {
        document.getElementById(Load + 'Pager').innerHTML = '';
        replace = true;
    }
    catch (e) { }
    var HasNext = (PageIndex + 1) < TotalPage ? '1' : '0';
    var HasPrevious = PageIndex > 0 ? '1' : '0';
    var vrPager = '';
    if (!replace)
        vrPager += '<div id="' + Load + 'Pager">';
    vrPager += ' <div style="float:left;">';
    if (StartIndex > 0) {
        vrPager += ' <div style="float:left;padding:3px 0px;font-size:12px;cursor:pointer;width:10px;" onclick="javascript:CreatePager(' + PageIndex + ',' + TotalPage + ',' + "'" + Load + "'" + ',' + PageSize + ',' + "'" + SortBy + "'" + ',' + (StartIndex - 1) + ');"><</div>&nbsp;';
    }
    if (HasPrevious == 1) {
        vrPager += '<div class="pagingnav" style="float:left;width:45px;padding:2px 0px 0px 5px;cursor:pointer;"  onclick="javascript:ShowNextPrevious(' + (PageIndex - 1) + ',' + "'" + Load + "'" + ',' + "'" + SortBy + "'" + ');">Previous</div>&nbsp;&nbsp;';
    }
    vrPager += '</div>';

    var i = StartIndex * 10;

    for (; i < TotalPage && i < (StartIndex + 1) * 10; i++) {
        vrPager += '<span class="pagingnav" style="cursor:pointer;" id="tdSelected' + i + '" onclick="javascript:ShowNextPrevious(' + (i) + ',' + "'" + Load + "'" + ',' + "'" + SortBy + "'" + ');">' + (i + 1) + '</span>';

    }


    vrPager += ' <div style="float:right;">';
    if (HasNext == 1) {
        vrPager += ' <div class="pagingnav" style="float:left; text-align: right;width:36px;padding:2px 0px 0px 0px;cursor:pointer;" onclick="javascript:ShowNextPrevious(' + (PageIndex + 1) + ',' + "'" + Load + "'" + ',' + "'" + SortBy + "'" + ');">Next</div>';
    }
    if ((StartIndex + 1) * 10 < TotalPage) {
        vrPager += ' <div style="float:right;padding:3px 0px;font-size:12px;width:10px;cursor:pointer;" onclick="javascript:CreatePager(' + PageIndex + ',' + TotalPage + ',\'' + Load + '\',' + PageSize + ',' + "'" + SortBy + "'" + ',' + (StartIndex + 1) + ');">></div>&nbsp;';
    }
    vrPager += '</div>';
    if (!replace) {
        vrPager += '</div>';
        return vrPager;
    }
    else {
        document.getElementById(Load + 'Pager').innerHTML = vrPager;
        return '<div id="' + Load + 'Pager">' + vrPager + '</div>';
    }

}



//Cookie
function getCookie(c_name) {
    try {
        var i, x, y, ARRcookies = document.cookie.split(";");
        for (i = 0; i < ARRcookies.length; i++) {
            x = ARRcookies[i].substr(0, ARRcookies[i].indexOf("="));
            y = ARRcookies[i].substr(ARRcookies[i].indexOf("=") + 1);
            x = x.replace(/^\s+|\s+$/g, "");
            if (x == c_name) {
                if (unescape(y) == '' || unescape(y) == null) {
                    return "Empty";
                }
                return unescape(y);
            }
        }
    }
    catch (e) {
    }
    return "Empty";
}

function setCookie(c_name, value, exdays) {
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var c_value = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toUTCString()) + "; path=/";
    //var c_value = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toUTCString()) + ";domain=innoventures.in;path=/" ;
    document.cookie = c_name + "=" + c_value;
}

function ValidatePhoneForBelow(value) {

    var raw_number = $('#' + value).val();
    var regex1 = /^\d{3}\-?\d{3}\-?\d{4}$/;
    var regex2 = /^[(]{0,1}[0-9]{3}[)]{0,1}[-\s\.]{0,1}[0-9]{3}[-\s\.]{0,1}[0-9]{4}$/;
    if (raw_number.length > 0 && (!regex1.test(raw_number) || !regex2.test(raw_number))) {
        $("#dvAlertValidation").html('<div class="alert alert-danger">Please make sure phone number is in correct format, (ex: 555-555-5555)</div>');

        $('#' + value).val("");
        return false;
    }
    else {
        $("#dvAlertValidation").html('');
        return true;
    }
}


function ValidateEmailForBelow(value) {

    var raw_number =  $('#' + value).val();
    var regex1 = /^['a-zA-Z0-9._%+-]+@['a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;

    if (raw_number.length > 0 && !regex1.test(raw_number)) {
        $("#dvAlertValidation").html('<div class="alert alert-danger">Please make sure email is in correct format</div>');
      
        $('#' + value).val("");
        return false;
    }
    else {
        $("#dvAlertValidation").html('');
        return true;
    }
}


function getUrlVarsUsername() {
    var vrUsername = "";
    try {
        //<script src="http://code.jquery.com/jquery-migrate-1.0.0.js"></script>
        var vars = decodeURIComponent(window.location.href).split('username=');
        vrUsername = vars[1];
    }
    catch (e) {

    }
    return vrUsername;
}


 function getQuerystring(key) {
            key = key.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regexS = "[\\?&]" + key + "=([^&#]*)";
            var regex = new RegExp(regexS);
            var results = regex.exec(window.location.search);
            if (results == null)
                return "";
            else
                return decodeURIComponent(results[1].replace(/\+/g, " "));
        }
		
	  var vrOrderID = getQuerystring('OrderID');

	$(document).ready(function () {
		if (vrOrderID > 0) {
			$('#btnBackTTOP').show();
			$('#btnBackPrivacyPolicy').show();
		}
		else { 
		$('#btnBackPrivacyPolicy').hide(); 
		$('#btnBackTTOP').hide(); 
		}
	});
function BackOrder(){
	window.location="/OrderSummary?OrderID="+vrOrderID;
}


function BackOrderPrivacyPolicy(){
	window.location="/OrderSummary?OrderID="+vrOrderID;
}


<!--Phone No. Format-->

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
