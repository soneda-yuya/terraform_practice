ENV="dev"
WORK_DIR="/terraform/environments"

.PHONY: build-up
build-up:
	docker compose up --build

.PHONY: up
up:
	docker compose up

.PHONY: down
down:
	docker compose stop

.PHONY: init
init:
	docker compose exec -w=${WORK_DIR}/${ENV} sample_terraform terraform init --reconfigure

.PHONY: backend-remote
backend-remote:
	mv ./environments/${ENV}/backend-remote.tf.bk ./environments/${ENV}/backend-remote.tf
	mv ./environments/${ENV}/backend-local.tf ./environments/${ENV}/backend-local.tf.bk
	make init ENV=${ENV}

.PHONY: backend-local
backend-local:
	mv ./environments/${ENV}/backend-local.tf.bk ./environments/${ENV}/backend-local.tf
	mv ./environments/${ENV}/backend-remote.tf ./environments/${ENV}/backend-remote.tf.bk
	make init ENV=${ENV}

.PHONY: apply
apply:
	docker compose exec -w=${WORK_DIR}/${ENV} sample_terraform terraform apply

.PHONY: plan
plan:
	docker compose exec -w=${WORK_DIR}/${ENV} sample_terraform terraform plan

.PHONY: destroy
destroy:
	docker compose exec -w=${WORK_DIR}/${ENV} sample_terraform terraform destroy
	rm -rf ./environments/${ENV}/.terraform/terraform.tfstate
	make backend-local

.PHONY: fmt
fmt:
	docker compose exec -w=${WORK_DIR}/${ENV} sample_terraform terraform fmt

.PHONY: console
console:
	docker compose exec -w=${WORK_DIR}/${ENV} sample_terraform terraform console

.PHONY: show
show:
	docker compose exec -w=${WORK_DIR}/${ENV} sample_terraform terraform show

.PHONY: platform_principal
platform_principal:
	openssl pkcs12 -in ${FILE_PATH} -nodes | sed -n "/-----BEGIN CERTIFICATE-----/,/-----END CERTIFICATE-----/p" > ./environments/${ENV}/credentials/platform_principal.txt

.PHONY: platform_credential
platform_credential:
	openssl pkcs12 -in ${FILE_PATH} -nodes | sed -n "/-----BEGIN PRIVATE KEY-----/,/-----END PRIVATE KEY-----/p" > ./environments/${ENV}/credentials/platform_credential.txt

.PHONY: new_env
new_env:
	cp -R ./example/basic ./environments/${NEW_ENV} && find ./environments/${NEW_ENV} -type f | xargs sed -i.bkk 's/basic/${NEW_ENV}/g' && rm -rf ./environments/${NEW_ENV}/*.bkk;
