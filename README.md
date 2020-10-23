# IIC2173 - Entrega 1 - Levantando clusters hechos por estudiantes de arquitectura de sistemas de software
## Consideraciones generales
## Método de acceso al servidor con archivo .pem y ssh (no publicar estas credenciales en el repositorio).
.pem en Canvas.  
SSH: 
- Todas las instancias EC2 tienen habilitado el puerto 22 para conectarse por SSH. Todas con el mismo archivo `.pem` que entregamos en Canvas. 
- Solo necestian saber la IP Publica de la instancia o el dns interno asignado por aws para elegir una instancia. 
## Logrado o no logrado y comentarios si son necesarios para cada aspecto a evaluar en la Parte mínima y en la Parte variable.
### Sección mínima:
#### Backend:  
RF1 ✔️ RF2 ✔️ RF3 ✔️ RF4 ✔️ RF4 ✔️(RF4 está dos veces en enunciado, hicimos ambos)  o
- URL frontend:  http://d17qxfs402k2yz.cloudfront.net   
- URL backend (https con ACM):  [lmfros.tech](lmfros.tech)
- Header para identificar las instancias: `x-fowarded-instance-id`
#### Frontend:
RF5 ✔️ RF6 ✔️  
App en React. 

### Sección variable:
#### Caché: 
RF1 ✔️ RF2 ❌ RF3 ✔️ 
#### Trabajo delegado: 
RF1 ✔️ RF2 ✔️ RF3 ✔️  
Documentación con explicación en este [link:](https://github.com/iic2173/iic2173-proyecto-semestral-grupo19/blob/master/backend/docs/E1_Documentacion_funciones_lambda.pdf) 
#### Mensajes en tiempo real: ❌

### Desarrollo:
#### Caché:

##### RF1
La infraestructura del caché se detalla a continuación:

- Local: Para montar la infraestructura en local, se instalaron en el backend las gemas `redis` y `sidekiq`. Con esto, al correr la aplicación debe también correr un servidor redis. Para esto se utiliza el comando `server-redis`, y luego se inicia la aplicación con `docker-compose -f local-docker-compose.yml build` y `docker-compose -f local-docker-compose.yml up`.

- Producción: Primero se estableció un cluster para el cache de Redis. Esto a través del servicio de ElastiCache de AWS. Posterior a eso se configuró el cluster para que tuviese acceso a nuestras instancias EC2 que contienen al backend.


##### RF2
 En el servidor de redis se agregaron al cache las `rooms` y los `messages`. Implementado sólo en local.

##### RF3

La tecnología ocupada fue `redis`. Los elementos se cachean en los controladores de nuestra aplicación, en donde los elementos cacheados se guardarán con sus respectivas _redis keys_ en el caché de `redis`, por lo tanto necesitamos un servidor de `redis` corriendo. Las _redis keys_ son _binary safe_, esto significa que puedes usar cualquier secuencia binaria como clave. La cadena vacía también es una clave válida.

El caché se refresca con LRU (_least recently used_), es decir, se van eliminando del caché las páginas que no han sido utilizadas recientemente para hacer espacio en la memoria y agregar las nuevas. Se utiliza LRU debido a que los usuarios que ocupen el servicio de chat con mayor frecuencia requerirán las salas y mensajes rápidamente, por lo que se puede prescindir de las salas y mensajes menos usados.

En nuetra aplicación se guardarán en caché las `rooms` y los `messages` de nuestro chat. Estas se guardarán con las _keys_,  `rooms` y `messages` respectivamente. Cuando un mensaje o una sala nueva se agreguen, entonces la llave `messages` y la llave `rooms` se actualizarán en el caché.
 
También se añadió la gema `sidekiq` para manejar la actualización del caché usando `Rails Active Job` en un proceso paralelo. Cada vez que se actualice el caché el trabajo lo hara `sidekiq` de forma eficiente.



#### Trabajo Delegado:  
Ver /backend/docs/E1_Documentacion_funciones_lambda.pdf  



-----------------------------------------------------------------------------------------------------------------------------------------------------------





Esta segunda parte del proyecto sirve para que conozcan e implementen herramientas para tener escalabilidad y performance en sus aplicaciones. Para esto, cada grupo debe escoger una E0 de los integrantes de su grupo y trabajar desde ahí o implementar una nueva que cumpla con los requisitos de la E0 (poco recomendado). Eventualmente pueden complementar su solución entre los conocimientos aprendidos por todos los integrantes durante esa primera entrega. 

## Objetivo

La entrega tiene por objetivo separar el frontend del backend del chat. Para esto se implementará una *Content Delivery Network* (CDN) y se desacomplarán los servicios utilizando endpoints mediante HTTP.

## Fecha límite

Debe ser entregada a más tardar a las 23:59 del domingo 11 de Octubre. Las condiciones de entrega están explicadas más abajo. De ser entregada el día lunes 12 de Octubre se obtendrá nota máxima 6.0.

### Método de entrega

Para esta entrega, deberan hacer una *demo* de 10-15 minutos acerca de lo que hicieron en la entrega y que al menos un tercio del grupo exponga sobre la solución. Se les pedirá mostrar su trabajo en la consola del servicio cloud y pruebas de usabilidad. Se les avisarán las fechas disponibles (es la semana entre entregas) y algunas pruebas obligatorias que deben hacer para evaluar la correctitud de su solución.

Deben subir el código de su solución (hasta donde aplique) en el repositorio que se les asignará vía github classroom a cada grupo. Deben inscribirse en el siguiente link

https://classroom.github.com/g/9f2h5kYm

Primero entra un miembro a crear el grupo y luego los demás pueden entrar a ese grupo. **Ojo con que entren al grupo correcto, puesto que es difícil cambiarlos.** 
Si se crean dos grupos con el mismo nombre, habra una penalizacion al grupo que se creo después.
También deben entregar el archivo .pem asociado al servidor EC2 para revisarla. Alternativamente pueden indicarnos para su disponibilidad para incorporarnos (ayudantes) a su lista de "_authorized_keys_". 

Además, para poder facilitar la corrección deben realizar un README.md que señale:

- Consideraciones generales
- Método de acceso al servidor con archivo .pem y _ssh_ (no publicar estas credenciales en el repositorio). 
- Logrado o no logrado y comentarios si son necesarios para cada aspecto a evaluar en la Parte mínima y en la Parte variable.
- De realizar un tercer requisito variable también explicitar en el readme.

Pueden sobreescribir este README sin problemas o cambiarle el nombre.

## Requisitos
Esta entrega consiste en dos partes, la parte mínima (que todos deben lograr) que vale **50%** de la nota final y una parte variable que también vale **50%**. Sobre la parte variable, tendrán 3 opciones para trabajar, de las que deberán escoger 2. Cada una de las que escojan para evaluar vale **25%** de la nota final, y realizar una tercera parte puede dar hasta 3 décimas.

---

## Parte mínima

### Sección mínima (50%) (30p)

#### **Backend**
* **RF1: (3p)** Se debe poder enviar mensajes y se debe registrar su timestamp. Estos mensajes deben aparecer en otro usuario, ya sea en tiempo real o refrescando la página. **El no cumplir este requisito completamente limita la nota a 3.9**
* **RF2: (5p)** Se deben exponer endpoints HTTP que realicen el procesamiento y cómputo del chat para permitir desacoplar la aplicación. **El no cumplir este requisito completamente limita la nota a 3.9**

* **RF3: (7p)** Establecer un AutoScalingGroup con una AMI de su instancia EC2 para lograr autoescalado direccionado desde un ELB (_Elastic Load Balancer_).
    * **(4p)** Debe estar implementado el Load Balancer
    * **(3p)** Se debe añadir al header del request información sobre cuál instancia fue utilizada para manejar el request. Se debe señalar en el Readme cuál fue el header agregado.
* **RF4: (2p)** El servidor debe tener un nombre de dominio de primer nivel (tech, me, tk, ml, ga, com, cl, etc).

* **RF4: (3p)** El dominio debe estar asegurado por SSL con Let's Encrypt. No se pide *auto renew*. Tambien pueden usar el servicio de certificados de AWS para el ELB
    * **(2p)** Debe tener SSL. 
    * **(1p)** Debe redirigir HTTP a HTTPS.

#### **Frontend**
* **RF5: (3p)** Utilizar un CDN para exponer los *assets* de su frontend. (ej. archivos estáticos, el mismo *frontend*, etc.). Para esto recomendamos fuertemente usar cloudfront en combinacion con S3.
* **RF6: (7p)** Realizar una aplicación para el *frontend* que permita ejecutar llamados a los endpoints HTTP del *backend*.
    * **(3p)** Debe hacer llamados al servidor correctamente.
    * Elegir **$1$** de los siguientes. No debe ser una aplicación compleja en diseño. No pueden usar una aplicacion que haga rendering via template de los sitios web. Debe ser una app que funcione via endpoints REST
        * **(4p)** Hacer una aplicación móvil (ej. Flutter, ReactNative)
        * **(4p)** Hacer una aplicación web (ej. ReactJS, Vue, Svelte)

---

## Sección variable

Deben completar al menos 2 de los 3 requisitos

### Caché (25%) (15p)
Para esta sección variable la idea es implementar una capa de Caché para almacenar información y reducir la carga en el sistema. Para almacenar información para la aplicación recomendamos el uso de **Redis**, así como recomendamos Memcached para fragmentos de HTML o respuestas de cara al cliente. 

* **RF1: (4p)** Levantar la infraestructura necesaria de caché. Se puede montar en otra máquina o usando el servicios administrado por AWS. Se debe indicar como funciona en local y en producción. 
* **RF2: (6p)** Utilizar la herramienta seleccionada de caché para almacenar las información para al menos 2 casos de uso. Por ejemplo las salas y sus últimos mensajes o credenciales de acceso (login). 
    * **Restricción** Por cada caso de uso debe utilizar alguna configuración distinta (reglas de entrada FIFO/LIFO, estructura de datos o bien el uso de reglas de expiración)
* **RF3: (5p)** Documentar y explicar la selección de la tecnología y su implementación en el sistema. Responder a preguntas como: "¿por qué se usó el FIFO/LRU o almacenar un hash/list/array?" para cada caso de uso implementado. 


### Trabajo delegado (25%) (15p)
Para esta sección de delegación de trabajo recomendamos el uso de "Functions as a Service" como el servicio administrado de AWS, _Lambda Functions_, o bien el uso de más herramientas como AWS SQS y AWS SNS. 

Se pide implementar al menos **3 casos de uso con distinto tipo de integración**.


1.- Mediante una llamada web (AWS API Gateway)
2.- Mediante código incluyendo la librería (sdk)
3.- Como evento a partir de una regla del AutoScalingGroup
4.- Mediante Eventbridge para eventos externos (NewRelic, Auth0 u otro)
5.- Cuando se esté haciendo un despliegue mediante CodeCommit 
6.- Cuando se cree/modifique un documento a S3

Alternativamente pueden integrar más servicios para realizar tareas más lentas de la siguiente forma: 
1.- Al crear un mensaje se registra en una cola (SQS) que llama a una función en lambda (directamente o a través de SNS)
2.- En Lambda se analiza ciertos criterios (si es positivo o negativo, si tiene "garabatos" o palabras prohibidas en el chat) y con este resultado se "taggea" el comentario. 
Si se crean en "tópics" distintos se consideran como 2 casos de uso (por el uso de distintas herramientas). 

Seguir el siguiente tutorial cuenta como 3 (https://read.acloud.guru/perform-sentiment-analysis-with-amazon-comprehend-triggered-by-aws-lambda-7363db23651f o https://medium.com/@manojf/sentiment-analysis-with-aws-comprehend-ai-ml-series-454c80a6114). No es necesaro que entiendan a cabalidad como funciona el código de estas funciones, pero sí que comprendan el flujo de la información y cómo es que se ejecuta.

Se deben documentar las decisiones tomadas. 

* **RF: (5p)** Por cada uno de los 3 tipos de integración.
    * **(3p)** Por la implementación.
    * **(2p)** Por la documentación.

### Mensajes en tiempo real (25%) (15p)
El objetivo de esta sección es implementar la capacidad de enviar actualizaciones hacia otros servicios. Servicios recomendados a utilizar: SNS, Sockets (front), AWS Pinpoint entre otras. 

* **RF1: (5p)** Cuando se escriben mensajes en un chat/sala que el usuario está viendo, se debe reflejar dicha acción sin que éste deba refrescar su aplicación. 
* **RF2: (5p)** Independientemente si el usuario está conectado o no, si es nombrado con @ o # se le debe enviar una notificación (al menos crear un servicio que diga que lo hace, servicio que imprime "se está enviando un correo")
* **RF3: (5p)** Debe documentar los mecanismos utilizados para cada uno de los puntos anteriores indicando sus limitaciones/restricciones. 


#### Caso borde
Si su grupo implementó varias funcionalidades como comandos en los chats, es posible utilizar dichas funciones en Lambdas y manejarlas en paralelo utilizando SQS y SNS en conjunto. Pueden aprovechar su desarrollo para implementar las secciones variables 2 y 3 en conjunto.


---
