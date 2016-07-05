#!/usr/bin/env bash

version='0.6.16'
os=$SYSTEM

dist="vendor/terraform"
filename="terraform_${version}_${os}_amd64.zip"

mkdir -p $dist
cd $dist
wget "https://releases.hashicorp.com/terraform/${version}/${filename}"
unzip $filename