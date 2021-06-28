
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
kubernetes-setup/roles
├── nome-descritivo
│   └── tasks+ <-- 
│       └── main.yaml
├── apacheTest
│   ├── files
│   │   └── installStressNgInsideDocker.sh
│   └── tasks
│       └── main.yaml
├── dockerInstall
│   ├── defaults
│   │   └── main.yaml
│   ├── handlers
│   │   └── main.yaml
│   └── tasks
│       └── main.yaml
├── helmInstall
│   ├── defaults
│   │   └── main.yaml
│   └── tasks
│       └── main.yaml
├── kubeadmSetup
│   ├── defaults
│   │   └── main.yaml
│   └── tasks
│       └── main.yaml
├── kubeconfigSetup
│   └── tasks
│       └── main.yaml
├── kubectlInstall
│   ├── defaults
│   │   └── main.yaml
│   ├── handlers
│   │   └── main.yaml
│   └── tasks
│       └── main.yaml
├── kubernetesInstall
│   ├── defaults
│   │   └── main.yaml
│   └── tasks
│       └── main.yaml
├── metallbSetup
│   ├── defaults
│   │   └── main.yaml
│   ├── files
│   │   ├── kind-sample-cluster.yaml
│   │   └── metallb-config-poll-addr.yaml
│   └── tasks
│       └── main.yaml
├── metricsServer
│   ├── files
│   │   └── components.yaml
│   └── tasks
│       └── main.yaml
├── nginxIngress
│   ├── files
│   │   └── deploy.yaml
│   └── tasks
│       └── main.yaml
├── stressNgInstall
│   └── tasks
│       └── main.yaml
└── stressNgTest
    ├── files
    │   └── installStressNgInsideDocker.sh
    └── tasks
        └── main.yaml
```

# Playbooks do projeto:
## master-playbook.yaml
Este playbook é o playbook responsável por configurar a infraestrutura
Suas roles sao:

```!#/bin/bash
...
├── apacheAb
│   └── tasks
│       └── main.yaml
├── dockerInstall
│   ├── defaults
│   │   └── main.yaml
│   ├── handlers
│   │   └── main.yaml
│   └── tasks
│       └── main.yaml
├── helmInstall
│   ├── defaults
│   │   └── main.yaml
│   └── tasks
│       └── main.yaml
├── kubeadmSetup
│   ├── defaults
│   │   └── main.yaml
│   └── tasks
│       └── main.yaml
├── kubeconfigSetup
│   └── tasks
│       └── main.yaml
├── kubectlInstall
│   ├── defaults
│   │   └── main.yaml
│   ├── handlers
│   │   └── main.yaml
│   └── tasks
│       └── main.yaml
├── kubernetesInstall
│   ├── defaults
│   │   └── main.yaml
│   └── tasks
│       └── main.yaml
├── metallbSetup
│   ├── defaults
│   │   └── main.yaml
│   ├── files
│   │   ├── kind-sample-cluster.yaml
│   │   └── metallb-config-poll-addr.yaml
│   └── tasks
│       └── main.yaml
├── metricsServer
│   ├── files
│   │   └── components.yaml
│   └── tasks
│       └── main.yaml
├── nginxIngress
│   ├── files
│   │   └── deploy.yaml
│   └── tasks
│       └── main.yaml
├── stressNgInstall
│   └── tasks
│       └── main.yaml
...
```
## test-playbook.yaml
Este é o playbook que executa os testes, tanto do stress-ng quanto do apache bench
```!#/bin/bash
...
└── stressNgTest
    ├── files
    │   └── installStressNgInsideDocker.sh
    └── tasks
        └── main.yaml
