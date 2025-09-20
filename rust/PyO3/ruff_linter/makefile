install: 
	pip install --upgrade pip && pip install -r requirements.txt

test:
	python -m pytest -vv --cov=main --cov=mylib test_*.py

format: 
	black *.py

lint:
	#disable comment to test speed
	#pylint --disable=R.C --ignore-patterns=test_*.py mylib/*.py
	#ruff linting is 10-100x faster than pylint
	ruff check *.py mylib/*.py

container-lint:
	docker run --rm -i hadolint/hadolint < Dockerfile