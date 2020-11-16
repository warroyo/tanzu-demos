#! /usr/bin/env bash

source ./demo-magic.sh

clear


pe 'tkg get clusters'

pe 'tkg create cluster devteam1 -p dev -w 2 --worker-size large'

pe 'tkg get cluster devteam1'

pe 'kubectl get clusters'

pe 'kubectl get machines'

pe 'tkg get credentials devteam1'



