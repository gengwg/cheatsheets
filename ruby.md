### Install Ruby 2.4.0 on CentOS 6

#### Step 1. Installing Requirements

```
# yum install gcc-c++ patch readline readline-devel zlib zlib-devel
# yum install libyaml-devel libffi-devel openssl-devel make
# yum install bzip2 autoconf automake libtool bison iconv-devel sqlite-devel
```

#### Step 2. Install RVM
```
# curl -sSL https://rvm.io/mpapis.asc | gpg --import -
# curl -L get.rvm.io | bash -s stable

# source /etc/profile.d/rvm.sh
# rvm reload
```

#### Step 3. Verify Dependencies

```
# rvm requirements run
```

#### Step 4. Install Ruby 2.4

```
# rvm install 2.4.0
```

#### Step 5. Setup Default Ruby Version

```
# rvm list
# rvm use 2.4.0 --default
# ruby --version
```

