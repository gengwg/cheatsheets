Association is a combination of cluster, account, user name, and (optional) partition name.
Each association can have a fair-share allocation of resources and a multitude of limits.

Always upgrade slurmdbd first. slurmdbd can communicate with SLURM commands and daemons at the same
or recent earlier versions. e.g. slurm 2.4 can not communicate with 2.5 RPCs.

## Commands

### Check the state of a host in Slurm

```
sinfo -N | grep $(hostname -s)
```

Check multiple hosts states

```
sinfo -N | grep -E 'node[1-5]'
```

### Check which scheduler is used by Slurm

```
$ scontrol show config | grep -i SchedulerType
SchedulerType           = sched/backfill
```

### Specify a batch script by filename on the command line

The batch script specifies a 1 minute time limit for the job. And on partition RTX, with specified format for job outputs.

```
# cat myscript.slrm
#!/bin/sh
#SBATCH -p RTX
#SBATCH --time=1
#SBATCH -o gengwg_test.%N.%j.out
#SBATCH -e gengwg_test.%N.%j.err
srun hostname |sort
```

Submit the job:

```
# sbatch -N5 myscript.slrm
Submitted batch job 26608
```

Find out which nodes the job was submitted on (BatchHost).  The output file will be generated on the first node of the job allocation. 

```
# scontrol show job 26608
JobId=26608 JobName=myscript.slrm
   UserId=root(0) GroupId=root(0) MCS_label=N/A
   Priority=100 Nice=0 Account=(null) QOS=(null)
   JobState=COMPLETED Reason=None Dependency=(null)
   Requeue=1 Restarts=0 BatchFlag=1 Reboot=0 ExitCode=0:0
   RunTime=00:00:01 TimeLimit=00:01:00 TimeMin=N/A
   SubmitTime=2023-02-09T21:01:25 EligibleTime=2023-02-09T21:01:25
   AccrueTime=2023-02-09T21:01:25
   StartTime=2023-02-09T21:01:25 EndTime=2023-02-09T21:01:26 Deadline=N/A
   SuspendTime=None SecsPreSuspend=0 LastSchedEval=2023-02-09T21:01:25
   Partition=RTX AllocNode:Sid=slurmcontrol01:3061916
   ReqNodeList=(null) ExcNodeList=(null)
   NodeList=node[1-5]
   BatchHost=node1 # <-----
   NumNodes=5 NumCPUs=10 NumTasks=5 CPUs/Task=1 ReqB:S:C:T=0:0:*:*
   TRES=cpu=10,mem=3500000M,node=5,billing=10
   Socks/Node=* NtasksPerN:B:S:C=0:0:*:* CoreSpec=*
   MinCPUsNode=1 MinMemoryNode=700000M MinTmpDiskNode=0
   Features=(null) DelayBoot=00:00:00
   OverSubscribe=OK Contiguous=0 Licenses=(null) Network=(null)
   Command=/home/gengwg/myscript.slrm
   WorkDir=/home/gengwg
   StdErr=/home/gengwg/gengwg_test.%N.26608.err
   StdIn=/dev/null
   StdOut=/home/gengwg/gengwg_test.%N.26608.out
   Power=
   NtasksPerTRES:0
```

Log in to the BatchHost:

```
$ ssh node1
$ ls -tlr
-rw-r--r-- 1 root root   0 Feb  9 21:01 gengwg_test.node1.26608.err
-rw-r--r-- 1 root root 185 Feb  9 21:01 gengwg_test.node1.26608.out
$ cat gengwg_test.node1.26608.out
node1
node2
node3
node4
node5
```

### Exclude nodes from sbatch

```
#SBATCH --exclude=node5
```

### Run a command on N hosts

```
$ srun -p MyPartition -N3  hostname
````

## Troubleshooting

### Invalid node state specified when trying to undrain a node

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

### Job in RH state with JobHoldMaxRequeue reason

```
RH       0:00     12 (JobHoldMaxRequeue)
```

Launch failed requeued held. Job launch failed for some reason. This is normally due to a faulty node. After requeuing 5 times (the default max requeue times), it gave up. Try schedule with fewer nodes.

```
RH REQUEUE_HOLD
Held job is being requeued.
```

### Add a node to another partition

```
scontrol update Partition=Team1 Nodes=<existing nodes>,<new node>
```

### Kill task failed 

```
# sinfo -R
REASON               USER      TIMESTAMP           NODELIST
Kill task failed     root      2023-04-11T11:42:06 node102
```

It seems simply undraining fixed it. I'm not sure about the root cause yet.

```
# scontrol update NodeName=node102 State=IDLE
```

### srun errors all ports exhausted

srun gives an error if ports in [min, max] are exhausted

```
srun: error: sock_bind_range all ports in range (60001, 63000) in use.
```

it has to do with many jobs being launched from that machine (e.g. there are ~1000 srun instances). Each Srun uses 3 ports at least. this will exhaust the port range.

> A single srun opens 3 listening ports plus 2 more for every 48 hosts.

There are two solutions.

One is to not submit all jobs from same machine. e.g. launching from a different machine when it's approaching 1000 sruns.

Another is to increase the SrunPortRange in slurm config:

```
$ scontrol show config|grep SrunPortRange
SrunPortRange           = 50000-63000
```
