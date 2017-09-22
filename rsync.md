Some common options used with rsync commands
```
-v : verbose
-r : copies data recursively (but don’t preserve timestamps and permission while transferring data)
-a : archive mode: 
        archive mode allows copying files recursively and it also 
        preserves symbolic links, file permissions, user & group ownerships and timestamps
-z : compress file data
-h : human-readable, output numbers in a human-readable format (e.g. 1.2M)
```

### Mirror a remote folder with local
```
rsync -avzh  --delete 10.117.137.70:/opt/sensu/embedded/bin/ ./bin/
```
