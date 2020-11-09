# Entrega 1
```
ssh -i "entrega1-ec2.pem" ubuntu@ec2-54-86-39-30.compute-1.amazonaws.com
```
# Usefull comands ec2:
## Check if  RDS is reachable from EC2
```
telnet ec2-database.cjbtc3b7ofay.us-east-1.rds.amazonaws.com 5432 
```

# Instrucciones para ejecutar

**Requisitos**
 - Instalar `docker-compose`

**Local**
 1. `docker-compose -f test-docker-compose.yml build`
 2. `docker-compose -f test-docker-compose.yml up`

**Desarrollo (ambiente usado para correr en el servidor)**
 1. `docker-compose -f local-docker-compose.yml build`
 2. `docker-compose -f local-docker-compose.yml up` (gestión de HTTPS con Traefik como container, sin implementación del chequeo de certificado cada 12 horas)

# API:

Las llamadas a la API se encuentran documentadas por medio de collections de postman: Rooms (Para solicitar información y enviar mensajes) y Users, para manejar todo lo relativo a usuarios.
# IIC2173 - Entrega 0

Consideraciones generales

- Nombre del dominio: www.berlinichat.ga
- Método de acceso al servidor: `ssh -i path/to/.pem_file ubuntu@34.232.25.58` (archivo .pem entregado vía Canvas)
- Puntos realizados están marcados con :heavy_check_mark:

Sobre la aplicación
* Debe recargarse la página para ver nuevos mensajes
* Opciones de login: Anon o con nombre propio (previamente registrado en Sign Up)

# IIC2173 - Entrega 0

### Seccion mínima (50%) (30p)


* **RF1: (5p)** Chat entre usuarios :heavy_check_mark:
* **RF2: (3p)** Crear salas de chat :heavy_check_mark:
* **RF3: (2p)** Nickname propio o aleatorio (anon) :heavy_check_mark:
* **RNF1: (4p)** Proxy inverso: traefik :heavy_check_mark:
* **RNF2: (3p)** Nombre dominio primer nivel :heavy_check_mark:
* **RNF3: (5p)** Server EC2 :heavy_check_mark:
* **RNF4: (3p)** Base de datos hosteada en otro container. :heavy_check_mark:
* **RNF5: (5p)** El servicio debe estar dentro de un container Docker. :heavy_check_mark:

---

## Seccion variable

### Docker-compose (25%) (15p)

* **RNF1: (5p)** Lanzar su app desde docker-compose :heavy_check_mark:
* **RNF2: (5p)** Integrar db desde docker-compose :heavy_check_mark:
* **RNF3: (5p)** Configurar su proxy inverso desde docker-compose :heavy_check_mark:

### Comandos in-chat (25%) (15p)

Los comandos in chat son muy populares en plataformas de chat mas avanzadas que WhatsApp o Facebook messenger. Usualmente siguen la fórmula */asl* o */ban*

* **RF1: (9p)** Implementar 1 comando :heavy_check_mark: 
* **RF2: (4p)** Implementar 2 comandos :heavy_check_mark:
* **RF3: (2p)** Implementar 3 comandos :heavy_check_mark:
 
Comandos: escribir en consola
* `/nameroom: <new_name>` cambia el nombre de la sala '<new_name>' (debe ser un nombre no vacio y no ocupado)
* `/reverse`: los mensajes de la sala se mostrarán invertidos
* `/reset`: elimina todos los mensajes y desactiva la opcion reverse, en caso de estar activada

### HTTPS (25%) (15p)

* **RNF1: (7p)** El dominio asegurado por SSL con Let's Encrypt. :heavy_check_mark:
* **RNF2: (3p)** Redireccionar HTTP a HTTPS. :heavy_check_mark:
* **RNF3: (5p)** Chequeo de expiracion del certificado SSL de forma automática 2 veces al día



## Enlaces utilizados
 * https://coderwall.com/p/ewk0mq/stop-remove-all-docker-containers
 * https://3rd-edition.railstutorial.org/book/sign_up
 * https://docs.docker.com/compose/rails/
 * https://linuxize.com/post/how-to-remove-docker-images-containers-volumes-and-networks/
 * https://docs.traefik.io/v2.0/user-guides/docker-compose/basic-example/
 * https://stackoverflow.com/questions/43516333/best-practice-for-rails-docker-compose-dbcreate-dbmigrate
 * https://stackoverflow.com/questions/28404482/rails-fatal-database-myapp-development-does-not-exist/28404606
 * https://stackoverflow.com/questions/21309901/getting-migrations-are-pending-run-bin-rake-dbmigrate-rails-env-development
 * https://docs.traefik.io/user-guides/docker-compose/acme-tls/
 * https://iridakos.com/programming/2019/04/04/creating-chat-application-rails-websockets
 * https://3rd-edition.railstutorial.org/book/sign_up
 * https://stackoverflow.com/questions/15988960/testing-for-empty-or-nil-value-string
 * https://stackoverflow.com/questions/27682276/rails-updating-boolean-attribute-in-a-model-on-create"
 * https://support.cloudways.com/creating-a-record-freenom/
 * https://stackoverflow.com/questions/58356714/how-to-redirect-http-to-https-with-traefik-2-0-and-docker-compose-labels

