# IIC2173 - Entrega 2 - Seguridad y documentación para sus aplicaciones

## Descripción de la entrega

En esta entrega se implementan herramientas para tener seguridad y mantenibilidad en nuestra aplicación.

## Consideraciones importantes

link al frontend: https://d56cod89vfqp0.cloudfront.net/

link al backend: https://www.tuchat-backend5.cf/

En primer lugar, antes de comenzar a evaluar el flujo de la página puede que sea necesario que deban limpiar el sessionStorage, los cookies y el localStorage del navegador. Es posible que las vistas no se actualicen en tiempo real, por lo que se aconseja refrescar la página en caso de notar incongruencias.

Para evaluar el flujo del administrador, un usuario admin es:

`email: test2@uc.cl `

`password: 16Arqsis`

Al registrar un usuario, la password debe contener 8 carácteres mínimo, mayúsculas y números.

Finalmente, para los requisitos funcionales que requieren documentación, esta se encuentra en el directorio `backend\docs` .

## Método de acceso al servidor:
Se accede al servidor con el archivo `.pem` y el comando `ssh`. Éste archivo fue subido en el cuestionario de canvas. El comando utilizado para entrar a la instancia es:

`ssh -i "16v2-key.pem" ec2-user@ec2-3-137-143-229.us-east-2.compute.amazonaws.com`


# Logrado, no logrado y comentarios si son necesarios para cada aspecto a evaluar en la Parte mínima y en la Parte variable.

### Autenticación

## Sección mínima

RF1: :heavy_check_mark: (4p) Añadir un servicio completamente independiente para manejar la sesión de los usuarios. La sesión debe contener información para permitir a la
aplicación acceder a la información que le corresponda. Se recomienda el uso de JWT o SAML.

RF2: :heavy_check_mark: (2p) La implementación debe considerar algún protocolo como OAuth, de manera que se externalice la identificación y nivel de acceso de los usuarios.
Con esta implementación debe permitir que se pueda desarrollar una nueva aplicación que consuma sus servicios, así como también manejar el acceso de
sus usuarios.

RF3: :heavy_check_mark: (3p) El mismo sistema debe considerar el acceso de administrador. Es decir, si el usuario tiene acceso a la aplicación de mensajería también debería
usar la misma cuenta para administrador. (Single Sign On, a.k.a SSO).

RF4 :x: (opcional): (3 décimas) Implementar 2FA en su solución. Esto debe ser implementado mediante un correo o SMS

### CI/CD

RF1: :heavy_check_mark: (3p) Debe documentarse un flujo de integración en el repositorio de código. Debe incluirse semantic versioning en todos sus commits (Visto en clases)

RF2: :heavy_check_mark: (3p) Cada vez que haya se haga un merge a master se debe automatizar el despliegue en un ambiente (ya sea staging o producción) utilizando alguna
herramienta como Travis/CodeBuild/Jenkins u otro. (Generar y almacenar las imágenes si correspnde)

RF3: :heavy_check_mark: (3p) Se deben incorporar tests de funcionalidad (unitarios y de integración) antes de hacer el paso real. Se piden algunos tests para mostrar su
funcionamiento (Al menos tres tests unitarios simbólicos pero que den resultados).

RF4: :heavy_check_mark: (2p) El sistema de despliegue continuo debe hacerse cargo de manejar las variables de entorno de manera segura.


### Documentación

RF1: :heavy_check_mark: (2p) Debe documentar con diagramas de componentes el sistema a fines de esta entrega.

RF2: :heavy_check_mark: (2p) Debe documentar con diagramas de flujo los procesos de log in/sign up, envío de mensajes (considerando todos los procesos que ocurran a partir
de ahí).

RF3: :heavy_check_mark: (2p) Debe documentar con diagramas el proceso de despliegue.

RF4: :heavy_check_mark: (4p) Debe documentar todas las posibles llamadas a sus APIs con algún estandar (Postman, Swagger u otra)

## Sección variable

### CRUD admin (25%) (15p)


RF1: :heavy_check_mark: (5p) Se implementa un menu para acceder a la información de los usuarios. Se puede revisar y modificar la información de éstos y bloquear el acceso
("borrar"). De ser necesario, debe interactuar con el sistema de auth implementado en la sección de Autenticación.

RF2: :heavy_check_mark: (5p) Se implementa el menú para manejar grupos. Se pueden cerrar grupos, dejar públicos o privados.

RF3: :heavy_check_mark: (5p) Se implementa el CRUD mensajes. Como admin puede enviar mensajes en grupos, ver y modificar los mensajes e incluye la censura de ellos. Al
modificar o censurar los mensajes no se puede perder el mensaje original.

### CSS/Javascript injection (25%) (15p)

RF1: :heavy_check_mark: (7p) Flujo de aprobación de inyecciones de código desde el usuario al administrador.

RF2: :heavy_check_mark: (5p) Se implementa el código CSS o javacript en la sala especificada.

RF3: :heavy_check_mark: (3p) Documente y explique las decisiones de diseño tomadas para esta implementación.



---