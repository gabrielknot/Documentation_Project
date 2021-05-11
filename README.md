 
Aplicacao dos conhecimentos adquiridos/ Projeto DevOps
===========================

Bem vimdo ao mundo DevOps!
-----------
Esse e um projeto exemplo, onde sao aplicadas algumas das ferramentas utilizadas por um engenheiro DevOps, na sua principal funcao, que e responsabilizar-se pelo  versionamento, entrega e infraestrutura de aplicoes.

O Ansible
----------------------
----------------------
O ansible e uma aplicacao de continous delivery. Ele e responsavel por automatizar processos na construcao da infraestrutura. Em uma grande aplicacao orientada a microsservico existem uma serie de dependencias que precisam ser instaladas e configuradas antes que a aplicacao seja executada. O que se torna extremamente lento, pricipalmente, se voce precisa configurar varias maquinas que compoem um cluster, ou ainda se precisa faze-lo sempre que alguem faz uma atualizacao no repositorio do codigo.

O kubernetes 
----------------------
----------------------
O kubernetes e a "estrela", ele e responsavel por orquestrar os containrers de uma aplicacao orientada a microsservico. Sua principal caracteristica que possibilita um alto grau de escalabilidade ja que por padrao o kubernetes gerencia esses containers dentro de um cluster, o que e muito importante para que em caso de uma grande aplicacao comecar a "pesar" dentro de dois oumais computadores o engenheiro e capaz de alocar mais recurssos ao cluster, simplesmente adicionando um computador (chamado de node) a este mesmo cluster. Alem disso o kubernetes possui uma serie de outras ferramentas satelites como grafana e prometheus, que possibilitam um monitoramento profundo da "saude" do cluster.
## Funcionamento

O kubernetes e uma especie de api, onde cada arquivo de manifesto descreve uma caracteristica do seu cluster, tais como a quantidadde de rplicas a versao, dentre outros
### Pods
Os pods sao uma abstracao do kubernetes que representa um grupo de no minimo um e no maximo (por padrao) dois containers, compoem a menor parte do cluster:
![img](https://d33wubrfki0l68.cloudfront.net/fe03f68d8ede9815184852ca2a4fd30325e5d15a/98064/docs/tutorials/kubernetes-basics/public/images/module_03_pods.svg)
### Deployment

O deployment funciona e um tipo de 
### 
O Kind
-------------
-------------
O kind e uma distribuicao kubernetes focada em ambientes de desenvolvimento e aprendizado. Ele simula o comportamento de cluster a patir de containres docker, onde cada container representa uma maquina do cluster.

#### Pros
O kind e uma das ferramentas de desenvolvimento e aprendizado completa. Simula como um cluster se comporta em na maioria dos cenarios. Por exemplo em uma ferramentta de desenvolvimento que nao possui suporte a varios nos, o comportamento da aplicacao em ambiente de producao pode ser completamente diferente de um ambiante de producao, por que dentro de um cluster, podem haver pods setados com mais "afinidade" a um node do que a outro, por recursos alocados e ou recuros exclusivos daquele node, como mior capacidade de processamento de video por ex.

#### contras
O kind pode simular relativamente bem um ambiente produtivo, entretando, ele e unicamente recomenmdado a ambientes de desenvolvimento. por usar containers docker para simular um cluster, ele roda sobre a "placa de rede" virtual do docker, sendo assim herda suas limitacoes.

Instalation
------------
------------
#### requisitos e suas instrucoes de instalacao:
***
- [Git](https://docs.docker.com/engine/install/)
- [Git](https://docs.docker.com/engine/install/)
-----------
### Antes de instalar siga os seguintes passos para baixar a aplicacao:


1. Clone the repository:
```!#/bin/bash
$ git clone https://github.com/gabrielknot/K8sProject
```

2. Get into the repository directory:
```!#/bin/bash
$ cd K8sProject/leaning_ansible
```
3. Como mencionado antes o ansible e uma ferramenta de continous delivery e automatiza os processos da construcao da infraestrutura portanto basta substiuir a label \<server-ip-adress> dentro do arquivo "inventory" pelo ip de seu servidor e rodar o seguite comando:

```!#/bin/bash
$ cd K8sProject/leaning_ansible && ansible-playbook kubernetes-setup/master-playbook.yaml -u '\<usuario da maquina cujo ip foi com acesso administrativo>' -p '<senha desse usuario>'
```
----------
To complete layer2 configuration, we need to provide metallb a range of IP addresses it controls. We want this range to be on the docker kindnetwork.
```!#/bin/bash
$ echo "      -  $( docker network inspect -f '{{.IPAM.Config}}' kind | sed 's/[^0-9]*//'  | awk '{print $1}' | sed 's/\.0/\.255/' | sed 's/\.0/\.200/' | sed 's/\/.*//g' )-$( docker network inspect -f '{{.IPAM.Config}}' kind | sed 's/[^0-9]*//'  | awk '{print $1}' | sed 's/\.0/\.255/' | sed 's/\.0/\.250/' | sed 's/\/.*//g' )" >> metallb/metallb-configmap.yaml
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
