
Aplicacao dos conhecimentos adquiridos/ Projeto DevOps
===========================

Bem vimdo ao mundo DevOps!
-----------
Esse e um projeto exemplo, onde sao aplicadas algumas das ferramentas utilizadas por um engenheiro DevOps, na sua principal funcao, que é responsabilizar-se pelo  versionamento, entrega e infraestrutura de aplicoes.

O Ansible
----------------------
----------------------
O ansible é uma aplicacao de Continuous Delivery. Ele é responsável por automatizar processos na construçao da infraestrutura e entrega da aplicaçaa. Em uma grande aplicacao orientada a microsservico existem uma serie de dependencias que precisam ser instaladas e configuradas antes que a aplicacao seja executada. O que se torna extremamente lento, pricipalmente, se voce precisa configurar varias maquinas que compoem um cluster, ou ainda se precisa faze-lo sempre que alguem faz uma atualizacao no repositorio do codigo.

```!#/bin/bash
roles/
    common/               # essa é a estrutura de arquivoos de uma "role"
        tasks/            #
            main.yml      #  <-- o diretorio tasks executa tarefas no host especificatdo no playbook
        handlers/         #
            main.yml      #  <-- handlers, lida com os erros e condiçoes nao satisfeitas
        templates/        #  <-- arquivos que servem de recursos de templates
            ntp.conf.j2   #  <------- os templates terminam com .j2
        files/            #
            bar.txt       #  <-- arquivos usados como recursos de cópia
            foo.sh        #  <-- arquivos de script para serem usados como recursos de script
        vars/             #
            main.yml      #  <-- variáveis
        defaults/         #
            main.yml      #  <-- default, sao variáveis padrao, o que significa que, caso haja uma variável com o mesmo nome, o valor utilizado será o da variável
```

