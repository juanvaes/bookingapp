setup:
	python -m venv venv
install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt
run-ansible-playbook:
	ansible-playbook -i .circleci/ansible/inventory.txt .circleci/ansible/main.yml
lint:
	pylint --disable=C bookingapp/
test:
	pytest -s tests/
run-api:
	python bookingapp/run.py
describe-aws-stacks:
	aws cloudformation describe-stacks