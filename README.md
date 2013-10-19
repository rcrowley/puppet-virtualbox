Puppet VirtualBox
=================

Use this Puppet module on your Mac to install and upgrade VirtualBox, PXE boot VMs, manage port forwarding, and SSH conveniently to your local VMs.

PXE
---

The `vbox` commands Puppet installs in `/usr/local/bin` use VirtualBox's `tftp` server to PXE boot Ubuntu 12.04 from absolute scratch.

SSH
---

Puppet will also install an `ssh` wrapper in `/usr/local/bin` that forwards all options to `/usr/bin/ssh` but detects when you're trying to SSH to a VM and rewrites the hostname to allow it.

Usage
-----

First, you'll need a complete Puppet environment.

1. Make a directory for your Puppet environment.  (Mine's called `puppet-airbook` and I'll use that placeholder from now on.)

2. In `puppet-airbook/puppet.conf`, configure Puppet:

        [main]
            manage_internal_file_permissions = false
            manifest = manifests/site.pp
            modulepath = modules

3. In `puppet-airbook/manifests/site.pp`, include the `virtualbox` class:

        class { "virtualbox": }

4. In `puppet-airbook/modules`, clone `puppet-virtualbox` (either directly or as a submodule):

        git clone git://github.com/rcrowley/puppet-virtualbox.git

5. Run Puppet:

        puppet apply --config="puppet.conf" --verbose "manifests/site.pp"

Once Puppet has run, you have the `vbox` and wrapped `ssh` commands available:

<pre><code>vbox up "<em>name</em>"</code></pre>

<pre><code>ssh -l"root" "<em>name</em>"</code></pre>

Further provisioning within the VM, say with Puppet, is an exercise left to the reader.
