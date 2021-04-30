 
8s Chronos Example
===========================

Welcome to the Kubernetes Universe!
-----------
This is a kubernetes cloud evironmet power example.

Each of these two directories contains a kubernetes-compose.yml file, which means, all you have to do is compose it up following the steps:

The kubernetes 
----------------------
----------------------
The kubernetes is a container orchestrator. Wich means you can autoscale your aplications based on the ressoussement mangaemant power, cloud and the cluster computing to increase the clkoud computing power and server infrastructure managment. 

The Kind
-------------
-------------
To simulate the cloud ambient with several machines and use the container power to dinamicaly manage our machine ressource we use kind. This application ca simulate a Kubernetes cluster using docker containers so using it we can focus on the cluster function wich means con6tainer ochestratiuon.

#### Pros
The kind is an easy way to simulate a Kubernees cluster. You can spend time just with your cluster deployments and services, without care about virtual machine (VM) ressources and his configurations. The kind suports too Control-plane HA multiple control plane-nodes.
#### contras
However the kind is just a development tool, you cant't deploy it in a real life service. 

You can use the kubeadm with the same configurations. This current setup will work in any bare-metal server, modifying only a thiny specific kind configuration parts.
You may have to check the [Kubernetes Documentation](https://kubernetes.io/pt-br/docs/home/).

Instalation
------------
------------
#### kind install
The kind can be intalled following [kind Documentation](https://kind.sigs.k8s.io/docs/user/quick-start/). 

### Requiriments
***
- [Docker](https://docs.docker.com/engine/install/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
------------------
### To run it follow:
There is too ways to run it:
### Manualy. 

1.
```console
$ git clone https://github.com/gabrielknot/K8sProject
```

2.
```console
$ cd K8sProject/kind
```
3.
```console
$ kind create cluster --config kind-config.yaml
```
4.
```console
$ kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```
5.
```console
$ kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/namespace.yaml
```
6.
```console
$ kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/metallb.yaml
```
7.
```console
$ kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/namespace.yaml
```
8.
```console
$ kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/metallb.yaml
```

### Using Ansible

3.
```console
$ kind create cluster --config kind-config.yaml
```
To run mysql contaner:
-----------
$ cd mysql-Docker && kubernetes-compose u
```
running in current terminal section.
or
-----------
```console
$ cd nginx-Docker && kubernetes-compose up -d
```
running in background
Stop it following:
----------------------
```console
$ kubernetes-compose down
```

-----------
```console
$ cd nginx-Docker && kubernetes-compose down -v
```
removig the created data volume
> :warning: **-v flag means all your volume in the kubernetes will be lost**: Be very careful here!n
