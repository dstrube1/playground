#tableParser.pl
#USAGE: perl tableParser.pl < in.txt >out.txt
while (<>){
	chomp;
	print "UPDATE $_ set cpr_id = 'new' where cpr_id = 'old'\n".
		"IF \@\@ERROR <> 0\n".
		"	BEGIN\n".
		"	ROLLBACK TRANSACTION\n".
		"	RETURN\n".
		"	END\n";
}