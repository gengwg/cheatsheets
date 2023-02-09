Association is a combination of cluster, account, user name, and (optional) partition name.
Each association can have a fair-share allocation of resources and a multitude of limits.

Always upgrade slurmdbd first. slurmdbd can communicate with SLURM commands and daemons at the same
or recent earlier versions. e.g. slurm 2.4 can not communicate with 2.5 RPCs.

## Commands

### Check the state of the host in Slurm

'''
sinfo -N | grep $(hostname -s)
'''


## Troubleshooting

### Invalid node state specified

Unable to undrain some nodes:

```
# scontrol update NodeName=node1 State=IDLE
slurm_update error: Invalid node state specified
```

This is due to all the nodes are in 'draining' state:

```
[root@sea112-dgx1052 ~]# sinfo --node node1 -p MyTeam
PARTITION    AVAIL  TIMELIMIT  NODES  STATE NODELIST
MyTeam     up   infinite      1   drng node1
```
