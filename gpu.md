### Enable persistence mode

```
# nvidia-smi -pm 1
Persistence mode is already Enabled for GPU 00000000:12:00.0.
Persistence mode is already Enabled for GPU 00000000:13:00.0.
Persistence mode is already Enabled for GPU 00000000:14:00.0.
Persistence mode is already Enabled for GPU 00000000:48:00.0.
Persistence mode is already Enabled for GPU 00000000:49:00.0.
Persistence mode is already Enabled for GPU 00000000:89:00.0.
Persistence mode is already Enabled for GPU 00000000:8A:00.0.
Persistence mode is already Enabled for GPU 00000000:C0:00.0.
Persistence mode is already Enabled for GPU 00000000:C1:00.0.
Persistence mode is already Enabled for GPU 00000000:C2:00.0.
All done.
```

### Upgrade Nvidia RTX Driver (460 -> 470)

Stop nvml_monitor and nvidia-persistenced first:

```
# systemctl stop nvml_monitor && systemctl stop nvidia-persistenced
```

Uninstall 460 Driver:

```
# nvidia-uninstall -ui=none --no-questions

Welcome to the NVIDIA Software Installer for Unix/Linux

Detected 80 CPUs online; setting concurrency level to 32.
If you plan to no longer use the NVIDIA driver, you should make sure that no X screens are configured to use the NVIDIA X driver in your X configuration file. If you used nvidia-xconfig to  configure X, it may have created a backup of your original configuration. Would
you like to run `nvidia-xconfig --restore-original-backup` to attempt restoration of the original X configuration file? (Answer: No)
Parsing log file:
  Parsing: [##############################] 100%
Validating previous installation:
  Validating: [##############################] 100%
Uninstalling NVIDIA Accelerated Graphics Driver for Linux-x86_64 (1.0-4603203 (460.32.03)):
  Uninstalling: [##############################] 100%
Running depmod and ldconfig:
done.

Uninstallation of existing driver: NVIDIA Accelerated Graphics Driver for Linux-x86_64 (460.32.03) is complete.
```

Confirm driver removed:

```
# rmmod nvidia_drm nvidia_modeset nvidia
rmmod: ERROR: Module nvidia_drm is not currently loaded
rmmod: ERROR: Module nvidia_modeset is not currently loaded
rmmod: ERROR: Module nvidia is not currently loaded
```

Download NVIDIA-Linux-x86_64-470.63.01.run driver from:

https://download.nvidia.com/XFree86/Linux-x86_64


Install:

