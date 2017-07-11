/***********************
This script and many more are available free online at 
The JavaScript Source!! http://javascript.internet.com 
Original:  Ken Lau (lauzon1999@yahoo.com) 
Web Site:  http://www.geocities.com/lauzon1999 
***********************/

//////////\\\\\\\\\\\\\
//change made 7-17-02-352pm: switch output around=stardate
//////////\\\\\\\\\\\\\

function dateinbar()
{
var d=new Date();
var mon=d.getMonth()+1;
var year=d.getFullYear();
var date=d.getDate();
var h=d.getHours();
var m=d.getMinutes();
var s=d.getSeconds();
/************ 
	very nice, but anti future:
var AorP=" ";
if (h>=12)
    AorP="P.M.";
else
    AorP="A.M.";
if (h>=13)
    h=h-12;
*************/
if (s<10)
    s="0"+s;
if (m<10)
    m="0"+m;
defaultStatus = "Stardate:  "+year+"-"+mon+"-"+date+ "-" + h+"-"+m+"-"+s;//+" "+AorP ;
setTimeout("dateinbar()",1000);
}
dateinbar();

