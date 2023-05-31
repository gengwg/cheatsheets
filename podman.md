## Install

On Mac:

```
$ brew install podman
$ brew services restart podman
$ podman machine init
$ podman machine start

# indicated by above output
$ sudo /opt/homebrew/Cellar/podman/4.5.0/bin/podman-mac-helper install
$ podman machine stop; podman machine start

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

Note above may be specific to DTR. Harbor had no issue.

```
$ podman run --rm -it harbor.example.com/gengwg/kaniko-test
WARNING: image platform (linux/amd64) does not match the expected platform (linux/arm64)
hello world from kaniko
```

## Tagging and Pushing Docker Image to Harbor Using Podman

### Step 1: Login

To login to a container registry using Podman, use the following command:

```bash
podman login -u <username> <registry>
```

Example:

```bash
podman login -u gengwg harbor.example.com
```

This command will prompt you to enter your password. Upon successful login, you will see the message "Login Succeeded!"

### Step 2: Build the Image

To build a container image using Podman, use the `podman build` command followed by the necessary options and arguments.

```bash
podman build --platform=<platform> -t <image-name:tag> .
```

Example:

```bash
podman build --platform=linux/amd64 -t my-python-app:amd64 .
```

This command builds a container image using the Dockerfile located in the current directory (`.`). The `--platform` option specifies the target platform for the image, and the `-t` option tags the image with the specified name and tag.

The output will display the progress of each step in the build process.

### Step 3: Tag the Image

After building the image, you can tag it using the `podman tag` command.

```bash
podman tag <source-image> <target-image>
```

Example:

```bash
podman tag my-python-app:amd64 harbor.example.com/gengwg/my-python-app:podman
```

This command creates a new tag for the specified image, allowing you to identify it with a different name or location.

### Step 4: Push the Image

To push the container image to the registry, use the `podman push` command.

```bash
podman push <image-name:tag>
```

Example:

```bash
podman push harbor.example.com/gengwg/my-python-app:podman
```

This command uploads the specified image to the container registry.

Once the process is complete, you will see the progress of each step, including the successful push of the image to the registry.

