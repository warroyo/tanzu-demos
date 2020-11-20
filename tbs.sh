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
   --build-image registry.pivotal.io/tbs-dependencies/build-full@sha256:5c4370ff05762de1f0376700abc3a4e2f6bc4fc1fe50eb6c03f6a62be89eb30b \
   --run-image registry.pivotal.io/tbs-dependencies/run-full@sha256:4e5fc822ef0edcdef513a6a979ee3e49df5b1849568fe0b3aa30eb5a6d557e95'

#hack until bug is fixed
kubectl patch clusterstack full --type='json' -p='[{"op": "replace", "path": "/spec/runImage/image", "value":"dev.registry.pivotal.io/warroyo/build-service/run@sha256:4e5fc822ef0edcdef513a6a979ee3e49df5b1849568fe0b3aa30eb5a6d557e95"}]'



pe 'watch kp build list petclinic'
pe 'kp build logs petclinic -b 3'
pe 'kp build status petclinic -b 3'
