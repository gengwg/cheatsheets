## Install

### Mac

```
brew install --cask docker
```

Then cmd+space to find Docker app and start it.

### Build an image from a Dockerfile

```
docker build -t myimage .
```

this will build a image with tag `myimage:latest`.

### Push an image to remote repo/registry

```
docker tag myimage dtr.example.com/gengwg/myimage
docker push dtr.example.com/gengwg/myimage
```

### Passing multiple environment variable to docker container

```
docker run -e ACCESS_TOKEN="abcdefg" -e ADDR="0.0.0.0:8080" -p 8080:8080 -it dtr.example.com/gengwg/myimage
```

Or use env file:

```
docker run --env-file ./myenv.lst -p 8080:8080 -it dtr.example.com/gengwg/myimage
```

where myenv.list contains (remove the quotes):

```
ACCESS_TOKEN=abcdefg
ADDR=0.0.0.0:8080
```

### Access localhost of host machine from within container

Looks for different Docker versions, this is implemented differently.

Docker 19, one use `host.docker.internal`; 
Docker 13, one just use `localhost` directly.

### Docker save and load

Use when there is no internet connection from server.

on laptop:

```
$ docker images | grep hello
hello-world                                             latest              fce289e99eb9        22 months ago       1.84kB
$ docker save fce289e99eb9 > hello-world.tar
$ scp hello-world.tar my-server:
```
on server:

```
$ docker load -i hello-world.tar
af0b15c8625b: Loading layer [==================================================>]  3.584kB/3.584kB
Loaded image ID: sha256:fce289e99eb9bca977dae136fbe2a82b6b7d4c372474c9235adc1741675f587e
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
<none>              <none>              fce289e99eb9        22 months ago       1.84kB
$ docker run -it fce289e99eb9
Hello from Docker!
```

### Rootless mode

#### start


```
curl -fsSL https://get.docker.com/rootless | sh

# Docker binaries are installed in /home/gengwg/bin
# Make sure the following environment variables are set (or add them to ~/.bashrc):
export DOCKER_HOST=unix:///run/user/1000/docker.sock

#
# To control docker service run:
# systemctl --user (start|stop|restart) docker
#

export DOCKER_HOST=unix:///run/user/1000/docker.sock
$ systemctl --user start  docker
```

#### stop

```
./rootlesskit rm -rf ~/.local/share/docker
systemctl --user stop docker
```

### Docker Named Volume

Create a Docker Named Volume:

```
$ docker volume create myvolume
$ sudo ls /var/lib/docker/volumes
9ab169130a08dbfe7ff0cda010baf01c543578bf21fbfe215d348bc277ad1ebc  metadata.db  myvolume
```

Write some data to the volume using one container:

```
$ docker run -v myvolume:/mnt/test --name mycontainer -it ubuntu
root@797c8659ad58:/# ls /mnt/test/
root@797c8659ad58:/# cd /mnt/test/
root@797c8659ad58:/mnt/test# echo test > abc.txt
root@797c8659ad58:/mnt/test# cat abc.txt 
test
```

Create a new container and attach the same volume. Data will persist between the two containers:

```
$ docker run -v myvolume:/mnt/test --name mycontainer2 -it ubuntu
root@34c36bca5af4:/# cat /mnt/test/abc.txt
test
```

### List docker networks

```
$ docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
41a5a09ff7de   bridge    bridge    local
0692f8283ad7   host      host      local
e6ef8b1bc81e   kind      bridge    local
f5be8f7e54b9   none      null      local
```

`bridge` in docker network refers to `docker0` on the host.

```
# bridge
6: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default 
    link/ether 02:42:4b:94:fe:c8 brd ff:ff:ff:ff:ff:ff
ip link add docker0 type bridge
```

the bridge network is like an interface to the host, but like a SWITCH  to the namespaces or containers within the host.

## Notes

The `–net=host` option means that containers inherit the IPs of their host machines, i.e. no network containerization is involved. A priori, no network containerization performs better than any network containerization.


How to change the docker image installation directory

```
# cat /etc/docker/daemon.json 
{
        "graph": "/home/gengwg/docker"
}
```

constrianing the cpu only impacts the application's priority for cpu time, the memory is a hard limit.

auto-restarting a container

--restart argument takes: no, always, on-failure:3.


web_1  | python: can't open file 'app.py': [Errno 13] Permission denied

===>

It is an selinux issue.
Mount with :Z param.

```
volumes:
  - .:/code:Z
```

```
Docker: Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock
```
===>

```
sudo usermod -aG docker ${USER}
```

Then log out and log in again.

### Cgroup error in Fedora

```
$ docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
0e03bdcc26d7: Pull complete
Digest: sha256:4cf9c47f86df71d48364001ede3a4fcd85ae80ce02ebad74156906caff5378bc
Status: Downloaded newer image for hello-world:latest
docker: Error response from daemon: cgroups: cgroup mountpoint does not exist: unknown.
ERRO[0025] error waiting for container: context canceled
```

===>

