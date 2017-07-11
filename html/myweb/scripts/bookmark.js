bmurl="http://students.kennesaw.edu/~dstrube"
bmtitle="David's Cool Site"

function addbookmark(){
	if (document.all)
		window.external.AddFavorite(bmurl,bmtitle);
}