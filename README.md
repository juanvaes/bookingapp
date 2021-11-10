# bookingapp

* Image Repository: https://hub.docker.com/r/juanvaes/bookingapp

Step 1: Scope of the project
------
* Pipeline structure:
  - setup-api
  - check-api-lint
  - test-api
  - deploy-infrastructure
  - configure-infrastructure 
  - deploy-api
  - smoke-test
  - cleanup
* Deployment Type: Blue/Green deployment
* Application: Simple flask application with a single /index route.

Step 2: CI
------
* CI Platform: Circle CI
* Project CI Link: https://app.circleci.com/pipelines/github/juanvaes/bookingapp

Step 3: Infrastructure
------
* Ansible is used for configuring and deploying a new application into a AWS EC2 instance. There are two main tasks which are `configure-server` and `deploy-api`. 
  - `configure-server` will install docker, kubernetes and minikube
  - `deploy-api` will create a cluster and will deploy and expose the dockerized flask application.
* The EC2 instance is deployed with a cloudformation template located in `.circleci/cloudformation/backend.yml`
  - We are creating a security group for the ec2 instance
  - We are attaching the security group to the ec2 instance

Step 4: The Pipeline
------
