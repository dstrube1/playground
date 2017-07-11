var message 

var textfont=new Array()
textfont[0]="Times"
textfont[1]="Arial Black"
textfont[2]="Arial Narrow"
textfont[3]="Verdana"
textfont[4]="Courier"

var textstyle=new Array()
textstyle[0]="normal"
textstyle[1]="italic"
textstyle[2]="normal"
textstyle[3]="italic"

var textcolor= new Array()
textcolor[0] ="FEFEFF"
textcolor[1] ="FDFDFF"
textcolor[2] ="FAFAFF"
textcolor[3] ="F5F5FF"
textcolor[4] ="F3F3FF"
textcolor[5] ="EEEEFF"
textcolor[6] ="ECECFF"
textcolor[7] ="E9E9FF"
textcolor[8] ="E5E5FF"
textcolor[9] ="E2E2FF"
textcolor[10] ="DDDDFF"

var obj = new Array()
var repeater = 30

function randommaker(range) {		
	return Math.floor(range*Math.random())
}

function initiate(){
    if (document.all) {
       for (i=0; i<=repeater;i++) {
            obj[i]=eval("span"+i)
       }
    }
}

function showmessage(newmessage) {		
	message = newmessage  
    if (document.all) {
        for (i=0; i<=repeater;i++) {
            obj[i].innerHTML="<span style='position:absolute;top:"+randommaker(250)+"px;left:"+randommaker(400)+"px;font-family:"+textfont[randommaker(4)]+";font-size:"+randommaker(50)+"pt;font-style:"+textstyle[randommaker(4)]+";color:"+textcolor[randommaker(9)]+"'>"+message+"</span>"
        }
    }
}
window.onload=initiate