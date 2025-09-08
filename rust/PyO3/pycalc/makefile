# https://www.linkedin.com/learning/using-rust-with-python/python-calc-cli
# 1:43

init:
	maturin init

install:
	#pip install -e requirements.txt
	#	^^^this gave this error:
	#ERROR: requirements.txt is not a valid editable requirement. It should either be a 
	#path to a local project or a VCS URL (beginning with bzr+http, bzr+https, bzr+ssh, 
	#bzr+sftp, bzr+ftp, bzr+lp, bzr+file, git+http, git+https, git+ssh, git+git, git+file, 
	#hg+file, hg+http, hg+https, hg+ssh, hg+static-http, svn+ssh, svn+http, svn+https, 
	#svn+svn, svn+file).
	# 	better option for now:
	python -m pip install fire
	

build:
	cargo build --release
	# TODO: does this still fail?
	# Yes. WHY?!
	
	# Copy .so file from its default output dir to my current working dir
	#cp target/release/libpycalc_cli.so .
	#^=> cp: target/release/[...].so: No such file or directory

clean:
	# Remove the built .so file
	rm -f libpycalc_cli.so
	
# run like this:
# make clean
# make install
# make build
