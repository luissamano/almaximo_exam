# AlMaximo Examen

Repositorio del examen técnico de [AlMaximoTI](http://www.almaximoti.com/Sitio/contactanos.html).

## Acerca del repositorio
📋 El proyecto fue realizado usando las siguientes tecnologías: ⚙️


- ASP.NET Core 2.2
- SQL Server 2017 
- ADO.NET
- Vue 3


>  **Nota:** El repositorio esta dividido en una API REST y un cliente Web. 🔩

  


## Estructura del proyecto 📦


🔧 La solución contiene dos proyectos, uno como api rest y otro como cliente web . 🖇️

  

| Proyecto               | Contenido                                      | Tools            |
| ---------------------- | ---------------------------------------------- | ---------------- |
| almaximo_exam.api      | Web API (Servicio) Responde via HTTPS con JSON | ASP.NET Core 2.2 |
| almaximo_exam.entities | Librería de clases identidades                 | .NET Standard    |
| almaximo_exam.web      | Aplicación WEB                                 | Vue 3            |
| docs                   | Documentos de el examen en PDF                 |                  |
| sql_querys             | Consultas SQL                                  | SQL              |



## Funcionamiento de la aplicación

La aplicación inicia con una tabla donde se listan los productos que se encuentran en la base de datos. En la parte superior hay un panel de búsqueda y en la parte inferior se puede cambiar las paginas o el numero de ítems que se muestran en la tabla.

![](C:\Users\marti\Pictures\Captura_manual.PNG)

En la parte superior derecha se encuentra un botón el cual abre un modal con el cual se puede agregar nuevos productos. Los datos de entrada son **clave**, **nombre**, **tipo de producto**, **costo**, **proveedor** y **estatus**. El boton registrar realiza un pre-registro y se muestra en una tabla 

![](C:\Users\marti\Pictures\Captura_manual1.PNG)



El botón registrar realiza un pre-registro y se muestra en una tabla en la parte inferior del modal. el botón **limpiar** elimina los datos ingresados en el formulario y reinicia las validaciones, ningún campo debe quedar vacío, los datos **Tipo de producto** y **Proveedor** se llenan a partir de la API rest.



![](C:\Users\marti\Pictures\Captura_manual2.PNG)

En la tabla pre-registro se puede eliminar el ítem que se registro anterior mente, al dar clic lanzara un modal donde debemos confirmar la acción, esta se puede confirmar o cancelar.

![](C:\Users\marti\Pictures\Captura_alx4.PNG)



Al dar clic en el botón **Guardar** realiza un el registro de los ítems ingresados en el modal.

![](C:\Users\marti\Pictures\Captura_end.PNG)

