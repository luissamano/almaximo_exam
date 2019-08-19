# API REST 
Para la publicación de la API se pueden utilizar diversos servidores web como NGNIX, a diferencia del .NET Framework que solo es compatible con el IIS. Mas sin embargo para este caso usaremos el Servidor IIS para la publicación. 

Lo primero es asegurase de tener la SDK de NET Core en su versión 2.2, disponible [aqui](https://dotnet.microsoft.com/download/dotnet-core/2.2). Una vez instalado y descargado el repositorio, abrimos una terminal (cmd o powershell). no dirigimos al lugar donde tenemos el repositorio almacenado e ingresamos los siguientes comandos.



```powershell
dotnet restore
```

```
dotnet msbuild
```



Y para generar los archivos de publicación de nuestro proyecto ingresamos el siguiente comando.

```
dotnet publish -c Release
```

Este comando nos genera una carpeta de nombre publish dentro del directorio *bin/Release/netcoreapp2.2/*  una vez hecho esto podemos proceder a la publicación.

![](C:\Users\marti\Pictures\Captura4.PNG)

### Instalación de Runtime & Hosting Bundle

Para la correcta instalación de la API se necesita el Runtime de NET Core, el cual se puede descargar de la siguiente [Aqui](https://dotnet.microsoft.com/download/thank-you/dotnet-runtime-2.1.12-windows-hosting-bundle-installer)

Ahora da clic derecho en **Sitios** y selecciona **Agregar sitio web**.

![](C:\Users\marti\Pictures\Captura5.PNG)


Coloca la siguiente información:

-   **Nombre del sitio:**  **alx**
-   **Ruta de acceso física:**  La  **ubicación**  donde publicaste el WebApi de la sesión anterior.
-   **Puerto:** **5001**.
-   **Nombre de host:**  Comodín, es  **decir,** *.



![](C:\Users\marti\Pictures\Captura_alx1.PNG)





**Ahora selecciona** Grupos de aplicaciones, elige el grupo **alx** (se creó al momento de generar el sitio web) y da clic en **Configuración básica**. En **Versión de .NET CLR** selecciona **Sin código administrado** y da clic en Aceptar.

![](C:\Users\marti\Pictures\Captura7.PNG)



Vuelve a seleccionar el grupo de aplicación **alx** y ahora elige **Configuración avanzada**. En la categoría **Modelo de proceso**, da clic en el **botón** que aparece en la propiedad y selecciona la cuenta integrada **LocalSystem** de la lista y acepta este cambio.



![](C:\Users\marti\Pictures\Captura_alx2.PNG)





Abre el navegador y utilizando  la **dirección IP**  de tu equipo o **localhost** y realiza una petición a alguno de los controladores disponibles en la api. consultemos la  **lista de productos** realizando una petición de tipo  **GET**  a la URL **https://localhost:5001/api/productos**.

![](C:\Users\marti\Pictures\Captura9.PNG)