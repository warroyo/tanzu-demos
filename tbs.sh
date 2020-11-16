#! /usr/bin/env bash

source ./demo-magic.sh

clear


pe 'bat tbs-resources/image.yml'

pe 'kubectl apply -f tbs-resources/image.yml'

pe 'kp image list'

pe 'kp image status petclinic'


# First build, CONFIG
pe 'kp build list petclinic'
pe 'kp build logs petclinic -b 1'
pe 'kp build status petclinic -b 1'

pe 'skopeo inspect docker://dev.registry.pivotal.io/warroyo/petclinic:latest | jq .Layers > build1'

# watch since we trigger the commit build in browser
pe 'watch kp build list petclinic'
# Second build, COMMIT
# Go change the code in GitHub
# Watch the COMMIT build
pe 'kp build logs petclinic -b 2'
pe 'kp build status petclinic -b 2'
pe 'skopeo inspect docker://dev.registry.pivotal.io/warroyo/petclinic:latest | jq .Layers > build2'

pe 'bat build1 build2'
pe 'diff build1 build2'

pe 'kp clusterstack update full \
   --build-image registry.pivotal.io/tbs-dependencies/build-full@sha256:ef09483901fec54c83c41a67e35e80d79450b1fdc0da7375b17bd93fd9a4a96c \
   --run-image registry.pivotal.io/tbs-dependencies/run-full@sha256:a007dd49172dd89c790a095ec6b54291dcb7bed942dd0a8ffd0a8d0b77cb68b5'

#hack until bug is fixed
kubectl patch clusterstack full --type='json' -p='[{"op": "replace", "path": "/spec/runImage/image", "value":"dev.registry.pivotal.io/warroyo/build-service/run@sha256:a007dd49172dd89c790a095ec6b54291dcb7bed942dd0a8ffd0a8d0b77cb68b5"}]'



pe 'watch kp build list petclinic'
pe 'kp build logs petclinic -b 3'
pe 'kp build status petclinic -b 3'