```
# chmod +x /tmp/NVIDIA-Linux-x86_64-470.63.01.run
# /tmp/NVIDIA-Linux-x86_64-470.63.01.run --dkms --ui=none --no-questions
# /tmp/NVIDIA-Linux-x86_64-470.63.01.run --no-questions --accept-license --ui=none --dkms
Verifying archive integrity... OK
Uncompressing NVIDIA Accelerated Graphics Driver for Linux-x86_64 470.63.                                                                                                                     01........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................

Welcome to the NVIDIA Software Installer for Unix/Linux

Detected 80 CPUs online; setting concurrency level to 32.
Installing NVIDIA driver version 470.63.01.
There appears to already be a driver installed on your system (version: 470.63.01).  As part of installing this driver (version: 470.63.01), the existing driver will be uninstalled.  Are    you sure you want to continue? (Answer: Continue installation)
Would you like to register the kernel module sources with DKMS? This will allow DKMS to automatically build a new module, if you install a different kernel later. (Answer: Yes)

WARNING: nvidia-installer was forced to guess the X library path '/usr/lib64' and X module path '/usr/lib64/xorg/modules'; these paths were not queryable from the system.  If X fails to     find the NVIDIA X driver module, please install the `pkg-config` utility and the
         X.Org SDK/development package for your distribution and reinstall the driver.

Install NVIDIA's 32-bit compatibility libraries? (Answer: Yes)
Uninstalling the previous installation with /bin/nvidia-uninstall.
An incomplete installation of libglvnd was found. All of the essential libglvnd libraries are present, but one or more optional components are missing. Do you want to install a full copy of libglvnd? This will overwrite any existing libglvnd libraries. (Answer: Don't
install libglvnd files)
Skipping GLVND file: "libOpenGL.so.0"
Skipping GLVND file: "libOpenGL.so"
Skipping GLVND file: "libGLESv1_CM.so.1.2.0"
Skipping GLVND file: "libGLESv1_CM.so.1"
Skipping GLVND file: "libGLESv1_CM.so"
Skipping GLVND file: "libGLESv2.so.2.1.0"
Skipping GLVND file: "libGLESv2.so.2"
Skipping GLVND file: "libGLESv2.so"
Skipping GLVND file: "libGLdispatch.so.0"
Skipping GLVND file: "libGLX.so.0"
Skipping GLVND file: "libGLX.so"
Skipping GLVND file: "libGL.so.1.7.0"
Skipping GLVND file: "libGL.so.1"
Skipping GLVND file: "libGL.so"
Skipping GLVND file: "libEGL.so.1.1.0"
Skipping GLVND file: "libEGL.so.1"
Skipping GLVND file: "libEGL.so"
Skipping GLVND file: "./32/libOpenGL.so.0"
Skipping GLVND file: "libOpenGL.so"
Skipping GLVND file: "./32/libGLdispatch.so.0"
Skipping GLVND file: "./32/libGLESv2.so.2.1.0"
Skipping GLVND file: "libGLESv2.so.2"
Skipping GLVND file: "libGLESv2.so"
Skipping GLVND file: "./32/libGLESv1_CM.so.1.2.0"
Skipping GLVND file: "libGLESv1_CM.so.1"
Skipping GLVND file: "libGLESv1_CM.so"
Skipping GLVND file: "./32/libGL.so.1.7.0"
Skipping GLVND file: "libGL.so.1"
Skipping GLVND file: "libGL.so"
Skipping GLVND file: "./32/libGLX.so.0"
Skipping GLVND file: "libGLX.so"
Skipping GLVND file: "./32/libEGL.so.1.1.0"
Skipping GLVND file: "libEGL.so.1"
Skipping GLVND file: "libEGL.so"
Searching for conflicting files:
  Searching: [##############################] 100%
Installing 'NVIDIA Accelerated Graphics Driver for Linux-x86_64' (470.63.01):
  Installing: [####                          ]  10%
ERROR: Unable to backup directory '/usr/lib64/libnvidia-rtcore.so.470.63.01'.

  Installing: [####                          ]  10%
ERROR: Unable to backup directory '/usr/lib64/libnvoptix.so.470.63.01'.

  Installing: [#######################       ]  75%
ERROR: Unable to create '/usr/lib64/libnvidia-rtcore.so.470.63.01' for copying (Is a directory)

  Installing: [#######################       ]  75%
ERROR: Unable to create '/usr/lib64/libnvoptix.so.470.63.01' for copying (Is a directory)

  Installing: [##############################] 100%
Driver file installation is complete.
Installing DKMS kernel module:
  Adding to DKMS: [##############################] 100%
Running post-install sanity check:
  Checking: [#######################       ]  76%
WARNING: The installed file '/usr/lib64/libnvidia-rtcore.so.470.63.01' is not of the correct filetype.

  Checking: [#######################       ]  76%
WARNING: The installed file '/usr/lib64/libnvoptix.so.470.63.01' is not of the correct filetype.

  Checking: [##############################] 100%
Post-install sanity check failed.
Running runtime sanity check:
  Checking: [##############################] 100%
Runtime sanity check passed.
Would you like to run the nvidia-xconfig utility to automatically update your X configuration file so that the NVIDIA X driver will be used when you restart X?  Any pre-existing X           configuration file will be backed up. (Answer: No)

Installation of the NVIDIA Accelerated Graphics Driver for Linux-x86_64 (version: 470.63.01) is now complete.  Please update your xorg.conf file as appropriate; see the file /usr/share/doc/ NVIDIA_GLX-1.0/README.txt for details.
```

