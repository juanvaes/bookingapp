setup:
	python -m venv venv
install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt
lint:
	pylint --disable=C bookingapp/
test:
	pytest -s tests/

all: install lint test