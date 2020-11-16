#! /usr/bin/env bash

source ./demo-magic.sh

clear

pe 'ytt -f ./app-manifests/app.yml | kbld -f - | kapp -y deploy -a petclinic -f -'