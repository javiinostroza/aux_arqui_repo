# IIC2173 - Entrega 3 - La paz del cierre

## Descripción de la entrega

En esta entrega se implementa IaaC y Monitoreo a la versión final de la aplicación.

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


# Logrado, no logrado y comentarios si son necesarios para cada aspecto a evaluar en la Parte mínima.

### Sección mínima

## Monitoreo

(1): :heavy_check_mark: (8p) Desde el sistema de monitoreo debe ser posible ver el estado de los servidores. En particular, el consumo de recursos de cada máquina.

(2): :heavy_check_mark: (7p) Desde el
sistema de monitoreo debe ser posible ver el estado de las aplicaciones, sus tiempos de respuesta así como la ocupación.

(3): :heavy_check_mark: (3p) Debe documentar con
diagramas de componentes el sistema a fines de esta entrega. La documentación de esta sección queda dentro del directorio `backend\docs` en el archivo `monitoring_UML.png`.

(4) :heavy_check_mark: (2p) La aplicación debe monitoreo debe ser accesible desde el panel de administración.

## IaaC

(1): :heavy_check_mark: (10p) Implementación del proyecto de "infraestructura como código" para montar su sistema actual en un nuevo ambiente.

(2): :heavy_check_mark: (3p) Documentación el código realizado
para implementar la estructura de su " IaaC" y comentarios donde existe espacio de mejorar. La documentación de esta sección quedará en el README.md del directorio `backend\docs`.


---

