### Kubectl timeout

```
$ kubectl config get-contexts
CURRENT   NAME                                                         CLUSTER                                                      AUTHINFO                                                     NAMESPACE
*         gke_hippocratic-459618_us-central1_hippocratic-gke-cluster   gke_hippocratic-459618_us-central1_hippocratic-gke-cluster   gke_hippocratic-459618_us-central1_hippocratic-gke-cluster   
$ kgp
^C
$ k cluster-info

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
Unable to connect to the server: dial tcp 34.29.32.97:443: i/o timeout
```

===>

Make sure cluster is running:

```
$ gcloud container clusters describe hippocratic-gke-cluster \
  --region us-central1 \
  --project hippocratic-459618 \
  --format="value(status)"
RUNNING
```

If it's running, refresh kubectl Credentials:


```
$ gcloud container clusters get-credentials hippocratic-gke-cluster \
  --region us-central1 \
  --project hippocratic-459618
Fetching cluster endpoint and auth data.
kubeconfig entry generated for hippocratic-gke-cluster.
```

Confirm it's working:

```
$ k cluster-info
Kubernetes control plane is running at https://35.238.234.120
GLBCDefaultBackend is running at https://35.238.234.120/api/v1/namespaces/kube-system/services/default-http-backend:http/proxy
KubeDNS is running at https://35.238.234.120/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
Metrics-server is running at https://35.238.234.120/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
$ kgn
NAME                                                  STATUS   ROLES    AGE   VERSION
gke-hippocratic-gke--default-node-poo-02f37428-xsfk   Ready    <none>   10m   v1.32.2-gke.1297002
gke-hippocratic-gke--default-node-poo-5bb78c2d-64kn   Ready    <none>   10m   v1.32.2-gke.1297002
gke-hippocratic-gke--default-node-poo-9aa736db-n0dn   Ready    <none>   10m   v1.32.2-gke.1297002
```
