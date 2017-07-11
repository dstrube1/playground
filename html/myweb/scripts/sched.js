function coolIntro()
{
 if (!document.layers&&!document.all&&!document.getElementById)
  {
   paramstp="height=580,width=796,top=0,left=0,scrollbars=yes,location=no"+
   ",directories=no,status=no,menubar=no,toolbar=no,resizable=yes"
   var gwa=window.open("http://students.kennesaw.edu/~dstrube/schedule.html","",paramstp);
   if (gwa.focus){gwa.focus();}
   return;
  }
 var movespeed=200;
 var resizespeed=100;
 var winreswidth=window.screen.availWidth;
 var winresheight=window.screen.availHeight;
 var leftspeed=winreswidth/movespeed;
 var topspeed=winresheight/movespeed;
 var movewidth=winreswidth;
 var moveheight=winresheight;
 var widthspeed=winreswidth/resizespeed;
 var heightspeed=winresheight/resizespeed;
 var sizewidth=0;
 var sizeheight=0;
 var gwa=open("http://students.kennesaw.edu/~dstrube/schedule.html","","left="+winreswidth+",top="+winresheight+",width=100,height=100,toolbar=no,menubar=no,location=no,status=yes,scrollbars=yes,resizable=yes");
 for (move=0;move<movespeed;move++)
  {
   gwa.moveTo(movewidth,moveheight);
   movewidth-=leftspeed;
   moveheight-=topspeed;
  }
 gwa.moveTo("0","0");

 for (size=0;size<resizespeed;size++)
  {
   gwa.resizeTo(sizewidth,sizeheight);
   sizewidth+=widthspeed;
   sizeheight+=heightspeed;
  }
 gwa.resizeTo(winreswidth,winresheight);
 if (gwa.focus){gwa.focus();}
}