...
├── apacheTest
│   ├── files
│   │   └── installStressNgInsideDocker.sh
│   └── tasks
│       └── main.yaml
...
```
## kubeconfig-playbook.yaml
Este é o playbook que aplica o kubeconfig do server para a maquina local, fazendo com que nosso cluster seja acessivel de dentro de nossa maquina local.
```!#/bin/bash
...
├── kubeconfigSetup
│   └── tasks
│       └── main.yaml
...
```
## deploy-playbook.yaml
Este é o playbook que aplica o deploy no cluster.
```!#/bin/bash
...
├── deploySetup
│   └── tasks
│       └── main.yaml
...
```
O Docker
----------------------
----------------------
O docdker e uma ferramenta de conteinizacao de aplicacoes, o que quer dizer que vc pode rodar sua aplicacao em um ambiente virtual emulado em seu computador. Entrentato diferentemente de, por exemplo uma maquina virtual propriamente dita um docker container, compartilha o kernel do host. Assim voce pode construir ambientes virtuais dinamicamete alocados e encapsulados.

## O Dockerfile

O Dockerfile e um arquivo de configuracao do docker, onde instrucoes definem o comportamento de uma imagem.
[Confira as principais instrucoes do docker aqui](https://dev.to/soutoigor/dockerfile-principais-comandos-e-instrucoes-2jpp#:~:text=O%20Dockerfile%20%C3%A9%20o%20meio,desta%20imagem%2C%20criamos%20nosso%20container.)

### gabrielknot/php_nginx_

Esta e uma imagem que armazena e serve a aplicacao deste repositorio [git](https://github.com/lucasdantas2014/exercicio_chronos), construida por Lucas Dantas.

#### gabrielknot/php_nginx Dockerfile

##### 1. [FROM](#) php:7.4-fpm
- Usa a imagem do php-fpm de referencia
##### 2. [RUN](#) apt-get update && apt-get install -y \
	    git \
	    curl \
	    libpng-dev \
	    libonig-dev \
	    libxml2-dev \
	    zip \
	    unzip \
	    supervisor \
	    nginx
##### 3. [RUN](#) docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd
- Instala as dependencias 
##### 4. [RUN](#) apt-get clean && rm -rf /var/lib/apt/lists/*
- Remove a lista de repositorios
##### 5. [COPY](#) supervisord.conf /etc/supervisor/conf.d/php_nginx.conf
- Copia o arquivos de configuracao do supervisor
##### 6. [COPY](#) --from=composer /usr/bin/composer /usr/local/bin/composer
- Instala o composer  
##### 7. [COPY](#) . /app
- Copia os arquivos da aplicacao para dentro do container
##### 8. [WORKDIR](#) /app
- Dentro do container o diretorio corrente agora e o "/app"
##### 9. [RUN](#) composer install
- Instala as dependencias da aplicacao laravel
##### 10. [RUN](#) chmod -R www-data:www-data /app
- Da pemissoes de acesso ao usuario do nginx
##### 11. [CMD](#) ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
- Inicia o supervisor com seu arquivo de configuracao

## O nginx

O nginx e resposavel por servir a aplicacao. Apesar de ser um servidor web e nao ter capacidade de inerpretar codigo php, o nginx consegue servir uma aplicacao laravel, comunicando-se com o [php-fpm](#php-fpm) (o gerenciador de processos do php), tanto via sock quanto via rede local, tornando-se capaz de servir qualquer view do php.

### As configuracoes do nginx e php-fpm

Seu arquivo de configuracao no caso dessa aplicacao e definido pelo [Kubernetes](#Kubernetes), atraves de um configmap.

```nginx.conf
...
    server {
            listen       80; <-- Prota em que o nginx ouvira as requisicoes
            listen       [::]:80;<--|
            root /www/app/public; <-- rota onde os arquivos servidos pelo nginx extao
            server_name  _;
            index index.php index.html index.htm; <-- Arquivo principal 
            
            location = /favicon.ico { access_log off; log_not_found off; }
            location = /robots.txt  { access_log off; log_not_found off; }

            location / {
              try_files $uri $uri/ /index.php?$query_string; 
            }

            location ~ \.php$ {
              try_files $uri /index.php =404;
              fastcgi_split_path_info ^(.+\.php)(/.+)$; 
              fastcgi_pass 127.0.0.1:9000; <-- Porta onde ocorrera a comunicacao entre o php-fpm e o nginx
              fastcgi_index index.php;
              fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
              include fastcgi_params;
              fastcgi_intercept_errors off;
              fastcgi_buffer_size 16k;
              fastcgi_buffers 4 16k;
              fastcgi_connect_timeout 300;
              fastcgi_send_timeout 300;
              fastcgi_read_timeut 300;
            }
            error_page 404 /404.html;
              location = /40x.html { <-- Em caso de erro, paginas que serao servidas -|
            }                                        |                               
                                                     |
            error_page 500 502 503 504 /50x.html; <--|
              location = /50x.html {
            }
        }



...
```

```www.conf
...
    [www]
