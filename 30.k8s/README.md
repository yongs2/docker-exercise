# Container image for k8s integration to be used in gitlab-ci

## 0. Prerequisites

### 0.1 kube config

- Copy the /etc/kubernetes/admin.conf file of k8s-dev to ${HOME}/.kube/config

## 1. Install Tools

### 1.1 [Install helm](https://helm.sh/docs/intro/install/)

```sh
cd /tmp;
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
export VERIFY_CHECKSUM=false
chmod +x get_helm.sh; ./get_helm.sh
```

### 1.2 [Install yq](https://github.com/mikefarah/yq)

```sh
VERSION=v4.14.1
BINARY=yq_linux_amd64
curl -LO https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY}.tar.gz
tar -zxvf ${BINARY}.tar.gz && mv ${BINARY} /usr/bin/yq
```

### 1.3 [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

```sh
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl; mv kubectl /usr/bin/kubectl
```
