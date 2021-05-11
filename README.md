 
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
### Abstracoes kubernetes:
#### Pods
Os pods sao uma abstracao do kubernetes que representa um grupo de no minimo um e no maximo (por padrao) dois containers, compoem a menor parte do cluster:
<img src="https://d33wubrfki0l68.cloudfront.net/fe03f68d8ede9815184852ca2a4fd30325e5d15a/98064/docs/tutorials/kubernetes-basics/public/images/module_03_pods.svg" width="900">
#### Nodes
Essa abstracao representa os membros do cluster, neste caso seus "workers" que sao partes componentes de qualquer cluster Kubernetes, nos nodes estao dispostos os pods como visto na imagem:
<img src="https://d33wubrfki0l68.cloudfront.net/5cb72d407cbe2755e581b6de757e0d81760d5b86/a9df9/docs/tutorials/kubernetes-basics/public/images/module_03_nodes.svg" width="700">
#### Deployment
O deployment representa, como a imagem abaixo descreve, a versao e a quantidade de pods, que estarao dispostos no cluster; sua versao e sua disposicao entre os diferentes pods de forma geral em casos de atualizacao da aplicacao:

<img src="https://storage.googleapis.com/cdn.thenewstack.io/media/2017/11/07751442-deployment.png" width="500">


#### Service
Nessa abstracao sao definidas as formas de comunicacao entre replicasets e uma rede, seja ela interna ou externa ao cluster. Funciona a partir de uma proxy interna do cluster com uma tabela de ips que compoem um determinado replicaset. Seus tipos sao:
##### ClusterIP
O ClusterIP cria uma interface de comunicacao interna do cluster expondo o replicaset somente dentro do cluster:

<img src="https://d33wubrfki0l68.cloudfront.net/e351b830334b8622a700a8da6568cb081c464a9b/13020/images/docs/services-userspace-overview.svg" width="500">

##### NodePort
O Service do tipo NodePort faz um port-forward (mapeaento de porta) de um ClusterIP dentro do cluster para o a partir de uma proxy no node master:

<img src="https://miro.medium.com/max/1700/1*I4j4xaaxsuchdvO66V3lAg.png" width="500">

##### LoadBalancer
O Service do tipo LoadBalancer e uma abstracao que designa um node para gerenciar os enderecamentos de cada acesso a um determinado pod, baseando-se na disponibilidade de recursos do node em que o mesmo esta insterido:

<img src="https://miro.medium.com/max/913/0*YxZrrdmKZ4Hw2s1c.png" width="500">

O Kind
-------------
-------------
O kind e uma distribuicao kubernetes focada em ambientes de desenvolvimento e aprendizado. Ele simula o comportamento de cluster a patir de containres docker, onde cada container representa uma maquina do cluster.

#### Pros
O kind e uma das ferramentas de desenvolvimento e aprendizado completa. Simula como um cluster se comporta em na maioria dos cenarios. Por exemplo em uma ferramentta de desenvolvimento que nao possui suporte a varios nos, o comportamento da aplicacao em ambiente de producao pode ser completamente diferente de um ambiante de producao, por que dentro de um cluster, podem haver pods setados com mais "afinidade" a um node do que a outro, por recursos alocados e ou recuros exclusivos daquele node, como mior capacidade de processamento de video por ex.

#### contras
O kind pode simular relativamente bem um ambiente produtivo, entretando, ele e unicamente recomenmdado a ambientes de desenvolvimento. por usar containers docker para simular um cluster, ele roda sobre a "placa de rede" virtual do docker, sendo assim herda suas limitacoes.

Instalacao
------------
------------
#### requisitos e suas instrucoes de instalacao:
***
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
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
4. Aguarde o termino da configuracao de seu servidor e pronto!
----------
