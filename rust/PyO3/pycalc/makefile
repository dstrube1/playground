# https://www.linkedin.com/learning/using-rust-with-python/python-calc-cli
# 1:43

init
	maturin init

install:
	pip install -e requirements.txt

build:
	cargo build --release
	# TODO: does this still fail?
	# Copy .so file from its default output dir to my current working dir
	#cp target/release/libpycalc_cli.so .
	#^=> cp: target/release/[...].so: No such file or directory

clean:
	# Remove the build .so file
	rm -f libpycalc_cli.so
	
# run like this:
# make install
# make clean
# make build
