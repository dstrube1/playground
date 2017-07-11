//Original:  Mike Dransfield (mike@blueroot.net) -->
//Web Site:  http://mike.dransfield.org/ -->

//This script and many more are available free online at -->
//The JavaScript Source!! http://javascript.internet.com -->

//Begin
var ival, imgname, total, steps, maxx, maxy, currentx, currenty, dx, dy;
function zoomImg(imgname, total, steps, maxx, maxy)	{
// convert the total from seconds to miliseconds
total = total * 1000;
objref = eval("document.getElementById('"+imgname+"')");
currentx = objref.width;
currenty = objref.height;
// work out how much we need to increase the image by each step
// devide image sizes by number of steps to get the amount we need to change each step
stepx = maxx / steps;
stepy = maxy / steps;
// devide the total time (in ms) by the number of steps to get the interval time
inttime = total / steps;
// set the interval to increase the size of the image by the required pixels 
functionRef = "resizeImg('"+imgname+"', "+stepx+", "+stepy+", "+maxx+", "+maxy+")";
ival = setInterval(functionRef, inttime);
}
function resizeImg(imgname, dx, dy, maxx, maxy) {
objref = eval("document.getElementById('"+imgname+"')");
currentx = objref.width;
currenty = objref.height;
if ((currentx<maxx-dx) && (currenty<maxy-dy)) {
objref.height = currenty + dy;
objref.width = currentx + dx;
}
else {
clearInterval(ival);
objref.height = maxy;
objref.width = maxx;
   }
}
//  End -->
