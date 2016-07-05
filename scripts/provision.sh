#!/usr/bin/env bash

project_dir=$(pwd)
access_key=${ACCESS_KEY:-none}
secret_key=${SECRET_KEY:-none}
environment=${ENVIRONMENT:-hydrogen}
db_name=${DB_NAME}
db_username=$DB_USERNAME
db_password=$DB_PASSWORD

if [ ! -f vendor/terraform/terraform ]; then
    bash scripts/terraform.sh
fi

./vendor/terraform/terraform get -update=true terraform
./vendor/terraform/terraform apply -var db_name=$db_name -var db_username=$db_username -var db_password=$db_password -var environment=$environment -var access_key=$access_key -var secret_key=$secret_key -state $environment.tfstate terraform