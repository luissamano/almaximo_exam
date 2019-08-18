# API REST 
Para la publicación de la API se pueden utilizar diversos servidores web como NGNIX, a diferencia del .NET Framework que solo es compatible con el IIS. Mas sin embargo para este caso usaremos el Servidor IIS para la publicación. 

### 1. Instalacion de Runtime & Hosting Bundle

Para la correcta instalación de la API se nesecita el Runtime de NET Core, el cual se puede descargar de la siguiente [Aqui](https://dotnet.microsoft.com/download/thank-you/dotnet-runtime-2.1.12-windows-hosting-bundle-installer)

Ahora da clic derecho en **Sitios** y selecciona **Agregar sitio web**.


**Paso 9.**  Coloca la siguiente información:

-   **Nombre del sitio:**  **Store**
-   **Ruta de acceso física:**  La  **ubicación**  donde publicaste el WebApi de la sesión anterior.
-   **Puerto:**  Uno diferente al 5000, por ejemplo el  **5001**.
-   **Nombre de host:**  Comodín, es  **decir,** *.

**Paso 10.** Ahora selecciona **Grupos de aplicaciones**, elige el grupo **Store** (se creó al momento de generar el sitio web) y da clic en **Configuración básica**.


**Paso 11.** En **Versión de .NET CLR** selecciona **Sin código administrado** y da clic en Aceptar.

**Paso 12.** Vuelve a seleccionar el grupo de aplicación **Store** y ahora elige **Configuración avanzada**.

**Paso 13.** En la categoría **Modelo de proceso**, da clic en el **botón** que aparece en la propiedad

**Paso 14.** Selecciona la **cuenta integrada LocalSystem** de la lista y acepta este cambio.

**Paso 15.**  Abre el navegador y utilizando  **la dirección IP**  de tu equipo o **localhost** y realiza una petición a alguno de los controladores disponibles en tu web service.  **La petición debería ser exitosa.**  Por ejemplo, consultemos la  **lista de clientes** realizando una petición de tipo  **GET**  a la URL **https://localhost:5001/api/productos** como puedes ver en la imagen, en este caso estoy usando:

-   La dirección IP asignada en el adaptador de red inalámbrico (debido a que el dispositivo con el que probaré la aplicación cliente -un teléfono- está conectado a la misma red inalámbrica.
-   El puerto 5001 asignado en el paso 9.