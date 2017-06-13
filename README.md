# HSPC Reference Platform Installer #

Welcome to the HSPC Reference Platform Installer!  This installer will create a full SMART on FHIR platform including a 
  FHIR server, an OAuth server, and a SMART launch simulator.

## SMART Fork
![SMART Logo](smart-logo.png)
This is the SMART fork of the HPSC Reference Platform Installer.  This repository is a fork of the 
  [hspconsortium/installer](https://bitbucket.org/hspconsortium/installer).  The forked version is maintained on
  [bitbucket](https://bitbucket.org/isalus/installer-smart) in order to take advantage of the features Bitbucket provides
  for syncing between forked repositories.  The repository is mirrored to [github](https://github.com/isalussolutions/installer-smart)
  so as to be available along with the rest of the SMART artifacts, however **the github version of the repo should be 
  considered read-only**.
  
The mirroring between Bitbucket and GitHub happens automatically, triggered on each commit to `isalussolutions/installer-smart` and 
  utilizing Bitbucket Pipelines.


### Supported System Architectures
The SMART on FHIR platform will be installed on a single machine in one of the following layouts:

1. [VM Instance Install](#localvm) (ie: an Ubuntu server running on VirtualBox on a developer machine)
2. [Native Install](#nativeinstall) (ie: an Ubuntu server)

More advanced installations are possible by modifying this installer (mainly inventory.yml) but are not supported by our technical team.

### Supported Operating Systems
The SMART on FHIR platform is tested on Ubuntu 16.04.  Other linux-based systems may require different commands or packages.
* **Ubuntu 16.04** may be used as a platform server or controller machine
* **Mac OSx** may be used as a controller machine or VirtualBox host
* **Windows** may be used as a VirtualBox host for a native install

    *See [Windows Notes](#windowsnotes)*

### SMART on FHIR Platfrom
When complete, you will have a SMART on FHIR platform!

* `{host}:9080/` for the Sandbox Manager application
* `{host}:9071/api/smartdstu2/data` for a FHIR DSTU2 API server
* `{host}:9071/api/smartdstu2/data/metadata` for the FHIR DSTU2 API conformance
* `{host}:9060/auth/` for an OAuth2 authorization server
* `{host}:9093` for a SMART apps server
* `{host}:10389` for an ApacheDS LDAP server
* `{host}:3306` for a MySQL database

The two sample accounts are `demo/demo` and `admin/password`.
You can connect to the LDAP server on `localhost:10389`.

* *See [SMART on FHIR Platform Systems](#platformsystems)*

---

## <a name="localvm"/>VM Instance Install using VirtualBox

In this install, we are going to build the SMART on FHIR platform on a Ubuntu server running on VirtualBox.

### Prerequisites
* [VirtualBox 5.0.20](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant 1.8.1](https://www.vagrantup.com/downloads.html)
* [Ansible 2.1.0](http://docs.ansible.com/intro_installation.html)

If you have the *pip* Python package manager installed, the easiest way to install the
correct version of Ansible is to run the following:

```
sudo pip install ansible==2.1.0
```

### Prepare the host
```
vagrant plugin install vagrant-vbguest
git clone https://github.com/smart-on-fhir/installer
cd installer
```

Ansible installers use inventory files to manage variables that can change between environments (ex: test, prod).  For a Vagrant install, the variables that would normally exist in an inventory are located within the Vagrantfile in the **ansible.extra_vars** block.  Alter any of these values as your installation requires:

```
vi Vagrantfile
```

### Run the Installer
```
vagrant up
```

... wait ~20min while everything installs (depending on your Internet connection speed).

You can poke around the virtual machine by doing:

```
vagrant ssh
```

And when you're done you can shut the virtual machine down with:

```
vagrant halt
```

---

## <a name="nativeinstall"/>Native Install on Ubuntu 16.04

In this install, we are going to build a SMART on FHIR platform directly on an Ubuntu 16.04 server.

### Prerequisites
* Ubuntu 16.04 machine

### Prepare the server
From the Ubuntu 16.04 machine:
```
sudo apt-get update
sudo apt-get -y install curl git python-pycurl python-pip python-yaml python-paramiko python-jinja2
sudo pip install ansible==2.1.0
git clone https://github.com/smart-on-fhir/installer
cd installer/provisioning
```

Create an inventory file for your environment using the inventory_example.yml as a template:
```
cp inventory_example.yml inventory.yml
vi inventory.yml
```

* set "installer_user" to your ssh username
* set "services_host" to a real-world route-able IP for your Ubuntu machine
* setting passwords, ports, and other properties as desired

### Run the Installer
Make a "local" connection using the "localhost" inventory file:

```
sudo ansible-playbook -c local -i 'localhost,' -vvvv site.yml
```

---

## <a name="platformsystems"/>SMART on FHIR Platform Components

The SMART on FHIR platform consists of several open-source systems that together support the SMART on FHIR launch and security specification for apps.
These open-source systems are reference systems, meaning they have not been created with the intention of supporting production use cases "out of the box".
Please contact each of these open-source projects with further questions.

| Functional Role            | System Name              | More Information                                                     |
| -------------------------- | ------------------------ | -------------------------------------------------------------------- |
| DSTU2 FHIR Server          | HSPC Reference API       | https://bitbucket.org/hspconsortium/reference-api                    |
|                            | HAPI FHIR                | http://jamesagnew.github.io/hapi-fhir/                               |
| OAuth2 Server              | HSPC Reference Auth      | https://bitbucket.org/hspconsortium/reference-auth                   |
|                            | MITRE Open ID Connect    | https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server |
| SMART Launch Simulator     | HSPC Sandbox Manager     | https://bitbucket.org/hspconsortium/sandbox-manager                  |
| Cardiac Risk App           | Cardiac Risk App         | https://github.com/smart-on-fhir/cardiac-risk-app                    |
| BP Centiles App            | BP Centiles App          | https://github.com/smart-on-fhir/bp-centiles-app                     |
| Growth Chart App           | Growth Chart App         | https://github.com/smart-on-fhir/growth-chart-app                    |
| Sandbox Manager            | HSPC Sandbox Manager     | https://bitbucket.org/hspconsortium/sandbox-manager                  |
| User Management            | ApacheDS                 | http://directory.apache.org/apacheds                                 |
| Messaging Server           | HSPC Reference Messaging | https://bitbucket.org/hspconsortium/reference-messaging              |

---

## Tips and Tricks

### AWS Test Configuration

Here is the exact configuration we use to test the installer using an AWS EC2 instance.  The ports must all be open for inbound connections in the security group.

| Item          | Value                   |
| ------------- | -----------------------:|
| Instance Type | t2.large                |
| AIM           | Ubuntu Server 16.04 LTS |
| SSH PORT      | 22                      |
| HTTP PORT     | 80                      |
| HTTPS PORT    | 443                     |
| LDAP PORT     | 10389                   |
| APPS PORTS    | 9070-9099               |

Here is the inventory.yml file:
```
installer_user: "ubuntu"
services_host: "x.x.x.x" (your IP address)
sample_patients_branch: "hapi-patients-testing"
apps_server_external_host: "{{services_host}}"
api_dstu2_server_host: "{{services_host}}"
persona_api_dstu2_server_host: "{{services_host}}"
sandman_server_external_host: "{{services_host}}"
auth_server_host: "{{services_host}}"
persona_auth_server_host: "{{services_host}}"
messaging_server_host: "{{services_host}}"
```

Here are the commands we run:
```
sudo apt-get update
sudo apt-get -y install curl git python-pycurl python-pip python-yaml python-paramiko python-jinja2
sudo pip install ansible==2.1.0
git clone https://github.com/smart-on-fhir/installer
cd installer/provisioning
vi inventory.yml
... (see above)
sudo ansible-playbook -c local -i 'localhost,' -vvvv site.yml
...
(about 20 minutes later...)
PLAY RECAP *********************************************************************
localhost                  : ok=216  changed=167  unreachable=0    failed=0

ubuntu:~/installer/provisioning$
```

Then launch the Sandbox Manager app at:
```
http://(your IP address):9080/
```

### TLS

By default, the install process will not enable TLS. To enable TLS for specific services, you can set the following variable:

* `use_secure_http: true`

What certificates will be used? You have two options:

1. Set `use_custom_ssl_certificates: true` and `custom_ssl_certificate_path: /path/to/cert/dir`. For an example, see our [testing server settings](provisioning/ci-server.yml#L5). And for an example of what the directory layout should look like, [see here](provisioning/examples/certificates).

2. If you set `use_custom_ssl_certificates: false`, the installer will generate self-signed SSL certificates.
Please note that with self-signed certificates, you will get a number of trust warning in your
web browser that can be resolved by adding certificate exceptions in your browser, or updating your CA list on
a client by client basis. Before you even try the apps, you should probably load the
API server and add the self-signed certificate to your browser's security exceptions.

### Sample data
By default, the server will load data for only 20 sample patients. To automatically load the entire set of ~60 samples patients, you can update your `inventory` to increase this limit:

* `api_dstu2_sample_patients_limit: 100`

### Log Files
The installer creates servers that log to the journal.  You can view the journal logs using this command:

* sudo journalctl -u api-dstu2-server.service
* sudo journalctl -u auth-server.service

Use the -f option tail the logs.

### Aliases
The installer creates several aliases that can be used to help you manage and navigate the sandbox system.

You can see the aliases by typing "alias" from the command prompt.  The aliases are defined in the ~/.bash_profile file.

```
ubuntu$ alias
```

These aliases are helpful to navigate the most important folders.
```
alias f='cd $hosting_user_home'
alias i='cd $installer_project_home'
alias n='cd $NGINX_SITES'
alias p='cd $PROVISIONING_HOME'
alias s='cd $SERVICE_HOME'
```

These aliases are helpful for starting services.
```
alias startn='sudo service nginx start'
alias stopn='sudo service nginx stop'
```

These aliases are helpful for viewing (ex: v...) or tailing (ex: t...) different service logs.
```
alias tapi='sudo journalctl -f -u api-dstu2-server.service'
alias tapip='sudo journalctl -f -u persona-api-dstu2-server.service'
alias tauth='sudo journalctl -f -u auth-server.service'
alias tauthp='sudo journalctl -f -u persona-auth-server.service'
alias tldap='sudo journalctl -f -u apacheds-server.service'
alias tmsg='sudo journalctl -f -u messaging-server.service'
alias tpwm='sudo journalctl -f -u pwm-server.service'
alias tsand='sudo journalctl -f -u sandbox-manager-server.service'
alias v='sudo ansible-playbook  -c local -i localhost, -vvvv site.yml --tags "verify"'
alias vapi='sudo journalctl -u api-dstu2-server.service'
alias vapip='sudo journalctl -u persona-api-dstu2-server.service'
alias vauth='sudo journalctl -u auth-server.service'
alias vauthp='sudo journalctl -u persona-auth-server.service'
alias vldap='sudo journalctl -u apacheds-server.service'
alias vmsg='sudo journalctl -u messaging-server.service'
alias vpwm='sudo journalctl -u pwm-server.service'
alias vsand='sudo journalctl -u sandbox-manager-server.service'
```

### <a name="windowsnotes"/>Windows Notes
* Windows Note: Ansible is not supported on Windows. If you want to build a SMART on FHIR VM on Windows, you should
create a VM instance for Ubuntu 16.04 and perform a
please use the version of the installer which runs Ansible on the guest machine instead of using the one on the host OS. To enable this mode, please edit `Vagrantfile` by commenting out the "ansible" provisioner and enabling second "shell" provisioner before running `vagrant up`. An alternative options is to follow the
instructions in the "Building SMART-on-FHIR on fresh Ubuntu 16.04 machine (without Vagrant)" section in this document.

* Windows Note: The default installation of GIT on Windows enables a LF to CRLF conversion
upon checkout which is going to mess up the install. You will need to make sure that this
conversion is disabled by running:

    ```git config --global core.autocrlf false```