```
$ sudo dnf install -y grubby
$ sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"
$ sudo reboot
```

### Forbidden path outside the build context

```
COPY failed: forbidden path outside the build context: ../../lib/go ()
```

===>

build from upper dir of Dockerfile dir:

```
docker build -t myimage -f parents/dir/Dockerfile .
```


### You don't have enough free space in /var/cache/apt/archives/

```
#0 66.01 E: You don't have enough free space in /var/cache/apt/archives/.
------
Dockerfile:36
--------------------
  34 |     LABEL maintainer="Random Liu <lantaol@google.com>"
  35 |
  36 | >>> RUN clean-install util-linux libsystemd0 bash systemd
  37 |
  38 |     # Avoid symlink of /etc/localtime.
--------------------
error: failed to solve: process "/bin/sh -c clean-install util-linux libsystemd0 bash systemd" did not complete successfully: exit code: 100
make: *** [Makefile:246: build-container] Error 1
```

This has nothing todo with build. It's docker issue. 

You run out of docker volume:

```
vagrant@vagrant:~/go/src/k8s.io/node-problem-detector$ df -h /
Filesystem                         Size  Used Avail Use% Mounted on
/dev/mapper/ubuntu--vg-ubuntu--lv   31G   29G   47M 100% /
```

To reclaim space:

```
vagrant@vagrant:~/go/src/k8s.io/node-problem-detector$ docker image prune -a  -f
vagrant@vagrant:~/go/src/k8s.io/node-problem-detector$ docker system prune -a -f
vagrant@vagrant:~/go/src/k8s.io/node-problem-detector$ docker volume prune -f
```

Now good:

```
vagrant@vagrant:~/go/src/k8s.io/node-problem-detector$ df -h /
Filesystem                         Size  Used Avail Use% Mounted on
/dev/mapper/ubuntu--vg-ubuntu--lv   31G   18G   12G  62% /
```

### unknown option overlay2.override_kernel_check: overlay2

```
$ sudo /usr/bin/dockerd
INFO[2023-06-18T20:20:37.183475780-07:00] Starting up
INFO[2023-06-18T20:20:37.198218291-07:00] [graphdriver] trying configured driver: overlay2
failed to start daemon: error initializing graphdriver: overlay2: unknown option overlay2.override_kernel_check: overlay2
INFO[2023-06-18T20:20:37.198929033-07:00] stopping event stream following graceful shutdown  error="context canceled" module=libcontainerd namespace=plugins.moby
```

As part of the platform upgrade, the Docker was also upgraded to v24. In this version of Docker the support for the overlay2.override_kernel_check storage option was removed as noted in Docker documentation.

```
$ docker version
Client: Docker Engine - Community
 Version:           24.0.2
 API version:       1.43
 Go version:        go1.20.4
 Git commit:        cb74dfc
 Built:             Thu May 25 21:53:44 2023
 OS/Arch:           linux/amd64
 Context:           default
Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
```

This storage option must be removed from the Docker daemon configuration in /etc/docker/daemon.json file.

Before:

```
$ cat daemon.json.bak
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
```

After:

```
$ cat daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
```

### Client.Timeout exceeded while awaiting headers

```
$ docker login harbor.my.com
Username: user
Password:
Error response from daemon: Get "https://harbor.my.com/v2/": Get "https://harbor-msec-snc.my.com/service/token?account=user&client_id=docker&offline_token=true&service=harbor-registry": net/http: request canceled (Client.Timeout exceeded while awaiting headers) (Client.Timeout exceeded while awaiting headers)

$ docker pull harbor.my.com/myns/blender3.0:v93
Error response from daemon: Head "https://harbor.my.com/v2/frl_gemini/blender3.0_ex/manifests/v93": Get "https://harbor-msec-snc.my.com/service/token?account=user&scope=repository%3Afrl_gemini%2exlender3.0_ex%3Apull&service=harbor-registry": net/http: request canceled (Client.Timeout exceeded while awaiting headers)
```

This could be many reasons. YMMV. Try some of below see if any of them works:

1. Increase Docker client time out

```
export DOCKER_CLIENT_TIMEOUT=600
```

Can you try run that first, then run the login command again.

Or put them on the same line. either should work.

```
DOCKER_CLIENT_TIMEOUT=600 docker login harbor.my.com
```

2. Check if you happen to use any proxy

check this:

```
gengwg@gengwg-mbp:~$ env | grep -i proxy
```

3. check your DNS setup

```
gengwg@gengwg-mbp:~$ cat /etc/resolv.conf  | grep -v \#
```

4. what happens when you curl the above endpoint? (unauthorized is expected).

```
gengwg@gengwg-mbp:~$ curl https://harbor.my.com/v2/
{"errors":[{"code":"UNAUTHORIZED","message":"unauthorized: unauthorized"}]}
```

5. try login to the UI directly. 

see if you still see the same issue.

https://harbor.my.com/harbor/projects

6. Try restart docker

7. Try big hammer


```
docker network prune
```

Finally worked!!

