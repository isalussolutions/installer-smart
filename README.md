# HSPC Reference Platform Installer #

Welcome to the HSPC Reference Platform Installer!

## SMART Version
This is the SMART version of the HPSC Reference Platform Installer.  This repository is a fork of the 
  [hspconsortium/installer](https://bitbucket.org/hspconsortium/installer).  The forked version is maintained on
  [bitbucket](https://bitbucket.org/isalus/installer-smart) in order to take advantage of the features Bitbucket provides
  for syncing between forked repositories.  The repository is mirrored to [github](https://github.com/isalussolutions/installer-smart)
  so as to be available along with the rest of the SMART artifacts, however **the github version of the repo should be 
  considered read-only**.
  
The mirroring between Bitbucket and GitHub happens automatically, triggered on each commit to `isalussolutions/installer-smart` and 
  utilizing Bitbucket Pipelines.


## Destination Environment

Systems will be installed in the target environment by the HSPC Installer (localhost, vm, hspc-test, hspc-prod, etc) follows

### Host Machine Setup

`````
sudo apt-get update && \
sudo apt-get -y install curl git python-pycurl python-pip python-yaml python-paramiko python-jinja2 && \
sudo pip install ansible==2.1.0 && \
sudo pip install --upgrade pip
````

### Port Assignments
| System        | Internal Port | External Port |
| ------------- | -------------:| -------------:|
| MySQL         |          3306 |          3306 |
| Auth          |          8060 |          9060 |
| Account       |          8065 |          9065 |
| API DSTU2     |          8071 |          9071 |
| API STU3 V2   |          8072 |          9072 |
| API STU3 V3   |          8073 |          9073 |
| API STU3      |          8074 |          9074 |
| Sandbox Mgr   |          8080 |          9080 |
| Gallery       |          8085 |          9085 |
| Bili Risk Cht |          8086 |          9086 |
| Bili Monitor  |          8087 |          9087 |
| Bili CDS Hks  |          8088 |          9088 |
| Messaging     |          8091 |          9091 |
| PWM           |          8092 |          9092 |
| Apps          |          8093 |          9093 |
| Patient Pckr  |          8096 |          9096 |