.PHONY: up
up:
	docker compose start

.PHONY: init
init:
	docker compose exec sample_terraform terraform init

.PHONY: apply
apply:
	docker compose exec sample_terraform terraform apply

.PHONY: plan
plan:
	docker compose exec sample_terraform terraform plan

.PHONY: fmt
fmt:
	docker compose exec sample_terraform terraform fmt

.PHONY: console
console:
	docker compose exec sample_terraform terraform console
