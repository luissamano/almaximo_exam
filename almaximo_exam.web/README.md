# Aplicación WEB con VUE

Para el desarrollo de la aplicación cliente se utiliza [VUE 3.9.1](https://cli.vuejs.org/guide/#components-of-the-system) la interfaz de un solo componente llamado productos.

![](C:\Users\marti\Pictures\Captura1.PNG)



La interfaz muestra un listado de los productos en la base de datos los cuales se pueden editar y eliminar, un cuadro de búsqueda y un botón para agregar nuevos productos.



## Instalación de la aplicación

Para el uso correcto de la aplicación se requiere de [NodeJS](https://nodejs.org/es/download/) una vez descargado e instalado, podemos abrir nuestro proyecto desde CMD o PowerShell. 



```powershell
cd .\Descagas\almaximo_exam\cliente_vue.web\
```

![](C:\Users\marti\Pictures\Captura_1.PNG)



Posteriormente debemos instalar las dependencias del proyecto con el gestor de paquetes [npm](https://www.npmjs.com) que viene por defecto en la instalación de [NodeJS](https://nodejs.org/es/download/).

```powershell
npm install
```



### Levantar servidor local

Con el siguiente podemos levantar el servidor local y probar la aplicación. 

```powershell
npm run serve
```



### Crear los archivos para producción

Para poder realizar la publicación de la aplicación se deben generar los archivos css, js y html. 

```powershell
npm run build
```

Este comando nos genera una carpeta de nombre **dist**.

![](C:\Users\marti\Pictures\dist.PNG)





## Publicación en IIS

Para la publicación de nuestro cliente, debemos crear un archivo **web.config** dentro de nuestro directorio dist, el cual de acuerdo a la *[documentación oficial](https://router.vuejs.org/guide/essentials/history-mode.html#example-server-configurations)* de VUE de llevar lo siguiente.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
  <system.webServer>
    <rewrite>
      <rules>
        <rule name="Handle History Mode and custom 404/500" stopProcessing="true">
            <match url="(.*)" />
            <conditions logicalGrouping="MatchAll">
              <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />
              <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />
            </conditions>
          <action type="Rewrite" url="/" />
        </rule>
      </rules>
    </rewrite>
  </system.webServer>
</configuration>
```

Ahora abriremos nuestro servidor IIS y nos dispondremos a agregar un nuevo sitio web.



![](C:\Users\marti\Pictures\Captura5.PNG)

Indicamos los datos solicitados.



![](C:\Users\marti\Pictures\Captura_2.PNG)



Y listo, el sitio web llamado **vue** se agrego a nuestro servidor IIS, pero aun realizar algunos ajustes antes de probar nuestra aplicación.

Del lado izquierdo de nuestro servidor podemos encontrar el panel de *Conexiones* y veremos una opción llamada **Grupos de aplicaciones**, buscamos y seleccionamos el grupo llamado de la misma manera que nuestro grupo, en este caso **vue**, despues del lado derecho se muestra el panel de *Acciones* y sección *Modificar grupo de aplicaciones*, damos clic en **Configuración básica...** 

![](C:\Users\marti\Pictures\Captura_3.PNG)



Cambiamos la opción *Versión de .NET CLR* a *Sin código administrado* y clic en aceptar.

![](C:\Users\marti\Pictures\Captura7.PNG)



Para finalizar en le mismo panel buscamos la opción **Configuración avanzada** y configuramos la opción Identidad con la opción *LocalSytem*.

![](C:\Users\marti\Pictures\Captura8.PNG)



Con esto es hemos finalizado la instalación de nuestra aplicación cliente VUE. Ahora no deponemos abrir la pagina con nuestra ip local y el puerto asignado en este caso el 5001. 

![](C:\Users\marti\Pictures\Captura.PNG)