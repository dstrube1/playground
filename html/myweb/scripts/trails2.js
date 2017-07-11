/* 
SviiTrailer 
*/ 
for (i=0;i<=message.length-1;i++) { 
    document.write("<span id='span"+i+"' class='cheesey'>") 
        document.write(message[i]) 
    document.write("</span>") 
} 
 
if (document.layers){ 
        document.captureEvents(Event.MOUSEMOVE); 
 
} 
document.onmousemove = SviiTrailer; 
