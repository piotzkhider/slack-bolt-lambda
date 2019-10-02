PROFILE := YOUR_AWS_PROFILE_NAME
REGION := YOUR_AWS_REGION
BUCKET := YOUR_UNIQUE_BUCKET_NAME

default: local
.PHONY: default

local:
	@sam local start-api
.PHONY: run

expose:
	@ssh -o ServerAliveInterval=60 -R 80:localhost:3000 serveo.net
.PHONY: expose

install:
	@cd ./hello-world && npm install
.PHONY: install

test:
	@cd ./hello-world && npm run test
.PHONY: test

clean: delete-stack delete-bucket
.PHONY: clean

create-bucket:
	@aws s3 mb s3://$(BUCKET) --region $(REGION) --profile $(PROFILE)
.PHONY: create-bucket

delete-bucket:
	@aws s3 rm s3://$(BUCKET) --recursive --region $(REGION) --profile $(PROFILE)
	@aws s3 rb s3://$(BUCKET) --region $(REGION) --profile $(PROFILE)
.PHONY: delete-bucket

package:
	@sam package --template-file template.yaml --output-template-file output-template.yaml --s3-bucket $(BUCKET) --profile $(PROFILE) --region $(REGION)
.PHONY: package

deploy:
	@sam deploy --template-file output-template.yaml --stack-name SlackAppScheduler --capabilities CAPABILITY_IAM --profile $(PROFILE) --region $(REGION)
.PHONY: deploy

package-deploy: package deploy
.PHONY: package-deploy

delete-stack:
	@aws cloudformation delete-stack --stack-name SlackAppScheduler --profile $(PROFILE) --region $(REGION)
.PHONY: delete-stack

setup: install
	@aws s3api get-bucket-location --bucket $(BUCKET) --region $(REGION) --profile $(PROFILE) || $(MAKE) create-bucket
	$(MAKE) package-deploy
.PHONY: setup

