#!/usr/bin/env bash

project_dir=$(pwd)
access_key=${ACCESS_KEY:-none}
secret_key=${SECRET_KEY:-none}
environment=${ENVIRONMENT:-hydrogen}

if [ ! -f vendor/terraform/terraform ]; then
    bash scripts/terraform.sh
fi

./vendor/terraform/terraform destroy -var environment=$environment -var access_key=$access_key -var secret_key=$secret_key -state $environment.tfstate terraform