#USAGE: dir /w | perl rename.pl > out.bat
#OR: rename.bat
while (<>){
	chomp;
	if (/\.mp3\.mp3$/i){
		$hey  =$_;
		chop $hey;
		chop $hey;
		chop $hey;
		chop $hey;
		print "move \"$_\" \"$hey\" \n";
	}
}