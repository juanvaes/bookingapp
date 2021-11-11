setup:
	python -m venv venv
install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt
install-hadolint:
	wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Linux-x86_64
	chmod +x /bin/hadolint
run-ansible-playbook:
	ansible-playbook -i .circleci/ansible/inventory.txt .circleci/ansible/main.yml
lint:
	hadolint --ignore DL3013 Dockerfile
	pylint --disable=C bookingapp/
test:
	pytest -s tests/
run-api:
	python bookingapp/run.py
describe-aws-stacks:
	aws cloudformation describe-stacks