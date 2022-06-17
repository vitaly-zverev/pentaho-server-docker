# **Pentaho server - Etapas implantação usando docker:**

1- Enviar para o servidor HML/PRD o pacote "pentaho-server-docker" (pasta com dockerfile, docker-compose, lib, data)

2- Criar imagem (build) do pentaho server 9 baseado no dockerfile (comando: docker-compose build)

   Caso o servidor HML/PRD não tenha acesso a internet, não será possível criar a imagem, então realizar etapas adicionais antes de rodar:
   - Gerar imagem em máquina que possui acesso a internet e realizar a exportação da imagem (docker save) para um arquivo .tar
   - Carregar arquivo no servidor HML/PRD (docker load) 

3- Rodar imagem para criar o container e inicializar (comando: docker-compose up)

4- Fazer upload do zip de jobs/transformações no pentaho server web (http://ip_servidor:8081/pentaho/Login)

5- Ajustar as configurações de conexão de banco e controle de usuário

6- Configurar schedule para execução do JOB

**Pronto!**


_**Obs. também é possível:**_ 
 - Realizar Commit do container para gerar snapshot.
 - Armazenar a imagem em repositório docker-hub ou nexus, usando o conceito de registrar a imagem.

## Conjunto de comandos docker / compose

### build (image creation)
> docker build -t pentaho_server_ce:9.3 .

**_via compose:_** 
> docker-compose build 

### Verification of image/container
>  - docker images  
>  - docker ps  
>  - docker ps -a
>  - docker inspect
>  - docker logs --follow (container_id)

### run (container creation && start)
> docker run -p 127.0.0.1:8081:8080 pentaho_server_ce:9.3

**_via compose:_** 
> docker-compose up

### Interactive shell (console) for container
> docker exec -t -i pentaho-server /bin/bash

### Start of created container
> docker container start pentaho-server

**_via compose:_** 
> docker-compose start

### Stop of running container
> docker container stop pentaho-server

**_via compose:_** 
> docker-compose stop

### Customizar container com confs e depois gerar uma imagem (snapshot)
> docker commit (container_id)  pentaho_server_ce_my_snapshot
