FROM ubuntu:bionic

RUN apt-get update -y && apt-get install -y bash jq curl && \
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh && \
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    curl -LO https://github.com/vmware-tanzu/kpack-cli/releases/download/v0.1.3/kp-linux-0.1.3 && \
    chmod +x ./kp-linux-0.1.3 && \
    mv ./kp-linux-0.1.3 /usr/local/bin/kp
