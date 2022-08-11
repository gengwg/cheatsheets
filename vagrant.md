Vagrant is a tool to “Create and configure lightweight, reproducible, and portable development environments.”

### install both virtualbox and extension pack

https://www.virtualbox.org/wiki/Downloads

On mac:

```
brew install --cask virtualbox
brew install --cask virtualbox-extension-pack
```

### install vagrant

https://www.vagrantup.com/downloads.html

On mac:

```
brew install vagrant --cask

# test
vagrant init hashicorp/bionic64
vagrant up 
vagrant ssh
```

### list running vms

```
vagrant status
```

### Saving an existing Vagrant box

```
vagrant package --output ubuntu22godocker.box
```

### ssh into a guest using NAT in VirtualBox

In VM Network panel, click on advanced, click on Port Forwarding button. In there set up a rule:

```
Host IP: 127.0.0.1
Host Port: 2222
Guest IP: 10.0.2.15
Guest Port: 22
```

Then enable ssh in the guest, and connect from the host using:

```
$ ssh -p 2222 training@127.0.0.1
```

### use centos 7 box from hashicorp

```
vagrant init centos/7; vagrant up --provider virtualbox
```

### Mac install virtualbox errors

```
$ brew cask install virtualbox
Updating Homebrew...
==> Auto-updated Homebrew!
Updated 1 tap (homebrew/core).
==> Updated Formulae
qtkeychain

==> Caveats
To install and/or use virtualbox you may need to enable its kernel extension in:
  System Preferences → Security & Privacy → General
For more information refer to vendor documentation or this Apple Technical Note:
  https://developer.apple.com/library/content/technotes/tn2459/_index.html

==> Downloading https://download.virtualbox.org/virtualbox/6.1.0/VirtualBox-6.1.0-135406-OSX.dmg
Already downloaded: /Users/gengwg/Library/Caches/Homebrew/downloads/d3700155a9ac5d3c28f736aebc70a1873313b30092a2213fd5dd48212e19ce08--VirtualBox-6.1.0-135406-OSX.dmg
==> Verifying SHA-256 checksum for Cask 'virtualbox'.
==> Installing Cask virtualbox
==> Running installer for virtualbox; your password may be necessary.
==> Package installers may write to any location; options such as --appdir are ignored.
installer: Package name is Oracle VM VirtualBox
installer: choices changes file '/var/folders/mt/zprv4tyn11s_crshd4n7s1000000gn/T/choices20191227-4488-45uibc.xml' applied
installer: Upgrading at base path /
installer: The upgrade failed. (The Installer encountered an error that caused the installation to fail. Contact the software manufacturer for assistance. An error occurred while running scripts from the package “VirtualBox.pkg”.)
==> Purging files for version 6.1.0,135406 of Cask virtualbox
Error: Failure while executing; `/usr/bin/sudo -E -- /usr/bin/env LOGNAME=gengwg USER=gengwg USERNAME=gengwg /usr/sbin/installer -pkg /usr/local/Caskroom/virtualbox/6.1.0,135406/VirtualBox.pkg -target / -applyChoiceChangesXML /var/folders/mt/zprv4tyn11s_crshd4n7s1000000gn/T/choices20191227-4488-45uibc.xml` exited with 1. Here's the output:
installer: Package name is Oracle VM VirtualBox
installer: choices changes file '/var/folders/mt/zprv4tyn11s_crshd4n7s1000000gn/T/choices20191227-4488-45uibc.xml' applied
installer: Upgrading at base path /
installer: The upgrade failed. (The Installer encountered an error that caused the installation to fail. Contact the software manufacturer for assistance. An error occurred while running scripts from the package “VirtualBox.pkg”.)
Follow the instructions here:
  https://github.com/Homebrew/homebrew-cask#reporting-bugs
/usr/local/Homebrew/Library/Homebrew/system_command.rb:176:in `assert_success!'
/usr/local/Homebrew/Library/Homebrew/system_command.rb:53:in `run!'
/usr/local/Homebrew/Library/Homebrew/system_command.rb:29:in `run'
/usr/local/Homebrew/Library/Homebrew/system_command.rb:33:in `run!'
/usr/local/Homebrew/Library/Homebrew/cask/artifact/pkg.rb:59:in `block in run_installer'
/usr/local/Homebrew/Library/Homebrew/cask/artifact/pkg.rb:70:in `block in with_choices_file'
/usr/local/Homebrew/Library/Homebrew/vendor/portable-ruby/2.6.3/lib/ruby/2.6.0/tempfile.rb:295:in `open'
/usr/local/Homebrew/Library/Homebrew/cask/artifact/pkg.rb:67:in `with_choices_file'
/usr/local/Homebrew/Library/Homebrew/cask/artifact/pkg.rb:52:in `run_installer'
/usr/local/Homebrew/Library/Homebrew/cask/artifact/pkg.rb:34:in `install_phase'
/usr/local/Homebrew/Library/Homebrew/cask/installer.rb:218:in `block in install_artifacts'
/usr/local/Homebrew/Library/Homebrew/vendor/portable-ruby/2.6.3/lib/ruby/2.6.0/set.rb:777:in `each'
/usr/local/Homebrew/Library/Homebrew/vendor/portable-ruby/2.6.3/lib/ruby/2.6.0/set.rb:777:in `each'
/usr/local/Homebrew/Library/Homebrew/cask/installer.rb:209:in `install_artifacts'
/usr/local/Homebrew/Library/Homebrew/cask/installer.rb:101:in `install'
/usr/local/Homebrew/Library/Homebrew/cask/cmd/install.rb:22:in `block in run'
/usr/local/Homebrew/Library/Homebrew/cask/cmd/install.rb:16:in `each'
/usr/local/Homebrew/Library/Homebrew/cask/cmd/install.rb:16:in `run'
/usr/local/Homebrew/Library/Homebrew/cask/cmd/abstract_command.rb:36:in `run'
/usr/local/Homebrew/Library/Homebrew/cask/cmd.rb:92:in `run_command'
/usr/local/Homebrew/Library/Homebrew/cask/cmd.rb:158:in `run'
/usr/local/Homebrew/Library/Homebrew/cask/cmd.rb:123:in `run'
/usr/local/Homebrew/Library/Homebrew/cmd/cask.rb:9:in `cask'
/usr/local/Homebrew/Library/Homebrew/brew.rb:102:in `<main>'
```
Go to: System Preferences → Security & Privacy → General . 
Click on 'lock to make changes' and allow Oracle.

