Check all the services deployed in kubernetes:

```
count by (service) (kube_service_info)
```

Check all the services deployed in kubernetes:

```
sum (kube_deployment_labels) by (deployment)
```

Exclude parent cgroup for container metrics:

```
container_memory_working_set_bytes{container != "POD", pod != ""}
```
