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