user = www-data <-- Ususario do nginx quem ira servir a aplicacao
group = www-data <-- Grupo do nginx quem ira servir a aplicacao (neste caso o nginx)
listen = 127.0.0.1:9000 <-- Porta de comunicacao com o server da aplicaco
pm = dynamic <-- O numero de processos sera dinamico conforme a demanda do servidor
pm.max_children = 20 <-- numero maximo de processos filhos do php fpm
pm.start_servers = 3 <-- numero inicial de processos do php fpm
pm.min_spare_servers = 2 <-- numero minimo de processos em espera
pm.max_spare_servers = 5 <-- numero max de processos em espera
pm.max_requests = 200 <-- numero maximo de requisicoes 
php_admin_flag[log_errors] = on <-- logs exibidos na tela, somente em desenvolvimento
...
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


O Deploy e o helm
----------------------
---------------------

O deploy da aplicacao e feito utilizando o gerenciador de pacotes do kubernetes, o helm. Com ele voce pode, facilmente versionar as diversas aplicacoes que rodam no seu cluster. O helm utiliza helm charts, no chart ficam todas as configuracoes das aplicacoes que rodam no seu cluster. 

Na nossa aplicacao por exemplo funciona assim:
```!#/bin/bash
└── laravel-app
    ├── Chart.yaml
    ├── backup
    ├── dry-run
    ├── templates
    │   ├── NOTES.txt
    │   ├── _helpers.tpl
    │   ├── configmap-nginx.yaml
    │   ├── configmap-php-fpm.yaml
    │   ├── configmap-php.yaml
    │   ├── deployment.yaml
    │   ├── hpa.yaml
    │   ├── ingress.yaml
    │   ├── secret.yaml
    │   ├── service.yaml
    │   ├── serviceaccount.yaml
    │   └── tests
    │       └── test-connection.yaml
    └── values.yaml

```
## Executando os testes:

1. Após o ansible encerrar a configuraçao do host execute os testes: 
```!#/bin/bash
$ ansible-playbook kubernetes-setup/test-playbook.yaml 
```

Esse teste, utilizando-se do [apache bench(ab)] testa a capacidade da aplicacao de receber requisicoes simultaneas.

#### Atencao !
O teste esta dimensionado para utilizar o maximo de recursos da maquina, rodando em um cluster kubernetes, com as segintes configuracoes:
- Um unico node (master e worker ao mesmo tempo)
- 8gb ram 4 cores
Somente o kubeadm consome 2 cores e 2gb, sendo assim dadas as limitascoes vamos aos seus resultados:
- Para evitar problemas, como conexao recusada pelo cloud provider, todos os testes rodam no servidor o que, em nossos testes consumiu em media 14% de de cpu.

### Resultados

- Falha na requisicao  86622 - razao: reponse time > 30s 
- 551 req/s
- Min recurso por pod - cpu: 300m (milicores) - ram 256Mi (megabytes)
- Max recurso por pod - cpu: 700m (milicores) - ram 400Mi (megabytes)
- Qantidade minima de pod's 1
- Quantidade maxima de pod's 5


### Problemas e melhorias futuras
#### Mysql
Um dos testes que foi feito, foi utilizar a aplicacao enquanto se faziam os testes de requisicoes. Ao entrar na parte de cadastro de clientes, o laravel retornava um log de erro ao tentar executar um foreach pela query dos estados. Dados esses responsaveis pela exibicao dos estados na tag "<select><option>Estado</option></select>" e somente na rota de cadastro "/novo_cliente".

Apos alguns testes, e observacoes do log do pod do mysql, concluimos que a razao da ocorrencia intermitente desse problema se deve ao fato de que existe uma limitacao de [de tempo para que uma conexao seja estabelecida](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html), [por padrao no mysql esse periodo de estabelecimento de conexao e de 10s](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html). Sendo assim caso o pod tenha feito uma conexao que exceda esse parametro ele perdera a conexao com o banco de dados e so podera reestabelece-la, caso tente novamente efetuar uma conexao com o banco de dados e consica estabelecer comunicacao em menos de 10s.
##### Causas 
A principal causa e a limitacao de recursos do pod. Com isso o mysql reduz sua capacidade de paralelismo fazendo com que as algumas das conexoes nao executem a tempo.
##### Possiveis solucoes
- Maximizar os recursos do pod.

O que, dado as caracteristicas do cluster necessario aumento de recursos da infraestrutura, ja que trabalha no limite.
- Aumentar a tolerancia de tempo para o estabelecimento de coneccoes.

