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

Scraping is node-local, so up == 0 never fires for a dead node — absence-based alerting is required. Never interpret a resolved node alert as recovery without checking the data is actually flowing again.


Exclusions must hold per sample, inside the window. This pages when an excluded series disappears, because the `unless` only sees the current sample while the window still holds old values:

```
min_over_time(port_state[30m]) < 4 unless port_phys_state == 3
```

Judge each sample with its own exclusion instead:

```
count_over_time(((port_state < 4) unless (port_phys_state == 3))[30m:1m]) >= 2
```

When an aggregation layer drops every label, `avg()` returns nothing but the fleet value is still there:

```
sum(DCGM_FI_PROF_GR_ENGINE_ACTIVE) / count(DCGM_FI_PROF_GR_ENGINE_ACTIVE)
```
