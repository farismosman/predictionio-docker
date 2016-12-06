# README #

This repository contains the scripts needed to create a docker image with the universal recommendation engine. To run the docker container locally, the steps bellow are followed to get docker running (in ubuntu behind proxy):

### Setting up docker locally ###

* [Install docker](https://docs.docker.com/engine/installation/linux/ubuntulinux/)
* To be able to run docker daemon with being a superuser (optional), you need to run the following command

```
#!shell

sudo usermod -aG docker *your username*
```
then logout and login again into the system or restart the system. Test by running


```
#!shell

docker version
```
[more details can be found here](https://docs.docker.com/engine/installation/linux/ubuntulinux/#create-a-docker-group).

* Configure docker to use proxy settings, add the following line to **/etc/default/docker**

```
#!shell

export http_proxy='http://*your proxy*:*port*'
export https_proxy='https://*your proxy*:*port*'
```
Restart the docker daemon and run

```
#!shell

docker run hello-world
```
If the proxy is configured properly you should see something like this

```
#!shell

Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
b901d36b6f2f: Pull complete
0a6ba66e537a: Pull complete
Digest: sha256:8be990ef2aeb16dbcb9271ddfe2610fa6658d13f6dfb8bc72074cc1ca36966a7
Status: Downloaded newer image for hello-world:latest
...................
```
On Ubuntu >= 15.04 the previous steps might not work since ubuntu uses **systemd** and it might not load the proxy settings on **/etc/default/docker**. To be able to configure the proxy, [follow the steps here](https://docs.docker.com/engine/admin/systemd/#http-proxy).

* By default docker uses google to resolve dns. This might not be permitted on our network and another dns server must be used instead. To find the ip address of the dns server used by you machine, run (ubuntu >= 15.04):

```
#!shell

nmcli device show <interfacename> | grep IP4.DNS
```

or

```
#!shell

nmcli dev list iface <interfacename> | grep IP4
```
for ubuntu < 15.04.
In older versions of ubuntu (< 15.04) the dns config lives in **/etc/default/docker** but that might not work in ubuntu >= 15.04 and steps similar to proxy settings have to be followed. [More details are given here.](http://nknu.net/how-to-configure-docker-on-ubuntu-15-04/)

To restart the docker daemon and check that it is running with all the relevant parameters, run:

```
#!shell

sudo systemctl daemon-reload && sudo systemctl restart docker && systemctl status docker
```

The output should indicate all the arguments passed to the docker server;


```
#!shell

● docker.service - Docker Application Container Engine
   Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
  Drop-In: /etc/systemd/system/docker.service.d
           └─http-proxy.conf, ubuntu.conf
   Active: active (running) since Mon 2016-08-22 10:32:15 SAST; 27ms ago
     Docs: https://docs.docker.com
 Main PID: 25476 (dockerd)
   Memory: 1.3G
      CPU: 176ms
   CGroup: /system.slice/docker.service
           ├─25476 /usr/bin/dockerd -H fd:// --dns *.*.*.* --dns *.*.*.* --dns 8.8.8.8 --dns 8.8.4.4 --insecure-registry registry.domain.com:port
           └─25483 docker-containerd -l unix:///var/run/docker/libcontainerd/docker-containerd.sock --shim docker-containerd-shim --metrics-interval=0 --start-timeout 2m --state-dir /var/run/docker/lib
```