Dadas as caracteristicas da aplicacao, um tempo de resposta maior do banco de dados nao afeta a experiencia do usuario. Visto que, no cadastro a so e acessada na tag "<select><option>Estado</option></select>" e na exibicao dos clientes cadasGGtrados.


O Jenkins
----------------------
---------------------
O Jenkins e uma ferramenta de [Continous Integration]() e [Countinous deployment](), serve para automatizar processos de desenvolvimento, como adimissao automatizada de commits e tambem e capas de fazer o deploy automatico das aplicacoes. O que aumenta a eficiencia na entrega da aplicacao, alem de aumentar a eficiencia do desenvolvimento de novas features, visto que tanto a integracao de codigo de diferentes desenvolvedores, quanto o deploy da aplicacao tornam-se automatizados.
O versionamento do codigo e uma ferramento de automatizacao de processos de integracao e de deploy como o jenkins, unidos podem evitar catastrofe. 

Imagine um cenario onde e feito um deploy em uma apliccao numa sexta feira, e no domigo apos um pico inesperado de acessos a aplicacao "quebra", um cenario muito estranho para sua equipe visto que na versao anterior um fluxo ainda maior de acessos acontecia com uma certa frequencia. 
Apos esse problema temos algumas possiveis solucoes, colocar o site em manutencao enquanto manualmente, voce e sua equipe fazem o deploy de uma versao anterior. Ficar trnquilo pois um trigger automatizado e capaz de voltar tudo para a versao anmterior  enquanto voce e sua equipe trabalham na manutencao do problema da versao atual e quando estiver tudo pronto, simplesmente fazem o deploy no repositorio de codigo, fazendo com que a aplicacao eteja "no ar" em poucos minutos.

Sendo assim a integrcao continua permite que desenvolvedores consigam programar independentemente um do outro, no mesmo codigo, pois este sera sempre testado antes de ter seu commit aceito fazendo com que o processo de entrega de ssoftware e suas funcionalidades seja muito mais otimizado, automatico e escalavel, no sentidod de que equipes cada vez maiores de desenvolvedores sao capases de atuar na aplicacao sem conflitos em qualquer push que ocorre.

## A Pipeline CI/CD

A pipeline e a "linha de producao", varios jobs que automatizam as tarefas de entgrega da aplicaccao o "deploy". Essas tarefas garantem que o codigo sera testado antes que um commit seja aceito por exemplo, um exemplo de CI, ou simplesmente automatizam o processo de deploy, fazendo com que, por exemplo, todo commit na branch "\*/main" seja colocado em producao periodicamente (CD).

### A nossa pipeline

Como estamos rodando em um cluster kubernetes com o objetivo de gerenciar os microsservissos que rodam sobre essa infraestrutura. Usamos o plugin do Kubernetes, que utilizando-se de uma feature chamada de "podTemplate" e capaz de executar commandos dentro de pods, que podem rodar por exemplo, o runtime do docker. Ou o helm, facilitando a construcao de pipelines dentro do cluster kubernetes.

**|**-------------------- **Criando o PodTemplate que executara esse job como um worker do jenkins**
```!#/bin/bash
 podTemplate( 
    containers: [
        containerTemplate(args: 'cat', name: 'docker', command: '/bin/sh -c', image: 'docker', ttyEnabled: true),
        containerTemplate(args: 'cat', command: '/bin/sh -c', image: 'lachlanevenson/k8s-helm:v3.5.2', name: 'helm', ttyEnabled: true),
	    containerTemplate(name: 'jnlp', image: 'lachlanevenson/jnlp-slave:3.10-1-alpine', args: '${computer.jnlpmac} ${computer.name}', workingDir: '/home/jenkins', resourceRequestCpu: '200m', resourceLimitCpu: '300m', resourceRequestMemory: '256Mi', resourceLimitMemory: '512Mi'),
	    containerTemplate(name: 'helm', image: 'lachlanevenson/k8s-helm:v2.6.0', command: 'cat', ttyEnabled: true),
	    containerTemplate(name: 'kubectl', image: 'lachlanevenson/k8s-kubectl:v1.4.8', command: 'cat', ttyEnabled: true)
    ],
```
**|**-------------------- **Crinado um volume compartilhado com o "Host", que aponta para o sock do docker. Fazendo com que apenas a instancia do docker no rost execute os comandos docker dentro do container**
```!#/bin/bash
    volumes: [
        hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock') 
    ]

```
**|**-------------------- **Checando se ha alteracoes no repositorio e clonando-o**
```!#/bin/bash
) {
  def image = "gabrielknot/php_nginx"
  node(POD_LABEL) {
    stage('Checkout') {
	checkout scm
    }
```
**|**-------------------- **Construindo a imagem docker, setando sua "tag" para o hash do commit e postando-a no docker hub.**
```!#/bin/bash

      stage('Build Docker image') {
        gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
        container('docker') {
          withDockerRegistry([credentialsId: 'dockerHub', url: ""]) {
             sh "docker build -t ${image}:${gitCommit} ."
             sh "docker push ${image}:${gitCommit}"
          }
        }
      }

```
**|**-------------------- **Fazendo o deploy do helm chart e setando o a tag da imagem para a mesma tag publicada no dockerHub no passo anterior**
```!#/bin/bash
      stage ('deploy to k8s') {
	gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
        container('helm') {
          // Deploy using Helm chart
          sh """
            helm upgrade --install --set image.tag=${gitCommit}
        """
        }
     }
}
}
```
# Certificacao SSL/TLS

