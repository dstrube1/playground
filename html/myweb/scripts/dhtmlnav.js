var n = window.open('d', 'f', 'width=310,height=225');

n.document.write('<LINK REL=stylesheet HREF="sheets/menubar.css">');
n.document.write('<script LANGUAGE="Javascript" SRC="scripts/menubar.js"></script>');
//the address of menubar.js may be a little confusing- even tho both js are in the same dir,
// the file dhtmlnav is writing to is in another dir

if (window && window.open && !window.closed) {
parent.window.focus();
top.window.close()
window.close();
}

