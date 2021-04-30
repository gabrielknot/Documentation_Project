 
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

------------------
#### Requiriments
***
- [Docker](https://docs.docker.com/engine/install/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
-----------
### To run it follow:
There is too ways to run it:
#### Manual Instalation: 

1. Clone the repository:
```!#/bin/bash
$ git clone https://github.com/gabrielknot/K8sProject
```

2. Get into the repository directory:
```!#/bin/bash
$ cd K8sProject/kind
```
3. Create a cluster with kind config. file: kind-config.yaml.
```!#/bin/bash
$ kind create cluster --config kind-config.yaml
```
4. Apply the flannel pod-network: 
```!#/bin/bash
$ kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```
##### Metallb Setup:
5. Create the metallb namespace: 
```!#/bin/bash
$ kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/namespace.yaml
```
6. Create the memberlist secrets:
```!#/bin/bash
$ kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" 
```
7. Apply metallb manifest
```!#/bin/bash
$ kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/metallb.yaml
```
8. Wait for metallb pods to have a status of Running:
```!#/bin/bash
$ kubectl get pods -n metallb-system --watch
```
9. Setup address pool used by loadbalancers
----------
To complete layer2 configuration, we need to provide metallb a range of IP addresses it controls. We want this range to be on the docker kindnetwork.
```!#/bin/bash
$ echo "      -  $( docker network inspect -f '{{.IPAM.Config}}' kind | sed 's/[^0-9]*//'  | awk '{print $1}' | sed 's/\.0/\.255/' | sed 's/\.0/\.200/' | sed 's/\/.*//g' )-$( docker network inspect -f '{{.IPAM.Config}}' kind | sed 's/[^0-9]*//'  | awk '{print $1}' | sed 's/\.0/\.255/' | sed 's/\.0/\.250/' | sed 's/\/.*//g' )" >> matallb-configmap.yaml
```
### Using Ansible

3.
```!#/bin/bash
$ kind create cluster --config kind-config.yaml
```
To run mysql contaner:
-----------
$ cd mysql-Docker && kubernetes-compose u
```
running in current terminal section.
or
-----------
```!#/bin/bash
$ cd nginx-Docker && kubernetes-compose up -d
```
running in background
Stop it following:
----------------------
```!#/bin/bash
$ kubernetes-compose down
```

-----------
```!#/bin/bash
$ cd nginx-Docker && kubernetes-compose down -v
```
removig the created data volume
> :warning: **-v flag means all your volume in the kubernetes will be lost**: Be very careful here!n