Os certificados digitais permitem uma comunicacao confiael entre o cliente e os sites que este acessa, essa comunicacao e criptografada em entre o cliente e o servidor, fazendo com que qualquer um que intercepte essa reqisicao no meio do caminho, nao consiga identificar o conteudo dessa comunicacao. Entretanto, e necessaria uma validacao de um terceiro confiavel. 

## Como funciona:

Um certificado digital solicitado por um mantenedor de um dominio a uma autoridade certificadora confiavel ao browser, de preferencia a maioria deles. Junto a esse certificado atestando que o site possui uma origem conhecida por essa entidade, o cliente recebe, tambem, a chave publica referente ao servidor com que se comuinica. Em posse dessa chave publica o cliente criptografa seus dados e envia para o servidor. Assim, os dados do cliente sao encriptados e o unico com capacidade computuacional de desdcriptografa-los e o servidor em posse da chave privada. Fazendo com que a comunicacao estabelecida, torne -se segura e confiavel.

<img src="https://images.tcdn.com.br/img/editor/up/712075/howSSLworksdiagram.jpg" width="900">

## Lets Encrypt

O Lets Encrypt e uma dssas autoridades certificadoras, fornecem certificados SSL gratuitamente.

## Cert bot

O cert-bot automatiza a geracao de certificados em servidores de forma geral, permitindo um processo siples e guiado automatico na obtencao de certificados validados pelo Lets Encrypt

## Cert-Maneger 

O cert-manager gerencia os certificados do kubernetes, automatizando os processos de geracao de certificados de variadas autoridades certificadpras, e com integracao com apis de gerenciadore de DNS permitindo a geracao de certificados wild card.

## Problemas e melhorias

Usando o kubeadm sem utilizar cloud provider, meus subdominios acabam por apontar sempre pra um ip fixo do master. Sendo assim meu cluster so consegue lidar com um dominio por vez, ja que o dns vai sempre resolver, tanto os sub-dominios quanto os dominios para o mesmo ip.
Instalacao
------------
------------
#### requisitos e suas instrucoes de instalacao:
***
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)**
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

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

4. Altere as variaveis padrao em ansible/kubernetes-setup/master-playbook.yaml

```!#/bin/bash
    ...
    environment_ACME: 'dev'
    my_cloudflare_mail: 'yourCLOUDFLAREmail@domain.com'
    my_cloudflare_token: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
    my_domain: 'domain.com'
    my_lets_encrypt_mail:  'yourACMEmail@domain.com'
    ...
```

obs: Seu token deve ter permissoes de leitura de todas as zonas e de edicao de DNS no [link](https://dash.cloudflare.com/profile/api-tokens), como descrito na documentacao do [cert-manager](https://cert-manager.io/docs/configuration/acme/dns01/cloudflare/)

5. Atualize os plugins do jenkins e esperem ate que terminem. Use o login "admin" e a senha "admin" e siga as instrucoes:

   

   1. <img src="" width="600">

   2. <img src="" width="600">

   3. <img src="" width="600">

   4. <img src="" width="600">


6. Aguarde o termino da configuracao de seu servidor e pronto!
