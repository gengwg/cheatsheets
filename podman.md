## Install

On Mac:

```
$ brew install podman
$ brew services restart podman
$ podman machine init
$ podman machine start
$ podman system connection list
Name                         URI                                                         Identity                                   Default
podman-machine-default       ssh://core@localhost:51838/run/user/501/podman/podman.sock  /Users/gengwg/.ssh/podman-machine-default  true
podman-machine-default-root  ssh://root@localhost:51838/run/podman/podman.sock           /Users/gengwg/.ssh/podman-machine-default  fals
```

## Run

To run public images:

```
$ podman run hello-world
Resolved "hello-world" as an alias (/etc/containers/registries.conf.d/000-shortnames.conf)
Trying to pull quay.io/podman/hello:latest...
Getting image source signatures
Copying blob sha256:9cce0c869aa9fd8197a1f9efd23a6f57ccb23539acd054773b4bbcbd50e40b4a
Copying config sha256:9cca94e444286adeac297d9e3493e6803262fab3dbbce1669fc5d1a3fbc229bd
Writing manifest to image destination
Storing signatures
!... Hello Podman World ...!

         .--"--.
       / -     - \
      / (O)   (O) \
   ~~~| -=(,Y,)=- |
    .---. /`  \   |~~
 ~/  o  o \~~~~.----. ~~
  | =(X)= |~  / (O (O) \
   ~~~~~~~  ~| =(Y_)=-  |
  ~~~~    ~~~|   U      |~~

Project:   https://github.com/containers/podman
Website:   https://podman.io
Documents: https://docs.podman.io
Twitter:   @Podman_io

$ podman run --rm -it alpine  echo hello
hello
$ podman run alpine  echo hello
hello
```

For internal image, there may be certificate issue:

```
$ podman run --rm -it dtr.example.com/gengwg/kaniko-test
Trying to pull dtr.example.com/gengwg/kaniko-test:latest...
Error: initializing source docker://dtr.example.com/gengwg/kaniko-test:latest: pinging container registry dtr.example.com: Get "https://dtr.example.com/v2/": x509: certificate signed by unknown authority
```

Need add `--tls-verify=false`:

```
$ podman run --tls-verify=false --rm -it dtr.example.com/gengwg/kaniko-test
Trying to pull dtr.example.com/gengwg/kaniko-test:latest...
Getting image source signatures
Copying blob sha256:c9b1b535fdd91a9855fb7f82348177e5f019329a58c53c47272962dd60f71fc9
Copying config sha256:fae2300b2a9f983471e43c15ae1d71b7409a4b872dea4259db3d55b1fe98fd3d
Writing manifest to image destination
Storing signatures
hello world from kaniko
```
