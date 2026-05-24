## Notes

### Generate Personal access tokens (PAT)

https://github.com/settings/tokens

### Push container images to ghcr.io

```
$ echo $PAT | docker login ghcr.io --username gengwg --password-stdin
WARNING! Your password will be stored unencrypted in /home/gengwg/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store
Login Succeeded
$ docker tag hello-world ghcr.io/gengwg/hello-world:1.0.0
$ docker push ghcr.io/gengwg/hello-world:1.0.0
The push refers to repository [ghcr.io/gengwg/hello-world]
9c27e219663c: Pushed
1.0.0: digest: sha256:90659bf80b44ce6be8234e6ff90a1ac34acbeb826903b02cfa0da11c82cbc042 size: 525
```

You can see the image pushed to here:

https://github.com/users/gengwg/packages/container/package/hello-world

### Push container images to ghcr.io and link to a repo

Label your image in Docker file with key `org.opencontainers.image.source`:

```
LABEL org.opencontainers.image.source=https://github.com/octocat/my-repo
```

Example:

https://github.com/gengwg/gtin

```
$ cat Dockerfile
FROM python:3.7-stretch
LABEL org.opencontainers.image.source=https://github.com/gengwg/gtin
LABEL org.opencontainers.image.description="Convert UPC number to valid GTINs"
LABEL org.opencontainers.image.licenses=MIT

ADD . /code
WORKDIR /code
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
```

Then build and push as normal:

```
$ docker build -t gtin .
$ docker tag gtin ghcr.io/gengwg/gtin:0.1.0
$ docker push ghcr.io/gengwg/gtin:0.1.0
```

View your package at:

https://github.com/gengwg/gtin/pkgs/container/gtin
