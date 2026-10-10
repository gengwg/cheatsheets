Infiniband is a Layer 2 networking protocl similar to Ethernet.

IB network referes to a mesh network between compute nodes that allows GPU to GPU communicate directly over GPUDirect RDMA. 

## Ports that are not a fabric (HGX B200/B300)

Four extra mlx5 devices at 100G are CX-Bridge functions of one ConnectX-7 on the baseboard, wired only to the NVSwitch complex. They read INIT or DOWN with no driver loaded, and ACTIVE with LIDs once NVLSM (the NVLink subnet manager in the driver) runs. Their names move between server layouts, so identify them by PCIe link width:

```
for d in /sys/class/infiniband/*; do
  echo "$(basename $d) $(cat $d/ports/1/rate) x$(cat $(readlink -f $d/device)/max_link_width)"
done
```

Bridges: 100G, x2, functions `.0`-`.3` of one PCI device. Rails: x16, 400G or more, each on its own bus. Never file bridges with a provider as down links.

## Port states

| `state` | `physical_state` | Meaning |
|---|---|---|
| 4 Active | 5 LinkUp | Healthy |
| 2 Init | 5 LinkUp | Link up, no subnet manager sweep yet |
| any | 2 Polling | No link partner: cable, optic or far end |
| any | 3 Disabled | Switched off on purpose |
| any | 4 PortConfigurationTraining | Partner present, training never completes |