![general](Screenshot_2019-12-27_20.16.47.png)

Then run again:

```
$ brew cask install virtualbox
==> Caveats
To install and/or use virtualbox you may need to enable its kernel extension in:
  System Preferences → Security & Privacy → General
For more information refer to vendor documentation or this Apple Technical Note:
  https://developer.apple.com/library/content/technotes/tn2459/_index.html

==> Downloading https://download.virtualbox.org/virtualbox/6.1.0/VirtualBox-6.1.0-135406-OSX.dmg
Already downloaded: /Users/gengwg/Library/Caches/Homebrew/downloads/d3700155a9ac5d3c28f736aebc70a1873313b30092a2213fd5dd48212e19ce08--VirtualBox-6.1.0-135406-OSX.dmg
==> Verifying SHA-256 checksum for Cask 'virtualbox'.
==> Installing Cask virtualbox
==> Running installer for virtualbox; your password may be necessary.
==> Package installers may write to any location; options such as --appdir are ignored.
installer: Package name is Oracle VM VirtualBox
installer: choices changes file '/var/folders/mt/zprv4tyn11s_crshd4n7s1000000gn/T/choices20191227-5893-guuzq7.xml' applied
installer: Upgrading at base path /
installer: The upgrade was successful.
==> Changing ownership of paths required by virtualbox; your password may be necessary
🍺  virtualbox was successfully installed!
```

```
$ vagrant up
The provider 'virtualbox' that was requested to back the machine
'default' is reporting that it isn't usable on this system. The
reason is shown below:

Vagrant has detected that you have a version of VirtualBox installed
that is not supported by this version of Vagrant. Please install one of
the supported versions listed below to use Vagrant:

4.0, 4.1, 4.2, 4.3, 5.0, 5.1, 5.2, 6.0

A Vagrant update may also be available that adds support for the version
you specified. Please check www.vagrantup.com/downloads.html to download
the latest version.
```

===>

For Mac users, `brew cask install virtualbox` recently changed to install Virtualbox 6.1 . If you still want to install Virtualbox 6.0 with homebrew for use with Vagrant, use the following command to install the most recent formula that still installed 6.0:

```
brew cask uninstall virtualbox
brew cask install https://raw.githubusercontent.com/Homebrew/homebrew-cask/7e703e0466a463fe26ab4e253e28baa9c20d5f36/Casks/virtualbox.rb
```

Or download older version and install here:

https://www.virtualbox.org/wiki/Download_Old_Builds_6_0

This is due to Vagrant 2.2.6 doesn't work with VirtualBox 6.1.0 yet. Hopefully future release of Vagrant will fix this.

https://github.com/hashicorp/vagrant/issues/11249

## Misc