## Um Playbook
Um playbook é um arquivo de definiçao das tarefas ou roles (conjunto de [tarefas](#/?id=As-tarefas)) que serao executadas nos hosts do ansible. 

## As tarefas 
As tarefas propriamente ditas sao a menor parte do que compoe um playbook, uma tarefa é uma unica definiçao de uma unica caracteristica da máquina host.

## As roles
Numa role vc pode agrupar tarefas do mesmo seguimento bem como suas variaveis e seus handlers.

# Roles no projeto
A estrutura das roles do projeto seguem o seguinte padrao:

```!#/bin/bash
├── apacheAb # instalar apache ab
│   └── tasks
│       └── main.yaml
├── chartsInstall # instalar os charts do ipnginx
│   ├── defaults
│   │   └── main.yaml
│   ├── files 
│   │   └── ipnginx-chart # diretorio do chart 
│   │       ├── Chart.yaml
│   │       ├── templates
│   │       │   ├── NOTES.txt
│   │       │   ├── _helpers.tpl
│   │       │   ├── deployment.yaml
│   │       │   ├── hpa.yaml
│   │       │   ├── ingress.yaml
│   │       │   ├── service.yaml
│   │       │   ├── serviceaccount.yaml
│   │       │   └── tests
│   │       │       └── test-connection.yaml
│   │       └── values.yaml
│   └── tasks
│       └── main.yaml
├── dockerInstall # instalar docker 
│   ├── defaults # variaveis padrao que descrevem os pacotes que devem ser instalados
│   │   └── main.yaml
│   ├── handlers
│   │   └── main.yaml # Caso o serviço do docker nao estiver iniciado o handler o inicia
│   └── tasks
│       └── main.yaml # instala o docker 
├── helmInstall # instala o helm (gerenciador de pacotes do kuberneetes)
│   ├── defaults
│   │   └── main.yaml
│   └── tasks
│       └── main.yaml
├── kubeadmSetup 
│   ├── defaults # variaveis de inicializaçao do cluster
│   │   └── main.yaml
│   └── tasks  # inicia o cluster
│       └── main.yaml
├── kubernetesInstall # instala o kubelet kubeadm e kubectl
│   ├── defaults
│   │   └── main.yaml # repositorio ppa e lista de apps
│   └── tasks
│       └── main.yaml # instala o repositorio ppa
├── nginxIngress
│   ├── files
│   │   └── deploy.yaml
│   └── tasks
│       └── main.yaml
├── stressNgInstall # instala o stress-ng 
│   └── tasks
├── apacheTest # testa a performace do server em conexoes paralelas
│   └── tasks
│       └── main.yaml
│       └── main.yaml
└── stressNgTest # testa o stress-ng 
    └── tasks
        └── main.yaml

```

# Playbooks do projeto:
## master-playbook.yaml
Este playbook é o playbook responsável por configurar a infraestrutura
## test-playbook.yaml
Este é o playbook que executa os testes, tanto do stress-ng quanto do apache bench

O Docker
----------------------
----------------------
O docdker e uma ferramenta de conteinizacao de aplicacoes, o que quer dizer que vc pode rodar sua aplicacao em um ambiente virtual emulado em seu computador. Entrentato diferentemente de, por exemplo uma maquina virtual propriamente dita um docker container, compartilha o kernel do host. Assim voce pode construir ambientes virtuais dinamicamete alocados e encapsulados.

## O Dockerfile

O Dockerfile e um arquivo de configuracao do docker, onde instrucoes definem o comportamento de uma imagem.
[Confira as principais instrucoes do docker aqui](https://dev.to/soutoigor/dockerfile-principais-comandos-e-instrucoes-2jpp#:~:text=O%20Dockerfile%20%C3%A9%20o%20meio,desta%20imagem%2C%20criamos%20nosso%20container.)

### ipngnx

Esta e a imagem que a aplicacao roda, ela foi construida para exibir o nome do [Pod](#/?id=pods) o [namespace](#/?id=namepsace) em que esta inserida e seu endereco de ip, fornecidos pelo [kubernetes](#/?id=kubernetes).

#### ipngnx Dockerfile
##### 1. [FROM](#) alpine as html
- Usando uma imagem de referencia e a chamando de "html", nesse caso a imagem do alpine.

##### 2. [WORKDIR ](#) html/
- Criando o diretorio html. 

##### 3. [RUN ](#)echo "<\h1>My pod name is: MY_POD_NAME<\/h1><\br><\/br><\h1>My pod namespace is: MY_POD_NAMESPACE<\/h1><\br><\/br><\h1>My pod ip is: MY_POD_IP<\/h1>" >> index.html  #remova as contraabaras
- Exibindo o texto descrito entre aspas e colocando sua saída no arquivo index.html dentro do diretório html.

##### 4. [FROM](#) nginx
- Usando uma imagem do nginx.

##### 5. [COPY](#) --from=html /html /usr/share/nginx/html
- Copiando os arquivos do diretorio /html da referida [imagem html]()

##### 6. [COPY](#) ./entryPoint.sh /
- Copiando o [entryPoint.sh]() no mesmo diretorio do Dockerfile para o container.

##### 7. [RUN ](#)chmod +x entryPoint.sh
- Modificando as permissões de usuário para que o entryPoint.sh tenha permissões para ser executado.

##### 8. [ENTRYPOINT](#) ["/entryPoint.sh"]
- Shell script que substituti os valores do index.html pelos valores de suas respecivas variáveis deambiente.

##### 9. [CMD](#) ["nginx", "-g", "daemon off;"]
- Previne que o docker mate o processo nginx fazendo com que ele execute sempre em primeiro plano.

#### ipngnx EntryPoint
O entripoint dessa imagem, verifica se as variáveis de ambiente estao setadas, e entao, aplica no index.html; de referencia através de um "sed"
```!#/bin/bash
set -xe
: "${MY_POD_NAME?Need an api url}"

set -xe
: "${MY_POD_IP?Need an api url}"
set -xe
: "${MY_POD_NAMESPACE?Need an api url}"

sed -i "s/MY_POD_NAMESPACE/$MY_POD_NAMESPACE/g" /usr/share/nginx/html/index.html

sed -i "s/MY_POD_NAME/$MY_POD_NAME/g" /usr/share/nginx/html/index.html


sed -i "s/MY_POD_IP/$MY_POD_IP/g" /usr/share/nginx/html/index.html

exec "$@"
```







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
$ cd K8sProject/leaning_ansible 
```
```!#/bin/bash
$ sed -i 's/PATH_CHAVEPRIVADA/<caminho para a chave privada que o ansible usará para se conectar ao servidor> ./inventory'
$ ssh-copy-id -i <path chave publica par da chave privada ssh que voce configurou no "inventory"> root@server
$ ansible-playbook kubernetes-setup/master-playbook.yaml 
```
4. Aguarde o termino da configuracao de seu servidor e pronto!

## Executando os testes:

1. Após o ansible encerrar a configuraçao do host execute os testes: 

```!#/bin/bash
$ ansible-playbook kubernetes-setup/test-playbook.yaml 
```
----------
