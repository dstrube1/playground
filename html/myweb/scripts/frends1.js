var redmax = 255;    // the maximum red value that should be displayed
var redmin = 0;      // the maximum red value that should be displayed
var greenmax = 255;  // the maximum green value that should be displayed
var greenmin = 0;    // the minimum green value that should be displayed
var bluemax = 255;   // the maximum blue value that should be displayed
var bluemin = 0;     // the minimum blue value that should be displayed
var changespeed = 0; // how fast you want the color to change

// error proofing values;
if (redmax > 255) redmax = 255;
if (greenmax > 255) greenmax = 255;
if (bluemax > 255) bluemax = 255;
if (redmin < 0) redmin = 0;
if (greenmin < 0) greenmin = 0;
if (bluemin < 0) bluemin = 0;
if (redmin > redmax) redmin = redmax;
if (greenmin > greenmax) greenmin = greenmax;
if (bluemin > bluemax) bluemin = bluemax;
if (changespeed < 0) changespeed = 0;

// loading initial variables and values
var stoploop = 0;
var rednum = redmax + 1;
var greennum = greenmax + 1;
var bluenum = bluemax + 1;
var redchng = -1;
var greenchng = -1;
var bluechng = -1;
var reddir = 0;
var greendir = 0;
var bluedir = 0;

// randomizing initial color relative to given max and mins
while (rednum == redmax + 1) {rednum = Math.floor(Math.random()*(redmax-redmin+1)+redmin);}
while (greennum == greenmax + 1) {greennum = Math.floor(Math.random()*(greenmax-greenmin+1)+greenmin);}
while (bluenum == bluemax + 1) {bluenum = Math.floor(Math.random()*(bluemax-bluemin)+bluemin+1);}

// creating a valid hex code for the background color;
hexcolor = (rednum * 256 + greennum) * 256 + bluenum;
outhex = hexcolor.toString(16);
while (outhex.length < 6) outhex = "0"+outhex;
outhex = "#"+outhex;

// function run after loading to store the new background color,
// create and store the text color, and begin the random color loop
function loadInit() {document.bgColor = outhex;
hexcolor = 16777215 - hexcolor;
outhex = hexcolor.toString(16);
while (outhex.length < 6) outhex = "0"+outhex;
outhex = "#"+outhex;
document.body.text = outhex;
document.linkColor = outhex;
document.alinkColor = outhex;
document.vlinkColor = outhex;
randColor();}

function randColor() {
// calculate which direction change will happen in and for how long
// calulate RED if no further changing would happen
if (redchng < 0) {reddir = 3;
while (reddir == 3) {reddir = Math.floor(Math.random()*3);
if ((reddir == 0) && (rednum == redmin)) reddir = 3;
if ((reddir == 2) && (redmax == rednum)) reddir = 3;}
if (reddir == 0) while ((redchng == rednum - redmin + 1) || (redchng < 1))
 redchng = Math.floor(Math.random() * (rednum - redmin) + 1);
if (reddir == 2) while ((redchng == redmax - rednum + 1) || (redchng < 1))
 redchng = Math.floor(Math.random() * (redmax - rednum) + 1);}

// calulate GREEN if no further changing would happen
if (greenchng < 0) {greendir = 3;
while (greendir == 3) {greendir = Math.floor(Math.random()*3);
if ((greendir == 0) && (greennum == greenmin)) greendir = 3;
if ((greendir == 2) && (greenmax == greennum)) greendir = 3;}
if (greendir == 0) while ((greenchng == greennum - greenmin + 1) || (greenchng < 1))
 greenchng = Math.floor(Math.random() * (greennum - greenmin) + 1);
if (greendir == 2) while ((greenchng == greenmax - greennum + 1) || (greenchng < 1))
 greenchng = Math.floor(Math.random() * (greenmax - greennum) + 1);}

// calulate BLUE if no further changing would happen
if (bluechng < 0) {bluedir = 3;
while (bluedir == 3) {bluedir = Math.floor(Math.random()*3);
if ((bluedir == 0) && (bluenum == bluemin)) bluedir = 3;
if ((bluedir == 2) && (bluemax == bluenum)) bluedir = 3;}
if (bluedir == 0) while ((bluechng == bluenum - bluemin + 1) || (bluechng < 1))
 bluechng = Math.floor(Math.random() * (bluenum - bluemin) + 1);
if (bluedir == 2) while ((bluechng == bluemax - bluenum + 1) || (bluechng <1 ))
 bluechng = Math.floor(Math.random() * (bluemax - bluenum) + 1);}

// change color values in their given directions if further change required
if (redchng > 0) rednum = rednum + reddir - 1;
redchng = redchng - 1;
if (greenchng > 0) greennum = greennum + greendir - 1;
greenchng = greenchng - 1;
if (bluechng > 0) bluenum = bluenum + bluedir - 1;
bluechng = bluechng - 1;

// create valid hex code from colors and store to background
hexcolor = (rednum * 256 + greennum) * 256 + bluenum;
outhex = hexcolor.toString(16);
while (outhex.length < 6) outhex = "0"+outhex;
outhex = "#"+outhex;
document.bgColor = outhex;

// create inverse of the hex code and store to text & links
hexcolor = 16777215 - hexcolor;
outhex = hexcolor.toString(16);
while (outhex.length < 6) outhex = "0"+outhex;
outhex = "#"+outhex;
document.body.text = outhex;
document.linkColor = outhex;
document.alinkColor = outhex;
document.vlinkColor = outhex;

// repeat the color loop if variable stop = 0
if (stoploop == 0) setTimeout("randColor();",changespeed);
}

// function used to start the color loop if it isn't already going
function startColor() {
if (stoploop != 0) {stoploop = 0;
setTimeout("randColor();",changespeed)
}
}

// function used to stop the color loop
function stopColor() {stoploop = 1;}