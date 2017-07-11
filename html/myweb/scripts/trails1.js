/*
Cheesy Mouse Trails
Copyright Al Sparber (www.projectseven.com)
Add more shock to your site, at DHTML Shock.com
*/

var x,y 
var step=20 
var flag=0

//Set speed. Higher number is slower and more elastic. Just change number below.
var speed=60

//Change the text that follows the mouse. You must leave a space between end of text and closing quotation mark! 
var message="Whee! " 
message=message.split("") 
 
var xpos=new Array() 
for (i=0;i<=message.length-1;i++) { 
        xpos[i]=-50 
 
} 
 
var ypos=new Array() 
for (i=0;i<=message.length-1;i++) { 
        ypos[i]=-50 
 
} 
 
function SviiTrailer(e){ 
        x = (document.layers) ? e.pageX : document.body.scrollLeft+event.clientX 
        y = (document.layers) ? e.pageY : document.body.scrollTop+event.clientY 
        flag=1 
 
} 
 
function HappyTrails() { 
        if (flag==1 && document.all) { 
        for (i=message.length-1; i>=1; i--) { 
                        xpos[i]=xpos[i-1]+step 
                        ypos[i]=ypos[i-1] 
        } 
                xpos[0]=x+step 
                ypos[0]=y 
         
                for (i=0; i<message.length-1; i++) { 
                var thisspan = eval("span"+(i)+".style") 
                thisspan.posLeft=xpos[i] 
                        thisspan.posTop=ypos[i] 
        } 
        } 
         
        else if (flag==1 && document.layers) { 
        for (i=message.length-1; i>=1; i--) { 
                        xpos[i]=xpos[i-1]+step 
                        ypos[i]=ypos[i-1] 
        } 
                xpos[0]=x+step 
                ypos[0]=y 
         
                for (i=0; i<message.length-1; i++) { 
                var thisspan = eval("document.span"+i) 
                thisspan.left=xpos[i] 
                        thisspan.top=ypos[i] 
        } 
        } 
                var timer=setTimeout("HappyTrails()",speed) 
 } 
