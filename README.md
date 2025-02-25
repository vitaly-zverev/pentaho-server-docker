### Pentaho server-deployment steps using docker:
1 - Send to the Dev/Prod server the package "pentaho-server-docker" (folder with dockerfile, docker-compose, lib, data)

2 - Create pentaho server 9 image (build) based on dockerfile (command: docker-compose build)

If the Dev/Prod server does not have internet access, it will not be possible to create the image, so perform additional steps before running:

Generate image on a machine that has internet access and export the image (docker save) to a file .tar
Upload file to Dev/Prod server (docker load)

3 - create image && run container (command: docker-compose up)

4 - Upload jobs/transformations zip to pentaho server web (http://server_ip:8081/pentaho/Login)

5 - adjust connection and user control settings

6 - Configure schedule for job execution

it is also possible:

Commit the container to generate snapshot.
Store the image in Docker-hub or nexus repository, using the concept of registering the image.
Docker / compose command set

### build (image creation)
> docker build -t pentaho_server_ce:9.4 .

**_via compose:_** 
> docker-compose build 

### Verification of image/container
>  - docker images  
>  - docker ps  
>  - docker ps -a
>  - docker inspect
>  - docker logs --follow (container_id)

### run (container creation && start)
> docker run -p 127.0.0.1:8081:8080 pentaho_server_ce:9.4

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

### Customize container, vim confs etc., backup image (snapshot)
> docker commit (container_id)  pentaho_server_ce_my_snapshot

### Environment Information 
>( http://server_ip:8081/pentaho/Login , goto /Browse Files/Public/Data Integration/Get Environment Information)

|Variable	                    |Value				  |
| ----------------------------- | ------------------- |
|Internal.Kettle.Version	    |9.4.0.0-343          |
|Internal.Kettle.Build.Version	|0.0                  |
|Internal.Kettle.Build.Date	    |2022-11-08 07.50.27  |
|java.runtime.version	        |11.0.15+10           |
|os.name	                    |Linux                |
|os.version	                    |5.4.0-117-generic    |
|os.arch	                    |amd64                |
|user.country	                |${user.country}      |
|user.language	                |en                   |
|user.home                      |/opt/pentaho         |

### Interactive Reports

The "Interactive Reports" functionality is not included in the Community Edition (CE) of Pentaho Server since version 6.0. Before this version, "Interactive Reports" were available in CE. However, starting with version 6.0, the "Interactive Reports" functionality became available only in the paid version of Pentaho Server.