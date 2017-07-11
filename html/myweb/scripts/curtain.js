/*
Left-Right Stripy Curtain Script-
© Dynamic Drive (www.dynamicdrive.com)
For full source code, installation instructions,
100's more free DHTML scripts, and Terms Of
Use, visit dynamicdrive.com
*/

var speed=20
var temp=new Array()
var temp2=new Array()
if (document.layers){
for (i=1;i<=8;i++){
temp[i]=eval("document.i"+i+".clip")
temp2[i]=eval("document.i"+i)
temp[i].width=window.innerWidth
temp[i].height=window.innerHeight/8
temp2[i].top=(i-1)*temp[i].height
}
}
else if (document.all){
var clipright=document.body.clientWidth,clipleft=0
for (i=1;i<=8;i++){
temp[i]=eval("document.all.i"+i+".style")
temp[i].width=document.body.clientWidth
temp[i].height=document.body.offsetHeight/8
temp[i].top=(i-1)*parseInt(temp[i].height)
}
}
function openit(){
window.scrollTo(0,0)
if (document.layers){
for (i=1;i<=8;i=i+2)
temp[i].right-=speed
for (i=2;i<=8;i=i+2)
temp[i].left+=speed
if (temp[2].left>window.innerWidth)
clearInterval(stopit)
}
else if (document.all){
clipright-=speed
for (i=1;i<=8;i=i+2){
temp[i].clip="rect(0 "+clipright+" auto 0)"
}
clipleft+=speed
for (i=2;i<=8;i=i+2){
temp[i].clip="rect(0 auto auto "+clipleft+")"
}
if (clipright<=0)
clearInterval(stopit)
}
}
function gogo(){
stopit=setInterval("openit()",100)
}
gogo()