Reboot.

### Got driver/library version mismatch error:

```
$ nvidia-smi
Failed to initialize NVML: Driver/library version mismatch
```

Root cause: The kernel modules were being embedded inside the compressed kernel image, then being loaded early in the boot process. These embedded, but outdated modules, would then prevent the correct, and newly installed/compiled standalone module files from being loaded. 

Folow [here](https://stackoverflow.com/questions/70276412/how-to-fix-nvrm-api-mismatch-between-client-version-and-kernel-module-version) to fix it.
 
You can confirm this by the following. Looks it's still loaded the 470.103 driver:

```
# cat /proc/driver/nvidia/version
NVRM version: NVIDIA UNIX x86_64 Kernel Module  470.103.01  Thu Jan  6 12:10:04 UTC 2022
GCC version:  gcc version 4.8.5 20150623 (Red Hat 4.8.5-44) (GCC)
# cat /sys/module/nvidia/version
470.103.01
```

dkms shows the correct kernel modules are available (470.063):

```
# dkms status
nvidia/470.63.01, 3.10.0-1160.83.1.el7.x86_64, x86_64: installed
```

The fix simply involves regenerating the kernel images. Run this for Centos 7:

```
# dracut --regenerate-all --force
```

Now all of them agrees:

```
$ cat /proc/driver/nvidia/version
NVRM version: NVIDIA UNIX x86_64 Kernel Module  470.63.01  Tue Aug  3 20:44:16 UTC 2021
GCC version:  gcc version 4.8.5 20150623 (Red Hat 4.8.5-44) (GCC)
$ cat /sys/module/nvidia/version
470.63.01
$ dkms status
nvidia/470.63.01, 3.10.0-1160.83.1.el7.x86_64, x86_64: installed
```

Then reboot. 

Now works:

```
$ nvidia-smi
Mon Feb  6 15:15:56 2023
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 470.63.01    Driver Version: 470.63.01    CUDA Version: 11.4     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  Quadro RTX 8000     On   | 00000000:12:00.0 Off |                  Off |
| 33%   18C    P8    16W / 260W |      1MiB / 48601MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
|   1  Quadro RTX 8000     On   | 00000000:13:00.0 Off |                  Off |
| 33%   18C    P8    13W / 260W |      1MiB / 48601MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
|   2  Quadro RTX 8000     On   | 00000000:14:00.0 Off |                  Off |
| 33%   20C    P8     7W / 260W |      1MiB / 48601MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
|   3  Quadro RTX 8000     On   | 00000000:48:00.0 Off |                  Off |
| 33%   19C    P8    11W / 260W |      1MiB / 48601MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
|   4  Quadro RTX 8000     On   | 00000000:49:00.0 Off |                  Off |
| 33%   18C    P8     5W / 260W |      1MiB / 48601MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
|   5  Quadro RTX 8000     On   | 00000000:89:00.0 Off |                  Off |
| 33%   18C    P8     8W / 260W |      1MiB / 48601MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
|   6  Quadro RTX 8000     On   | 00000000:8A:00.0 Off |                  Off |
| 33%   19C    P8    14W / 260W |      1MiB / 48601MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
|   7  Quadro RTX 8000     On   | 00000000:C0:00.0 Off |                  Off |
| 33%   18C    P8     6W / 260W |      1MiB / 48601MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
|   8  Quadro RTX 8000     On   | 00000000:C1:00.0 Off |                  Off |
| 34%   18C    P8    10W / 260W |      1MiB / 48601MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
|   9  Quadro RTX 8000     On   | 00000000:C2:00.0 Off |                  Off |
| 34%   18C    P8     9W / 260W |      1MiB / 48601MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+

+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```

You can also fix the problem temporarily, by manually removing (unloading) the NVIDIA module using rmmod or modprobe, then reloading them. When you do modprobe will use the standalone kernel module which should match your installed driver version.

### Display topological information about the system

Below is for DGX A100.

```
# nvidia-smi topo -m
	GPU0	GPU1	GPU2	GPU3	GPU4	GPU5	GPU6	GPU7	mlx5_0	mlx5_1	mlx5_2	mlx5_3	mlx5_4	mlx5_5	mlx5_6	mlx5_7	mlx5_8	mlx5_9	mlx5_10	mlx5_11	CPU Affinity	NUMA Affinity
GPU0	 X 	NV12	NV12	NV12	NV12	NV12	NV12	NV12	PXB	PXB	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	48-63,176-191	3
GPU1	NV12	 X 	NV12	NV12	NV12	NV12	NV12	NV12	PXB	PXB	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	48-63,176-191	3
GPU2	NV12	NV12	 X 	NV12	NV12	NV12	NV12	NV12	SYS	SYS	PXB	PXB	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	16-31,144-159	1
GPU3	NV12	NV12	NV12	 X 	NV12	NV12	NV12	NV12	SYS	SYS	PXB	PXB	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	16-31,144-159	1
GPU4	NV12	NV12	NV12	NV12	 X 	NV12	NV12	NV12	SYS	SYS	SYS	SYS	SYS	SYS	PXB	PXB	SYS	SYS	SYS	SYS	112-127,240-255	7
GPU5	NV12	NV12	NV12	NV12	NV12	 X 	NV12	NV12	SYS	SYS	SYS	SYS	SYS	SYS	PXB	PXB	SYS	SYS	SYS	SYS	112-127,240-255	7
GPU6	NV12	NV12	NV12	NV12	NV12	NV12	 X 	NV12	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	PXB	PXB	SYS	SYS	80-95,208-223	5
GPU7	NV12	NV12	NV12	NV12	NV12	NV12	NV12	 X 	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	PXB	PXB	SYS	SYS	80-95,208-223	5
mlx5_0	PXB	PXB	SYS	SYS	SYS	SYS	SYS	SYS	 X 	PXB	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS
mlx5_1	PXB	PXB	SYS	SYS	SYS	SYS	SYS	SYS	PXB	 X 	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS
mlx5_2	SYS	SYS	PXB	PXB	SYS	SYS	SYS	SYS	SYS	SYS	 X 	PXB	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS
mlx5_3	SYS	SYS	PXB	PXB	SYS	SYS	SYS	SYS	SYS	SYS	PXB	 X 	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS
mlx5_4	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	 X 	PIX	SYS	SYS	SYS	SYS	SYS	SYS
mlx5_5	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	PIX	 X 	SYS	SYS	SYS	SYS	SYS	SYS
mlx5_6	SYS	SYS	SYS	SYS	PXB	PXB	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	 X 	PXB	SYS	SYS	SYS	SYS
mlx5_7	SYS	SYS	SYS	SYS	PXB	PXB	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	PXB	 X 	SYS	SYS	SYS	SYS
mlx5_8	SYS	SYS	SYS	SYS	SYS	SYS	PXB	PXB	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	 X 	PXB	SYS	SYS
mlx5_9	SYS	SYS	SYS	SYS	SYS	SYS	PXB	PXB	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	PXB	 X 	SYS	SYS
mlx5_10	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	 X 	PIX
mlx5_11	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	SYS	PIX	 X

Legend:

  X    = Self
  SYS  = Connection traversing PCIe as well as the SMP interconnect between NUMA nodes (e.g., QPI/UPI)
  NODE = Connection traversing PCIe as well as the interconnect between PCIe Host Bridges within a NUMA node
  PHB  = Connection traversing PCIe as well as a PCIe Host Bridge (typically the CPU)
  PXB  = Connection traversing multiple PCIe bridges (without traversing the PCIe Host Bridge)
  PIX  = Connection traversing at most a single PCIe bridge
  NV#  = Connection traversing a bonded set of # NVLinks

# nvidia-smi topo -c 48
The GPUs that have an affinity with CPU 48 are:
0, 1

[root@ash6-hpccdgx-node0009 ~]# nvidia-smi topo -c 222
The GPUs that have an affinity with CPU 222 are:
6, 7
```