```bash
There are errors in the configuration of this machine. Please fix
the following errors and try again:

Vagrant:
* Unknown configuration section 'hostmanager'.

===>
vgeng@vgeng:/projects/puppet_foreman/mz_twemproxy$ vagrant plugin install vagrant-hostmanager

The SSH command responded with a non-zero exit status. Vagrant
assumes that this means the command failed. The output for this command
should be in the log above. Please read the output to determine what
went wrong.
===>
vagrant halt 
vagrant up
twice...
Seems only able to provision centos7 well for now.

vgeng@vgeng:/projects/puppet_foreman/mz_twemproxy$ vagrant ssh
This command requires a specific VM name to target in a multi-VM environment.
===>
vgeng@vgeng:/projects/puppet_foreman/mz_twemproxy$ vagrant ssh centos7

------------------
vagrant destroy -f
yeah, if you rename the vm
it might not destory 
-----------------------------
==> foreman-centos: Error: Evaluation Error: Error while evaluating a Function Call, Could not find class ::mz_yum for foreman-centos.vagrant.local at /tmp/vagrant-puppet/manifests-cc5378cfa08822ef3c3537e75c93247c/init.pp:6:1 on node foreman-centos.vagrant.local
==> foreman-centos: Error: Evaluation Error: Error while evaluating a Function Call, Could not find class ::mz_yum for foreman-centos.vagrant.local at /tmp/vagrant-puppet/manifests-cc5378cfa08822ef3c3537e75c93247c/init.pp:6:1 on node foreman-centos.vagrant.local
===>
In Vagrantfile, add:
 30     puppet.module_path = "spec/fixtures/modules/"

-------
Providers, such as VirtualBox, VMWare, Amazon AWS, and Digital Ocean, are the services where your virtual environment will be created and hosted. 
Provisioners are tools that allow you to quickly configure your server to your exact requirements. The two most common provisioners used with Vagrant are Puppet and Chef.
-------
vgeng@vgeng:~/vagrant/mzbox$ vagrant init mzcentos7 http://boxes.addsrv.com/centos71-mz-puppet3.8.1-1.0.18.box
vgeng@vgeng:~/vagrant/mzbox$ vagrant up
------------------
8/19/15

Host key verification failed.
fatal: The remote end hung up unexpectedly
===>
[vagrant@localhost ~]$ sudo cat /root/.ssh/config
Host gitlab.addsrv.com
  StrictHostKeyChecking no

The SSH key of the git server is not known/trusted. When you clone the repo manually on the VM, you get a prompt asking to verify the fingerprint, right?

You can either skip the host key verification in ~/.ssh/config (or globally in /etc/ssh/config or alike):

Host git.example.com
  StrictHostKeyChecking no
Or you can add the key in advance to ~/.ssh/known_hosts (or /etc/ssh/ssh_known_hosts). For example:

ssh-keyscan -H git.example.com >> ~/.ssh/known_hosts
-------------
vgeng@vgeng:~/vagrant/test$ vim Vagrantfile
vgeng@vgeng:~/vagrant/test$ vagrant reload

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.synced_folder "../", "/vagrant_data"

VBoxManage list runningvms

# rebox a current box
vgeng@vgeng:~/vagrant/rebox$ vagrant package --output ubuntu1204-puppet3.8.2-1.0.18.box

# box a vbox vm
vagrant package --base SPECIFIC_NAME_FOR_VM --output /yourfolder/OUTPUT_BOX_NAME.box

# upload box to repo server
root@repo-1-001:/repodata/repo/boxes/public# wget https://googledrive.com/host/0ByvYVln9b5A-flBKNTRUcnNhN1F1ZHBFY25YWm90Qm1vNzFDXzhFckNjdkxpTjVCRzVWWDA/ubuntu1204-puppet3.8.2-1.0.18.box

# boxes location
vgeng@vgeng:~$ ls .vagrant.d/boxes/
vgeng@vgeng:~$ ls .vagrant.d/boxes/http\:-VAGRANTSLASH--VAGRANTSLASH-boxes.addsrv.com-VAGRANTSLASH-centos71-mz-puppet3.8.1-1.0.18.box/0/virtualbox/
Vagrantfile         box.ovf             centos71-disk1.vmdk metadata.json
--------------------------
Vagrant experienced a version conflict with some installed plugins!
This usually happens if you recently upgraded Vagrant. As part of the
upgrade process, some existing plugins are no longer compatible with
this version of Vagrant. The recommended way to fix this is to remove
your existing plugins and reinstall them one-by-one. To remove all
plugins:

    rm -r ~/.vagrant.d/plugins.json ~/.vagrant.d/gems

Note if you have an alternate VAGRANT_HOME environmental variable
set, the folders above will be in that directory rather than your
user's home directory.

The error message is shown below:

Bundler could not find compatible versions for gem "bundler":
  In Gemfile:
    vagrant (= 1.7.4) ruby depends on
      bundler (<= 1.10.5, >= 1.5.2) ruby

  Current Bundler version:
    bundler (1.10.6)
This Gemfile requires a different version of Bundler.
Perhaps you need to update Bundler by running `gem install bundler`?
Could not find gem 'bundler (<= 1.10.5, >= 1.5.2) ruby', which is required by gem 'vagrant (= 1.7.4) ruby', in any of the sources.
====>
vgeng@vgeng:~$ which vagrant
/Users/vgeng/.rvm/gems/ruby-2.1.1/bin/vagrant
vgeng@vgeng:~$ gem uninstall vagrant
vgeng@vgeng:~$ gem uninstall vagrant-wrapper
---------------
# to use hiera in vagrant

vgeng@vgeng:/projects/puppet_foreman/mz_php$ cat .vagrant_puppet/init.pp
# Exec['/usr/bin/apt-get update || true'] -> Package <| |>
# Exec {
#   path => '/usr/bin:/usr/sbin:/bin'
# }

hiera_include('classes')
-------------------------------
# use local box 
vgeng@vgeng:~/vagrant/localbox$ vagrant init testbox file:///Users/vgeng/package.box

http://download.virtualbox.org/virtualbox/5.0.6/Oracle_VM_VirtualBox_Extension_Pack-5.0.6.vbox-extpack

# run command in box
vgeng@vgeng:~/pos_dev$ vagrant ssh -c 'echo hello'
hello

# Running Ansible Manually

# Here is an example using the Vagrant global insecure key (config.ssh.insert_key must be set to false in your Vagrantfile):
vgeng@vgeng:~/vagrant/ansible$ ansible-playbook --private-key=~/.vagrant.d/insecure_private_key -u vagrant -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory simple.yml

vgeng@vgeng:~/vagrant/ansible$ ansible-playbook --private-key=.vagrant/machines/default/virtualbox/private_key -u vagrant -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory simple.yml
----------
    default: Warning: Authentication failure. Retrying...
    default: Warning: Authentication failure. Retrying...
Timed out while waiting for the machine to boot. This means that
Vagrant was unable to communicate with the guest machine within
the configured ("config.vm.boot_timeout" value) time period.
===>
For anybody else who could benefit, the location to manually patch on Mac is /opt/vagrant/embedded/gems/gems/vagrant-1.8.5/plugins/guests/linux/cap/public_key.rb.
@@ -54,6 +54,7 @@
             if test -f ~/.ssh/authorized_keys; then
               grep -v -x -f '#{remote_path}' ~/.ssh/authorized_keys > ~/.ssh/authorized_keys.tmp
               mv ~/.ssh/authorized_keys.tmp ~/.ssh/authorized_keys
+              chmod 0600 ~/.ssh/authorized_keys
             fi

             rm -f '#{remote_path}'
--------------------

# Copy files to a Vagrant VM via SCP.
vagrant plugin install vagrant-scp
vagrant scp <some_local_file_or_dir> <somewhere_on_the_vm>

#  To make folders sync in two-way add explicit definition in Vagrantfile:
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

# public (bridged) network
  config.vm.network "public_network"
# static ip
  config.vm.network "public_network", ip: "172.29.233.133"  # do a nmap or ping to make sure ip is not used
# usage example
$ redis-cli -h 172.29.233.133 -p 7479 -c cluster nodes

# private network. only accessible from host.
  config.vm.network "private_network", ip: "192.168.33.10"
# usage example
$ redis-cli -h 192.168.33.10 -p 7479 -c cluster nodes

=================
Vagrant was unable to mount VirtualBox shared folders. This is usually
because the filesystem "vboxsf" is not available. This filesystem is
made available via the VirtualBox Guest Additions and kernel module.
Please verify that these guest additions are properly installed in the
guest. This is not a bug in Vagrant and is usually caused by a faulty
Vagrant box. For context, the command attemped was:

set -e
mount -t vboxsf -o uid=`id -u vagrant`,gid=`getent group vagrant | cut -d: -f3` vagrant /vagrant
mount -t vboxsf -o uid=`id -u vagrant`,gid=`id -g vagrant` vagrant /vagrant

The error output from the command was:

/sbin/mount.vboxsf: mounting failed with the error: No such device
===>
$ vagrant plugin install vagrant-vbguest

Then saw error in the box:
/tmp/vbox.0/Makefile.include.header:112: *** Error: unable to find the sources of your current Linux kernel. Specify KERN_DIR=<directory> and run Make again. Stop.

This seems due to vagrant box need update.

vagrant box update
Fixed the issue.

ref:
https://github.com/aidanns/vagrant-reload/issues/4
======================================================
```
