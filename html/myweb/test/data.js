var ap = window.navigator.appVersion.toLowerCase();
var i = ap.indexOf("msie");
if (ap.indexOf("windows") >= 0 && i >= 0 && ((i + 5) < ap.length)) {
  var v = ap.charAt(i + 5);
  if (v >= 5 ) {
	document.write(ap + '<br>' + i + '<br>' + v);
}
}

var t = new Date();
t.setYear(t.getYear() + 10);
document.write(t + '<br>' );