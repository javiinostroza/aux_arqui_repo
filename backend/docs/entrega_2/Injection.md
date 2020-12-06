## Documentación CSS/Javascript injection

Rutas del backend:
```
	POST https://tuchat-backend5/upload	
```
Genera una solicitud para agregarle un archivo css a una sala de chat.
Necesita: `{file: "css file", filename: "string", roomname: "string" }` y devuelve: `{"objeto request"}`
```	
	GET https://tuchat-backend5/requests
```
Pide todas las solicitudes de la base de datos y devuelve: `[{"objeto request"}]`
```
	POST https://tuchat-backend5/acceptrequest
```
Acepta una solicitud para que se incorpore el css a la sala de chat. Necesita: `{id: "request id"}`

	
El flujo va de la siguiente manera:
- Un usuario carga un archivo en el frontend y solicita que lo agregren a una sala, para eso el archivo se envía al backend y ahí se guarda en una instancia S3, en donde se crea una solicitud con el formato `{id, room_id, url, accepted}` donde el url corresponde a la ubicación del archivo css en S3.
- Luego un administrador puede revisar el archivo `.css` y aceptar la solicitud. Eso cambia el estado de `request.accepted` a `true` y le agrega a la sala correspondiente el atributo `style_sheet = request.url`.
- Cada vez que un usuario se conecta a una sala de chat, recibe los mensajes de la sala junto con el url del archivo `css` correspondiente. De esta manera puede importar el archivo `css` mientras esté dentro de la sala.