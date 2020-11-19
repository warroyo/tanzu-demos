#! /bin/bash

ytt -f ./carvel/basic/app -f ./carvel/basic/values.yaml -f ./carvel/basic/values.local.yaml | kbld -f - | kapp -y deploy -a petclinic -f -