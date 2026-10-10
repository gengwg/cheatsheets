# Kubernetes

## Concepts

### Container

A collection of software processes unified by one namespace, with access to an
operating system kernel that it shares with other containers, and little to no
access between containers.

A runtime instance of a docker image contains 3 things:

- a docker image
- an execution environment
- a standard set of instructions

Two features that allow k8s to scale: registration; discovery.

## Install minikube

https://kubernetes.io/docs/tasks/tools/install-minikube/

```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
    && chmod +x minikube
sudo cp minikube /usr/local/bin && rm minikube
```

## Install kubectl

https://kubernetes.io/docs/tasks/tools/install-kubectl/

```
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

yum install -y kubectl
```

## Start dashboard

```
kubectl proxy --address 0.0.0.0 --accept-hosts '.*'
```

or:

```
minikube dashboard
```

(it seems only localhost)

### Test dashboard

```
systemctl status firewalld
sudo systemctl stop firewalld
```

then go to:

```
http://<host-ip>:8001/api/v1/namespaces/kube-system/services/http:kubernetes-dashboard:/proxy/#!/overview?namespace=default
```

## Who uncordoned a node?

Check the API audit log for a `patch` on `nodes/<node>` and its `user.username`. On GPU Operator clusters with the containerized driver, the driver pod's `k8s-driver-manager` init container uncordons the node on every run, even when someone else cordoned it:

```
kubectl -n gpu-operator logs <nvidia-driver-pod> -c k8s-driver-manager | grep -i cordon
```

To keep a faulted node out through a reboot, label it `nvidia.com/gpu.deploy.driver=false`, and set it back to `true` after the repair.

## `context ... does not exist` with per-file kubeconfigs

When `KUBECONFIG` is a colon-separated list built at shell start, a config file added later is not in it. Open a new shell, or pass `--kubeconfig <file>`.
