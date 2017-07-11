///////////////\\\\\\\\\\\
//NO RIGHT CLICK
///////////////\\\\\\\\\\\
function click() {
if (event.button==2) {
alert(' The right click has been blocked !');
}
}
document.onmousedown=click;

///////////////\\\\\\\\\\\
//no shift key?
///////////////\\\\\\\\\\\
//requires: <BODY ... onKeyPress="handlePress(event)">

function handlePress(e) {
	var shiftpressed = (window.Event) ? e.modifiers & Event.SHIFT_MASK : e.shiftKey;
	var altpressed = (window.Event) ? e.modifiers & Event.ALT_MASK : e.altKey;
	var ctrlpress = (window.Event) ? e.modifiers & Event.CONTROL_MASK : e.ctrlKey;
//	var somethingpressed = shiftpressed || altpressed || ctrlpressed;
	var alrtmsg1 = "I dont like people using the ";
	var shftmsg = "Shift key "; 
	var ctrlmsg = "Control key ";
	var altmsg = "Alt key ";
	var alrtmsg2 = "on this site";
	//var alrtmsg3;
	if (shiftpressed) {
        	alert(alrtmsg1 +shftmsg +alrtmsg2);
                return false;
	}
	else if (altpressed) {
        	alert(alrtmsg1 +ctrlmsg +alrtmsg2);
                return false;
	}
	else if (ctrlpressed) {
        	alert(alrtmsg1 +altmsg +alrtmsg2);
                return false;
	}
	else return true;
}
