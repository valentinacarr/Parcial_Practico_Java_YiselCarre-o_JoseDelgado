**INFORME TÉCNICO DEL PROYECTO**

**NEXO INMOBILIARIA**

Aplicación web para la gestión de propiedades, agentes, clientes y
solicitudes

*JSP + JSPF + Servlet Filter + JDBC + MySQL 8 + Bootstrap 5*

  -----------------------------------------------------------------------
  **Elemento**            **Detalle**
  ----------------------- -----------------------------------------------
  Nombre del proyecto     Nexo Inmobiliaria (InmobiliariaSantander)

  Asignatura              Programación Web con Java (Java EE / Jakarta
                          EE)

  Tipo de aplicación      Portal inmobiliario multi-rol: Cliente, Agente
                          inmobiliario y Administrador

  Arquitectura            Modelo 1: páginas JSP + fragmentos
                          reutilizables .jspf + Filtro de control de
                          acceso

  Base de datos           MySQL 8 --- esquema db_inmobiliaria

  Conexión                Archivo conexion.jspf con JDBC (driver
                          mysql-connector-j 9.7.0)

  Interfaz                Bootstrap 5.3 desde CDN, diseño responsivo

  Control de acceso       FiltroControlAcceso.java --- servlet Filter que
                          protege /admin/\*, /inmobiliaria/\* y
                          /cliente/\*

  Archivos del proyecto   24 páginas JSP, 4 fragmentos .jspf, 1 filtro
                          Java, CSS y web.xml
  -----------------------------------------------------------------------

Integrantes: Yisel Valentina Carreño Contreras, Jose David Delgado
Ropero

Docente: Julian Barney Jaimes Rincon

Fecha: 17 de septiembre de 2026

# **Contenido**

[**Contenido** [2](#contenido)](#contenido)

[**1. Presentación del proyecto**
[4](#presentación-del-proyecto)](#presentación-del-proyecto)

[**1.1 Qué se construyó** [4](#qué-se-construyó)](#qué-se-construyó)

[**1.2 Roles y flujo general**
[4](#roles-y-flujo-general)](#roles-y-flujo-general)

[**1.3 Competencias que se practican**
[4](#competencias-que-se-practican)](#competencias-que-se-practican)

[**1.4 Entregables sugeridos** [5](#entregables)](#entregables)

[**2. Herramientas y requisitos**
[6](#herramientas-y-requisitos)](#herramientas-y-requisitos)

[**3. La base de datos del proyecto**
[7](#la-base-de-datos-del-proyecto)](#la-base-de-datos-del-proyecto)

[**3.1 Tablas identificadas y su función**
[7](#tablas-identificadas-y-su-función)](#tablas-identificadas-y-su-función)

[**3.2 Relaciones clave del modelo**
[7](#relaciones-clave-del-modelo)](#relaciones-clave-del-modelo)

[**3.3 Modelo entidad-relación**
[8](#modelo-entidad-relación)](#modelo-entidad-relación)

[**4. Arquitectura de la aplicación** [9](#section)](#section)

[**4.1 Los cuatro fragmentos .jspf**
[9](#los-cuatro-fragmentos-.jspf)](#los-cuatro-fragmentos-.jspf)

[**4.2 El Filtro de control de acceso (en vez de seguridad.jspf)**
[9](#el-filtro-de-control-de-acceso-en-vez-de-seguridad.jspf)](#el-filtro-de-control-de-acceso-en-vez-de-seguridad.jspf)

[**4.3 Archivos del proyecto**
[10](#archivos-del-proyecto)](#archivos-del-proyecto)

[**4.4 Diagrama de arquitectura**
[11](#diagrama-de-arquitectura)](#diagrama-de-arquitectura)

[**5. La conexión a la base de datos: conexion.jspf**
[12](#_Toc240484070)](#_Toc240484070)

[**6. La plantilla visual: header, footer e imágenes**
[13](#la-plantilla-visual-header-footer-e-imágenes)](#la-plantilla-visual-header-footer-e-imágenes)

[**6.1 header.jspf** [13](#header.jspf)](#header.jspf)

[**6.2 footer.jspf** [13](#footer.jspf)](#footer.jspf)

[**6.3 imagenes.jspf** [13](#imagenes.jspf)](#imagenes.jspf)

[**7. Registro e inicio de sesión**
[14](#registro-e-inicio-de-sesión)](#registro-e-inicio-de-sesión)

[**7.1 registro.jsp: alta de un cliente**
[14](#registro.jsp-alta-de-un-cliente)](#registro.jsp-alta-de-un-cliente)

[**7.2 login.jsp: validación e inicio de sesión**
[14](#login.jsp-validación-e-inicio-de-sesión)](#login.jsp-validación-e-inicio-de-sesión)

[**7.3 logout.jsp** [14](#logout.jsp)](#logout.jsp)

[**8. Configuración final: web.xml**
[15](#configuración-final-web.xml)](#configuración-final-web.xml)

[**9. Módulo público: inicio, catálogo y detalle**
[16](#módulo-público-inicio-catálogo-y-detalle)](#módulo-público-inicio-catálogo-y-detalle)

[**9.1 index.jsp y catalogo.jsp**
[16](#index.jsp-y-catalogo.jsp)](#index.jsp-y-catalogo.jsp)

[**9.2 detalle_propiedad.jsp**
[16](#detalle_propiedad.jsp)](#detalle_propiedad.jsp)

[**9.3 contactar.jsp** [16](#contactar.jsp)](#contactar.jsp)

[**9.4 mis_solicitudes.jsp y favorito_toggle.jsp**
[17](#mis_solicitudes.jsp-y-favorito_toggle.jsp)](#mis_solicitudes.jsp-y-favorito_toggle.jsp)

[**10. Panel del cliente** [18](#panel-del-cliente)](#panel-del-cliente)

[**11. Panel del agente (inmobiliaria)**
[19](#_Toc240484086)](#_Toc240484086)

[**12. Panel de administración**
[20](#panel-de-administración)](#panel-de-administración)

[**13. Desplegar y probar la aplicación**
[21](#desplegar-y-probar-la-aplicación)](#desplegar-y-probar-la-aplicación)

[**13.1 Puesta en marcha** [21](#puesta-en-marcha)](#puesta-en-marcha)

[**13.2 Guion de prueba sugerido**
[21](#guion-de-prueba-sugerido)](#guion-de-prueba-sugerido)

[**14. Errores frecuentes y observaciones**
[23](#_Toc240484091)](#_Toc240484091)

[**Anexo A. Inventario de archivos entregados**
[24](#anexo-a.-inventario-de-archivos-entregados)](#anexo-a.-inventario-de-archivos-entregados)

*Nota: para actualizar los números de página, haga clic derecho sobre la
tabla y seleccione \"Actualizar campo\".*

# **1. Presentación del proyecto**

## **1.1 Qué se construyó**

Nexo Inmobiliario es una aplicación web que permite publicar, buscar y
gestionar propiedades en venta o arriendo. Un visitante anónimo puede
explorar el catálogo público y ver el detalle de cada inmueble; al
registrarse como cliente puede agendar citas, enviar solicitudes de
compra o arriendo y guardar propiedades en favoritos. Cada propiedad
pertenece a una inmobiliaria (agente), que administra su propio
inventario y atiende las solicitudes y citas que recibe. Por encima de
los dos roles anteriores, el administrador supervisa toda la plataforma:
usuarios, propiedades, solicitudes y reportes generales.

El proyecto se escribe con páginas JSP y fragmentos .jspf, siguiendo el
mismo Modelo 1 (páginas JSP que consultan la base de datos y generan el
HTML) que se usa en los talleres de la asignatura, pero incorpora una
pieza adicional que no está en el taller base: un Filtro de Servlet
(FiltroControlAcceso.java) que centraliza el control de acceso por rol
para toda la aplicación, en lugar de repetir la validación en cada
página con un fragmento como seguridad.jspf.

## **1.2 Roles y flujo general**

  -----------------------------------------------------------------------------
  **Rol**         **Qué puede hacer**                   **Zona de la
                                                        aplicación**
  --------------- ------------------------------------- -----------------------
  Visitante (sin  Ver el catálogo, filtrar por          Raíz pública:
  sesión)         ciudad/tipo/precio y ver el detalle   index.jsp,
                  de cada propiedad.                    catalogo.jsp,
                                                        detalle_propiedad.jsp

  Cliente         Agendar citas, enviar solicitudes de  /cliente/\*
                  compra/arriendo, guardar favoritos,   
                  editar su perfil y hacer seguimiento  
                  a sus solicitudes.                    

  Agente /        Publicar y editar sus propiedades,    /inmobiliaria/\*
  Inmobiliaria    subir imágenes, marcar                
                  características, y gestionar las      
                  citas y solicitudes recibidas sobre   
                  sus inmuebles.                        

  Administrador   Ver el panel general, administrar     /admin/\*
                  todas las propiedades, gestionar      
                  usuarios (bloquear/activar), revisar  
                  solicitudes de toda la plataforma y   
                  consultar reportes.                   
  -----------------------------------------------------------------------------

El recorrido natural de un cliente es: entra al catálogo, revisa el
detalle de un inmueble, inicia sesión (o se registra), agenda una cita o
envía una solicitud, y hace seguimiento desde su panel. El agente revisa
esa misma solicitud desde su propio panel y cambia su estado (confirmar,
rechazar, etc.). El administrador puede ver y actuar sobre todo lo
anterior, más la gestión global de usuarios y los reportes.

## **1.3 Competencias que se practican**

-   Crear un proyecto web Java multi-rol y desplegarlo en un servidor de
    aplicaciones (Tomcat).

-   Separar código repetido en fragmentos .jspf (conexión, cabecera,
    pie, generación de imágenes de apoyo).

-   Centralizar el control de acceso por rol en un Filtro de Servlet, en
    vez de repetirlo en cada página.

-   Conectar la aplicación a MySQL con JDBC y PreparedStatement,
    evitando la inyección SQL en los puntos donde se usa.

-   Manejar transacciones (commit/rollback) en operaciones que tocan
    varias tablas: registro de usuario (usuario + perfil + usuario_rol)
    y guardado de propiedades (propiedad + propiedad_caracteristica +
    imagen_propiedad).

-   Cifrar contraseñas con hash + salt (SHA-256) en vez de guardarlas en
    texto plano.

-   Construir interfaces responsivas con Bootstrap 5, reutilizando una
    cabecera y un pie comunes a todo el sitio.

-   Traducir errores de restricciones de la base de datos (código 1062,
    clave duplicada) a mensajes claros para el usuario.

## **1.4 Entregables** 

  ----------------------------------------------------------------------------
  **\#**   **Entregable**     **Descripción**
  -------- ------------------ ------------------------------------------------
  1        Script de la base  Archivo .sql con las tablas del esquema
           de datos           db_inmobiliaria, sus llaves y los datos
                              iniciales (ciudades, tipos de propiedad,
                              características, roles).

  2        Proyecto web       Carpeta completa del proyecto: 24 páginas JSP, 4
                              fragmentos .jspf, el filtro Java, el CSS y el
                              web.xml.

  3        Evidencia de       Capturas de pantalla del recorrido completo:
           funcionamiento     registro, login, catálogo, cita/solicitud, panel
                              de agente y panel de administrador.

  4        Diagramas del      Modelo entidad-relación de la base de datos y
           proyecto           diagrama de arquitectura de la aplicación
                              (espacio reservado en este documento).

  5        Informe corto      Explicación de qué hace cada fragmento .jspf,
                              por qué se usa un Filtro en vez de un
                              seguridad.jspf, y dónde se usan transacciones.
  ----------------------------------------------------------------------------

# **2. Herramientas y requisitos**

El proyecto puede ejecutarse contra una base de datos local (XAMPP) o
contra una base de datos MySQL alojada en la nube (Clever Cloud); el
archivo conexion.jspf permite alternar entre las dos con una sola
bandera, sin tocar el resto del código.

  -------------------------------------------------------------------------------------------
  **Herramienta**   **Versión sugerida**          **Para qué se usa** **Cómo verificar**
  ----------------- ----------------------------- ------------------- -----------------------
  JDK               Java 17+                      Compilar las        java -version en la
                                                  páginas JSP y el    consola
                                                  filtro Java.        

  Apache Tomcat     9.0.x (o 10/11 con ajuste,    Servidor de         Abrir
                    ver anexo)                    aplicaciones que    http://localhost:8080
                                                  ejecuta el          
                                                  proyecto.           

  MySQL Server      8.0.x                         Motor de la base de mysql -u root -p
                                                  datos.              

  XAMPP /           8.0                           Entorno local para  Conexión local a
  phpMyAdmin                                      crear y revisar el  127.0.0.1:3306
                                                  esquema.            

  Base de datos en  Clever Cloud (MySQL)          Alternativa remota  Cambiar USAR_NUBE =
  la nube                                         para no depender de true en conexion.jspf
                                                  un motor local.     

  Driver JDBC       mysql-connector-j-9.7.0.jar   Permite que Java    Debe quedar en
                                                  hable con MySQL.    WEB-INF/lib

  IDE               Visual Studio Code / Eclipse  Editar el proyecto  Crear un proyecto web
                    / NetBeans                    y desplegar en      de prueba
                                                  Tomcat.             

  Navegador         Chrome, Edge o Firefox        Probar la           F12 para ver errores
                                                  aplicación.         

  Bootstrap 5.3 /   Desde CDN (no se descarga)    Estilos y           Requiere internet la
  Bootstrap Icons                                 componentes de la   primera vez
                                                  interfaz.           
  -------------------------------------------------------------------------------------------

+-----------------------------------------------------------------------+
| **Importante:**                                                       |
|                                                                       |
| La aplicación usa javax.servlet (Tomcat 9) tanto en el web.xml como   |
| en el filtro FiltroControlAcceso.java. Si se despliega en Tomcat 10 u |
| 11 (espacio de nombres jakarta.servlet), hay que actualizar el import |
| del filtro y la cabecera de web.xml; ya existe una referencia         |
| (web-tomcat10-11-REFERENCIA.xml) dentro del proyecto para ese caso.   |
+=======================================================================+
+-----------------------------------------------------------------------+

# **3. La base de datos del proyecto**

La aplicación trabaja sobre el esquema db_inmobiliaria. A partir de las
consultas SQL escritas en las páginas JSP se puede reconstruir el
siguiente inventario de tablas y para qué las usa cada módulo.

## **3.1 Tablas identificadas y su función**

  -------------------------------------------------------------------------------
  Tabla                      Qué guarda                Módulo que la usa
                                                       principalmente
  -------------------------- ------------------------- --------------------------
  usuario                    Cuenta de acceso: correo, login.jsp, registro.jsp,
                             contrasena_hash, salt y   admin/usuarios.jsp
                             estado (ACTIVO/INACTIVO). 

  perfil                     Datos personales 1:1 con  registro.jsp,
                             usuario: nombres,         cliente/perfil.jsp
                             apellidos, documento,     
                             telefono, direccion.      

  rol                        Catálogo de roles:        registro.jsp, login.jsp
                             ADMINISTRADOR /           
                             INMOBILIARIA / CLIENTE.   

  usuario_rol                Relación N:M entre        registro.jsp, login.jsp
                             usuario y rol.            

  inmobiliaria               Ficha del agente (1:1 con login.jsp, módulo
                             usuario que tiene rol     /inmobiliaria/\*
                             INMOBILIARIA):            
                             nombre_comercial,         
                             telefono_contacto.        

  ciudad                     Ciudades disponibles:     catalogo.jsp, index.jsp,
                             nombre_ciudad,            formularios de propiedad
                             departamento.             

  tipo_propiedad             Tipos de inmueble (casa,  catalogo.jsp, formularios
                             apartamento, lote, etc.): de propiedad
                             nombre_tipo.              

  propiedad                  Encabezado del inmueble:  todos los módulos
                             matricula_inmobiliaria,   
                             id_inmobiliaria,          
                             id_ciudad, id_tipo,       
                             titulo, descripcion,      
                             precio, area_m2,          
                             habitaciones, banos,      
                             estado, activo.           

  imagen_propiedad           Fotos de cada propiedad:  formularios de propiedad,
                             url_imagen, es_portada.   catálogo, detalle

  caracteristica             Catálogo de               admin/inmobiliaria:
                             características o         formulario_propiedad.jsp
                             amenidades (ej. piscina,  
                             garaje).                  

  propiedad_caracteristica   Relación N:M entre        formulario_propiedad.jsp
                             propiedad y               
                             caracteristica.           

  cita                       Visitas agendadas:        contactar.jsp,
                             id_propiedad, id_cliente, mis_solicitudes.jsp,
                             fecha_hora,               paneles de agente y admin
                             observaciones, estado.    

  solicitud                  Solicitudes de            contactar.jsp,
                             compra/arriendo:          mis_solicitudes.jsp,
                             id_propiedad, id_cliente, paneles de agente y admin
                             tipo_solicitud,           
                             observaciones, estado.    

  documento_solicitud        Documentos adjuntos a una No se usa en ningún JSP
                             solicitud: id_solicitud,  del proyecto entregado ---
                             nombre_documento,         corresponde a
                             url_archivo, fecha_carga. radicar_documento.jsp, que
                                                       tampoco está en el .zip

  favorito                   Propiedades marcadas como cliente/favoritos.jsp,
                             favoritas: id_usuario,    favorito_toggle.jsp,
                             id_propiedad,             cliente/index.jsp,
                             fecha_marcado.            header.jspf

  auditoria                  Bitácora de acciones del  No se usa en ningún JSP
                             sistema: id_usuario,      del proyecto entregado
                             accion, detalle,          
                             fecha_hora, ip_origen.    

  Tabla                      Qué guarda                Módulo que la usa
                                                       principalmente

  usuario                    Cuenta de acceso: correo, login.jsp, registro.jsp,
                             contrasena_hash, salt y   admin/usuarios.jsp
                             estado (ACTIVO/INACTIVO). 

  perfil                     Datos personales 1:1 con  registro.jsp,
                             usuario: nombres,         cliente/perfil.jsp
                             apellidos, documento,     
                             telefono, direccion.      

  rol                        Catálogo de roles:        registro.jsp, login.jsp
                             ADMINISTRADOR /           
                             INMOBILIARIA / CLIENTE.   

  usuario_rol                Relación N:M entre        registro.jsp, login.jsp
                             usuario y rol.            

  inmobiliaria               Ficha del agente (1:1 con login.jsp, módulo
                             usuario que tiene rol     /inmobiliaria/\*
                             INMOBILIARIA):            
                             nombre_comercial,         
                             telefono_contacto.        

  ciudad                     Ciudades disponibles:     catalogo.jsp, index.jsp,
                             nombre_ciudad,            formularios de propiedad
                             departamento.             

  tipo_propiedad             Tipos de inmueble (casa,  catalogo.jsp, formularios
                             apartamento, lote, etc.): de propiedad
                             nombre_tipo.              

  propiedad                  Encabezado del inmueble:  todos los módulos
                             matricula_inmobiliaria,   
                             id_inmobiliaria,          
                             id_ciudad, id_tipo,       
                             titulo, descripcion,      
                             precio, area_m2,          
                             habitaciones, banos,      
                             estado, activo.           

  imagen_propiedad           Fotos de cada propiedad:  formularios de propiedad,
                             url_imagen, es_portada.   catálogo, detalle

  caracteristica             Catálogo de               admin/inmobiliaria:
                             características o         formulario_propiedad.jsp
                             amenidades (ej. piscina,  
                             garaje).                  
  -------------------------------------------------------------------------------

## **3.2 Relaciones clave del modelo**

-   usuario 1---1 perfil: cada cuenta tiene una ficha de datos
    personales.

-   usuario N---M rol a través de usuario_rol: por defecto, el registro
    público asigna el rol CLIENTE.

-   usuario 1---1 inmobiliaria (opcional): si existe una fila en
    inmobiliaria para ese id_usuario, la sesión lo trata como agente
    (id_inmobiliaria en la sesión), sin depender únicamente del texto
    guardado en rol.

-   inmobiliaria 1---N propiedad: cada propiedad pertenece a un único
    agente.

-   propiedad N---1 ciudad y propiedad N---1 tipo_propiedad: catálogos
    de apoyo para filtrar el catálogo.

-   propiedad 1---N imagen_propiedad: varias fotos por propiedad, una
    marcada como portada (es_portada).

-   propiedad N---M caracteristica a través de propiedad_caracteristica.

-   propiedad 1---N cita y propiedad 1---N solicitud, ambas asociadas
    también al cliente que las generó.

## **3.3 Modelo entidad-relación**

Diagrame aquí las tablas anteriores y sus relaciones. Sugerencia de
leyenda: PK (llave primaria), FK (llave foránea), U (campo UNIQUE), UQ
(UNIQUE compuesto), igual que en los diagramas usados en clase.

  -----------------------------------------------------------------------
  ![](media/image2.png){width="7.0in" height="4.247916666666667in"}
  -----------------------------------------------------------------------

  -----------------------------------------------------------------------

## 3.4 Modelo MER

  -----------------------------------------------------------------------
  ![](media/image3.png){width="9.4375in" height="4.398611111111111in"}
  -----------------------------------------------------------------------

  -----------------------------------------------------------------------

# 

# **4. Arquitectura de la aplicación**

El proyecto usa el Modelo 1: cada página JSP recibe la petición,
consulta la base de datos y devuelve el HTML directamente, sin servlets
de controlador por cada acción. El código repetido se saca a cuatro
fragmentos .jspf. La novedad frente al taller de referencia es que el
control de acceso por rol NO vive en un fragmento incluido en cada
página, sino en un único Filtro de Servlet que intercepta las peticiones
antes de que lleguen al JSP.

## **4.1 Los cuatro fragmentos .jspf**

  -------------------------------------------------------------------------------
  **Fragmento**   **Qué contiene**                 **Se incluye en**
  --------------- -------------------------------- ------------------------------
  conexion.jspf   Constantes de conexión (local y  Toda página que consulte la
                  nube) y el método                base de datos
                  obtenerConexion().               

  header.jspf     Cabecera HTML, enlaces a         Todas las páginas visibles
                  Bootstrap, y la barra de         
                  navegación que cambia según el   
                  rol de la sesión.                

  footer.jspf     Cierre del \<main\>, pie de      Todas las páginas visibles
                  página y el script de Bootstrap. 

  imagenes.jspf   Método imagenPorTipo(): genera   catalogo.jsp, index.jsp,
                  una foto de relleno              detalle_propiedad.jsp,
                  (picsum.photos) cuando la        admin/admin_propiedades.jsp,
                  propiedad aún no tiene imagen    cliente/index.jsp,
                  propia cargada.                  cliente/favoritos.jsp
  -------------------------------------------------------------------------------

Al igual que en el taller de restaurante, estos fragmentos se incluyen
con la directiva estática \<%@ include file=\"\...\" %\>, por lo que la
unión ocurre al compilar y las variables/métodos declarados en un
fragmento (por ejemplo obtenerConexion() de conexion.jspf) quedan
disponibles en la página que lo incluye.

## **4.2 El Filtro de control de acceso (en vez de seguridad.jspf)**

En lugar de declarar un arreglo de roles permitidos al inicio de cada
página e incluir un fragmento de seguridad, el proyecto usa un único
servlet Filter, com.inmobiliaria.filtros.FiltroControlAcceso, registrado
en web.xml para las rutas /admin/\*, /inmobiliaria/\* y /cliente/\*. El
filtro intercepta la petición ANTES de que el JSP se ejecute:

-   Si la ruta pedida no empieza por esos tres prefijos (landing,
    catálogo, login, registro, detalle de propiedad, css, img\...), la
    deja pasar sin restricción.

-   Si la ruta es privada y no hay sesión activa
    (session.getAttribute(\"id_usuario\") == null), redirige a
    login.jsp, guardando en el parámetro redirect a dónde quería ir el
    usuario.

-   Si hay sesión pero el rol guardado no coincide con el que exige el
    prefijo de la URL, redirige a acceso_denegado.jsp. El administrador
    tiene permiso para entrar a cualquier panel.

-   Si todo es correcto, deja continuar la petición hacia el JSP con
    chain.doFilter(\...).

Fragmento representativo del filtro
(com/inmobiliaria/filtros/FiltroControlAcceso.java):

+-----------------------------------------------------------------------+
| String path = uri.substring(contextPath.length());                    |
|                                                                       |
| String rolRequerido = null;                                           |
|                                                                       |
| if (path.startsWith(\"/admin/\")) rolRequerido = \"ADMINISTRADOR\";   |
|                                                                       |
| else if (path.startsWith(\"/inmobiliaria/\")) rolRequerido =          |
| \"INMOBILIARIA\";                                                     |
|                                                                       |
| else if (path.startsWith(\"/cliente/\")) rolRequerido = \"CLIENTE\";  |
|                                                                       |
| if (rolRequerido == null) { chain.doFilter(req, res); return; } //    |
| ruta pública                                                          |
|                                                                       |
| Integer idUsuario = (session != null) ? (Integer)                     |
| session.getAttribute(\"id_usuario\") : null;                          |
|                                                                       |
| if (idUsuario == null) {                                              |
|                                                                       |
| response.sendRedirect(contextPath + \"/login.jsp?redirect=\" +        |
| path.substring(1));                                                   |
|                                                                       |
| return;                                                               |
|                                                                       |
| }                                                                     |
|                                                                       |
| boolean esAdmin = \"ADMINISTRADOR\".equalsIgnoreCase(rolSesion) \|\|  |
| \"ADMIN\".equalsIgnoreCase(rolSesion);                                |
|                                                                       |
| if (!rolRequerido.equalsIgnoreCase(rolSesion) && !esAdmin) {          |
|                                                                       |
| response.sendRedirect(contextPath + \"/acceso_denegado.jsp\");        |
|                                                                       |
| return;                                                               |
|                                                                       |
| }                                                                     |
+=======================================================================+
+-----------------------------------------------------------------------+

## **4.3 Archivos del proyecto**

  ---------------------------------------------------------------------------------------------
  **Archivo**                                     **Rol**         **Qué hace**
  ----------------------------------------------- --------------- -----------------------------
  index.jsp                                       Vista pública   Landing con catálogo
                                                                  destacado y filtros rápidos
                                                                  (ciudad, tipo, precio
                                                                  máximo).

  login.jsp                                       Vista +         Formulario de acceso y
                                                  controlador     validación de credenciales
                                                                  contra usuario.

  registro.jsp                                    Vista +         Alta de una cuenta de
                                                  controlador     cliente: usuario + perfil +
                                                                  usuario_rol en una
                                                                  transacción.

  logout.jsp                                      Controlador     Invalida la sesión.

  catalogo.jsp                                    Vista           Catálogo completo con filtros
                                                                  por ciudad, tipo y precio
                                                                  máximo.

  detalle_propiedad.jsp                           Vista           Ficha de una propiedad:
                                                                  datos, fotos y datos de
                                                                  contacto de la inmobiliaria.

  contactar.jsp                                   Vista +         Formulario con pestañas para
                                                  controlador     agendar cita o enviar
                                                                  solicitud de compra/arriendo
                                                                  (requiere sesión).

  mis_solicitudes.jsp                             Vista +         Lista las citas y solicitudes
                                                  controlador     del usuario en sesión y
                                                                  permite cancelarlas.

  favorito_toggle.jsp                             Controlador     Agrega o quita una propiedad
                                                                  de los favoritos guardados en
                                                                  la sesión.

  acceso_denegado.jsp                             Vista           Página 403: se usa cuando el
                                                                  filtro bloquea el acceso a
                                                                  una ruta privada.

  cliente/index.jsp                               Vista           Panel del cliente con accesos
                                                                  rápidos y propiedades
                                                                  favoritas destacadas.

  cliente/perfil.jsp                              Vista +         Edición de los datos
                                                  controlador     personales (tabla perfil).

  cliente/favoritos.jsp                           Vista           Listado completo de
                                                                  propiedades marcadas como
                                                                  favoritas.

  cliente/solicitudes.jsp                         Vista +         Crear y cancelar solicitudes
                                                  controlador     de compra/arriendo desde el
                                                                  panel del cliente.

  inmobiliaria/index.jsp                          Vista           Panel del agente: resumen de
                                                                  su inmobiliaria y accesos
                                                                  directos.

  inmobiliaria/propiedades.jsp                    Vista +         Listado de propiedades del
                                                  controlador     agente; activar/desactivar
                                                                  publicación.

  inmobiliaria/formulario_propiedad.jsp           Vista +         Alta y edición de una
                                                  controlador     propiedad: datos,
                                                                  características e imágenes.

  inmobiliaria/solicitudes.jsp                    Vista +         Gestión de citas y
                                                  controlador     solicitudes recibidas,
                                                                  filtradas por las propiedades
                                                                  del agente.

  admin/index.jsp                                 Vista           Panel general del
                                                                  administrador con indicadores
                                                                  globales.

  admin/admin_propiedades.jsp                     Vista           Consulta de cualquier
                                                                  propiedad de la plataforma.

  admin/formulario_propiedad.jsp                  Vista +         Alta/edición de propiedades
                                                  controlador     desde el rol administrador.

  admin/usuarios.jsp                              Vista +         Listado de usuarios y acción
                                                  controlador     de bloquear/activar cuentas.

  admin/solicitudes_admin.jsp                     Vista +         Gestión de todas las citas y
                                                  controlador     solicitudes de la plataforma.

  admin/reportes.jsp                              Vista           Indicadores y reportes
                                                                  generales del negocio.

  WEB-INF/jspf/conexion.jspf                      Fragmento       Conexión JDBC centralizada
                                                                  (local/nube).

  WEB-INF/jspf/header.jspf                        Fragmento       Cabecera HTML y barra de
                                                                  navegación dependiente del
                                                                  rol.

  WEB-INF/jspf/footer.jspf                        Fragmento       Cierre de página y JS de
                                                                  Bootstrap.

  WEB-INF/jspf/imagenes.jspf                      Fragmento       Imagen de relleno por tipo de
                                                                  propiedad.

  WEB-INF/classes/\.../FiltroControlAcceso.java   Filtro (Java)   Control de acceso
                                                                  centralizado por rol, para
                                                                  /admin/\*, /inmobiliaria/\* y
                                                                  /cliente/\*.

  WEB-INF/web.xml                                 Configuración   Página inicial, tiempo de
                                                                  sesión, codificación y
                                                                  registro del filtro.

  css/estilos.css                                 Estilos         Ajustes propios sobre
                                                                  Bootstrap.
  ---------------------------------------------------------------------------------------------

## **4.4 Diagrama de arquitectura**

  -----------------------------------------------------------------------
  ![](media/image4.png){width="9.291338582677165in"
  height="4.483419728783902in"}
  -----------------------------------------------------------------------

  -----------------------------------------------------------------------

[]{#_Toc240484070 .anchor}**5. La conexión a la base de datos:
conexion.jspf**

Este fragmento define dos entornos completos ---local (XAMPP) y remoto
(Clever Cloud)--- y una bandera booleana que decide cuál usar. Esto
permite trabajar en el computador de cada integrante y desplegar en la
nube sin tocar el resto del proyecto.

+-----------------------------------------------------------------------+
| \<%@ page import=\"java.sql.\*\" %\>                                  |
|                                                                       |
| \<%!                                                                  |
|                                                                       |
|     // Bandera de entorno: false = Local (XAMPP), true = Remoto       |
| (Clever Cloud)                                                        |
|                                                                       |
|     private static final boolean USAR_NUBE = false;                   |
|                                                                       |
|     // Configuración Local (XAMPP)                                    |
|                                                                       |
|     private static final String DB_HOST_LOCAL = \"localhost\";        |
|                                                                       |
|     private static final String DB_PORT_LOCAL = \"3306\";             |
|                                                                       |
|     private static final String DB_NAME_LOCAL = \"db_inmobiliaria\";  |
|                                                                       |
|     private static final String DB_USER_LOCAL = \"root\";             |
|                                                                       |
|     private static final String DB_PASS_LOCAL = \"\";                 |
|                                                                       |
|     // Configuración Remota (Clever Cloud)                            |
|                                                                       |
|     private static final String DB_HOST_NUBE  =                       |
| \"ber3s5svknzmbdgnmo73-mysql.services.clever-cloud.com\";             |
|                                                                       |
|     private static final String DB_PORT_NUBE  = \"3306\";             |
|                                                                       |
|     private static final String DB_NAME_NUBE  =                       |
| \"ber3s5svknzmbdgnmo73\";                                             |
|                                                                       |
|     private static final String DB_USER_NUBE  = \"uoq2jfpmej2oumnk\"; |
|                                                                       |
|     private static final String DB_PASS_NUBE  =                       |
| \"xwinXFkaYdrlwGsCZvJh\";                                             |
|                                                                       |
|     public Connection obtenerConexion() {                             |
|                                                                       |
|         Connection conn = null;                                       |
|                                                                       |
|         try {                                                         |
|                                                                       |
|             Class.forName(\"com.mysql.cj.jdbc.Driver\");              |
|                                                                       |
|                                                                       |
|                                                                       |
|             String host = USAR_NUBE ? DB_HOST_NUBE : DB_HOST_LOCAL;   |
|                                                                       |
|             String port = USAR_NUBE ? DB_PORT_NUBE : DB_PORT_LOCAL;   |
|                                                                       |
|             String db   = USAR_NUBE ? DB_NAME_NUBE : DB_NAME_LOCAL;   |
|                                                                       |
|             String user = USAR_NUBE ? DB_USER_NUBE : DB_USER_LOCAL;   |
|                                                                       |
|             String pass = USAR_NUBE ? DB_PASS_NUBE : DB_PASS_LOCAL;   |
|                                                                       |
|             String url = \"jdbc:mysql://\" + host + \":\" + port +    |
| \"/\" + db +                                                          |
|                                                                       |
|                                                                       |
|  \"?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true\";   |
|                                                                       |
|             conn = DriverManager.getConnection(url, user, pass);      |
|                                                                       |
|         } catch (Exception e) {                                       |
|                                                                       |
|             // Error silencioso en la declaración para evitar         |
| conflictos de compilación en Tomcat                                   |
|                                                                       |
|         }                                                             |
|                                                                       |
|         return conn;                                                  |
|                                                                       |
|     }                                                                 |
|                                                                       |
| %\>                                                                   |
+=======================================================================+
+-----------------------------------------------------------------------+

  -----------------------------------------------------------------------------------
  **Elemento**                                                   **Explicación**
  -------------------------------------------------------------- --------------------
  USAR_NUBE                                                      Bandera única que
                                                                 decide si la
                                                                 aplicación habla con
                                                                 el MySQL local o con
                                                                 el de Clever Cloud.

  Class.forName(\"com.mysql.cj.jdbc.Driver\")                    Carga el driver
                                                                 mysql-connector-j;
                                                                 el .jar debe estar
                                                                 en WEB-INF/lib.

  useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true   Mismos parámetros
                                                                 que evitan los
                                                                 errores típicos de
                                                                 MySQL 8 sobre SSL y
                                                                 zona horaria.

  obtenerConexion() devuelve null en vez de lanzar excepción     Cada página debe
                                                                 comprobar if (conn
                                                                 != null) antes de
                                                                 consultar; es una
                                                                 diferencia de diseño
                                                                 frente a
                                                                 abrirConexion(), que
                                                                 sí propaga
                                                                 SQLException.
  -----------------------------------------------------------------------------------

# **6. La plantilla visual: header, footer e imágenes**

Todas las páginas comparten la misma estructura: cabecera con Bootstrap
5, barra de navegación que cambia según el rol, contenido propio de la
página y pie. El patrón es idéntico al del taller de referencia: cada
página incluye header.jspf al principio y footer.jspf al final.

+-----------------------------------------------------------------------+
| \<%@ include file=\"/WEB-INF/jspf/conexion.jspf\" %\>                 |
|                                                                       |
| \<%@ include file=\"/WEB-INF/jspf/header.jspf\" %\>                   |
|                                                                       |
| \... contenido propio de la página \...                               |
|                                                                       |
| \<%@ include file=\"/WEB-INF/jspf/footer.jspf\" %\>                   |
+=======================================================================+
+-----------------------------------------------------------------------+

## **6.1 header.jspf**

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%

    // Recuperar datos de la sesión actual

    Integer idUsuarioSesion = (Integer)
session.getAttribute(\"id_usuario\");

    String nombreUsuarioSesion = (String)
session.getAttribute(\"nombre_usuario\");

    String rolUsuarioSesion = (String) session.getAttribute(\"rol\"); //
ej: \'ADMIN\', \'AGENTE\' o \'CLIENTE\'

    Integer idInmobiliariaSesion = (Integer)
session.getAttribute(\"id_inmobiliaria\"); // != null =\> es Agente

    boolean esAdminSesion =
\"ADMINISTRADOR\".equalsIgnoreCase(rolUsuarioSesion) \|\|
\"ADMIN\".equalsIgnoreCase(rolUsuarioSesion);

    boolean esAgenteSesion = !esAdminSesion && idInmobiliariaSesion !=
null;

%\>

\<!DOCTYPE html\>

\<html lang=\"es\"\>

\<head\>

    \<meta charset=\"UTF-8\"\>

    \<meta name=\"viewport\" content=\"width=device-width,
initial-scale=1.0\"\>

    \<title\>Nexo Inmobiliaria\</title\>

    \<!\-- Bootstrap 5 CSS \--\>

    \<link
href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css\"
rel=\"stylesheet\"\>

    \<!\-- Bootstrap Icons \--\>

    \<link rel=\"stylesheet\"
href=\"https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css\"\>

    \<!\-- Estilos propios del sitio \--\>

    \<link rel=\"stylesheet\" href=\"\<%= request.getContextPath()
%\>/css/estilos.css\"\>

\</head\>

\<body class=\"bg-light\"\>

\<nav class=\"navbar navbar-expand-lg navbar-dark bg-dark sticky-top\"\>

  \<div class=\"container\"\>

    \<!\-- Ajustar la ruta del Home dependiendo de donde esté guardado
el archivo \--\>

    \<a class=\"navbar-brand\" href=\"\<%= request.getContextPath()
%\>/index.jsp\"\>

        \<img src=\"\<%= request.getContextPath()
%\>/img/logo-recortado.png\" alt=\"Nexo Inmobiliaria\"
class=\"brand-logo\"\>

    \</a\>

    \<button class=\"navbar-toggler\" type=\"button\"
data-bs-toggle=\"collapse\" data-bs-target=\"#navbarNav\"\>

      \<span class=\"navbar-toggler-icon\"\>\</span\>

    \</button\>

    \<div class=\"collapse navbar-collapse\" id=\"navbarNav\"\>

      \<ul class=\"navbar-nav me-auto\"\>

        \<li class=\"nav-item\"\>

          \<a class=\"nav-link\" href=\"\<%= request.getContextPath()
%\>/index.jsp\"\>Inicio\</a\>

        \</li\>

        \<li class=\"nav-item\"\>

          \<a class=\"nav-link\" href=\"\<%= request.getContextPath()
%\>/catalogo.jsp\"\>Propiedades\</a\>

        \</li\>

      \</ul\>

      \<ul class=\"navbar-nav ms-auto\"\>

        \<% if (idUsuarioSesion == null) { %\>

            \<!\-- Menú cuando NO hay sesión \--\>

            \<li class=\"nav-item\"\>

              \<a class=\"nav-link\" href=\"\<%=
request.getContextPath() %\>/login.jsp\"\>Iniciar Sesión\</a\>

            \</li\>

            \<li class=\"nav-item\"\>

              \<a class=\"btn btn-outline-primary ms-2\" href=\"\<%=
request.getContextPath() %\>/registro.jsp\"\>Registrarse\</a\>

            \</li\>

        \<% } else { %\>

            \<!\-- Menú cuando SÍ hay sesión activa \--\>

            \<li class=\"nav-item dropdown\"\>

              \<a class=\"nav-link dropdown-toggle active fw-bold\"
href=\"#\" role=\"button\" data-bs-toggle=\"dropdown\"\>

                \<i class=\"bi bi-person-circle me-1\"\>\</i\> \<%=
nombreUsuarioSesion != null ? nombreUsuarioSesion : \"Mi Cuenta\" %\>

              \</a\>

              \<ul class=\"dropdown-menu dropdown-menu-end shadow\"\>

                \<% if (esAdminSesion) { %\>

                    \<li\>\<a class=\"dropdown-item\" href=\"\<%=
request.getContextPath() %\>/admin/index.jsp\"\>\<i class=\"bi
bi-speedometer2 me-2\"\>\</i\>Panel Admin\</a\>\</li\>

                    \<li\>\<a class=\"dropdown-item\" href=\"\<%=
request.getContextPath() %\>/admin/admin_propiedades.jsp\"\>\<i
class=\"bi bi-houses me-2\"\>\</i\>Propiedades\</a\>\</li\>

                    \<li\>\<a class=\"dropdown-item\" href=\"\<%=
request.getContextPath() %\>/admin/solicitudes_admin.jsp\"\>\<i
class=\"bi bi-clipboard-check me-2\"\>\</i\>Solicitudes y
Citas\</a\>\</li\>

                    \<li\>\<a class=\"dropdown-item\" href=\"\<%=
request.getContextPath() %\>/admin/usuarios.jsp\"\>\<i class=\"bi
bi-people me-2\"\>\</i\>Usuarios\</a\>\</li\>

                    \<li\>\<a class=\"dropdown-item\" href=\"\<%=
request.getContextPath() %\>/admin/reportes.jsp\"\>\<i class=\"bi
bi-bar-chart-line me-2\"\>\</i\>Reportes\</a\>\</li\>

                \<% } else if (esAgenteSesion) { %\>

                    \<li\>\<a class=\"dropdown-item\" href=\"\<%=
request.getContextPath() %\>/inmobiliaria/index.jsp\"\>\<i class=\"bi
bi-speedometer2 me-2\"\>\</i\>Panel Agente\</a\>\</li\>

                    \<li\>\<a class=\"dropdown-item\" href=\"\<%=
request.getContextPath() %\>/inmobiliaria/propiedades.jsp\"\>\<i
class=\"bi bi-houses me-2\"\>\</i\>Mis Propiedades\</a\>\</li\>

                    \<li\>\<a class=\"dropdown-item\" href=\"\<%=
request.getContextPath() %\>/inmobiliaria/solicitudes.jsp\"\>\<i
class=\"bi bi-clipboard-check me-2\"\>\</i\>Solicitudes y
Citas\</a\>\</li\>

                \<% } else { %\>

                    \<li\>\<a class=\"dropdown-item\" href=\"\<%=
request.getContextPath() %\>/cliente/index.jsp\"\>\<i class=\"bi
bi-house-door me-2\"\>\</i\>Mi Panel Cliente\</a\>\</li\>

                    \<li\>\<a class=\"dropdown-item\" href=\"\<%=
request.getContextPath() %\>/cliente/perfil.jsp\"\>\<i class=\"bi
bi-person me-2\"\>\</i\>Mi Perfil\</a\>\</li\>

                    \<li\>\<a class=\"dropdown-item\" href=\"\<%=
request.getContextPath() %\>/cliente/favoritos.jsp\"\>\<i class=\"bi
bi-heart me-2\"\>\</i\>Mis Favoritos\</a\>\</li\>

                \<% } %\>

                \<li\>\<hr class=\"dropdown-divider\"\>\</li\>

                \<li\>

                    \<a class=\"dropdown-item text-danger\" href=\"\<%=
request.getContextPath() %\>/logout.jsp\"\>

                        \<i class=\"bi bi-box-arrow-right
me-2\"\>\</i\>Cerrar Sesión

                    \</a\>

                \</li\>

              \</ul\>

            \</li\>

        \<% } %\>

      \</ul\>

    \</div\>

  \</div\>

\</nav\>

Recupera de la sesión id_usuario, nombre_usuario, rol e id_inmobiliaria,
y a partir de estos calcula dos banderas (esAdminSesion, esAgenteSesion)
que se usan para dibujar un menú desplegable distinto por rol: enlaces a
/admin/\*, a /inmobiliaria/\* o a /cliente/\* según corresponda. Cuando
no hay sesión, muestra \"Iniciar sesión\" y \"Registrarse\".

## **6.2 footer.jspf**

\</div\> \<!\-- Cierre container main \--\>

\<footer class=\"bg-dark text-white text-center py-3 mt-5\"\>

    \<div class=\"container\"\>

        \<p class=\"mb-0\"\>&copy; 2026 Nexo Inmobiliaria - Todos los
derechos reservados.\</p\>

    \</div\>

\</footer\>

\<!\-- Bootstrap 5 Bundle JS \--\>

\<script
src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js\"\>\</script\>

\<script src=\"\<%= request.getContextPath()
%\>/js/script.js\"\>\</script\>

\</body\>

\</html\>

Cierra el contenedor principal, pinta el pie de página y carga al final
el bundle de JavaScript de Bootstrap (igual que en el taller de
restaurante: debe ir después del HTML para que los menús y el toggler
respondan).

## **6.3 imagenes.jspf**

Aporta el método imagenPorTipo(nombreTipo, seed), que genera una URL de
picsum.photos usando como semilla el id de la propiedad (y opcionalmente
su tipo). Esto resuelve un problema práctico de los proyectos
académicos: mostrar una foto real y consistente por propiedad mientras
no se tenga un banco de imágenes propio, sin repetir la misma imagen
aleatoria en cada recarga.

+-----------------------------------------------------------------------+
| private String imagenPorTipo(String nombreTipo, int seed) {           |
|                                                                       |
| String semilla = \"propiedad\" + seed;                                |
|                                                                       |
| if (nombreTipo != null) {                                             |
|                                                                       |
| semilla += \"-\" +                                                    |
| nombreTipo.toLowerCase().replaceAll(\"\[\^a-z0-9\]\", \"\");          |
|                                                                       |
| }                                                                     |
|                                                                       |
| return \"https://picsum.photos/seed/\" + semilla + \"/600/400\";      |
|                                                                       |
| }                                                                     |
+=======================================================================+
+-----------------------------------------------------------------------+

# **7. Registro e inicio de sesión**

## **7.1 registro.jsp: alta de un cliente**

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ page import=\"java.security.MessageDigest\" %\>

\<%@ include file=\"/WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/header.jspf\" %\>

\<%!

    // Genera un salt aleatorio de 16 bytes en hexadecimal (32
caracteres)

    private String generarSalt() {

        java.security.SecureRandom random = new
java.security.SecureRandom();

        byte\[\] saltBytes = new byte\[16\];

        random.nextBytes(saltBytes);

        StringBuilder hexString = new StringBuilder();

        for (byte b : saltBytes) {

            String hex = Integer.toHexString(0xff & b);

            if (hex.length() == 1) hexString.append(\'0\');

            hexString.append(hex);

        }

        return hexString.toString();

    }

    // Hash SHA-256 de (salt + password), nativo de Java (sin librerías
externas)

    private String hashPassword(String password, String salt) {

        try {

            MessageDigest md = MessageDigest.getInstance(\"SHA-256\");

            byte\[\] hash = md.digest((salt +
password).getBytes(\"UTF-8\"));

            StringBuilder hexString = new StringBuilder();

            for (byte b : hash) {

                String hex = Integer.toHexString(0xff & b);

                if (hex.length() == 1) hexString.append(\'0\');

                hexString.append(hex);

            }

            return hexString.toString();

        } catch (Exception e) {

            return password; // Fallback

        }

    }

%\>

\<%

    String mensajeExito = null;

    String mensajeError = null;

    if (\"POST\".equalsIgnoreCase(request.getMethod())) {

        String correo = request.getParameter(\"correo\");

        String password = request.getParameter(\"password\");

        String nombres = request.getParameter(\"nombres\");

        String apellidos = request.getParameter(\"apellidos\");

        String documento = request.getParameter(\"documento\");

        String telefono = request.getParameter(\"telefono\");

        String direccion = request.getParameter(\"direccion\");

        if (correo != null && password != null && nombres != null &&
documento != null &&

            !correo.trim().isEmpty() && !password.trim().isEmpty() &&
!nombres.trim().isEmpty() && !documento.trim().isEmpty()) {

            Connection conn = obtenerConexion();

            PreparedStatement stmtUser = null;

            PreparedStatement stmtPerfil = null;

            PreparedStatement stmtRol = null;

            ResultSet rsUser = null;

            if (conn != null) {

                try {

                    conn.setAutoCommit(false); // Iniciar transacción
atómica

                    // 1. Generar salt único y cifrar la contraseña
(salt + password)

                    String salt = generarSalt();

                    String passHash = hashPassword(password, salt);

                    // 2. Insertar en tabla \'usuario\'

                    String sqlUser = \"INSERT INTO usuario (correo,
contrasena_hash, salt, estado) VALUES (?, ?, ?, \'ACTIVO\')\";

                    stmtUser = conn.prepareStatement(sqlUser,
Statement.RETURN_GENERATED_KEYS);

                    stmtUser.setString(1, correo.trim());

                    stmtUser.setString(2, passHash);

                    stmtUser.setString(3, salt);

                    stmtUser.executeUpdate();

                    rsUser = stmtUser.getGeneratedKeys();

                    int idUsuarioGenerado = 0;

                    if (rsUser.next()) {

                        idUsuarioGenerado = rsUser.getInt(1);

                    }

                    // 3. Insertar en tabla \'perfil\' (Relación 1:1)

                    String sqlPerfil = \"INSERT INTO perfil (id_usuario,
nombres, apellidos, documento, telefono, direccion) VALUES (?, ?, ?, ?,
?, ?)\";

                    stmtPerfil = conn.prepareStatement(sqlPerfil);

                    stmtPerfil.setInt(1, idUsuarioGenerado);

                    stmtPerfil.setString(2, nombres.trim());

                    stmtPerfil.setString(3, apellidos != null ?
apellidos.trim() : \"\");

                    stmtPerfil.setString(4, documento.trim());

                    stmtPerfil.setString(5, telefono != null ?
telefono.trim() : \"\");

                    stmtPerfil.setString(6, direccion != null ?
direccion.trim() : \"\");

                    stmtPerfil.executeUpdate();

                    // 4. Asignar rol CLIENTE por defecto (Relación N:M
usuario_rol)

                    stmtRol = conn.prepareStatement(

                        \"INSERT INTO usuario_rol (id_usuario, id_rol)
\" +

                        \"SELECT ?, id_rol FROM rol WHERE nombre_rol =
\'CLIENTE\' LIMIT 1\");

                    stmtRol.setInt(1, idUsuarioGenerado);

                    stmtRol.executeUpdate();

                    conn.commit(); // Confirmar cambios en la BD

                    mensajeExito = \"¡Registro exitoso! Ya puedes
iniciar sesión con tu cuenta.\";

                } catch (SQLException e) {

                    if (conn != null) {

                        try { conn.rollback(); } catch (SQLException ex)
{ /\* Ignore \*/ }

                    }

                    if (e.getErrorCode() == 1062) { // UNIQUE constraint
violado

                        if
(e.getMessage().contains(\"uk_usuario_correo\")) {

                            mensajeError = \"El correo electrónico ya se
encuentra registrado.\";

                        } else if
(e.getMessage().contains(\"uk_perfil_documento\")) {

                            mensajeError = \"El número de documento ya
está registrado.\";

                        } else {

                            mensajeError = \"Ya existe un registro con
esos datos únicos en el sistema.\";

                        }

                    } else {

                        mensajeError = \"Error al completar el registro:
\" + e.getMessage();

                    }

                } finally {

                    try { conn.setAutoCommit(true); } catch (Exception
e) {}

                    if (rsUser != null) try { rsUser.close(); } catch
(Exception e) {}

                    if (stmtUser != null) try { stmtUser.close(); }
catch (Exception e) {}

                    if (stmtPerfil != null) try { stmtPerfil.close(); }
catch (Exception e) {}

                    if (stmtRol != null) try { stmtRol.close(); } catch
(Exception e) {}

                    if (conn != null) try { conn.close(); } catch
(Exception e) {}

                }

            }

        } else {

            mensajeError = \"Por favor completa todos los campos
obligatorios.\";

        }

    }

%\>

\<div class=\"container my-5\" style=\"max-width: 600px;\"\>

    \<div class=\"card auth-card\"\>

        \<div class=\"card-header bg-primary text-white text-center
py-3\"\>

            \<h4 class=\"mb-0 fw-bold\"\>Registro de Usuario\</h4\>

        \</div\>

        \<div class=\"card-body p-4\"\>

            \<% if (mensajeExito != null) { %\>

                \<div class=\"alert alert-success alert-dismissible fade
show\" role=\"alert\"\>

                    \<%= mensajeExito %\>

                    \<div class=\"mt-2\"\>

                        \<a href=\"login.jsp\" class=\"btn btn-sm
btn-success\"\>Ir a Iniciar Sesión\</a\>

                    \</div\>

                \</div\>

            \<% } %\>

            \<% if (mensajeError != null) { %\>

                \<div class=\"alert alert-danger alert-dismissible fade
show\" role=\"alert\"\>

                    \<%= mensajeError %\>

                    \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

                \</div\>

            \<% } %\>

            \<form method=\"POST\" action=\"registro.jsp\"\>

                \<div class=\"row g-3\"\>

                    \<div class=\"col-md-6\"\>

                        \<label for=\"nombres\" class=\"form-label
fw-bold\"\>Nombres \*\</label\>

                        \<input type=\"text\" class=\"form-control\"
id=\"nombres\" name=\"nombres\" required\>

                    \</div\>

                    \<div class=\"col-md-6\"\>

                        \<label for=\"apellidos\" class=\"form-label
fw-bold\"\>Apellidos\</label\>

                        \<input type=\"text\" class=\"form-control\"
id=\"apellidos\" name=\"apellidos\"\>

                    \</div\>

                    \<div class=\"col-md-6\"\>

                        \<label for=\"documento\" class=\"form-label
fw-bold\"\>Documento de Identidad \*\</label\>

                        \<input type=\"text\" class=\"form-control\"
id=\"documento\" name=\"documento\" required\>

                    \</div\>

                    \<div class=\"col-md-6\"\>

                        \<label for=\"telefono\" class=\"form-label
fw-bold\"\>Teléfono\</label\>

                        \<input type=\"text\" class=\"form-control\"
id=\"telefono\" name=\"telefono\"\>

                    \</div\>

                    \<div class=\"col-12\"\>

                        \<label for=\"direccion\" class=\"form-label
fw-bold\"\>Dirección\</label\>

                        \<input type=\"text\" class=\"form-control\"
id=\"direccion\" name=\"direccion\"\>

                    \</div\>

                    \<div class=\"col-12\"\>

                        \<label for=\"correo\" class=\"form-label
fw-bold\"\>Correo Electrónico \*\</label\>

                        \<input type=\"email\" class=\"form-control\"
id=\"correo\" name=\"correo\" required
placeholder=\"ejemplo@correo.com\"\>

                    \</div\>

                    \<div class=\"col-12\"\>

                        \<label for=\"password\" class=\"form-label
fw-bold\"\>Contraseña \*\</label\>

                        \<input type=\"password\" class=\"form-control\"
id=\"password\" name=\"password\" required placeholder=\"••••••••\"\>

                    \</div\>

                \</div\>

                \<button type=\"submit\" class=\"btn btn-primary w-100
py-2 mt-4 fw-bold\"\>Crear Cuenta\</button\>

            \</form\>

        \</div\>

        \<div class=\"card-footer text-center bg-light py-3\"\>

            \<small class=\"text-muted\"\>¿Ya tienes una cuenta? \<a
href=\"login.jsp\" class=\"text-primary fw-bold\"\>Inicia Sesión
aquí\</a\>\</small\>

        \</div\>

    \</div\>

\</div\>

\<%@ include file=\"/WEB-INF/jspf/footer.jspf\" %\>

Crea la cuenta con una contraseña cifrada (no en texto plano) y en una
única transacción inserta tres filas relacionadas: la cuenta en usuario,
la ficha personal en perfil y la asignación del rol CLIENTE en
usuario_rol.

  -------------------------------------------------------------------------
  **Paso**   **Operación**
  ---------- --------------------------------------------------------------
  1          Genera un salt aleatorio de 16 bytes (SecureRandom) y calcula
             el hash SHA-256 de salt + contraseña.

  2          con.setAutoCommit(false) --- empieza la transacción.

  3          INSERT INTO usuario (correo, contrasena_hash, salt, estado)
             con RETURN_GENERATED_KEYS.

  4          INSERT INTO perfil (id_usuario, nombres, apellidos, documento,
             telefono, direccion).

  5          INSERT INTO usuario_rol seleccionando el id_rol de la fila rol
             donde nombre_rol = \'CLIENTE\'.

  6          con.commit(). Si algo falla en el camino, con.rollback() y se
             traduce el error 1062 (correo duplicado) a un mensaje claro.
  -------------------------------------------------------------------------

+-----------------------------------------------------------------------+
| **Detalle de diseño:**                                                |
|                                                                       |
| El rol se asigna con una subconsulta (SELECT id_rol FROM rol WHERE    |
| nombre_rol = \'CLIENTE\') en vez de un identificador fijo, así que el |
| código no depende de que el rol CLIENTE tenga siempre el mismo id_rol |
| en la base de datos.                                                  |
+=======================================================================+
+-----------------------------------------------------------------------+

## **7.2 login.jsp: validación e inicio de sesión**

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ page import=\"java.security.MessageDigest\" %\>

\<%@ include file=\"WEB-INF/jspf/conexion.jspf\" %\>

\<%!

    // MISMO método usado en registro.jsp: hash SHA-256 de (salt +
password)

    private String hashPassword(String password, String salt) {

        try {

            MessageDigest md = MessageDigest.getInstance(\"SHA-256\");

            byte\[\] hash = md.digest((salt +
password).getBytes(\"UTF-8\"));

            StringBuilder hexString = new StringBuilder();

            for (byte b : hash) {

                String hex = Integer.toHexString(0xff & b);

                if (hex.length() == 1) hexString.append(\'0\');

                hexString.append(hex);

            }

            return hexString.toString();

        } catch (Exception e) {

            return password; // Fallback

        }

    }

%\>

\<%

    String mensajeError = null;

    if (\"POST\".equalsIgnoreCase(request.getMethod())) {

        String correo = request.getParameter(\"correo\");

        String clave = request.getParameter(\"clave\");

        if (correo != null && clave != null && !correo.trim().isEmpty()
&& !clave.trim().isEmpty()) {

            Connection conn = obtenerConexion();

            if (conn != null) {

                PreparedStatement stmtLogin = null;

                ResultSet rsLogin = null;

                try {

                    // Se trae hash + salt y se valida en Java (no en el
SQL)

                    String sql = \"SELECT u.id_usuario, u.correo,
u.estado, u.contrasena_hash, u.salt, \" +

                                 \"CONCAT(COALESCE(p.nombres, \'\'), \'
\', COALESCE(p.apellidos, \'\')) AS nombre_completo, \" +

                                 \"r.nombre_rol \" +

                                 \"FROM usuario u \" +

                                 \"LEFT JOIN perfil p ON u.id_usuario =
p.id_usuario \" +

                                 \"LEFT JOIN usuario_rol ur ON
u.id_usuario = ur.id_usuario \" +

                                 \"LEFT JOIN rol r ON ur.id_rol =
r.id_rol \" +

                                 \"WHERE u.correo = ?\";

                    stmtLogin = conn.prepareStatement(sql);

                    stmtLogin.setString(1, correo.trim());

                    rsLogin = stmtLogin.executeQuery();

                    if (rsLogin.next()) {

                        String estado = rsLogin.getString(\"estado\");

                        String hashGuardado =
rsLogin.getString(\"contrasena_hash\");

                        String saltGuardado =
rsLogin.getString(\"salt\");

                        // Se hashea la clave ingresada con el mismo
salt guardado del usuario

                        // y se compara contra el hash guardado en la
BD.

                        boolean claveValida = hashPassword(clave.trim(),
saltGuardado != null ? saltGuardado : \"\").equals(hashGuardado);

                        if (!claveValida) {

                            mensajeError = \"Correo electrónico o
contraseña incorrectos.\";

                        } else if
(\"INACTIVO\".equalsIgnoreCase(estado)) {

                            // El DDL solo define ACTIVO/INACTIVO en el
ENUM de usuario.estado

                            mensajeError = \"Tu cuenta se encuentra
inactiva. Contacta al administrador.\";

                        } else {

                            // Guardar datos en la sesión

                            int idUsuario =
rsLogin.getInt(\"id_usuario\");

                            String nombre =
rsLogin.getString(\"nombre_completo\");

                            String rol =
rsLogin.getString(\"nombre_rol\");

                            if (nombre == null \|\|
nombre.trim().isEmpty()) {

                                nombre = rsLogin.getString(\"correo\");

                            }

                            session.setAttribute(\"id_usuario\",
idUsuario);

                            session.setAttribute(\"correo\",
rsLogin.getString(\"correo\"));

                            session.setAttribute(\"nombre_usuario\",
nombre);

                            session.setAttribute(\"rol\", rol != null ?
rol.toUpperCase() : \"CLIENTE\");

                            // Verificar si el usuario tiene una ficha
de AGENTE (tabla inmobiliaria es 1:1 con usuario).

                            // Esto es más robusto que fiarse solo del
texto guardado en rol.nombre_rol.

                            int idInmobiliariaSesion = 0;

                            PreparedStatement stmtInmo = null;

                            ResultSet rsInmo = null;

                            try {

                                stmtInmo = conn.prepareStatement(

                                    \"SELECT id_inmobiliaria FROM
inmobiliaria WHERE id_usuario = ?\");

                                stmtInmo.setInt(1, idUsuario);

                                rsInmo = stmtInmo.executeQuery();

                                if (rsInmo.next()) {

                                    idInmobiliariaSesion =
rsInmo.getInt(\"id_inmobiliaria\");

                                }

                            } catch (SQLException ex) {

                                // Si falla, simplemente no se trata
como agente

                            } finally {

                                if (rsInmo != null) try {
rsInmo.close(); } catch (Exception ex) {}

                                if (stmtInmo != null) try {
stmtInmo.close(); } catch (Exception ex) {}

                            }

                            boolean esAgente = idInmobiliariaSesion \>
0;

                            if (esAgente) {

                               
session.setAttribute(\"id_inmobiliaria\", idInmobiliariaSesion);

                            } else {

                               
session.removeAttribute(\"id_inmobiliaria\");

                            }

                            // REDIRECCIÓN SEGÚN ROL

                            String redirectParam =
request.getParameter(\"redirect\");

                            if (redirectParam != null &&
!redirectParam.trim().isEmpty()) {

                                response.sendRedirect(redirectParam);

                            } else if
(\"ADMINISTRADOR\".equalsIgnoreCase(rol) \|\|
\"ADMIN\".equalsIgnoreCase(rol)) {

                               
response.sendRedirect(\"admin/index.jsp\");

                            } else if (esAgente) {

                               
response.sendRedirect(\"inmobiliaria/index.jsp\");

                            } else {

                               
response.sendRedirect(\"cliente/index.jsp\");

                            }

                            return;

                        }

                    } else {

                        mensajeError = \"Correo electrónico o contraseña
incorrectos.\";

                    }

                } catch (SQLException e) {

                    mensajeError = \"Error al autenticar: \" +
e.getMessage();

                } finally {

                    if (rsLogin != null) try { rsLogin.close(); } catch
(Exception e) {}

                    if (stmtLogin != null) try { stmtLogin.close(); }
catch (Exception e) {}

                    if (conn != null) try { conn.close(); } catch
(Exception e) {}

                }

            } else {

                mensajeError = \"No se pudo conectar a la base de
datos.\";

            }

        } else {

            mensajeError = \"Por favor completa todos los campos.\";

        }

    }

%\>

\<!DOCTYPE html\>

\<html lang=\"es\"\>

\<head\>

    \<meta charset=\"UTF-8\"\>

    \<meta name=\"viewport\" content=\"width=device-width,
initial-scale=1.0\"\>

    \<title\>Iniciar Sesión - Nexo Inmobiliaria\</title\>

    \<link
href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\"
rel=\"stylesheet\"\>

    \<link rel=\"stylesheet\"
href=\"https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css\"\>

    \<link rel=\"stylesheet\" href=\"\<%= request.getContextPath()
%\>/css/estilos.css\"\>

\</head\>

\<body class=\"d-flex align-items-center min-vh-100\"\>

\<div class=\"container\" style=\"max-width: 420px;\"\>

    \<div class=\"card auth-card\"\>

        \<div class=\"card-body p-4\"\>

            \<div class=\"text-center mb-4\"\>

                \<img src=\"\<%= request.getContextPath()
%\>/img/logo-recortado.png\" alt=\"Nexo Inmobiliaria\"
class=\"auth-logo\"\>

                \<p class=\"text-muted small mt-2\"\>Ingresa tus
credenciales para acceder\</p\>

            \</div\>

            \<% if (mensajeError != null) { %\>

                \<div class=\"alert alert-danger alert-dismissible fade
show small\" role=\"alert\"\>

                    \<%= mensajeError %\>

                    \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

                \</div\>

            \<% } %\>

            \<form method=\"POST\" action=\"login.jsp\"\>

                \<div class=\"mb-3\"\>

                    \<label for=\"correo\" class=\"form-label
fw-semibold\"\>Correo Electrónico\</label\>

                    \<input type=\"email\" class=\"form-control\"
id=\"correo\" name=\"correo\" required
placeholder=\"correo@ejemplo.com\"\>

                \</div\>

                \<div class=\"mb-3\"\>

                    \<label for=\"clave\" class=\"form-label
fw-semibold\"\>Contraseña\</label\>

                    \<input type=\"password\" class=\"form-control\"
id=\"clave\" name=\"clave\" required placeholder=\"••••••••\"\>

                \</div\>

                \<button type=\"submit\" class=\"btn btn-primary w-100
fw-bold py-2\"\>Iniciar Sesión\</button\>

            \</form\>

            \<div class=\"text-center mt-3\"\>

                \<a href=\"index.jsp\" class=\"text-secondary
small\"\>&larr; Volver al catálogo\</a\>

            \</div\>

        \</div\>

    \</div\>

\</div\>

\<script
src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"\>\</script\>

\</body\>

\</html\>

Trae el hash y el salt guardados del usuario que escribió el correo,
calcula el hash de la contraseña ingresada con ese mismo salt y compara
ambos valores en Java (no en la consulta SQL). Si coinciden y la cuenta
está ACTIVA, guarda en la sesión id_usuario, correo, nombre_usuario y
rol.

Después consulta si ese usuario tiene una fila propia en la tabla
inmobiliaria; si la tiene, lo trata como agente y guarda id_inmobiliaria
en la sesión. Esta comprobación adicional es más robusta que fiarse
únicamente del texto guardado en rol, porque separa \"qué rol tiene
asignado\" de \"tiene o no una ficha de agente configurada\".

Por último redirige según el rol: a admin/index.jsp, a
inmobiliaria/index.jsp o a cliente/index.jsp; y si la petición trae un
parámetro redirect (puesto por el Filtro cuando alguien intentó entrar a
una ruta privada sin sesión), respeta ese destino en lugar del panel por
defecto.

## **7.3 logout.jsp**

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%

    // Invalida la sesión actual y remueve todos los atributos guardados

    if (session != null) {

        session.invalidate();

    }

    // Redirige al inicio o al login

    response.sendRedirect(\"login.jsp\");

%\>

Invalida la sesión (session.invalidate()) y redirige a login.jsp, igual
que en el taller de referencia.

# **8. Configuración final: web.xml**

El descriptor de despliegue define la página de bienvenida, el tiempo de
sesión, la codificación UTF-8 global y, lo más particular de este
proyecto, el registro del Filtro de control de acceso sobre tres
prefijos de URL.

+-----------------------------------------------------------------------+
| \<?xml version=\"1.0\" encoding=\"UTF-8\"?\>                          |
|                                                                       |
| \<web-app xmlns=\"http://xmlns.jcp.org/xml/ns/javaee\"                |
|                                                                       |
|          xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"      |
|                                                                       |
|          xsi:schemaLocation=\"http://xmlns.jcp.org/xml/ns/javaee      |
|                                                                       |
|              http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd\"     |
|                                                                       |
|          version=\"3.1\"\>                                            |
|                                                                       |
|     \<display-name\>InmobiliariaSantander\</display-name\>            |
|                                                                       |
|     \<!\-- Archivo de inicio por defecto \--\>                        |
|                                                                       |
|     \<welcome-file-list\>                                             |
|                                                                       |
|         \<welcome-file\>index.jsp\</welcome-file\>                    |
|                                                                       |
|     \</welcome-file-list\>                                            |
|                                                                       |
|     \<!\-- Expiración de la sesión (30 minutos) \--\>                 |
|                                                                       |
|     \<session-config\>                                                |
|                                                                       |
|         \<session-timeout\>30\</session-timeout\>                     |
|                                                                       |
|     \</session-config\>                                               |
|                                                                       |
|     \<!\-- Configuración global UTF-8 para todos los JSP \--\>        |
|                                                                       |
|     \<jsp-config\>                                                    |
|                                                                       |
|         \<jsp-property-group\>                                        |
|                                                                       |
|             \<url-pattern\>\*.jsp\</url-pattern\>                     |
|                                                                       |
|             \<page-encoding\>UTF-8\</page-encoding\>                  |
|                                                                       |
|                                                                       |
| \<trim-directive-whitespaces\>true\</trim-directive-whitespaces\>     |
|                                                                       |
|         \</jsp-property-group\>                                       |
|                                                                       |
|     \</jsp-config\>                                                   |
|                                                                       |
|     \<!\-- ====================== FILTRO DE CONTROL DE ACCESO         |
| ====================== \--\>                                          |
|                                                                       |
|     \<!\-- Protege /admin/\*, /inmobiliaria/\* y /cliente/\*. Ver     |
| lógica en                                                             |
|                                                                       |
|          com.inmobiliaria.filtros.FiltroControlAcceso \--\>           |
|                                                                       |
|     \<filter\>                                                        |
|                                                                       |
|         \<filter-name\>FiltroControlAcceso\</filter-name\>            |
|                                                                       |
|                                                                       |
| \<filter                                                              |
| -class\>com.inmobiliaria.filtros.FiltroControlAcceso\</filter-class\> |
|                                                                       |
|     \</filter\>                                                       |
|                                                                       |
|     \<filter-mapping\>                                                |
|                                                                       |
|         \<filter-name\>FiltroControlAcceso\</filter-name\>            |
|                                                                       |
|         \<url-pattern\>/admin/\*\</url-pattern\>                      |
|                                                                       |
|     \</filter-mapping\>                                               |
|                                                                       |
|     \<filter-mapping\>                                                |
|                                                                       |
|         \<filter-name\>FiltroControlAcceso\</filter-name\>            |
|                                                                       |
|         \<url-pattern\>/inmobiliaria/\*\</url-pattern\>               |
|                                                                       |
|     \</filter-mapping\>                                               |
|                                                                       |
|     \<filter-mapping\>                                                |
|                                                                       |
|         \<filter-name\>FiltroControlAcceso\</filter-name\>            |
|                                                                       |
|         \<url-pattern\>/cliente/\*\</url-pattern\>                    |
|                                                                       |
|     \</filter-mapping\>                                               |
|                                                                       |
|     \<!\--                                                            |
| ======                                                                |
| ===================================================================== |
| \--\>                                                                 |
|                                                                       |
|     \<!\-- Manejo global de error 404 (Recurso no encontrado) \--\>   |
|                                                                       |
|     \<error-page\>                                                    |
|                                                                       |
|         \<error-code\>404\</error-code\>                              |
|                                                                       |
|         \<location\>/acceso_denegado.jsp\</location\>                 |
|                                                                       |
|     \</error-page\>                                                   |
|                                                                       |
| \</web-app\>                                                          |
+=======================================================================+
+-----------------------------------------------------------------------+

# **9. Módulo público: inicio, catálogo y detalle**

## **9.1 index.jsp y catalogo.jsp**

##  **9.1.1 index.jsp**

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ include file=\"/WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/header.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/imagenes.jspf\" %\>

\<%

    String filtroCiudad = request.getParameter(\"ciudad\");

    String filtroTipo = request.getParameter(\"tipo\");

    String filtroPrecio = request.getParameter(\"precio_max\");

    Connection conn = obtenerConexion();

    PreparedStatement stmtCiudades = null;

    ResultSet rsCiudades = null;

    PreparedStatement stmtTipos = null;

    ResultSet rsTipos = null;

    PreparedStatement stmt = null;

    ResultSet rs = null;

    if (conn != null) {

        stmtCiudades = conn.prepareStatement(\"SELECT \* FROM ciudad
ORDER BY nombre_ciudad\");

        rsCiudades = stmtCiudades.executeQuery();

        stmtTipos = conn.prepareStatement(\"SELECT \* FROM
tipo_propiedad ORDER BY nombre_tipo\");

        rsTipos = stmtTipos.executeQuery();

        StringBuilder query = new StringBuilder(

            \"SELECT p.\*, c.nombre_ciudad, t.nombre_tipo,
img.url_imagen \" +

            \"FROM propiedad p \" +

            \"INNER JOIN ciudad c ON p.id_ciudad = c.id_ciudad \" +

            \"INNER JOIN tipo_propiedad t ON p.id_tipo = t.id_tipo \" +

            \"LEFT JOIN imagen_propiedad img ON p.id_propiedad =
img.id_propiedad AND img.es_portada = TRUE \" +

            \"WHERE p.activo = TRUE \"

        );

        if (filtroCiudad != null && !filtroCiudad.trim().isEmpty()) {

            query.append(\" AND p.id_ciudad =
\").append(Integer.parseInt(filtroCiudad));

        }

        if (filtroTipo != null && !filtroTipo.trim().isEmpty()) {

            query.append(\" AND p.id_tipo =
\").append(Integer.parseInt(filtroTipo));

        }

        if (filtroPrecio != null && !filtroPrecio.trim().isEmpty()) {

            query.append(\" AND p.precio \<=
\").append(Double.parseDouble(filtroPrecio));

        }

        query.append(\" ORDER BY p.id_propiedad DESC\");

        stmt = conn.prepareStatement(query.toString());

        rs = stmt.executeQuery();

    }

%\>

\<div class=\"container my-4\"\>

\<!\-- Banner Principal \--\>

\<div class=\"hero-banner p-5 mb-4 shadow\"\>

    \<div class=\"container-fluid py-3\"\>

        \<p class=\"hero-eyebrow\"\>Inmobiliaria en Santander\</p\>

        \<h1 class=\"display-5 fw-bold\"\>Encuentra tu inmueble
ideal\</h1\>

        \<p class=\"fs-5\"\>Explora el catálogo de propiedades
disponibles en Santander.\</p\>

    \</div\>

\</div\>

\<!\-- Filtros de Búsqueda \--\>

\<div class=\"card filter-card shadow-sm mb-4\"\>

    \<div class=\"card-body\"\>

        \<form method=\"GET\" action=\"index.jsp\" class=\"row g-3\"\>

            \<div class=\"col-md-4\"\>

                \<label for=\"ciudad\" class=\"form-label
fw-bold\"\>Ciudad\</label\>

                \<select name=\"ciudad\" id=\"ciudad\"
class=\"form-select\"\>

                    \<option value=\"\"\>Todas las ciudades\</option\>

                    \<%

                        if (rsCiudades != null) {

                            while(rsCiudades.next()) {

                                String selected = (filtroCiudad != null
&&
filtroCiudad.equals(String.valueOf(rsCiudades.getInt(\"id_ciudad\")))) ?
\"selected\" : \"\";

                    %\>

                                \<option value=\"\<%=
rsCiudades.getInt(\"id_ciudad\") %\>\" \<%= selected %\>\>

                                    \<%=
rsCiudades.getString(\"nombre_ciudad\") %\>

                                \</option\>

                    \<%

                            }

                        }

                    %\>

                \</select\>

            \</div\>

           

            \<div class=\"col-md-4\"\>

                \<label for=\"tipo\" class=\"form-label fw-bold\"\>Tipo
de Inmueble\</label\>

                \<select name=\"tipo\" id=\"tipo\"
class=\"form-select\"\>

                    \<option value=\"\"\>Todos los tipos\</option\>

                    \<%

                        if (rsTipos != null) {

                            while(rsTipos.next()) {

                                String selected = (filtroTipo != null &&
filtroTipo.equals(String.valueOf(rsTipos.getInt(\"id_tipo\")))) ?
\"selected\" : \"\";

                    %\>

                                \<option value=\"\<%=
rsTipos.getInt(\"id_tipo\") %\>\" \<%= selected %\>\>

                                    \<%=
rsTipos.getString(\"nombre_tipo\") %\>

                                \</option\>

                    \<%

                            }

                        }

                    %\>

                \</select\>

            \</div\>

            \<div class=\"col-md-4\"\>

                \<label for=\"precio_max\" class=\"form-label
fw-bold\"\>Precio Máximo (\$)\</label\>

                \<input type=\"number\" name=\"precio_max\"
id=\"precio_max\" class=\"form-control\" placeholder=\"Ej: 300000000\"
value=\"\<%= (filtroPrecio != null) ? filtroPrecio : \"\" %\>\"\>

            \</div\>

            \<div class=\"col-12 text-end\"\>

                \<a href=\"index.jsp\" class=\"btn btn-outline-secondary
me-2\"\>Limpiar Filtros\</a\>

                \<button type=\"submit\" class=\"btn btn-primary
px-4\"\>Buscar\</button\>

            \</div\>

        \</form\>

    \</div\>

\</div\>

\<!\-- Catálogo de Propiedades \--\>

\<div class=\"row row-cols-1 row-cols-md-3 g-4\"\>

    \<%

        if (rs != null && rs.isBeforeFirst()) {

            while (rs.next()) {

                String img = rs.getString(\"url_imagen\");

                int idProp = rs.getInt(\"id_propiedad\");

                // Las URLs locales tipo /img/\... no existen como
archivos reales todavia,

                // asi que mientras no subas fotos propias, se usa una
foto real y acorde

                // al tipo de inmueble (siempre la misma para la misma
propiedad).

                if (img == null \|\| img.trim().isEmpty() \|\|
img.startsWith(\"/img/\")) {

                    img = imagenPorTipo(rs.getString(\"nombre_tipo\"),
idProp);

                }

    %\>

        \<div class=\"col\"\>

            \<div class=\"card property-card h-100 shadow-sm\"\>

                \<img src=\"\<%= img %\>\" class=\"card-img-top\"
alt=\"\<%= rs.getString(\"titulo\") %\>\"\>

                \<div class=\"card-body\"\>

                    \<span class=\"badge bg-info text-dark mb-2\"\>\<%=
rs.getString(\"nombre_tipo\") %\>\</span\>

                    \<span class=\"badge bg-secondary mb-2\"\>\<%=
rs.getString(\"nombre_ciudad\") %\>\</span\>

                    \<h5 class=\"card-title text-truncate\"\>\<%=
rs.getString(\"titulo\") %\>\</h5\>

                    \<p class=\"card-text text-muted small mb-1\"\>

                        \<strong\>Área:\</strong\> \<%=
rs.getDouble(\"area_m2\") %\> m² \|

                        \<strong\>Hab:\</strong\> \<%=
rs.getInt(\"habitaciones\") %\> \|

                        \<strong\>Baños:\</strong\> \<%=
rs.getInt(\"banos\") %\>

                    \</p\>

                    \<h4 class=\"price\"\>\$\<%=
String.format(\"%,.0f\", rs.getDouble(\"precio\")) %\>\</h4\>

                \</div\>

                \<div class=\"card-footer bg-white border-top-0
d-grid\"\>

                    \<a href=\"detalle_propiedad.jsp?id=\<%= idProp
%\>\" class=\"btn btn-outline-primary\"\>Ver Detalle\</a\>

                \</div\>

            \</div\>

        \</div\>

    \<%

            }

        } else {

    %\>

        \<div class=\"col-12 text-center py-5\"\>

            \<h4 class=\"text-muted\"\>No se encontraron propiedades
disponibles con esos criterios.\</h4\>

        \</div\>

    \<%

        }

        // Cierre de conexiones

        if (rs != null) try { rs.close(); } catch (Exception e) {}

        if (stmt != null) try { stmt.close(); } catch (Exception e) {}

        if (rsCiudades != null) try { rsCiudades.close(); } catch
(Exception e) {}

        if (stmtCiudades != null) try { stmtCiudades.close(); } catch
(Exception e) {}

        if (rsTipos != null) try { rsTipos.close(); } catch (Exception
e) {}

        if (stmtTipos != null) try { stmtTipos.close(); } catch
(Exception e) {}

        if (conn != null) try { conn.close(); } catch (Exception e) {}

    %\>

\</div\>

\<%@ include file=\"/WEB-INF/jspf/footer.jspf\" %\>

##  **9.1.2 catalogo.jsp**

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ include file=\"/WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/header.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/imagenes.jspf\" %\>

\<%

    String filtroCiudad = request.getParameter(\"ciudad\");

    String filtroTipo = request.getParameter(\"tipo\");

    String filtroPrecio = request.getParameter(\"precio_max\");

    Connection conn = obtenerConexion();

    PreparedStatement stmtCiudades = null;

    ResultSet rsCiudades = null;

    PreparedStatement stmtTipos = null;

    ResultSet rsTipos = null;

    PreparedStatement stmt = null;

    ResultSet rs = null;

    if (conn != null) {

        stmtCiudades = conn.prepareStatement(\"SELECT \* FROM ciudad
ORDER BY nombre_ciudad\");

        rsCiudades = stmtCiudades.executeQuery();

        stmtTipos = conn.prepareStatement(\"SELECT \* FROM
tipo_propiedad ORDER BY nombre_tipo\");

        rsTipos = stmtTipos.executeQuery();

        StringBuilder query = new StringBuilder(

            \"SELECT p.\*, c.nombre_ciudad, t.nombre_tipo,
img.url_imagen \" +

            \"FROM propiedad p \" +

            \"INNER JOIN ciudad c ON p.id_ciudad = c.id_ciudad \" +

            \"INNER JOIN tipo_propiedad t ON p.id_tipo = t.id_tipo \" +

            \"LEFT JOIN imagen_propiedad img ON p.id_propiedad =
img.id_propiedad AND img.es_portada = TRUE \" +

            \"WHERE p.activo = TRUE \"

        );

        if (filtroCiudad != null && !filtroCiudad.trim().isEmpty()) {

            query.append(\" AND p.id_ciudad =
\").append(Integer.parseInt(filtroCiudad));

        }

        if (filtroTipo != null && !filtroTipo.trim().isEmpty()) {

            query.append(\" AND p.id_tipo =
\").append(Integer.parseInt(filtroTipo));

        }

        if (filtroPrecio != null && !filtroPrecio.trim().isEmpty()) {

            query.append(\" AND p.precio \<=
\").append(Double.parseDouble(filtroPrecio));

        }

        query.append(\" ORDER BY p.id_propiedad DESC\");

        stmt = conn.prepareStatement(query.toString());

        rs = stmt.executeQuery();

    }

%\>

\<div class=\"container my-4\"\>

\<!\-- Encabezado de la pagina de catalogo \--\>

\<div class=\"catalog-header mb-3\"\>

    \<h2\>Catálogo de propiedades\</h2\>

    \<p\>Filtra y encuentra la propiedad que se ajuste a lo que
buscas.\</p\>

\</div\>

\<!\-- Filtros de Búsqueda \--\>

\<div class=\"card filter-card shadow-sm mb-4\"
style=\"margin-top:0;\"\>

    \<div class=\"card-body\"\>

        \<form method=\"GET\" action=\"catalogo.jsp\" class=\"row
g-3\"\>

            \<div class=\"col-md-4\"\>

                \<label for=\"ciudad\" class=\"form-label
fw-bold\"\>Ciudad\</label\>

                \<select name=\"ciudad\" id=\"ciudad\"
class=\"form-select\"\>

                    \<option value=\"\"\>Todas las ciudades\</option\>

                    \<%

                        if (rsCiudades != null) {

                            while(rsCiudades.next()) {

                                String selected = (filtroCiudad != null
&&
filtroCiudad.equals(String.valueOf(rsCiudades.getInt(\"id_ciudad\")))) ?
\"selected\" : \"\";

                    %\>

                                \<option value=\"\<%=
rsCiudades.getInt(\"id_ciudad\") %\>\" \<%= selected %\>\>

                                    \<%=
rsCiudades.getString(\"nombre_ciudad\") %\>

                                \</option\>

                    \<%

                            }

                        }

                    %\>

                \</select\>

            \</div\>

           

            \<div class=\"col-md-4\"\>

                \<label for=\"tipo\" class=\"form-label fw-bold\"\>Tipo
de Inmueble\</label\>

                \<select name=\"tipo\" id=\"tipo\"
class=\"form-select\"\>

                    \<option value=\"\"\>Todos los tipos\</option\>

                    \<%

                        if (rsTipos != null) {

                            while(rsTipos.next()) {

                                String selected = (filtroTipo != null &&
filtroTipo.equals(String.valueOf(rsTipos.getInt(\"id_tipo\")))) ?
\"selected\" : \"\";

                    %\>

                                \<option value=\"\<%=
rsTipos.getInt(\"id_tipo\") %\>\" \<%= selected %\>\>

                                    \<%=
rsTipos.getString(\"nombre_tipo\") %\>

                                \</option\>

                    \<%

                            }

                        }

                    %\>

                \</select\>

            \</div\>

            \<div class=\"col-md-4\"\>

                \<label for=\"precio_max\" class=\"form-label
fw-bold\"\>Precio Máximo (\$)\</label\>

                \<input type=\"number\" name=\"precio_max\"
id=\"precio_max\" class=\"form-control\" placeholder=\"Ej: 300000000\"
value=\"\<%= (filtroPrecio != null) ? filtroPrecio : \"\" %\>\"\>

            \</div\>

            \<div class=\"col-12 text-end\"\>

                \<a href=\"catalogo.jsp\" class=\"btn
btn-outline-secondary me-2\"\>Limpiar Filtros\</a\>

                \<button type=\"submit\" class=\"btn btn-primary
px-4\"\>Buscar\</button\>

            \</div\>

        \</form\>

    \</div\>

\</div\>

\<!\-- Catálogo de Propiedades \--\>

\<div class=\"row row-cols-1 row-cols-md-3 g-4\"\>

    \<%

        if (rs != null && rs.isBeforeFirst()) {

            while (rs.next()) {

                String img = rs.getString(\"url_imagen\");

                int idProp = rs.getInt(\"id_propiedad\");

                // Las URLs locales tipo /img/\... no existen como
archivos reales todavia,

                // asi que mientras no subas fotos propias, se usa una
foto real y acorde

                // al tipo de inmueble (siempre la misma para la misma
propiedad).

                if (img == null \|\| img.trim().isEmpty() \|\|
img.startsWith(\"/img/\")) {

                    img = imagenPorTipo(rs.getString(\"nombre_tipo\"),
idProp);

                }

    %\>

        \<div class=\"col\"\>

            \<div class=\"card property-card h-100 shadow-sm\"\>

                \<img src=\"\<%= img %\>\" class=\"card-img-top\"
alt=\"\<%= rs.getString(\"titulo\") %\>\"\>

                \<div class=\"card-body\"\>

                    \<span class=\"badge bg-info text-dark mb-2\"\>\<%=
rs.getString(\"nombre_tipo\") %\>\</span\>

                    \<span class=\"badge bg-secondary mb-2\"\>\<%=
rs.getString(\"nombre_ciudad\") %\>\</span\>

                    \<h5 class=\"card-title text-truncate\"\>\<%=
rs.getString(\"titulo\") %\>\</h5\>

                    \<p class=\"card-text text-muted small mb-1\"\>

                        \<strong\>Área:\</strong\> \<%=
rs.getDouble(\"area_m2\") %\> m² \|

                        \<strong\>Hab:\</strong\> \<%=
rs.getInt(\"habitaciones\") %\> \|

                        \<strong\>Baños:\</strong\> \<%=
rs.getInt(\"banos\") %\>

                    \</p\>

                    \<h4 class=\"price\"\>\$\<%=
String.format(\"%,.0f\", rs.getDouble(\"precio\")) %\>\</h4\>

                \</div\>

                \<div class=\"card-footer bg-white border-top-0
d-grid\"\>

                    \<a href=\"detalle_propiedad.jsp?id=\<%= idProp
%\>\" class=\"btn btn-outline-primary\"\>Ver Detalle\</a\>

                \</div\>

            \</div\>

        \</div\>

    \<%

            }

        } else {

    %\>

        \<div class=\"col-12 text-center py-5\"\>

            \<h4 class=\"text-muted\"\>No se encontraron propiedades
disponibles con esos criterios.\</h4\>

        \</div\>

    \<%

        }

        // Cierre de conexiones

        if (rs != null) try { rs.close(); } catch (Exception e) {}

        if (stmt != null) try { stmt.close(); } catch (Exception e) {}

        if (rsCiudades != null) try { rsCiudades.close(); } catch
(Exception e) {}

        if (stmtCiudades != null) try { stmtCiudades.close(); } catch
(Exception e) {}

        if (rsTipos != null) try { rsTipos.close(); } catch (Exception
e) {}

        if (stmtTipos != null) try { stmtTipos.close(); } catch
(Exception e) {}

        if (conn != null) try { conn.close(); } catch (Exception e) {}

    %\>

\</div\>

\<%@ include file=\"/WEB-INF/jspf/footer.jspf\" %\>

Ambas páginas comparten prácticamente la misma consulta: traen las
ciudades y los tipos de propiedad para poblar los filtros, y arman
dinámicamente el SELECT sobre propiedad según los parámetros recibidos
(ciudad, tipo, precio_max). index.jsp muestra un catálogo destacado en
la portada; catalogo.jsp es la versión completa con los mismos filtros.

+-----------------------------------------------------------------------+
| StringBuilder query = new StringBuilder(                              |
|                                                                       |
| \"SELECT p.\*, c.nombre_ciudad, t.nombre_tipo, img.url_imagen \" +    |
|                                                                       |
| \"FROM propiedad p \" +                                               |
|                                                                       |
| \"INNER JOIN ciudad c ON p.id_ciudad = c.id_ciudad \" +               |
|                                                                       |
| \"INNER JOIN tipo_propiedad t ON p.id_tipo = t.id_tipo \" +           |
|                                                                       |
| \"LEFT JOIN imagen_propiedad img ON p.id_propiedad = img.id_propiedad |
| AND img.es_portada = TRUE \" +                                        |
|                                                                       |
| \"WHERE p.activo = TRUE \"                                            |
|                                                                       |
| );                                                                    |
|                                                                       |
| if (filtroCiudad != null) query.append(\" AND p.id_ciudad =           |
| \").append(Integer.parseInt(filtroCiudad));                           |
|                                                                       |
| // \... filtroTipo, filtroPrecio se agregan de la misma forma         |
+=======================================================================+
+-----------------------------------------------------------------------+

## **9.2 detalle_propiedad.jsp**

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ include file=\"/WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/header.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/imagenes.jspf\" %\>

\<%

    String idStr = request.getParameter(\"id\");

    int idPropiedad = 0;

    if (idStr != null && !idStr.trim().isEmpty()) {

        try {

            idPropiedad = Integer.parseInt(idStr);

        } catch (NumberFormatException e) {

            idPropiedad = 0;

        }

    }

    Connection conn = obtenerConexion();

    PreparedStatement stmtProp = null;

    ResultSet rsProp = null;

    PreparedStatement stmtFotos = null;

    ResultSet rsFotos = null;

    boolean existePropiedad = false;

    if (conn != null && idPropiedad \> 0) {

        String sqlProp = \"SELECT p.\*, c.nombre_ciudad, c.departamento,
t.nombre_tipo, i.nombre_comercial, i.telefono_contacto \" +

                         \"FROM propiedad p \" +

                         \"INNER JOIN ciudad c ON p.id_ciudad =
c.id_ciudad \" +

                         \"INNER JOIN tipo_propiedad t ON p.id_tipo =
t.id_tipo \" +

                         \"INNER JOIN inmobiliaria i ON
p.id_inmobiliaria = i.id_inmobiliaria \" +

                         \"WHERE p.id_propiedad = ? AND p.activo =
TRUE\";

        stmtProp = conn.prepareStatement(sqlProp);

        stmtProp.setInt(1, idPropiedad);

        rsProp = stmtProp.executeQuery();

        if (rsProp.next()) {

            existePropiedad = true;

        }

        String sqlFotos = \"SELECT \* FROM imagen_propiedad WHERE
id_propiedad = ? ORDER BY es_portada DESC, id_imagen ASC\";

        stmtFotos = conn.prepareStatement(sqlFotos);

        stmtFotos.setInt(1, idPropiedad);

        rsFotos = stmtFotos.executeQuery();

    }

%\>

\<div class=\"container my-4\"\>

    \<% if (!existePropiedad) { %\>

        \<div class=\"alert alert-warning text-center my-5 shadow-sm\"
role=\"alert\"\>

            \<h4 class=\"alert-heading\"\>¡Propiedad no
encontrada!\</h4\>

            \<p\>El inmueble especificado no existe o ha sido
desactivado.\</p\>

            \<hr\>

            \<a href=\"index.jsp\" class=\"btn btn-primary\"\>Volver al
catálogo\</a\>

        \</div\>

    \<% } else { %\>

        \<a href=\"index.jsp\" class=\"btn btn-outline-secondary
mb-3\"\>&larr; Volver a las propiedades\</a\>

        \<div class=\"row\"\>

            \<!\-- Columna Izquierda: Galería e Información General
\--\>

            \<div class=\"col-md-8\"\>

                \<h2\>\<%= rsProp.getString(\"titulo\") %\>\</h2\>

                \<p class=\"text-muted mb-3\"\>

                    \<i class=\"bi bi-geo-alt\"\>\</i\> \<%=
rsProp.getString(\"nombre_ciudad\") %\>, \<%=
rsProp.getString(\"departamento\") %\>

                    \<span class=\"ms-3 badge bg-outline-dark border
text-dark\"\>Matrícula: \<%=
rsProp.getString(\"matricula_inmobiliaria\") %\>\</span\>

                \</p\>

               

                \<!\-- Carrusel de fotos \--\>

                \<div id=\"carouselPropiedad\" class=\"carousel slide
mb-4 shadow rounded overflow-hidden bg-light\"
data-bs-ride=\"carousel\"\>

                    \<div class=\"carousel-inner\"\>

                        \<%

                            boolean primeraFoto = true;

                            if (rsFotos != null &&
rsFotos.isBeforeFirst()) {

                                while (rsFotos.next()) {

                        %\>

                                    \<div class=\"carousel-item \<%=
primeraFoto ? \"active\" : \"\" %\>\"\>

                                        \<img src=\"\<%=
rsFotos.getString(\"url_imagen\") %\>\" class=\"d-block w-100\"
alt=\"Foto Inmueble\" style=\"max-height: 480px; object-fit: cover;\"\>

                                    \</div\>

                        \<%

                                    primeraFoto = false;

                                }

                            } else {

                        %\>

                                \<div class=\"carousel-item active\"\>

                                    \<img src=\"\<%=
imagenPorTipo(rsProp.getString(\"nombre_tipo\"), idPropiedad) %\>\"
class=\"d-block w-100\" alt=\"\<%= rsProp.getString(\"titulo\") %\>\"
style=\"max-height: 480px; object-fit: cover;\"\>

                                \</div\>

                        \<% } %\>

                    \</div\>

                    \<button class=\"carousel-control-prev\"
type=\"button\" data-bs-target=\"#carouselPropiedad\"
data-bs-slide=\"prev\"\>

                        \<span class=\"carousel-control-prev-icon\"
aria-hidden=\"true\"\>\</span\>

                        \<span
class=\"visually-hidden\"\>Anterior\</span\>

                    \</button\>

                    \<button class=\"carousel-control-next\"
type=\"button\" data-bs-target=\"#carouselPropiedad\"
data-bs-slide=\"next\"\>

                        \<span class=\"carousel-control-next-icon\"
aria-hidden=\"true\"\>\</span\>

                        \<span
class=\"visually-hidden\"\>Siguiente\</span\>

                    \</button\>

                \</div\>

                \<!\-- Descripción detallada \--\>

                \<div class=\"card shadow-sm mb-4\"\>

                    \<div class=\"card-body\"\>

                        \<h4 class=\"card-title mb-3\"\>Descripción de
la Propiedad\</h4\>

                        \<p class=\"card-text text-secondary\"
style=\"white-space: pre-line;\"\>\<%= rsProp.getString(\"descripcion\")
!= null ? rsProp.getString(\"descripcion\") : \"Sin descripción
disponible.\" %\>\</p\>

                    \</div\>

                \</div\>

            \</div\>

            \<!\-- Columna Derecha: Tarjeta de Precio, Características e
Inmobiliaria \--\>

            \<div class=\"col-md-4\"\>

                \<div class=\"card shadow-sm sticky-top\" style=\"top:
20px;\"\>

                    \<div class=\"card-body\"\>

                        \<span class=\"badge bg-info text-dark
mb-2\"\>\<%= rsProp.getString(\"nombre_tipo\") %\>\</span\>

                        \<span class=\"badge bg-success mb-2\"\>\<%=
rsProp.getString(\"estado\") %\>\</span\>

                        \<h3 class=\"text-primary fw-bold my-2\"\>\$\<%=
String.format(\"%,.0f\", rsProp.getDouble(\"precio\")) %\>\</h3\>

                       

                        \<hr\>

                        \<h5 class=\"fw-bold
mb-3\"\>Características\</h5\>

                        \<ul class=\"list-group list-group-flush
mb-4\"\>

                            \<li class=\"list-group-item d-flex
justify-content-between align-items-center px-0\"\>

                                Área \<span\>\<%=
rsProp.getDouble(\"area_m2\") %\> m²\</span\>

                            \</li\>

                            \<li class=\"list-group-item d-flex
justify-content-between align-items-center px-0\"\>

                                Habitaciones \<span\>\<%=
rsProp.getInt(\"habitaciones\") %\>\</span\>

                            \</li\>

                            \<li class=\"list-group-item d-flex
justify-content-between align-items-center px-0\"\>

                                Baños \<span\>\<%=
rsProp.getInt(\"banos\") %\>\</span\>

                            \</li\>

                        \</ul\>

                        \<div class=\"alert alert-light border\"\>

                            \<small class=\"text-muted
d-block\"\>Publicado por:\</small\>

                            \<strong\>\<%=
rsProp.getString(\"nombre_comercial\") %\>\</strong\>\<br\>

                            \<small\>Tel: \<%=
rsProp.getString(\"telefono_contacto\") != null ?
rsProp.getString(\"telefono_contacto\") : \"No disponible\"
%\>\</small\>

                        \</div\>

                        \<div class=\"d-grid gap-2\"\>

                            \<a href=\"contactar.jsp?id=\<%= idPropiedad
%\>\" class=\"btn btn-success btn-lg\"\>Agendar Cita / Contactar\</a\>

                        \</div\>

                    \</div\>

                \</div\>

            \</div\>

        \</div\>

    \<%

        }

        // Cierre de conexiones

        if (rsFotos != null) try { rsFotos.close(); } catch (Exception
e) {}

        if (stmtFotos != null) try { stmtFotos.close(); } catch
(Exception e) {}

        if (rsProp != null) try { rsProp.close(); } catch (Exception e)
{}

        if (stmtProp != null) try { stmtProp.close(); } catch (Exception
e) {}

        if (conn != null) try { conn.close(); } catch (Exception e) {}

    %\>

\</div\>

\<%@ include file=\"/WEB-INF/jspf/footer.jspf\" %\>

Recibe el id de la propiedad por parámetro, trae sus datos junto con la
ciudad, el tipo y los datos de contacto de la inmobiliaria (JOIN con
inmobiliaria), y lista sus fotos. Desde aquí se enlaza a contactar.jsp
para agendar cita o enviar solicitud, y a favorito_toggle.jsp para
guardarla en favoritos.

## **9.3 contactar.jsp**

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ include file=\"/WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/header.jspf\" %\>

\<%

    // CONTROL DE SEGURIDAD: Verificar que el usuario inició sesión

    Integer idCliente = (Integer) session.getAttribute(\"id_usuario\");

    String idPropStr = request.getParameter(\"id\");

   

    if (idCliente == null) {

        // Redirige al login guardando el destino original

        response.sendRedirect(\"login.jsp?redirect=contactar.jsp?id=\" +
(idPropStr != null ? idPropStr : \"\"));

        return;

    }

    int idPropiedad = 0;

    if (idPropStr != null && !idPropStr.trim().isEmpty()) {

        try {

            idPropiedad = Integer.parseInt(idPropStr);

        } catch (NumberFormatException e) {

            idPropiedad = 0;

        }

    }

    Connection conn = obtenerConexion();

    PreparedStatement stmtProp = null;

    ResultSet rsProp = null;

   

    String mensajeExito = null;

    String mensajeError = null;

    // Procesar envío del formulario

    if (\"POST\".equalsIgnoreCase(request.getMethod())) {

        String tipoAccion = request.getParameter(\"tipo_accion\");

        String observaciones = request.getParameter(\"observaciones\");

        if (\"CITA\".equals(tipoAccion)) {

            String fechaHora = request.getParameter(\"fecha_hora\");

            if (fechaHora != null && !fechaHora.isEmpty()) {

                fechaHora = fechaHora.replace(\"T\", \" \") + \":00\";

               

                PreparedStatement stmtCita = null;

                try {

                    String sqlCita = \"INSERT INTO cita (id_propiedad,
id_cliente, fecha_hora, observaciones) VALUES (?, ?, ?, ?)\";

                    stmtCita = conn.prepareStatement(sqlCita);

                    stmtCita.setInt(1, idPropiedad);

                    stmtCita.setInt(2, idCliente);

                    stmtCita.setString(3, fechaHora);

                    stmtCita.setString(4, observaciones);

                   

                    stmtCita.executeUpdate();

                    mensajeExito = \"¡Tu cita ha sido agendada con
éxito! Estado: PENDIENTE de confirmación por la inmobiliaria.\";

                } catch (SQLException e) {

                    if (e.getErrorCode() == 1062) {

                        mensajeError = \"Ya existe una cita agendada en
esa propiedad para el horario seleccionado.\";

                    } else {

                        mensajeError = \"Error al agendar la cita: \" +
e.getMessage();

                    }

                } finally {

                    if (stmtCita != null) try { stmtCita.close(); }
catch (Exception e) {}

                }

            } else {

                mensajeError = \"Selecciona una fecha y hora válidas.\";

            }

        } else if (\"SOLICITUD\".equals(tipoAccion)) {

            String tipoSolicitud =
request.getParameter(\"tipo_solicitud\");

            PreparedStatement stmtSol = null;

            try {

                String sqlSol = \"INSERT INTO solicitud (id_propiedad,
id_cliente, tipo_solicitud, observaciones) VALUES (?, ?, ?, ?)\";

                stmtSol = conn.prepareStatement(sqlSol);

                stmtSol.setInt(1, idPropiedad);

                stmtSol.setInt(2, idCliente);

                stmtSol.setString(3, tipoSolicitud);

                stmtSol.setString(4, observaciones);

               

                stmtSol.executeUpdate();

                mensajeExito = \"¡Solicitud enviada correctamente! La
inmobiliaria revisará tus datos.\";

            } catch (SQLException e) {

                mensajeError = \"Error al enviar la solicitud: \" +
e.getMessage();

            } finally {

                if (stmtSol != null) try { stmtSol.close(); } catch
(Exception e) {}

            }

        }

    }

    // Consulta de los datos de la propiedad

    boolean existePropiedad = false;

    if (conn != null && idPropiedad \> 0) {

        String sql = \"SELECT p.titulo, p.precio, c.nombre_ciudad,
t.nombre_tipo \" +

                     \"FROM propiedad p \" +

                     \"INNER JOIN ciudad c ON p.id_ciudad = c.id_ciudad
\" +

                     \"INNER JOIN tipo_propiedad t ON p.id_tipo =
t.id_tipo \" +

                     \"WHERE p.id_propiedad = ?\";

        stmtProp = conn.prepareStatement(sql);

        stmtProp.setInt(1, idPropiedad);

        rsProp = stmtProp.executeQuery();

        if (rsProp.next()) {

            existePropiedad = true;

        }

    }

%\>

\<div class=\"container my-5\" style=\"max-width: 800px;\"\>

    \<% if (!existePropiedad) { %\>

        \<div class=\"alert alert-warning text-center\" role=\"alert\"\>

            \<h4\>Propiedad no especificada\</h4\>

            \<p\>Por favor selecciona un inmueble del catálogo para
contactar.\</p\>

            \<a href=\"index.jsp\" class=\"btn btn-primary\"\>Ver
Inmuebles\</a\>

        \</div\>

    \<% } else { %\>

        \<a href=\"detalle_propiedad.jsp?id=\<%= idPropiedad %\>\"
class=\"btn btn-outline-secondary mb-4\"\>&larr; Volver al
inmueble\</a\>

        \<div class=\"card shadow-sm\"\>

            \<div class=\"card-header bg-primary text-white py-3\"\>

                \<h4 class=\"mb-0\"\>Contactar por: \<%=
rsProp.getString(\"titulo\") %\>\</h4\>

                \<small\>\<%= rsProp.getString(\"nombre_tipo\") %\> en
\<%= rsProp.getString(\"nombre_ciudad\") %\> --- \$\<%=
String.format(\"%,.0f\", rsProp.getDouble(\"precio\")) %\>\</small\>

            \</div\>

            \<div class=\"card-body p-4\"\>

                \<% if (mensajeExito != null) { %\>

                    \<div class=\"alert alert-success alert-dismissible
fade show\" role=\"alert\"\>

                        \<%= mensajeExito %\>

                        \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

                    \</div\>

                \<% } %\>

                \<% if (mensajeError != null) { %\>

                    \<div class=\"alert alert-danger alert-dismissible
fade show\" role=\"alert\"\>

                        \<%= mensajeError %\>

                        \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

                    \</div\>

                \<% } %\>

                \<ul class=\"nav nav-tabs mb-4\" id=\"contactTab\"
role=\"tablist\"\>

                    \<li class=\"nav-item\" role=\"presentation\"\>

                        \<button class=\"nav-link active fw-bold\"
id=\"cita-tab\" data-bs-toggle=\"tab\" data-bs-target=\"#cita-pane\"
type=\"button\" role=\"tab\"\>Agendar Cita\</button\>

                    \</li\>

                    \<li class=\"nav-item\" role=\"presentation\"\>

                        \<button class=\"nav-link fw-bold\"
id=\"solicitud-tab\" data-bs-toggle=\"tab\"
data-bs-target=\"#solicitud-pane\" type=\"button\" role=\"tab\"\>Enviar
Solicitud (Compra/Arriendo)\</button\>

                    \</li\>

                \</ul\>

                \<div class=\"tab-content\" id=\"contactTabContent\"\>

                    \<!\-- Formulario de Cita \--\>

                    \<div class=\"tab-pane fade show active\"
id=\"cita-pane\" role=\"tabpanel\"\>

                        \<form method=\"POST\"
action=\"contactar.jsp?id=\<%= idPropiedad %\>\"\>

                            \<input type=\"hidden\" name=\"tipo_accion\"
value=\"CITA\"\>

                            \<div class=\"mb-3\"\>

                                \<label for=\"fecha_hora\"
class=\"form-label fw-bold\"\>Fecha y Hora Preferida\</label\>

                                \<input type=\"datetime-local\"
class=\"form-control\" id=\"fecha_hora\" name=\"fecha_hora\" required\>

                            \</div\>

                            \<div class=\"mb-3\"\>

                                \<label for=\"obsCita\"
class=\"form-label fw-bold\"\>Observaciones o Comentarios\</label\>

                                \<textarea class=\"form-control\"
id=\"obsCita\" name=\"observaciones\" rows=\"3\" placeholder=\"Ej:
Prefiero la visita en horas de la mañana\...\"\>\</textarea\>

                            \</div\>

                            \<button type=\"submit\" class=\"btn
btn-primary w-100 py-2\"\>Confirmar Cita\</button\>

                        \</form\>

                    \</div\>

                    \<!\-- Formulario de Solicitud \--\>

                    \<div class=\"tab-pane fade\" id=\"solicitud-pane\"
role=\"tabpanel\"\>

                        \<form method=\"POST\"
action=\"contactar.jsp?id=\<%= idPropiedad %\>\"\>

                            \<input type=\"hidden\" name=\"tipo_accion\"
value=\"SOLICITUD\"\>

                            \<div class=\"mb-3\"\>

                                \<label for=\"tipo_solicitud\"
class=\"form-label fw-bold\"\>Tipo de Solicitud\</label\>

                                \<select class=\"form-select\"
id=\"tipo_solicitud\" name=\"tipo_solicitud\" required\>

                                    \<option value=\"COMPRA\"\>Interés
de Compra\</option\>

                                    \<option value=\"ARRIENDO\"\>Interés
de Arriendo\</option\>

                                \</select\>

                            \</div\>

                            \<div class=\"mb-3\"\>

                                \<label for=\"obsSol\"
class=\"form-label fw-bold\"\>Observaciones / Detalles\</label\>

                                \<textarea class=\"form-control\"
id=\"obsSol\" name=\"observaciones\" rows=\"4\" placeholder=\"Indica
detalles como fecha estimada de mudanza, forma de pago,
etc.\"\>\</textarea\>

                            \</div\>

                            \<button type=\"submit\" class=\"btn
btn-success w-100 py-2\"\>Enviar Solicitud\</button\>

                        \</form\>

                    \</div\>

                \</div\>

            \</div\>

        \</div\>

    \<%

        }

        if (rsProp != null) try { rsProp.close(); } catch (Exception e)
{}

        if (stmtProp != null) try { stmtProp.close(); } catch (Exception
e) {}

        if (conn != null) try { conn.close(); } catch (Exception e) {}

    %\>

\</div\>

\<%@ include file=\"/WEB-INF/jspf/footer.jspf\" %\>

Página protegida por sesión (verificación propia, no solo el filtro,
porque está fuera de /cliente/\*): si no hay id_usuario en la sesión,
redirige a login.jsp?redirect=contactar.jsp?id=\... para volver aquí
después de iniciar sesión. Presenta dos pestañas de Bootstrap: \"Agendar
cita\" y \"Enviar solicitud\".

+-----------------------------------------------------------------------+
| if (\"CITA\".equals(tipoAccion)) {                                    |
|                                                                       |
| String sqlCita = \"INSERT INTO cita (id_propiedad, id_cliente,        |
| fecha_hora, observaciones) VALUES (?, ?, ?, ?)\";                     |
|                                                                       |
| // \... setInt/setString \...                                         |
|                                                                       |
| stmtCita.executeUpdate();                                             |
|                                                                       |
| } catch (SQLException e) {                                            |
|                                                                       |
| if (e.getErrorCode() == 1062) {                                       |
|                                                                       |
| mensajeError = \"Ya existe una cita agendada en esa propiedad para el |
| horario seleccionado.\";                                              |
|                                                                       |
| }                                                                     |
|                                                                       |
| }                                                                     |
|                                                                       |
| } else if (\"SOLICITUD\".equals(tipoAccion)) {                        |
|                                                                       |
| String sqlSol = \"INSERT INTO solicitud (id_propiedad, id_cliente,    |
| tipo_solicitud, observaciones) VALUES (?, ?, ?, ?)\";                 |
|                                                                       |
| // \...                                                               |
|                                                                       |
| }                                                                     |
+=======================================================================+
+-----------------------------------------------------------------------+

## **9.4 mis_solicitudes.jsp y favorito_toggle.jsp**

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ include file=\"/WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/header.jspf\" %\>

\<%

    // Verificar autenticación de usuario

    Integer idUsuario = (Integer) session.getAttribute(\"id_usuario\");

    if (idUsuario == null) {

       
response.sendRedirect(\"login.jsp?redirect=mis_solicitudes.jsp\");

        return;

    }

    Connection conn = obtenerConexion();

    PreparedStatement stmtAccion = null;

    String mensajeExito = null;

    String mensajeError = null;

    // Procesar actualización de estado (Confirmar, Rechazar, Cancelar,
etc.)

    if (\"POST\".equalsIgnoreCase(request.getMethod())) {

        String tipoAccion = request.getParameter(\"tipo_registro\"); //
\"CITA\" o \"SOLICITUD\"

        String nuevoEstado = request.getParameter(\"nuevo_estado\");

        String idRegStr = request.getParameter(\"id_registro\");

        if (idRegStr != null && nuevoEstado != null) {

            try {

                int idRegistro = Integer.parseInt(idRegStr);

                if (\"CITA\".equals(tipoAccion)) {

                    String sqlUpd = \"UPDATE cita SET estado = ? WHERE
id_cita = ?\";

                    stmtAccion = conn.prepareStatement(sqlUpd);

                    stmtAccion.setString(1, nuevoEstado);

                    stmtAccion.setInt(2, idRegistro);

                    stmtAccion.executeUpdate();

                    mensajeExito = \"Estado de la cita actualizado
correctamente.\";

                } else if (\"SOLICITUD\".equals(tipoAccion)) {

                    String sqlUpd = \"UPDATE solicitud SET estado = ?
WHERE id_solicitud = ?\";

                    stmtAccion = conn.prepareStatement(sqlUpd);

                    stmtAccion.setString(1, nuevoEstado);

                    stmtAccion.setInt(2, idRegistro);

                    stmtAccion.executeUpdate();

                    mensajeExito = \"Estado de la solicitud actualizado
correctamente.\";

                }

            } catch (SQLException e) {

                mensajeError = \"Error al actualizar el estado: \" +
e.getMessage();

            } finally {

                if (stmtAccion != null) try { stmtAccion.close(); }
catch (Exception e) {}

            }

        }

    }

    // Consultar las Citas asociadas al cliente

    PreparedStatement stmtCitas = null;

    ResultSet rsCitas = null;

   

    // Consultar las Solicitudes asociadas al cliente

    PreparedStatement stmtSol = null;

    ResultSet rsSol = null;

    if (conn != null) {

        // Query para traer las citas del cliente con información del
inmueble

        String sqlCitas = \"SELECT c.\*, p.titulo, p.precio,
ciu.nombre_ciudad \" +

                          \"FROM cita c \" +

                          \"INNER JOIN propiedad p ON c.id_propiedad =
p.id_propiedad \" +

                          \"INNER JOIN ciudad ciu ON p.id_ciudad =
ciu.id_ciudad \" +

                          \"WHERE c.id_cliente = ? \" +

                          \"ORDER BY c.fecha_hora DESC\";

        stmtCitas = conn.prepareStatement(sqlCitas);

        stmtCitas.setInt(1, idUsuario);

        rsCitas = stmtCitas.executeQuery();

        // Query para traer las solicitudes del cliente con información
del inmueble

        String sqlSol = \"SELECT s.\*, p.titulo, p.precio,
ciu.nombre_ciudad \" +

                        \"FROM solicitud s \" +

                        \"INNER JOIN propiedad p ON s.id_propiedad =
p.id_propiedad \" +

                        \"INNER JOIN ciudad ciu ON p.id_ciudad =
ciu.id_ciudad \" +

                        \"WHERE s.id_cliente = ? \" +

                        \"ORDER BY s.fecha_solicitud DESC\";

        stmtSol = conn.prepareStatement(sqlSol);

        stmtSol.setInt(1, idUsuario);

        rsSol = stmtSol.executeQuery();

    }

%\>

\<div class=\"container my-5\"\>

    \<h2 class=\"fw-bold mb-4\"\>Gestión de Citas y Solicitudes\</h2\>

    \<% if (mensajeExito != null) { %\>

        \<div class=\"alert alert-success alert-dismissible fade show\"
role=\"alert\"\>

            \<%= mensajeExito %\>

            \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

        \</div\>

    \<% } %\>

    \<% if (mensajeError != null) { %\>

        \<div class=\"alert alert-danger alert-dismissible fade show\"
role=\"alert\"\>

            \<%= mensajeError %\>

            \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

        \</div\>

    \<% } %\>

    \<!\-- Tabs para alternar entre Citas y Solicitudes \--\>

    \<ul class=\"nav nav-tabs mb-4\" id=\"panelTab\" role=\"tablist\"\>

        \<li class=\"nav-item\" role=\"presentation\"\>

            \<button class=\"nav-link active fw-bold\" id=\"citas-tab\"
data-bs-toggle=\"tab\" data-bs-target=\"#citas-pane\" type=\"button\"
role=\"tab\"\>Mis Citas Agendadas\</button\>

        \</li\>

        \<li class=\"nav-item\" role=\"presentation\"\>

            \<button class=\"nav-link fw-bold\" id=\"solicitudes-tab\"
data-bs-toggle=\"tab\" data-bs-target=\"#solicitudes-pane\"
type=\"button\" role=\"tab\"\>Mis Solicitudes
(Compra/Arriendo)\</button\>

        \</li\>

    \</ul\>

    \<div class=\"tab-content\" id=\"panelTabContent\"\>

       

        \<!\-- PANE DE CITAS \--\>

        \<div class=\"tab-pane fade show active\" id=\"citas-pane\"
role=\"tabpanel\"\>

            \<div class=\"card shadow-sm border-0\"\>

                \<div class=\"card-body p-0\"\>

                    \<div class=\"table-responsive\"\>

                        \<table class=\"table table-hover align-middle
mb-0\"\>

                            \<thead class=\"table-dark\"\>

                                \<tr\>

                                    \<th\>Propiedad\</th\>

                                    \<th\>Ciudad\</th\>

                                    \<th\>Fecha y Hora\</th\>

                                    \<th\>Observaciones\</th\>

                                    \<th\>Estado\</th\>

                                    \<th
class=\"text-center\"\>Acciones\</th\>

                                \</tr\>

                            \</thead\>

                            \<tbody\>

                                \<%

                                    if (rsCitas != null &&
rsCitas.isBeforeFirst()) {

                                        while (rsCitas.next()) {

                                            String estado =
rsCitas.getString(\"estado\");

                                            String badgeClass =
\"bg-warning text-dark\";

                                            if
(\"CONFIRMADA\".equals(estado)) badgeClass = \"bg-success\";

                                            else if
(\"RECHAZADA\".equals(estado) \|\| \"CANCELADA\".equals(estado))
badgeClass = \"bg-danger\";

                                            else if
(\"REALIZADA\".equals(estado)) badgeClass = \"bg-info text-dark\";

                                %\>

                                            \<tr\>

                                                \<td
class=\"fw-bold\"\>\<%= rsCitas.getString(\"titulo\") %\>\</td\>

                                                \<td\>\<%=
rsCitas.getString(\"nombre_ciudad\") %\>\</td\>

                                                \<td\>\<%=
rsCitas.getTimestamp(\"fecha_hora\") %\>\</td\>

                                                \<td\>\<small
class=\"text-muted\"\>\<%= rsCitas.getString(\"observaciones\") != null
? rsCitas.getString(\"observaciones\") : \"-\" %\>\</small\>\</td\>

                                                \<td\>\<span
class=\"badge \<%= badgeClass %\>\"\>\<%= estado %\>\</span\>\</td\>

                                                \<td
class=\"text-center\"\>

                                                    \<% if
(\"PENDIENTE\".equals(estado)) { %\>

                                                        \<form
method=\"POST\" action=\"mis_solicitudes.jsp\" class=\"d-inline\"\>

                                                            \<input
type=\"hidden\" name=\"tipo_registro\" value=\"CITA\"\>

                                                            \<input
type=\"hidden\" name=\"id_registro\" value=\"\<%=
rsCitas.getInt(\"id_cita\") %\>\"\>

                                                            \<input
type=\"hidden\" name=\"nuevo_estado\" value=\"CANCELADA\"\>

                                                            \<button
type=\"submit\" class=\"btn btn-sm btn-outline-danger\" onclick=\"return
confirm(\'¿Deseas cancelar esta cita?\');\"\>Cancelar\</button\>

                                                        \</form\>

                                                    \<% } else { %\>

                                                        \<span
class=\"text-muted small\"\>Sin acciones\</span\>

                                                    \<% } %\>

                                                \</td\>

                                            \</tr\>

                                \<%

                                        }

                                    } else {

                                %\>

                                        \<tr\>

                                            \<td colspan=\"6\"
class=\"text-center py-4 text-muted\"\>No tienes citas
registradas.\</td\>

                                        \</tr\>

                                \<%  } %\>

                            \</tbody\>

                        \</table\>

                    \</div\>

                \</div\>

            \</div\>

        \</div\>

        \<!\-- PANE DE SOLICITUDES \--\>

        \<div class=\"tab-pane fade\" id=\"solicitudes-pane\"
role=\"tabpanel\"\>

            \<div class=\"card shadow-sm border-0\"\>

                \<div class=\"card-body p-0\"\>

                    \<div class=\"table-responsive\"\>

                        \<table class=\"table table-hover align-middle
mb-0\"\>

                            \<thead class=\"table-dark\"\>

                                \<tr\>

                                    \<th\>Propiedad\</th\>

                                    \<th\>Tipo\</th\>

                                    \<th\>Fecha Solicitud\</th\>

                                    \<th\>Observaciones\</th\>

                                    \<th\>Estado\</th\>

                                \</tr\>

                            \</thead\>

                            \<tbody\>

                                \<%

                                    if (rsSol != null &&
rsSol.isBeforeFirst()) {

                                        while (rsSol.next()) {

                                            String estadoSol =
rsSol.getString(\"estado\");

                                            String badgeClassSol =
\"bg-warning text-dark\";

                                            if
(\"APROBADA\".equals(estadoSol)) badgeClassSol = \"bg-success\";

                                            else if
(\"RECHAZADA\".equals(estadoSol)) badgeClassSol = \"bg-danger\";

                                %\>

                                            \<tr\>

                                                \<td
class=\"fw-bold\"\>\<%= rsSol.getString(\"titulo\") %\>\</td\>

                                                \<td\>\<span
class=\"badge bg-secondary\"\>\<%= rsSol.getString(\"tipo_solicitud\")
%\>\</span\>\</td\>

                                                \<td\>\<%=
rsSol.getTimestamp(\"fecha_solicitud\") %\>\</td\>

                                                \<td\>\<small
class=\"text-muted\"\>\<%= rsSol.getString(\"observaciones\") != null ?
rsSol.getString(\"observaciones\") : \"-\" %\>\</small\>\</td\>

                                                \<td\>\<span
class=\"badge \<%= badgeClassSol %\>\"\>\<%= estadoSol
%\>\</span\>\</td\>

                                            \</tr\>

                                \<%

                                        }

                                    } else {

                                %\>

                                        \<tr\>

                                            \<td colspan=\"5\"
class=\"text-center py-4 text-muted\"\>No tienes solicitudes de
compra/arriendo registradas.\</td\>

                                        \</tr\>

                                \<%  } %\>

                            \</tbody\>

                        \</table\>

                    \</div\>

                \</div\>

            \</div\>

        \</div\>

    \</div\>

    \<%

        if (rsCitas != null) try { rsCitas.close(); } catch (Exception
e) {}

        if (stmtCitas != null) try { stmtCitas.close(); } catch
(Exception e) {}

        if (rsSol != null) try { rsSol.close(); } catch (Exception e) {}

        if (stmtSol != null) try { stmtSol.close(); } catch (Exception
e) {}

        if (conn != null) try { conn.close(); } catch (Exception e) {}

    %\>

\</div\>

\<%@ include file=\"/WEB-INF/jspf/footer.jspf\" %\>

mis_solicitudes.jsp lista las citas y solicitudes del usuario en sesión
y permite actualizar su estado (por ejemplo, cancelarlas) con dos UPDATE
distintos según tipo_registro sea \'CITA\' o \'SOLICITUD\'.

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%@ page import=\"java.util.\*\" %\>

\<%

    // Solo un usuario con sesion iniciada puede tener favoritos

    Integer idUsuarioSesion = (Integer)
session.getAttribute(\"id_usuario\");

    if (idUsuarioSesion == null) {

        response.sendRedirect(request.getContextPath() +
\"/login.jsp\");

        return;

    }

    String idParam = request.getParameter(\"id\");

    String redirect = request.getParameter(\"redirect\");

    if (redirect == null \|\| redirect.trim().isEmpty()) {

        redirect = \"cliente/index.jsp\";

    }

    if (idParam != null) {

        try {

            int idPropiedad = Integer.parseInt(idParam);

            \@SuppressWarnings(\"unchecked\")

            Set\<Integer\> favoritos = (Set\<Integer\>)
session.getAttribute(\"favoritos\");

            if (favoritos == null) {

                favoritos = new HashSet\<Integer\>();

            }

            if (favoritos.contains(idPropiedad)) {

                favoritos.remove(idPropiedad);

            } else {

                favoritos.add(idPropiedad);

            }

            session.setAttribute(\"favoritos\", favoritos);

        } catch (NumberFormatException e) {

            // id invalido, se ignora

        }

    }

    response.sendRedirect(request.getContextPath() + \"/\" + redirect);

%\>

favorito_toggle.jsp guarda los favoritos en un Set\<Integer\> dentro de
la sesión HTTP, no en una tabla de base de datos: agrega o quita el id
de la propiedad del conjunto y redirige de vuelta a la página de origen.
Es una solución simple, pero significa que los favoritos se pierden al
cerrar sesión o al expirar el tiempo de inactividad (30 minutos, según
session-timeout de web.xml).

# **10. Panel del cliente**

Las cuatro páginas de /cliente/\* están protegidas por el Filtro (exige
rol CLIENTE o ADMINISTRADOR) y además repiten su propia verificación de
sesión, reutilizando las variables que header.jspf ya dejó declaradas
(idUsuarioSesion).

  -------------------------------------------------------------------------------
  **Página**                **Qué hace**
  ------------------------- -----------------------------------------------------
  cliente/index.jsp         Panel de bienvenida: accesos directos y un resumen de
                            las propiedades marcadas como favoritas en la sesión.

  cliente/perfil.jsp        Formulario para editar documento, telefono y
                            direccion; hace un UPDATE sobre perfil filtrado por
                            id_usuario de la sesión.

  cliente/favoritos.jsp     Lista completa de las propiedades cuyo id está en el
                            Set de favoritos de la sesión, con imagen de portada.

  cliente/solicitudes.jsp   Permite crear una nueva solicitud de compra/arriendo
                            y cancelar las existentes, sin pasar por
                            contactar.jsp.
  -------------------------------------------------------------------------------

## 10.1 cliente/index.jsp 

\<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\"%\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ page import=\"java.util.\*\" %\>

\<%@ include file=\"/WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/header.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/imagenes.jspf\" %\>

\<%

    // Verificación de sesión de cliente

    // (idUsuarioSesion ya fue declarada por header.jspf, la
reutilizamos)

    if (idUsuarioSesion == null) {

        response.sendRedirect(request.getContextPath() +
\"/login.jsp?redirect=cliente/index.jsp\");

        return;

    }

    \@SuppressWarnings(\"unchecked\")

    Set\<Integer\> favoritos = (Set\<Integer\>)
session.getAttribute(\"favoritos\");

    if (favoritos == null) {

        favoritos = new HashSet\<Integer\>();

    }

%\>

\<div class=\"container my-4\"\>

    \<div class=\"d-flex justify-content-between align-items-center
mb-4\"\>

        \<h2\>Bienvenido a tu Panel de Cliente\</h2\>

        \<div class=\"d-flex gap-2\"\>

            \<a href=\"perfil.jsp\" class=\"btn
btn-outline-secondary\"\>\<i class=\"bi bi-person-fill me-1\"\>\</i\>Mi
Perfil\</a\>

            \<a href=\"favoritos.jsp\" class=\"btn
btn-outline-danger\"\>\<i class=\"bi bi-heart-fill me-1\"\>\</i\>Mis
Favoritos\</a\>

            \<a href=\"solicitudes.jsp\" class=\"btn
btn-outline-info\"\>Ver Mis Solicitudes\</a\>

        \</div\>

    \</div\>

    \<h4 class=\"mb-3\"\>Propiedades Disponibles\</h4\>

    \<div class=\"row g-3\"\>

        \<%

            Connection conn = obtenerConexion(); // \<\-\-- LLAMADA A TU
FUNCIÓN

            if (conn != null) {

                try {

                    String query = \"SELECT p.id_propiedad, p.titulo,
p.precio, p.descripcion, c.nombre_ciudad, t.nombre_tipo, img.url_imagen
\" +

                                   \"FROM propiedad p \" +

                                   \"INNER JOIN ciudad c ON p.id_ciudad
= c.id_ciudad \" +

                                   \"INNER JOIN tipo_propiedad t ON
p.id_tipo = t.id_tipo \" +

                                   \"LEFT JOIN imagen_propiedad img ON
p.id_propiedad = img.id_propiedad AND img.es_portada = TRUE \" +

                                   \"WHERE p.estado = \'DISPONIBLE\' AND
p.activo = TRUE LIMIT 6\";

                    Statement st = conn.createStatement();

                    ResultSet rs = st.executeQuery(query);

                    while (rs.next()) {

                        int idProp = rs.getInt(\"id_propiedad\");

                        String img = rs.getString(\"url_imagen\");

                        if (img == null \|\| img.trim().isEmpty() \|\|
img.startsWith(\"/img/\")) {

                            img =
imagenPorTipo(rs.getString(\"nombre_tipo\"), idProp);

                        }

                        boolean esFavorito = favoritos.contains(idProp);

        %\>

            \<div class=\"col-md-4\"\>

                \<div class=\"card property-card h-100 shadow-sm\"\>

                    \<a href=\"\<%= request.getContextPath()
%\>/favorito_toggle.jsp?id=\<%= idProp %\>&redirect=cliente/index.jsp\"

                       class=\"fav-toggle \<%= esFavorito ? \"is-fav\" :
\"\" %\>\"

                       title=\"\<%= esFavorito ? \"Quitar de favoritos\"
: \"Agregar a favoritos\" %\>\"\>

                        \<i class=\"bi \<%= esFavorito ?
\"bi-heart-fill\" : \"bi-heart\" %\>\"\>\</i\>

                    \</a\>

                    \<img src=\"\<%= img %\>\" class=\"card-img-top\"
alt=\"\<%= rs.getString(\"titulo\") %\>\"\>

                    \<div class=\"card-body\"\>

                        \<span class=\"badge bg-secondary mb-2\"\>\<%=
rs.getString(\"nombre_tipo\") %\>\</span\>

                        \<h5 class=\"card-title\"\>\<%=
rs.getString(\"titulo\") %\>\</h5\>

                        \<p class=\"text-muted\"\>\<%=
rs.getString(\"nombre_ciudad\") %\>\</p\>

                        \<p class=\"card-text\"\>\<%=
rs.getString(\"descripcion\") %\>\</p\>

                        \<h6 class=\"price\"\>\$\<%=
String.format(\"%,.0f\", rs.getBigDecimal(\"precio\")) %\>\</h6\>

                    \</div\>

                    \<div class=\"card-footer bg-white border-top-0\"\>

                        \<a href=\"../detalle_propiedad.jsp?id=\<%=
idProp %\>\" class=\"btn btn-primary btn-sm w-100\"\>Ver Detalle\</a\>

                    \</div\>

                \</div\>

            \</div\>

        \<%

                    }

                    rs.close();

                    st.close();

                } catch (SQLException e) {

                    out.println(\"\<div class=\'alert
alert-danger\'\>Error al cargar propiedades: \" + e.getMessage() +
\"\</div\>\");

                } finally {

                    try { conn.close(); } catch (Exception e) {}

                }

            } else {

                out.println(\"\<div class=\'alert alert-warning\'\>No
hay conexión con la base de datos.\</div\>\");

            }

        %\>

    \</div\>

\</div\>

\<%@ include file=\"/WEB-INF/jspf/footer.jspf\" %\>

## 10.2 cliente/perfil.jsp 

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ include file=\"/WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/header.jspf\" %\>

\<%

    // Verificación de sesión (idUsuarioSesion ya viene declarada por
header.jspf)

    if (idUsuarioSesion == null) {

        response.sendRedirect(request.getContextPath() +
\"/login.jsp?redirect=cliente/perfil.jsp\");

        return;

    }

    String mensajeExito = null;

    String mensajeError = null;

    Connection conn = obtenerConexion();

    // \-\-\-\-\-\-\-\-\-- Guardar cambios (POST) \-\-\-\-\-\-\-\-\--

    if (\"POST\".equalsIgnoreCase(request.getMethod()) && conn != null)
{

        String documento = request.getParameter(\"documento\");

        String telefono = request.getParameter(\"telefono\");

        String direccion = request.getParameter(\"direccion\");

        if (documento != null && !documento.trim().isEmpty()) {

            PreparedStatement stmtUpd = null;

            try {

                String sqlUpd = \"UPDATE perfil SET documento = ?,
telefono = ?, direccion = ? WHERE id_usuario = ?\";

                stmtUpd = conn.prepareStatement(sqlUpd);

                stmtUpd.setString(1, documento.trim());

                stmtUpd.setString(2, telefono != null ? telefono.trim()
: \"\");

                stmtUpd.setString(3, direccion != null ?
direccion.trim() : \"\");

                stmtUpd.setInt(4, idUsuarioSesion);

                int filas = stmtUpd.executeUpdate();

                if (filas \> 0) {

                    mensajeExito = \"Tu perfil se actualizó
correctamente.\";

                } else {

                    mensajeError = \"No se encontró un perfil asociado a
tu cuenta.\";

                }

            } catch (SQLException e) {

                if (e.getErrorCode() == 1062) { // UNIQUE constraint
violado (uk_perfil_documento)

                    mensajeError = \"Ese número de documento ya está
registrado por otro usuario.\";

                } else {

                    mensajeError = \"Error al actualizar el perfil: \" +
e.getMessage();

                }

            } finally {

                if (stmtUpd != null) try { stmtUpd.close(); } catch
(Exception e) {}

            }

        } else {

            mensajeError = \"El documento es obligatorio.\";

        }

    }

    // \-\-\-\-\-\-\-\-\-- Cargar datos actuales (siempre, para repintar
el formulario) \-\-\-\-\-\-\-\-\--

    String nombresActual = \"\", apellidosActual = \"\", documentoActual
= \"\", telefonoActual = \"\", direccionActual = \"\";

    String correoActual = \"\";

    if (conn != null) {

        PreparedStatement stmtGet = null;

        ResultSet rsGet = null;

        try {

            stmtGet = conn.prepareStatement(

                \"SELECT u.correo, p.nombres, p.apellidos, p.documento,
p.telefono, p.direccion \" +

                \"FROM usuario u LEFT JOIN perfil p ON u.id_usuario =
p.id_usuario \" +

                \"WHERE u.id_usuario = ?\");

            stmtGet.setInt(1, idUsuarioSesion);

            rsGet = stmtGet.executeQuery();

            if (rsGet.next()) {

                correoActual = rsGet.getString(\"correo\");

                nombresActual = rsGet.getString(\"nombres\") != null ?
rsGet.getString(\"nombres\") : \"\";

                apellidosActual = rsGet.getString(\"apellidos\") != null
? rsGet.getString(\"apellidos\") : \"\";

                documentoActual = rsGet.getString(\"documento\") != null
? rsGet.getString(\"documento\") : \"\";

                telefonoActual = rsGet.getString(\"telefono\") != null ?
rsGet.getString(\"telefono\") : \"\";

                direccionActual = rsGet.getString(\"direccion\") != null
? rsGet.getString(\"direccion\") : \"\";

            }

        } catch (SQLException e) {

            if (mensajeError == null) mensajeError = \"Error al cargar
tu perfil: \" + e.getMessage();

        } finally {

            if (rsGet != null) try { rsGet.close(); } catch (Exception
e) {}

            if (stmtGet != null) try { stmtGet.close(); } catch
(Exception e) {}

        }

    }

    if (conn != null) try { conn.close(); } catch (Exception e) {}

%\>

\<div class=\"container my-5\" style=\"max-width: 600px;\"\>

    \<div class=\"d-flex justify-content-between align-items-center
mb-4\"\>

        \<h2 class=\"fw-bold m-0\"\>Mi Perfil\</h2\>

        \<a href=\"index.jsp\" class=\"btn
btn-outline-secondary\"\>&larr; Volver al Panel\</a\>

    \</div\>

    \<% if (mensajeExito != null) { %\>

        \<div class=\"alert alert-success alert-dismissible fade show\"
role=\"alert\"\>

            \<%= mensajeExito %\>

            \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

        \</div\>

    \<% } %\>

    \<% if (mensajeError != null) { %\>

        \<div class=\"alert alert-danger alert-dismissible fade show\"
role=\"alert\"\>

            \<%= mensajeError %\>

            \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

        \</div\>

    \<% } %\>

    \<div class=\"card shadow-sm border-0\"\>

        \<div class=\"card-body p-4\"\>

            \<div class=\"mb-3\"\>

                \<label class=\"form-label fw-bold\"\>Nombre
completo\</label\>

                \<input type=\"text\" class=\"form-control\"
value=\"\<%= nombresActual %\> \<%= apellidosActual %\>\" disabled\>

                \<div class=\"form-text\"\>Para cambiar tu nombre
contacta al administrador.\</div\>

            \</div\>

            \<div class=\"mb-4\"\>

                \<label class=\"form-label fw-bold\"\>Correo
electrónico\</label\>

                \<input type=\"text\" class=\"form-control\"
value=\"\<%= correoActual %\>\" disabled\>

            \</div\>

            \<form method=\"POST\" action=\"perfil.jsp\"\>

                \<div class=\"mb-3\"\>

                    \<label for=\"documento\" class=\"form-label
fw-bold\"\>Documento de Identidad \*\</label\>

                    \<input type=\"text\" class=\"form-control\"
id=\"documento\" name=\"documento\"

                           value=\"\<%= documentoActual %\>\" required\>

                \</div\>

                \<div class=\"mb-3\"\>

                    \<label for=\"telefono\" class=\"form-label
fw-bold\"\>Teléfono\</label\>

                    \<input type=\"text\" class=\"form-control\"
id=\"telefono\" name=\"telefono\"

                           value=\"\<%= telefonoActual %\>\"\>

                \</div\>

                \<div class=\"mb-4\"\>

                    \<label for=\"direccion\" class=\"form-label
fw-bold\"\>Dirección\</label\>

                    \<input type=\"text\" class=\"form-control\"
id=\"direccion\" name=\"direccion\"

                           value=\"\<%= direccionActual %\>\"\>

                \</div\>

                \<button type=\"submit\" class=\"btn btn-primary w-100
py-2 fw-bold\"\>Guardar Cambios\</button\>

            \</form\>

        \</div\>

    \</div\>

\</div\>

\<%@ include file=\"/WEB-INF/jspf/footer.jspf\" %\>

## 10.3 cliente/favoritos.jsp 

\<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\"%\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ page import=\"java.util.\*\" %\>

\<%@ include file=\"/WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/header.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/imagenes.jspf\" %\>

\<%

    // Verificación de sesión de cliente

    if (idUsuarioSesion == null) {

        response.sendRedirect(request.getContextPath() +
\"/login.jsp?redirect=cliente/favoritos.jsp\");

        return;

    }

    \@SuppressWarnings(\"unchecked\")

    Set\<Integer\> favoritos = (Set\<Integer\>)
session.getAttribute(\"favoritos\");

    if (favoritos == null) {

        favoritos = new HashSet\<Integer\>();

    }

%\>

\<div class=\"container my-4\"\>

    \<div class=\"d-flex justify-content-between align-items-center
mb-4\"\>

        \<h2\>\<i class=\"bi bi-heart-fill text-danger me-2\"\>\</i\>Mis
Favoritos\</h2\>

        \<a href=\"index.jsp\" class=\"btn
btn-outline-secondary\"\>&larr; Volver a mi panel\</a\>

    \</div\>

    \<div class=\"row row-cols-1 row-cols-md-3 g-4\"\>

        \<%

            if (favoritos.isEmpty()) {

        %\>

            \<div class=\"col-12 text-center py-5\"\>

                \<i class=\"bi bi-heart\" style=\"font-size: 3rem;
color: var(\--line);\"\>\</i\>

                \<h4 class=\"text-muted mt-3\"\>Todavía no has guardado
propiedades favoritas.\</h4\>

                \<p class=\"text-muted\"\>Explora el catálogo y toca el
corazón de las propiedades que te interesen.\</p\>

                \<a href=\"\<%= request.getContextPath()
%\>/catalogo.jsp\" class=\"btn btn-primary mt-2\"\>Explorar
catálogo\</a\>

            \</div\>

        \<%

            } else {

                Connection conn = obtenerConexion();

                if (conn != null) {

                    PreparedStatement stmt = null;

                    ResultSet rs = null;

                    try {

                        StringBuilder placeholders = new
StringBuilder();

                        for (int i = 0; i \< favoritos.size(); i++) {

                            placeholders.append(i == 0 ? \"?\" :
\",?\");

                        }

                        String sql = \"SELECT p.\*, c.nombre_ciudad,
t.nombre_tipo, img.url_imagen \" +

                                     \"FROM propiedad p \" +

                                     \"INNER JOIN ciudad c ON
p.id_ciudad = c.id_ciudad \" +

                                     \"INNER JOIN tipo_propiedad t ON
p.id_tipo = t.id_tipo \" +

                                     \"LEFT JOIN imagen_propiedad img ON
p.id_propiedad = img.id_propiedad AND img.es_portada = TRUE \" +

                                     \"WHERE p.id_propiedad IN (\" +
placeholders + \")\";

                        stmt = conn.prepareStatement(sql);

                        int idx = 1;

                        for (Integer fid : favoritos) {

                            stmt.setInt(idx++, fid);

                        }

                        rs = stmt.executeQuery();

                        boolean hayResultados = false;

                        while (rs.next()) {

                            hayResultados = true;

                            int idProp = rs.getInt(\"id_propiedad\");

                            String img = rs.getString(\"url_imagen\");

                            if (img == null \|\| img.trim().isEmpty()
\|\| img.startsWith(\"/img/\")) {

                                img =
imagenPorTipo(rs.getString(\"nombre_tipo\"), idProp);

                            }

        %\>

            \<div class=\"col\"\>

                \<div class=\"card property-card h-100 shadow-sm\"\>

                    \<a href=\"\<%= request.getContextPath()
%\>/favorito_toggle.jsp?id=\<%= idProp
%\>&redirect=cliente/favoritos.jsp\"

                       class=\"fav-toggle is-fav\" title=\"Quitar de
favoritos\"\>

                        \<i class=\"bi bi-heart-fill\"\>\</i\>

                    \</a\>

                    \<img src=\"\<%= img %\>\" class=\"card-img-top\"
alt=\"\<%= rs.getString(\"titulo\") %\>\"\>

                    \<div class=\"card-body\"\>

                        \<span class=\"badge bg-info text-dark
mb-2\"\>\<%= rs.getString(\"nombre_tipo\") %\>\</span\>

                        \<span class=\"badge bg-secondary mb-2\"\>\<%=
rs.getString(\"nombre_ciudad\") %\>\</span\>

                        \<h5 class=\"card-title text-truncate\"\>\<%=
rs.getString(\"titulo\") %\>\</h5\>

                        \<h4 class=\"price\"\>\$\<%=
String.format(\"%,.0f\", rs.getDouble(\"precio\")) %\>\</h4\>

                    \</div\>

                    \<div class=\"card-footer bg-white border-top-0
d-grid\"\>

                        \<a href=\"\<%= request.getContextPath()
%\>/detalle_propiedad.jsp?id=\<%= idProp %\>\" class=\"btn
btn-outline-primary\"\>Ver Detalle\</a\>

                    \</div\>

                \</div\>

            \</div\>

        \<%

                        }

                        if (!hayResultados) {

        %\>

            \<div class=\"col-12 text-center py-5\"\>

                \<h4 class=\"text-muted\"\>Las propiedades que habías
guardado ya no están disponibles.\</h4\>

            \</div\>

        \<%

                        }

                    } catch (SQLException e) {

                        out.println(\"\<div class=\'col-12\'\>\<div
class=\'alert alert-danger\'\>Error al cargar tus favoritos: \" +
e.getMessage() + \"\</div\>\</div\>\");

                    } finally {

                        if (rs != null) try { rs.close(); } catch
(Exception e) {}

                        if (stmt != null) try { stmt.close(); } catch
(Exception e) {}

                        try { conn.close(); } catch (Exception e) {}

                    }

                } else {

        %\>

            \<div class=\"col-12\"\>\<div class=\"alert
alert-warning\"\>No hay conexión con la base de datos.\</div\>\</div\>

        \<%

                }

            }

        %\>

    \</div\>

\</div\>

\<%@ include file=\"/WEB-INF/jspf/footer.jspf\" %\>

## 10.4 cliente/solicitudes.jsp 

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ include file=\"../WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"../WEB-INF/jspf/header.jspf\" %\>

\<%

    // Verificación de sesión de cliente

    Integer idUsuario = (Integer) session.getAttribute(\"id_usuario\");

    if (idUsuario == null) {

       
response.sendRedirect(\"../login.jsp?redirect=cliente/solicitudes.jsp\");

        return;

    }

    Connection conn = obtenerConexion();

    String mensajeExito = null;

    String mensajeError = null;

    // 1. PROCESAR ACCIONES (NUEVA SOLICITUD O CANCELACIÓN)

    if (\"POST\".equalsIgnoreCase(request.getMethod())) {

        String accion = request.getParameter(\"accion\");

        if (\"crear\".equals(accion)) {

            String idPropStr = request.getParameter(\"id_propiedad\");

            String tipoSolicitud =
request.getParameter(\"tipo_solicitud\");

            String observaciones =
request.getParameter(\"observaciones\");

            if (idPropStr != null && tipoSolicitud != null &&

                observaciones != null &&
!observaciones.trim().isEmpty()) {

                PreparedStatement stmtIns = null;

                try {

                    int idProp = Integer.parseInt(idPropStr);

                    // La tabla real es \"solicitud\" (no
\"solicitud_contacto\"),

                    // con columna id_cliente (no id_usuario) y
tipo_solicitud obligatorio (COMPRA/ARRIENDO).

                    // estado y fecha_solicitud se llenan solos por
defecto (PENDIENTE / NOW()).

                    String sqlIns = \"INSERT INTO solicitud
(id_propiedad, id_cliente, tipo_solicitud, observaciones) \" +

                                    \"VALUES (?, ?, ?, ?)\";

                    stmtIns = conn.prepareStatement(sqlIns);

                    stmtIns.setInt(1, idProp);

                    stmtIns.setInt(2, idUsuario);

                    stmtIns.setString(3, tipoSolicitud);

                    stmtIns.setString(4, observaciones.trim());

                    stmtIns.executeUpdate();

                    mensajeExito = \"Tu solicitud ha sido enviada
correctamente. Un asesor se pondrá en contacto contigo pronto.\";

                } catch (SQLException e) {

                    mensajeError = \"Error al registrar la solicitud:
\" + e.getMessage();

                } catch (NumberFormatException e) {

                    mensajeError = \"La propiedad seleccionada no es
válida.\";

                } finally {

                    if (stmtIns != null) try { stmtIns.close(); } catch
(Exception e) {}

                }

            } else {

                mensajeError = \"Por favor selecciona una propiedad, el
tipo de solicitud y escribe un mensaje.\";

            }

        } else if (\"cancelar\".equals(accion)) {

            String idSolStr = request.getParameter(\"id_solicitud\");

            if (idSolStr != null) {

                PreparedStatement stmtCan = null;

                try {

                    int idSol = Integer.parseInt(idSolStr);

                    // El ENUM de estado solo admite
PENDIENTE/APROBADA/RECHAZADA (no CANCELADO),

                    // asi que \"cancelar\" retira la solicitud mientras
siga PENDIENTE.

                    String sqlCan = \"DELETE FROM solicitud WHERE
id_solicitud = ? AND id_cliente = ? AND estado = \'PENDIENTE\'\";

                    stmtCan = conn.prepareStatement(sqlCan);

                    stmtCan.setInt(1, idSol);

                    stmtCan.setInt(2, idUsuario);

                    int filas = stmtCan.executeUpdate();

                    if (filas \> 0) {

                        mensajeExito = \"La solicitud fue cancelada y
retirada exitosamente.\";

                    } else {

                        mensajeError = \"No se pudo cancelar: la
solicitud ya no está pendiente o no existe.\";

                    }

                } catch (SQLException e) {

                    mensajeError = \"Error al cancelar la solicitud:
\" + e.getMessage();

                } finally {

                    if (stmtCan != null) try { stmtCan.close(); } catch
(Exception e) {}

                }

            }

        }

    }

    // 2. CONSULTAR LISTADO DE SOLICITUDES DEL CLIENTE

    PreparedStatement stmtList = null;

    ResultSet rsList = null;

    try {

        String sqlList = \"SELECT s.\*, p.titulo AS titulo_propiedad,
p.precio, c.nombre_ciudad \" +

                         \"FROM solicitud s \" +

                         \"INNER JOIN propiedad p ON s.id_propiedad =
p.id_propiedad \" +

                         \"INNER JOIN ciudad c ON p.id_ciudad =
c.id_ciudad \" +

                         \"WHERE s.id_cliente = ? \" +

                         \"ORDER BY s.fecha_solicitud DESC\";

        stmtList = conn.prepareStatement(sqlList);

        stmtList.setInt(1, idUsuario);

        rsList = stmtList.executeQuery();

    } catch (SQLException e) {

        mensajeError = \"Error al cargar las solicitudes: \" +
e.getMessage();

    }

    // 3. CONSULTAR PROPIEDADES DISPONIBLES PARA EL COMBOBOX DE NUEVA
SOLICITUD

    Statement stmtPropList = conn.createStatement();

    ResultSet rsProps = stmtPropList.executeQuery(\"SELECT id_propiedad,
titulo FROM propiedad WHERE estado = \'DISPONIBLE\' ORDER BY titulo\");

%\>

\<div class=\"container my-5\"\>

    \<div class=\"d-flex justify-content-between align-items-center
mb-4\"\>

        \<div\>

            \<h2 class=\"fw-bold mb-0\"\>\<i class=\"bi bi-chat-dots
text-success me-2\"\>\</i\>Mis Solicitudes\</h2\>

            \<p class=\"text-muted small\"\>Consulta el estado de tus
solicitudes de compra o arriendo enviadas a la inmobiliaria\</p\>

        \</div\>

        \<div\>

            \<a href=\"index.jsp\" class=\"btn btn-outline-secondary
me-2\"\>&larr; Volver al Panel\</a\>

            \<button type=\"button\" class=\"btn btn-primary fw-bold\"
data-bs-toggle=\"modal\" data-bs-target=\"#modalNuevaSolicitud\"\>

                \<i class=\"bi bi-plus-circle me-1\"\>\</i\> Nueva
Solicitud

            \</button\>

        \</div\>

    \</div\>

    \<% if (mensajeExito != null) { %\>

        \<div class=\"alert alert-success alert-dismissible fade show
shadow-sm\" role=\"alert\"\>

            \<i class=\"bi bi-check-circle-fill me-2\"\>\</i\>\<%=
mensajeExito %\>

            \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

        \</div\>

    \<% } %\>

    \<% if (mensajeError != null) { %\>

        \<div class=\"alert alert-danger alert-dismissible fade show
shadow-sm\" role=\"alert\"\>

            \<i class=\"bi bi-exclamation-triangle-fill
me-2\"\>\</i\>\<%= mensajeError %\>

            \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

        \</div\>

    \<% } %\>

    \<div class=\"card shadow-sm border-0\"\>

        \<div class=\"card-body p-0\"\>

            \<div class=\"table-responsive\"\>

                \<table class=\"table table-hover align-middle mb-0\"\>

                    \<thead class=\"table-light\"\>

                        \<tr\>

                            \<th\>ID\</th\>

                            \<th\>Propiedad\</th\>

                            \<th\>Ubicación\</th\>

                            \<th\>Tipo\</th\>

                            \<th\>Observaciones\</th\>

                            \<th\>Fecha\</th\>

                            \<th\>Estado\</th\>

                            \<th class=\"text-center\"\>Acciones\</th\>

                        \</tr\>

                    \</thead\>

                    \<tbody\>

                        \<%

                            if (rsList != null &&
rsList.isBeforeFirst()) {

                                while (rsList.next()) {

                                    int idSol =
rsList.getInt(\"id_solicitud\");

                                    int idProp =
rsList.getInt(\"id_propiedad\");

                                    String estado =
rsList.getString(\"estado\");

                                    String tipoSolicitud =
rsList.getString(\"tipo_solicitud\");

                                    String observaciones =
rsList.getString(\"observaciones\");

                                    Timestamp fecha =
rsList.getTimestamp(\"fecha_solicitud\");

                                    String badgeClass = \"bg-warning
text-dark\";

                                    if
(\"APROBADA\".equalsIgnoreCase(estado)) {

                                        badgeClass = \"bg-success\";

                                    } else if
(\"RECHAZADA\".equalsIgnoreCase(estado)) {

                                        badgeClass = \"bg-danger\";

                                    }

                        %\>

                                    \<tr\>

                                        \<td\>\<strong\>#\<%= idSol
%\>\</strong\>\</td\>

                                        \<td\>

                                            \<a
href=\"../detalle_propiedad.jsp?id=\<%= idProp %\>\" class=\"fw-bold
text-decoration-none text-dark\"\>

                                                \<%=
rsList.getString(\"titulo_propiedad\") %\>

                                            \</a\>

                                            \<div class=\"small
text-muted\"\>

                                                \$\<%=
String.format(\"%,.0f\", rsList.getDouble(\"precio\")) %\>

                                            \</div\>

                                        \</td\>

                                        \<td\>\<%=
rsList.getString(\"nombre_ciudad\") %\>\</td\>

                                        \<td\>\<span class=\"badge
bg-secondary\"\>\<%= tipoSolicitud %\>\</span\>\</td\>

                                        \<td style=\"max-width:
260px;\"\>

                                            \<span
class=\"d-inline-block text-truncate\" style=\"max-width: 240px;\"
title=\"\<%= observaciones %\>\"\>

                                                \<%= observaciones !=
null ? observaciones : \"\" %\>

                                            \</span\>

                                        \</td\>

                                        \<td class=\"small
text-muted\"\>

                                            \<%= fecha != null ?
fecha.toString().substring(0, 16) : \"N/A\" %\>

                                        \</td\>

                                        \<td\>

                                            \<span class=\"badge \<%=
badgeClass %\>\"\>\<%= estado %\>\</span\>

                                        \</td\>

                                        \<td class=\"text-center\"\>

                                            \<div class=\"btn-group
btn-group-sm\"\>

                                                \<a
href=\"../detalle_propiedad.jsp?id=\<%= idProp %\>\" class=\"btn
btn-outline-primary\" title=\"Ver Inmueble\"\>

                                                    \<i class=\"bi
bi-eye-fill\"\>\</i\>

                                                \</a\>

                                                \<% if
(\"PENDIENTE\".equalsIgnoreCase(estado)) { %\>

                                                    \<form
method=\"POST\" action=\"solicitudes.jsp\" class=\"d-inline\"
onsubmit=\"return confirm(\'¿Seguro que deseas cancelar esta
solicitud?\');\"\>

                                                        \<input
type=\"hidden\" name=\"accion\" value=\"cancelar\"\>

                                                        \<input
type=\"hidden\" name=\"id_solicitud\" value=\"\<%= idSol %\>\"\>

                                                        \<button
type=\"submit\" class=\"btn btn-outline-danger\" title=\"Cancelar
Solicitud\"\>

                                                            Cancelar

                                                        \</button\>

                                                    \</form\>

                                                \<% } %\>

                                            \</div\>

                                        \</td\>

                                    \</tr\>

                        \<%

                                }

                            } else {

                        %\>

                                \<tr\>

                                    \<td colspan=\"8\"
class=\"text-center py-5 text-muted\"\>

                                        \<i class=\"bi bi-inbox
display-4 d-block mb-2 text-secondary\"\>\</i\>

                                        No has enviado ninguna solicitud
aún.\<br\>

                                        \<button type=\"button\"
class=\"btn btn-primary btn-sm mt-3 fw-bold\" data-bs-toggle=\"modal\"
data-bs-target=\"#modalNuevaSolicitud\"\>

                                            Enviar Primera Solicitud

                                        \</button\>

                                    \</td\>

                                \</tr\>

                        \<%  } %\>

                    \</tbody\>

                \</table\>

            \</div\>

        \</div\>

    \</div\>

\</div\>

\<!\-- MODAL PARA NUEVA SOLICITUD \--\>

\<div class=\"modal fade\" id=\"modalNuevaSolicitud\" tabindex=\"-1\"
aria-labelledby=\"modalNuevaSolicitudLabel\" aria-hidden=\"true\"\>

  \<div class=\"modal-dialog\"\>

    \<div class=\"modal-content\"\>

      \<form method=\"POST\" action=\"solicitudes.jsp\"\>

        \<input type=\"hidden\" name=\"accion\" value=\"crear\"\>

        \<div class=\"modal-header\"\>

          \<h5 class=\"modal-title fw-bold\"
id=\"modalNuevaSolicitudLabel\"\>\<i class=\"bi bi-send
me-2\"\>\</i\>Nueva Solicitud sobre Inmueble\</h5\>

          \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"modal\" aria-label=\"Close\"\>\</button\>

        \</div\>

        \<div class=\"modal-body\"\>

          \<div class=\"mb-3\"\>

            \<label for=\"id_propiedad\" class=\"form-label
fw-bold\"\>Selecciona el Inmueble \*\</label\>

            \<select class=\"form-select\" id=\"id_propiedad\"
name=\"id_propiedad\" required\>

                \<option value=\"\" disabled selected\>\-- Selecciona un
inmueble \--\</option\>

                \<% while (rsProps.next()) { %\>

                    \<option value=\"\<%=
rsProps.getInt(\"id_propiedad\") %\>\"\>

                        #\<%= rsProps.getInt(\"id_propiedad\") %\> -
\<%= rsProps.getString(\"titulo\") %\>

                    \</option\>

                \<% } %\>

            \</select\>

          \</div\>

          \<div class=\"mb-3\"\>

            \<label for=\"tipo_solicitud\" class=\"form-label
fw-bold\"\>Tipo de Solicitud \*\</label\>

            \<select class=\"form-select\" id=\"tipo_solicitud\"
name=\"tipo_solicitud\" required\>

                \<option value=\"\" disabled selected\>\-- Selecciona
una opción \--\</option\>

                \<option value=\"COMPRA\"\>Compra\</option\>

                \<option value=\"ARRIENDO\"\>Arriendo\</option\>

            \</select\>

          \</div\>

          \<div class=\"mb-3\"\>

            \<label for=\"observaciones\" class=\"form-label
fw-bold\"\>Tu Mensaje / Inquietud \*\</label\>

            \<textarea class=\"form-control\" id=\"observaciones\"
name=\"observaciones\" rows=\"4\" required placeholder=\"Escribe aquí
tus dudas sobre el precio, agenda de visita o condiciones del
contrato\...\"\>\</textarea\>

          \</div\>

        \</div\>

        \<div class=\"modal-footer\"\>

          \<button type=\"button\" class=\"btn btn-secondary\"
data-bs-dismiss=\"modal\"\>Cancelar\</button\>

          \<button type=\"submit\" class=\"btn btn-primary
fw-bold\"\>Enviar Solicitud\</button\>

        \</div\>

      \</form\>

    \</div\>

  \</div\>

\</div\>

\<%

    if (rsList != null) try { rsList.close(); } catch (Exception e) {}

    if (stmtList != null) try { stmtList.close(); } catch (Exception e)
{}

    if (rsProps != null) try { rsProps.close(); } catch (Exception e) {}

    if (stmtPropList != null) try { stmtPropList.close(); } catch
(Exception e) {}

    if (conn != null) try { conn.close(); } catch (Exception e) {}

%\>

\<%@ include file=\"../WEB-INF/jspf/footer.jspf\" %\>

[]{#_Toc240484086 .anchor}

# 11. Panel del agente (inmobiliaria)

Las páginas de /inmobiliaria/\* verifican dos condiciones seguidas: que
haya sesión (idUsuario != null) y que esa sesión tenga id_inmobiliaria
(es decir, que el usuario tenga ficha de agente); si falta cualquiera de
las dos, se redirige a login.jsp o a acceso_denegado.jsp
respectivamente.

  ----------------------------------------------------------------------------------
  **Página**                              **Qué hace**
  --------------------------------------- ------------------------------------------
  inmobiliaria/index.jsp                  Panel de resumen: indicadores de la
                                          inmobiliaria del agente en sesión.

  inmobiliaria/propiedades.jsp            Lista solo las propiedades cuyo
                                          id_inmobiliaria coincide con el del
                                          agente; permite activar/desactivar cada
                                          una.

  inmobiliaria/formulario_propiedad.jsp   Alta y edición de propiedades: inserta en
                                          propiedad, sincroniza
                                          propiedad_caracteristica (borra y vuelve a
                                          insertar las marcadas) y agrega filas en
                                          imagen_propiedad.

  inmobiliaria/solicitudes.jsp            Gestión de citas y solicitudes, pero cada
                                          UPDATE hace JOIN con propiedad y filtra
                                          por id_inmobiliaria, de modo que un agente
                                          nunca puede cambiar el estado de una
                                          solicitud de un inmueble ajeno.
  ----------------------------------------------------------------------------------

## 11.1 inmobiliaria/index.jsp

\<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\"%\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ include file=\"/WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/header.jspf\" %\>

\<%

    // Verificación de sesión de agente: debe haber iniciado sesión Y
tener ficha en la tabla \'inmobiliaria\'

    Integer idUsuario = (Integer) session.getAttribute(\"id_usuario\");

    Integer idInmobiliaria = (Integer)
session.getAttribute(\"id_inmobiliaria\");

    if (idUsuario == null) {

        response.sendRedirect(request.getContextPath() +
\"/login.jsp?redirect=inmobiliaria/index.jsp\");

        return;

    }

    if (idInmobiliaria == null) {

        response.sendRedirect(request.getContextPath() +
\"/acceso_denegado.jsp\");

        return;

    }

%\>

\<div class=\"container my-4\"\>

    \<div class=\"d-flex justify-content-between align-items-center
mb-4\"\>

        \<div\>

            \<h2 class=\"fw-bold m-0\"\>Panel del Agente\</h2\>

            \<p class=\"text-muted m-0\"\>Resumen de tu inmobiliaria y
accesos rápidos\</p\>

        \</div\>

    \</div\>

    \<%

        String nombreComercial = \"Mi Inmobiliaria\";

        int totalPropiedades = 0;

        int solicitudesPendientes = 0;

        int citasPendientes = 0;

        Connection conn = obtenerConexion();

        if (conn != null) {

            try {

                PreparedStatement stmtInmo = conn.prepareStatement(

                    \"SELECT nombre_comercial FROM inmobiliaria WHERE
id_inmobiliaria = ?\");

                stmtInmo.setInt(1, idInmobiliaria);

                ResultSet rsInmo = stmtInmo.executeQuery();

                if (rsInmo.next()) nombreComercial =
rsInmo.getString(\"nombre_comercial\");

                rsInmo.close(); stmtInmo.close();

                PreparedStatement stmt1 = conn.prepareStatement(

                    \"SELECT COUNT(\*) FROM propiedad WHERE
id_inmobiliaria = ? AND activo = TRUE\");

                stmt1.setInt(1, idInmobiliaria);

                ResultSet rs1 = stmt1.executeQuery();

                if (rs1.next()) totalPropiedades = rs1.getInt(1);

                rs1.close(); stmt1.close();

                PreparedStatement stmt2 = conn.prepareStatement(

                    \"SELECT COUNT(\*) FROM solicitud s INNER JOIN
propiedad p ON s.id_propiedad = p.id_propiedad \" +

                    \"WHERE p.id_inmobiliaria = ? AND s.estado =
\'PENDIENTE\'\");

                stmt2.setInt(1, idInmobiliaria);

                ResultSet rs2 = stmt2.executeQuery();

                if (rs2.next()) solicitudesPendientes = rs2.getInt(1);

                rs2.close(); stmt2.close();

                PreparedStatement stmt3 = conn.prepareStatement(

                    \"SELECT COUNT(\*) FROM cita c INNER JOIN propiedad
p ON c.id_propiedad = p.id_propiedad \" +

                    \"WHERE p.id_inmobiliaria = ? AND c.estado =
\'PENDIENTE\'\");

                stmt3.setInt(1, idInmobiliaria);

                ResultSet rs3 = stmt3.executeQuery();

                if (rs3.next()) citasPendientes = rs3.getInt(1);

                rs3.close(); stmt3.close();

            } catch (SQLException e) {

                out.println(\"\<div class=\'alert alert-danger\'\>Error
al cargar métricas: \" + e.getMessage() + \"\</div\>\");

            } finally {

                try { conn.close(); } catch (Exception e) {}

            }

        } else {

            out.println(\"\<div class=\'alert alert-warning\'\>No se
pudo conectar a la base de datos.\</div\>\");

        }

    %\>

    \<div class=\"alert alert-primary fw-bold\"\>

        \<i class=\"bi bi-briefcase me-2\"\>\</i\>\<%= nombreComercial
%\>

    \</div\>

    \<!\-- TARJETAS DE MÉTRICAS \--\>

    \<div class=\"row g-3 mb-4\"\>

        \<div class=\"col-md-4\"\>

            \<div class=\"card bg-primary text-white p-3 shadow-sm\"\>

                \<h5\>Mis Propiedades Activas\</h5\>

                \<h3 class=\"fw-bold\"\>\<%= totalPropiedades %\>\</h3\>

            \</div\>

        \</div\>

        \<div class=\"col-md-4\"\>

            \<div class=\"card bg-warning text-dark p-3 shadow-sm\"\>

                \<h5\>Solicitudes Pendientes\</h5\>

                \<h3 class=\"fw-bold\"\>\<%= solicitudesPendientes
%\>\</h3\>

            \</div\>

        \</div\>

        \<div class=\"col-md-4\"\>

            \<div class=\"card bg-info text-dark p-3 shadow-sm\"\>

                \<h5\>Citas Pendientes\</h5\>

                \<h3 class=\"fw-bold\"\>\<%= citasPendientes %\>\</h3\>

            \</div\>

        \</div\>

    \</div\>

    \<!\-- ACCESOS RÁPIDOS \--\>

    \<h4 class=\"mb-3 fw-bold\"\>Gestión de mi Inmobiliaria\</h4\>

    \<div class=\"d-flex flex-wrap gap-2 mb-4\"\>

        \<a href=\"propiedades.jsp\" class=\"btn btn-outline-primary\"\>

            🏠 Mis Propiedades

        \</a\>

        \<a href=\"formulario_propiedad.jsp\" class=\"btn
btn-success\"\>

            ➕ Nueva Propiedad

        \</a\>

        \<a href=\"solicitudes.jsp\" class=\"btn btn-outline-warning
text-dark\"\>

            📋 Solicitudes y Citas

        \</a\>

    \</div\>

\</div\>

\<%@ include file=\"/WEB-INF/jspf/footer.jspf\" %\>

## 11.2 inmobiliaria/propiedades.jsp

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ include file=\"/WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/header.jspf\" %\>

\<%

    // Verificación de sesión de agente

    Integer idUsuario = (Integer) session.getAttribute(\"id_usuario\");

    Integer idInmobiliaria = (Integer)
session.getAttribute(\"id_inmobiliaria\");

    if (idUsuario == null) {

        response.sendRedirect(request.getContextPath() +
\"/login.jsp?redirect=inmobiliaria/propiedades.jsp\");

        return;

    }

    if (idInmobiliaria == null) {

        response.sendRedirect(request.getContextPath() +
\"/acceso_denegado.jsp\");

        return;

    }

    Connection conn = obtenerConexion();

    String mensajeExito = request.getParameter(\"exito\");

    String mensajeError = null;

    // Procesar acción de cambio de estado (activar/desactivar), SIEMPRE
validando que la propiedad

    // pertenezca a este agente (id_inmobiliaria) para no permitir tocar
propiedades ajenas.

    String accion = request.getParameter(\"accion\");

    String idEliminar = request.getParameter(\"id\");

    if (accion != null && idEliminar != null && conn != null) {

        PreparedStatement stmtAccion = null;

        try {

            if (\"eliminar\".equals(accion)) {

                String sqlDel = \"UPDATE propiedad SET activo = FALSE
WHERE id_propiedad = ? AND id_inmobiliaria = ?\";

                stmtAccion = conn.prepareStatement(sqlDel);

                stmtAccion.setInt(1, Integer.parseInt(idEliminar));

                stmtAccion.setInt(2, idInmobiliaria);

                int filas = stmtAccion.executeUpdate();

                mensajeExito = filas \> 0 ? \"Propiedad desactivada
correctamente.\" : null;

                if (filas == 0) mensajeError = \"No tienes permiso sobre
esa propiedad.\";

            } else if (\"activar\".equals(accion)) {

                String sqlAct = \"UPDATE propiedad SET activo = TRUE
WHERE id_propiedad = ? AND id_inmobiliaria = ?\";

                stmtAccion = conn.prepareStatement(sqlAct);

                stmtAccion.setInt(1, Integer.parseInt(idEliminar));

                stmtAccion.setInt(2, idInmobiliaria);

                int filas = stmtAccion.executeUpdate();

                mensajeExito = filas \> 0 ? \"Propiedad reactivada
correctamente.\" : null;

                if (filas == 0) mensajeError = \"No tienes permiso sobre
esa propiedad.\";

            }

        } catch (SQLException e) {

            mensajeError = \"Error al procesar la acción: \" +
e.getMessage();

        } finally {

            if (stmtAccion != null) try { stmtAccion.close(); } catch
(Exception e) {}

        }

    }

    // Consulta de propiedades, SOLO las de este agente (id_inmobiliaria
de la sesión)

    PreparedStatement stmtProp = null;

    ResultSet rsProp = null;

    if (conn != null) {

        try {

            String sqlList = \"SELECT p.id_propiedad,
p.matricula_inmobiliaria, p.titulo, p.precio, p.area_m2, \" +

                             \"p.habitaciones, p.banos, p.estado,
p.activo, c.nombre_ciudad, t.nombre_tipo \" +

                             \"FROM propiedad p \" +

                             \"INNER JOIN ciudad c ON p.id_ciudad =
c.id_ciudad \" +

                             \"INNER JOIN tipo_propiedad t ON p.id_tipo
= t.id_tipo \" +

                             \"WHERE p.id_inmobiliaria = ? \" +

                             \"ORDER BY p.id_propiedad DESC\";

            stmtProp = conn.prepareStatement(sqlList);

            stmtProp.setInt(1, idInmobiliaria);

            rsProp = stmtProp.executeQuery();

        } catch (SQLException e) {

            mensajeError = \"Error al listar propiedades: \" +
e.getMessage();

        }

    }

%\>

\<div class=\"container my-5\"\>

    \<div class=\"d-flex justify-content-between align-items-center
mb-4\"\>

        \<div\>

            \<h2 class=\"fw-bold m-0\"\>Mis Propiedades\</h2\>

            \<p class=\"text-muted m-0\"\>Inmuebles publicados por tu
inmobiliaria\</p\>

        \</div\>

        \<div\>

            \<a href=\"index.jsp\" class=\"btn btn-outline-secondary
me-2\"\>&larr; Volver al Panel\</a\>

            \<a href=\"formulario_propiedad.jsp\" class=\"btn
btn-success fw-bold\"\>+ Nueva Propiedad\</a\>

        \</div\>

    \</div\>

    \<% if (mensajeExito != null) { %\>

        \<div class=\"alert alert-success alert-dismissible fade show\"
role=\"alert\"\>

            \<%= mensajeExito %\>

            \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

        \</div\>

    \<% } %\>

    \<% if (mensajeError != null) { %\>

        \<div class=\"alert alert-danger alert-dismissible fade show\"
role=\"alert\"\>

            \<%= mensajeError %\>

            \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

        \</div\>

    \<% } %\>

    \<div class=\"card shadow-sm border-0\"\>

        \<div class=\"card-body p-0\"\>

            \<div class=\"table-responsive\"\>

                \<table class=\"table table-hover align-middle mb-0\"\>

                    \<thead class=\"table-light\"\>

                        \<tr\>

                            \<th\># ID\</th\>

                            \<th\>Matrícula\</th\>

                            \<th\>Título\</th\>

                            \<th\>Tipo\</th\>

                            \<th\>Ciudad\</th\>

                            \<th\>Estado\</th\>

                            \<th\>Precio (\$ COP)\</th\>

                            \<th\>Visibilidad\</th\>

                            \<th class=\"text-end
px-4\"\>Acciones\</th\>

                        \</tr\>

                    \</thead\>

                    \<tbody\>

                        \<%

                            boolean hayPropiedades = false;

                            if (rsProp != null) {

                                while (rsProp.next()) {

                                    hayPropiedades = true;

                                    int idP =
rsProp.getInt(\"id_propiedad\");

                                    boolean estaActivo =
rsProp.getBoolean(\"activo\");

                                    String est =
rsProp.getString(\"estado\");

                        %\>

                        \<tr class=\"\<%= !estaActivo ?
\"table-secondary text-muted\" : \"\" %\>\"\>

                            \<td class=\"fw-bold\"\>#\<%= idP %\>\</td\>

                            \<td\>\<small class=\"text-muted\"\>\<%=
rsProp.getString(\"matricula_inmobiliaria\") %\>\</small\>\</td\>

                            \<td class=\"fw-semibold\"\>\<%=
rsProp.getString(\"titulo\") %\>\</td\>

                            \<td\>\<span class=\"badge
bg-secondary\"\>\<%= rsProp.getString(\"nombre_tipo\")
%\>\</span\>\</td\>

                            \<td\>\<%=
rsProp.getString(\"nombre_ciudad\") %\>\</td\>

                            \<td\>

                                \<% if (\"DISPONIBLE\".equals(est)) {
%\>

                                    \<span class=\"badge
bg-success\"\>Disponible\</span\>

                                \<% } else if
(\"RESERVADA\".equals(est)) { %\>

                                    \<span class=\"badge bg-warning
text-dark\"\>Reservada\</span\>

                                \<% } else if (\"VENDIDA\".equals(est))
{ %\>

                                    \<span class=\"badge
bg-danger\"\>Vendida\</span\>

                                \<% } else if
(\"ARRENDADA\".equals(est)) { %\>

                                    \<span class=\"badge bg-info
text-dark\"\>Arrendada\</span\>

                                \<% } else { %\>

                                    \<span class=\"badge
bg-dark\"\>Inactiva\</span\>

                                \<% } %\>

                            \</td\>

                            \<td class=\"text-success fw-bold\"\>\$\<%=
String.format(\"%,.2f\", rsProp.getDouble(\"precio\")) %\>\</td\>

                            \<td\>

                                \<% if (estaActivo) { %\>

                                    \<span class=\"badge
bg-success-subtle text-success border border-success\"\>Activa\</span\>

                                \<% } else { %\>

                                    \<span class=\"badge
bg-danger-subtle text-danger border
border-danger\"\>Desactivada\</span\>

                                \<% } %\>

                            \</td\>

                            \<td class=\"text-end px-4\"\>

                                \<a
href=\"formulario_propiedad.jsp?id=\<%= idP %\>\" class=\"btn btn-sm
btn-outline-primary me-1\" title=\"Editar\"\>

                                    Editar

                                \</a\>

                                \<% if (estaActivo) { %\>

                                    \<a
href=\"propiedades.jsp?accion=eliminar&id=\<%= idP %\>\"

                                       class=\"btn btn-sm
btn-outline-danger\"

                                       onclick=\"return
confirm(\'¿Deseas desactivar esta propiedad?\');\"

                                       title=\"Desactivar\"\>

                                        Desactivar

                                    \</a\>

                                \<% } else { %\>

                                    \<a
href=\"propiedades.jsp?accion=activar&id=\<%= idP %\>\"

                                       class=\"btn btn-sm
btn-outline-success\"

                                       title=\"Activar\"\>

                                        Activar

                                    \</a\>

                                \<% } %\>

                            \</td\>

                        \</tr\>

                        \<%

                                }

                            }

                            if (!hayPropiedades) {

                        %\>

                        \<tr\>

                            \<td colspan=\"9\" class=\"text-center py-4
text-muted\"\>

                                Aún no has publicado ninguna propiedad.

                            \</td\>

                        \</tr\>

                        \<% } %\>

                    \</tbody\>

                \</table\>

            \</div\>

        \</div\>

    \</div\>

\</div\>

\<%

    if (rsProp != null) try { rsProp.close(); } catch (Exception e) {}

    if (stmtProp != null) try { stmtProp.close(); } catch (Exception e)
{}

    if (conn != null) try { conn.close(); } catch (Exception e) {}

%\>

\<%@ include file=\"/WEB-INF/jspf/footer.jspf\" %\>

## 11.3 inmobiliaria/formulario_propiedad.jsp

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ page import=\"java.util.Date\" %\>

\<%@ page import=\"java.util.Set\" %\>

\<%@ page import=\"java.util.HashSet\" %\>

\<%@ include file=\"/WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/header.jspf\" %\>

\<%

    // Verificación de sesión de agente

    Integer idUsuario = (Integer) session.getAttribute(\"id_usuario\");

    Integer idInmobiliaria = (Integer)
session.getAttribute(\"id_inmobiliaria\");

    if (idUsuario == null) {

        response.sendRedirect(request.getContextPath() +
\"/login.jsp?redirect=inmobiliaria/propiedades.jsp\");

        return;

    }

    if (idInmobiliaria == null) {

        response.sendRedirect(request.getContextPath() +
\"/acceso_denegado.jsp\");

        return;

    }

    String idPropStr = request.getParameter(\"id\");

    int idPropiedad = 0;

    boolean esEdicion = false;

    if (idPropStr != null && !idPropStr.trim().isEmpty()) {

        try {

            idPropiedad = Integer.parseInt(idPropStr);

            esEdicion = (idPropiedad \> 0);

        } catch (NumberFormatException e) {

            idPropiedad = 0;

        }

    }

    Connection conn = obtenerConexion();

    String mensajeExito = null;

    String mensajeError = null;

    // Variables ajustadas a la tabla \'propiedad\'

    String matricula = \"\", titulo = \"\", descripcion = \"\", estado =
\"DISPONIBLE\";

    int idTipo = 0, idCiudad = 0, habitaciones = 0, banos = 0;

    double areaM2 = 0.0, precio = 0.0;

    // IDs de las características (N:M) actualmente marcadas para esta
propiedad

    Set\<Integer\> caracteristicasSeleccionadas = new
HashSet\<Integer\>();

    // Texto con las URLs de las fotos de la propiedad (una por línea)

    String urlsImagenes = \"\";

    // Si es edición, verificar de una vez que la propiedad pertenezca a
este agente

    if (esEdicion && conn != null) {

        try {

            PreparedStatement stmtCheck = conn.prepareStatement(

                \"SELECT id_inmobiliaria FROM propiedad WHERE
id_propiedad = ?\");

            stmtCheck.setInt(1, idPropiedad);

            ResultSet rsCheck = stmtCheck.executeQuery();

            boolean esPropia = rsCheck.next() &&
rsCheck.getInt(\"id_inmobiliaria\") == idInmobiliaria;

            rsCheck.close(); stmtCheck.close();

            if (!esPropia) {

                response.sendRedirect(request.getContextPath() +
\"/acceso_denegado.jsp\");

                return;

            }

        } catch (SQLException e) {

            mensajeError = \"Error al verificar la propiedad: \" +
e.getMessage();

        }

    }

    // 1. PROCESAR GUARDADO (INSERT O UPDATE)

    if (\"POST\".equalsIgnoreCase(request.getMethod())) {

        titulo = request.getParameter(\"titulo\");

        descripcion = request.getParameter(\"descripcion\");

        estado = request.getParameter(\"estado\");

        matricula = request.getParameter(\"matricula_inmobiliaria\");

        if (matricula == null \|\| matricula.trim().isEmpty()) {

            matricula = \"MAT-\" + (new Date()).getTime();

        }

        try { idTipo =
Integer.parseInt(request.getParameter(\"id_tipo\")); } catch (Exception
e) {}

        try { idCiudad =
Integer.parseInt(request.getParameter(\"id_ciudad\")); } catch
(Exception e) {}

        try { habitaciones =
Integer.parseInt(request.getParameter(\"habitaciones\")); } catch
(Exception e) {}

        try { banos = Integer.parseInt(request.getParameter(\"banos\"));
} catch (Exception e) {}

        try {

            String areaStr = request.getParameter(\"area_m2\");

            if (areaStr != null && !areaStr.trim().isEmpty()) {

                areaM2 = Double.parseDouble(areaStr.replace(\",\",
\".\"));

            }

        } catch (Exception e) { areaM2 = 0.0; }

        try {

            String precioStr = request.getParameter(\"precio\");

            if (precioStr != null && !precioStr.trim().isEmpty()) {

                precio = Double.parseDouble(precioStr.replace(\",\",
\".\"));

            }

        } catch (Exception e) { precio = 0.0; }

        PreparedStatement stmtSave = null;

        try {

            if (esEdicion) {

                // El WHERE incluye id_inmobiliaria como segundo
candado: nunca se edita una propiedad ajena

                String sqlUpd = \"UPDATE propiedad SET id_tipo=?,
id_ciudad=?, titulo=?, descripcion=?, \" +

                                \"precio=?, area_m2=?, habitaciones=?,
banos=?, estado=?, matricula_inmobiliaria=? \" +

                                \"WHERE id_propiedad=? AND
id_inmobiliaria=?\";

                stmtSave = conn.prepareStatement(sqlUpd);

                stmtSave.setInt(1, idTipo);

                stmtSave.setInt(2, idCiudad);

                stmtSave.setString(3, titulo);

                stmtSave.setString(4, descripcion);

                stmtSave.setDouble(5, precio);

                stmtSave.setDouble(6, areaM2);

                stmtSave.setInt(7, habitaciones);

                stmtSave.setInt(8, banos);

                stmtSave.setString(9, estado);

                stmtSave.setString(10, matricula);

                stmtSave.setInt(11, idPropiedad);

                stmtSave.setInt(12, idInmobiliaria);

                stmtSave.executeUpdate();

                mensajeExito = \"Propiedad actualizada con éxito.\";

            } else {

                // id_inmobiliaria SIEMPRE se toma de la sesión, nunca
de un campo del formulario

                String sqlIns = \"INSERT INTO propiedad
(matricula_inmobiliaria, id_inmobiliaria, id_ciudad, id_tipo, \" +

                                \"titulo, descripcion, precio, area_m2,
habitaciones, banos, estado) \" +

                                \"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
?)\";

                stmtSave = conn.prepareStatement(sqlIns,
Statement.RETURN_GENERATED_KEYS);

                stmtSave.setString(1, matricula);

                stmtSave.setInt(2, idInmobiliaria);

                stmtSave.setInt(3, idCiudad);

                stmtSave.setInt(4, idTipo);

                stmtSave.setString(5, titulo);

                stmtSave.setString(6, descripcion);

                stmtSave.setDouble(7, precio);

                stmtSave.setDouble(8, areaM2);

                stmtSave.setInt(9, habitaciones);

                stmtSave.setInt(10, banos);

                stmtSave.setString(11, estado);

                stmtSave.executeUpdate();

                ResultSet rsKeys = stmtSave.getGeneratedKeys();

                if (rsKeys.next()) {

                    idPropiedad = rsKeys.getInt(1);

                    esEdicion = true;

                }

                mensajeExito = \"Propiedad registrada exitosamente en la
base de datos.\";

            }

        } catch (SQLException e) {

            mensajeError = \"Error al guardar los datos de la propiedad:
\" + e.getMessage();

        } finally {

            if (stmtSave != null) try { stmtSave.close(); } catch
(Exception e) {}

        }

        // 1.b GUARDAR CARACTERÍSTICAS (relación N:M propiedad \<-\>
característica)

        // Se reemplazan todas: primero se borran las que tenía y luego
se insertan las marcadas ahora.

        if (mensajeError == null && idPropiedad \> 0) {

            String\[\] idsCaracteristicas =
request.getParameterValues(\"caracteristicas\");

            PreparedStatement stmtDelCar = null;

            PreparedStatement stmtInsCar = null;

            try {

                stmtDelCar = conn.prepareStatement(\"DELETE FROM
propiedad_caracteristica WHERE id_propiedad = ?\");

                stmtDelCar.setInt(1, idPropiedad);

                stmtDelCar.executeUpdate();

                if (idsCaracteristicas != null) {

                    stmtInsCar = conn.prepareStatement(

                        \"INSERT INTO propiedad_caracteristica
(id_propiedad, id_caracteristica) VALUES (?, ?)\");

                    for (String idCarStr : idsCaracteristicas) {

                        try {

                            int idCar = Integer.parseInt(idCarStr);

                            caracteristicasSeleccionadas.add(idCar);

                            stmtInsCar.setInt(1, idPropiedad);

                            stmtInsCar.setInt(2, idCar);

                            stmtInsCar.executeUpdate();

                        } catch (NumberFormatException nfe) { /\*
ignorar valor inválido \*/ }

                    }

                }

            } catch (SQLException e) {

                mensajeError = \"La propiedad se guardó, pero hubo un
error al guardar sus características: \" + e.getMessage();

            } finally {

                if (stmtInsCar != null) try { stmtInsCar.close(); }
catch (Exception e) {}

                if (stmtDelCar != null) try { stmtDelCar.close(); }
catch (Exception e) {}

            }

        }

        // 1.c GUARDAR IMÁGENES (1:N propiedad -\> imagen_propiedad)

        // Se reemplazan todas: se borran las que tenía y se insertan
las URLs pegadas ahora.

        // La primera línea del textarea queda marcada como es_portada.

        if (mensajeError == null && idPropiedad \> 0) {

            urlsImagenes = request.getParameter(\"urls_imagenes\");

            PreparedStatement stmtDelImg = null;

            PreparedStatement stmtInsImg = null;

            try {

                stmtDelImg = conn.prepareStatement(\"DELETE FROM
imagen_propiedad WHERE id_propiedad = ?\");

                stmtDelImg.setInt(1, idPropiedad);

                stmtDelImg.executeUpdate();

                if (urlsImagenes != null &&
!urlsImagenes.trim().isEmpty()) {

                    stmtInsImg = conn.prepareStatement(

                        \"INSERT INTO imagen_propiedad (id_propiedad,
url_imagen, es_portada) VALUES (?, ?, ?)\");

                    String\[\] lineas =
urlsImagenes.split(\"\\\\r?\\\\n\");

                    boolean primera = true;

                    for (String linea : lineas) {

                        String url = linea.trim();

                        if (url.isEmpty()) continue;

                        stmtInsImg.setInt(1, idPropiedad);

                        stmtInsImg.setString(2, url);

                        stmtInsImg.setBoolean(3, primera);

                        stmtInsImg.executeUpdate();

                        primera = false;

                    }

                }

            } catch (SQLException e) {

                mensajeError = \"La propiedad se guardó, pero hubo un
error al guardar sus fotos: \" + e.getMessage();

            } finally {

                if (stmtInsImg != null) try { stmtInsImg.close(); }
catch (Exception e) {}

                if (stmtDelImg != null) try { stmtDelImg.close(); }
catch (Exception e) {}

            }

        }

    }

    // 2. CARGAR DATOS SI ES EDICIÓN

    if (esEdicion && !\"POST\".equalsIgnoreCase(request.getMethod())) {

        PreparedStatement stmtLoad = null;

        ResultSet rsLoad = null;

        try {

            String sql = \"SELECT \* FROM propiedad WHERE id_propiedad =
? AND id_inmobiliaria = ?\";

            stmtLoad = conn.prepareStatement(sql);

            stmtLoad.setInt(1, idPropiedad);

            stmtLoad.setInt(2, idInmobiliaria);

            rsLoad = stmtLoad.executeQuery();

            if (rsLoad.next()) {

                matricula =
rsLoad.getString(\"matricula_inmobiliaria\");

                idTipo = rsLoad.getInt(\"id_tipo\");

                idCiudad = rsLoad.getInt(\"id_ciudad\");

                titulo = rsLoad.getString(\"titulo\");

                descripcion = rsLoad.getString(\"descripcion\");

                precio = rsLoad.getDouble(\"precio\");

                areaM2 = rsLoad.getDouble(\"area_m2\");

                habitaciones = rsLoad.getInt(\"habitaciones\");

                banos = rsLoad.getInt(\"banos\");

                estado = rsLoad.getString(\"estado\");

            }

        } catch (SQLException e) {

            mensajeError = \"Error al cargar la propiedad: \" +
e.getMessage();

        } finally {

            if (rsLoad != null) try { rsLoad.close(); } catch (Exception
e) {}

            if (stmtLoad != null) try { stmtLoad.close(); } catch
(Exception e) {}

        }

        // Cargar las características que esta propiedad ya tiene
marcadas

        PreparedStatement stmtCarSel = null;

        ResultSet rsCarSel = null;

        try {

            stmtCarSel = conn.prepareStatement(

                \"SELECT id_caracteristica FROM propiedad_caracteristica
WHERE id_propiedad = ?\");

            stmtCarSel.setInt(1, idPropiedad);

            rsCarSel = stmtCarSel.executeQuery();

            while (rsCarSel.next()) {

               
caracteristicasSeleccionadas.add(rsCarSel.getInt(\"id_caracteristica\"));

            }

        } catch (SQLException e) {

            mensajeError = \"Error al cargar las características: \" +
e.getMessage();

        } finally {

            if (rsCarSel != null) try { rsCarSel.close(); } catch
(Exception e) {}

            if (stmtCarSel != null) try { stmtCarSel.close(); } catch
(Exception e) {}

        }

        // Cargar las URLs de las fotos que esta propiedad ya tiene
registradas

        PreparedStatement stmtImgSel = null;

        ResultSet rsImgSel = null;

        try {

            stmtImgSel = conn.prepareStatement(

                \"SELECT url_imagen FROM imagen_propiedad WHERE
id_propiedad = ? ORDER BY es_portada DESC, id_imagen ASC\");

            stmtImgSel.setInt(1, idPropiedad);

            rsImgSel = stmtImgSel.executeQuery();

            StringBuilder sbImgs = new StringBuilder();

            while (rsImgSel.next()) {

                if (sbImgs.length() \> 0) sbImgs.append(\"\\n\");

                sbImgs.append(rsImgSel.getString(\"url_imagen\"));

            }

            urlsImagenes = sbImgs.toString();

        } catch (SQLException e) {

            mensajeError = \"Error al cargar las fotos: \" +
e.getMessage();

        } finally {

            if (rsImgSel != null) try { rsImgSel.close(); } catch
(Exception e) {}

            if (stmtImgSel != null) try { stmtImgSel.close(); } catch
(Exception e) {}

        }

    }

    // Consultar combos

    Statement stmtCombos = conn.createStatement();

    ResultSet rsTipos = stmtCombos.executeQuery(\"SELECT \* FROM
tipo_propiedad ORDER BY nombre_tipo\");

    Statement stmtCiudades = conn.createStatement();

    ResultSet rsCiudades = stmtCiudades.executeQuery(\"SELECT \* FROM
ciudad ORDER BY nombre_ciudad\");

    // Catálogo completo de características disponibles (para pintar los
checkboxes)

    Statement stmtCaracteristicas = conn.createStatement();

    ResultSet rsCaracteristicas = stmtCaracteristicas.executeQuery(

        \"SELECT \* FROM caracteristica ORDER BY
nombre_caracteristica\");

%\>

\<div class=\"container my-5\" style=\"max-width: 900px;\"\>

    \<div class=\"d-flex justify-content-between align-items-center
mb-4\"\>

        \<h2 class=\"fw-bold\"\>\<%= esEdicion ? \"Editar Propiedad
#\" + idPropiedad : \"Publicar Nueva Propiedad\" %\>\</h2\>

        \<a href=\"propiedades.jsp\" class=\"btn
btn-outline-secondary\"\>&larr; Volver al Panel\</a\>

    \</div\>

    \<% if (mensajeExito != null) { %\>

        \<div class=\"alert alert-success alert-dismissible fade show\"
role=\"alert\"\>

            \<%= mensajeExito %\>

            \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

        \</div\>

    \<% } %\>

    \<% if (mensajeError != null) { %\>

        \<div class=\"alert alert-danger alert-dismissible fade show\"
role=\"alert\"\>

            \<%= mensajeError %\>

            \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

        \</div\>

    \<% } %\>

    \<div class=\"card shadow-sm border-0\"\>

        \<div class=\"card-body p-4\"\>

            \<form method=\"POST\" action=\"formulario_propiedad.jsp\<%=
esEdicion ? \"?id=\" + idPropiedad : \"\" %\>\"\>

                \<div class=\"row g-3\"\>

                    \<div class=\"col-md-8\"\>

                        \<label for=\"titulo\" class=\"form-label
fw-bold\"\>Título de la Publicación \*\</label\>

                        \<input type=\"text\" class=\"form-control\"
id=\"titulo\" name=\"titulo\" value=\"\<%= titulo %\>\" required
placeholder=\"Ej: Hermoso Apartamento en Girón\"\>

                    \</div\>

                    \<div class=\"col-md-4\"\>

                        \<label for=\"matricula_inmobiliaria\"
class=\"form-label fw-bold\"\>Matrícula Inmobiliaria \*\</label\>

                        \<input type=\"text\" class=\"form-control\"
id=\"matricula_inmobiliaria\" name=\"matricula_inmobiliaria\"
value=\"\<%= matricula %\>\" placeholder=\"Ej: MAT-102030\"\>

                    \</div\>

                    \<div class=\"col-md-4\"\>

                        \<label for=\"id_tipo\" class=\"form-label
fw-bold\"\>Tipo de Inmueble \*\</label\>

                        \<select class=\"form-select\" id=\"id_tipo\"
name=\"id_tipo\" required\>

                            \<% while (rsTipos.next()) {

                                int idT = rsTipos.getInt(\"id_tipo\");

                            %\>

                                \<option value=\"\<%= idT %\>\" \<%= idT
== idTipo ? \"selected\" : \"\" %\>\>\<%=
rsTipos.getString(\"nombre_tipo\") %\>\</option\>

                            \<% } %\>

                        \</select\>

                    \</div\>

                    \<div class=\"col-md-4\"\>

                        \<label for=\"id_ciudad\" class=\"form-label
fw-bold\"\>Ciudad \*\</label\>

                        \<select class=\"form-select\" id=\"id_ciudad\"
name=\"id_ciudad\" required\>

                            \<% while (rsCiudades.next()) {

                                int idC =
rsCiudades.getInt(\"id_ciudad\");

                            %\>

                                \<option value=\"\<%= idC %\>\" \<%= idC
== idCiudad ? \"selected\" : \"\" %\>\>\<%=
rsCiudades.getString(\"nombre_ciudad\") %\>\</option\>

                            \<% } %\>

                        \</select\>

                    \</div\>

                    \<div class=\"col-md-4\"\>

                        \<label for=\"estado\" class=\"form-label
fw-bold\"\>Estado \*\</label\>

                        \<select class=\"form-select\" id=\"estado\"
name=\"estado\" required\>

                            \<option value=\"DISPONIBLE\" \<%=
\"DISPONIBLE\".equals(estado) ? \"selected\" : \"\"
%\>\>Disponible\</option\>

                            \<option value=\"RESERVADA\" \<%=
\"RESERVADA\".equals(estado) ? \"selected\" : \"\"
%\>\>Reservada\</option\>

                            \<option value=\"VENDIDA\" \<%=
\"VENDIDA\".equals(estado) ? \"selected\" : \"\" %\>\>Vendida\</option\>

                            \<option value=\"ARRENDADA\" \<%=
\"ARRENDADA\".equals(estado) ? \"selected\" : \"\"
%\>\>Arrendada\</option\>

                            \<option value=\"INACTIVA\" \<%=
\"INACTIVA\".equals(estado) ? \"selected\" : \"\"
%\>\>Inactiva\</option\>

                        \</select\>

                    \</div\>

                    \<div class=\"col-md-6\"\>

                        \<label for=\"precio\" class=\"form-label
fw-bold\"\>Precio (\$ COP) \*\</label\>

                        \<input type=\"number\" step=\"0.01\"
class=\"form-control\" id=\"precio\" name=\"precio\" value=\"\<%= precio
\> 0 ? precio : \"\" %\>\" required placeholder=\"Ej: 250000000\"\>

                    \</div\>

                    \<div class=\"col-md-6\"\>

                        \<label for=\"area_m2\" class=\"form-label
fw-bold\"\>Área (m²) \*\</label\>

                        \<input type=\"number\" step=\"0.01\"
class=\"form-control\" id=\"area_m2\" name=\"area_m2\" value=\"\<%=
areaM2 \> 0 ? areaM2 : \"\" %\>\" required placeholder=\"Ej: 75.5\"\>

                    \</div\>

                    \<div class=\"col-md-6\"\>

                        \<label for=\"habitaciones\" class=\"form-label
fw-bold\"\>Habitaciones\</label\>

                        \<input type=\"number\" class=\"form-control\"
id=\"habitaciones\" name=\"habitaciones\" value=\"\<%= habitaciones
%\>\" min=\"0\"\>

                    \</div\>

                    \<div class=\"col-md-6\"\>

                        \<label for=\"banos\" class=\"form-label
fw-bold\"\>Baños\</label\>

                        \<input type=\"number\" class=\"form-control\"
id=\"banos\" name=\"banos\" value=\"\<%= banos %\>\" min=\"0\"\>

                    \</div\>

                    \<div class=\"col-12\"\>

                        \<label for=\"descripcion\" class=\"form-label
fw-bold\"\>Descripción Completa\</label\>

                        \<textarea class=\"form-control\"
id=\"descripcion\" name=\"descripcion\" rows=\"4\"\>\<%= descripcion
%\>\</textarea\>

                    \</div\>

                    \<div class=\"col-12\"\>

                        \<label for=\"urls_imagenes\" class=\"form-label
fw-bold\"\>Fotos del Inmueble (una URL por línea)\</label\>

                        \<textarea class=\"form-control\"
id=\"urls_imagenes\" name=\"urls_imagenes\" rows=\"3\"
placeholder=\"https://ejemplo.com/foto1.jpg&#10;https://ejemplo.com/foto2.jpg\"\>\<%=
urlsImagenes %\>\</textarea\>

                        \<small class=\"text-muted\"\>La primera URL
queda como foto de portada. Si la dejas vacía, se mostrará una foto
genérica según el tipo de inmueble.\</small\>

                    \</div\>

                    \<div class=\"col-12\"\>

                        \<label class=\"form-label
fw-bold\"\>Características\</label\>

                        \<div class=\"row\"\>

                            \<%

                                while (rsCaracteristicas.next()) {

                                    int idCarac =
rsCaracteristicas.getInt(\"id_caracteristica\");

                                    String nombreCarac =
rsCaracteristicas.getString(\"nombre_caracteristica\");

                                    boolean marcado =
caracteristicasSeleccionadas.contains(idCarac);

                            %\>

                                \<div class=\"col-md-3 col-6 form-check
mb-2\"\>

                                    \<input class=\"form-check-input\"
type=\"checkbox\" name=\"caracteristicas\"

                                           value=\"\<%= idCarac %\>\"
id=\"carac\<%= idCarac %\>\" \<%= marcado ? \"checked\" : \"\" %\>\>

                                    \<label class=\"form-check-label\"
for=\"carac\<%= idCarac %\>\"\>\<%= nombreCarac %\>\</label\>

                                \</div\>

                            \<% } %\>

                        \</div\>

                    \</div\>

                \</div\>

                \<div class=\"mt-4 text-end\"\>

                    \<a href=\"propiedades.jsp\" class=\"btn
btn-secondary me-2\"\>Cancelar\</a\>

                    \<button type=\"submit\" class=\"btn btn-primary
px-4 fw-bold\"\>

                        \<%= esEdicion ? \"Guardar Cambios\" : \"Crear
Propiedad\" %\>

                    \</button\>

                \</div\>

            \</form\>

        \</div\>

    \</div\>

\</div\>

\<%

    if (rsTipos != null) try { rsTipos.close(); } catch (Exception e) {}

    if (rsCiudades != null) try { rsCiudades.close(); } catch (Exception
e) {}

    if (rsCaracteristicas != null) try { rsCaracteristicas.close(); }
catch (Exception e) {}

    if (stmtCombos != null) try { stmtCombos.close(); } catch (Exception
e) {}

    if (stmtCiudades != null) try { stmtCiudades.close(); } catch
(Exception e) {}

    if (stmtCaracteristicas != null) try { stmtCaracteristicas.close();
} catch (Exception e) {}

    if (conn != null) try { conn.close(); } catch (Exception e) {}

%\>

\<%@ include file=\"/WEB-INF/jspf/footer.jspf\" %\>

## 11.4 inmobiliaria/solicitudes.jsp

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ include file=\"/WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/header.jspf\" %\>

\<%

    // Verificación de sesión de agente

    Integer idUsuario = (Integer) session.getAttribute(\"id_usuario\");

    Integer idInmobiliaria = (Integer)
session.getAttribute(\"id_inmobiliaria\");

    if (idUsuario == null) {

        response.sendRedirect(request.getContextPath() +
\"/login.jsp?redirect=inmobiliaria/solicitudes.jsp\");

        return;

    }

    if (idInmobiliaria == null) {

        response.sendRedirect(request.getContextPath() +
\"/acceso_denegado.jsp\");

        return;

    }

    Connection conn = obtenerConexion();

    String mensajeExito = null;

    String mensajeError = null;

    // Procesar actualización de estado para Solicitud o Cita.

    // Cada UPDATE hace JOIN con propiedad y filtra por id_inmobiliaria:
un agente

    // jamás puede cambiar el estado de una solicitud/cita que no sea de
sus propiedades.

    String tipoAccion = request.getParameter(\"tipo\"); // \"solicitud\"
o \"cita\"

    String idTarget = request.getParameter(\"id\");

    String nuevoEstado = request.getParameter(\"nuevo_estado\");

    if (tipoAccion != null && idTarget != null && nuevoEstado != null &&
conn != null) {

        PreparedStatement stmtUpd = null;

        try {

            if (\"solicitud\".equals(tipoAccion)) {

                String sql = \"UPDATE solicitud s \" +

                             \"INNER JOIN propiedad p ON s.id_propiedad
= p.id_propiedad \" +

                             \"SET s.estado = ? WHERE s.id_solicitud = ?
AND p.id_inmobiliaria = ?\";

                stmtUpd = conn.prepareStatement(sql);

                stmtUpd.setString(1, nuevoEstado);

                stmtUpd.setInt(2, Integer.parseInt(idTarget));

                stmtUpd.setInt(3, idInmobiliaria);

                int filas = stmtUpd.executeUpdate();

                if (filas \> 0) {

                    mensajeExito = \"Estado de la solicitud #\" +
idTarget + \" actualizado a \" + nuevoEstado + \".\";

                } else {

                    mensajeError = \"No tienes permiso sobre esa
solicitud.\";

                }

            } else if (\"cita\".equals(tipoAccion)) {

                String sql = \"UPDATE cita c \" +

                             \"INNER JOIN propiedad p ON c.id_propiedad
= p.id_propiedad \" +

                             \"SET c.estado = ? WHERE c.id_cita = ? AND
p.id_inmobiliaria = ?\";

                stmtUpd = conn.prepareStatement(sql);

                stmtUpd.setString(1, nuevoEstado);

                stmtUpd.setInt(2, Integer.parseInt(idTarget));

                stmtUpd.setInt(3, idInmobiliaria);

                int filas = stmtUpd.executeUpdate();

                if (filas \> 0) {

                    mensajeExito = \"Estado de la cita #\" + idTarget +
\" actualizado a \" + nuevoEstado + \".\";

                } else {

                    mensajeError = \"No tienes permiso sobre esa
cita.\";

                }

            }

        } catch (SQLException e) {

            mensajeError = \"Error al actualizar estado: \" +
e.getMessage();

        } finally {

            if (stmtUpd != null) try { stmtUpd.close(); } catch
(Exception e) {}

        }

    }

    // Consultar Solicitudes de las propiedades de este agente

    PreparedStatement stmtSoli = null;

    ResultSet rsSoli = null;

    // Consultar Citas de las propiedades de este agente

    PreparedStatement stmtCita = null;

    ResultSet rsCitas = null;

    if (conn != null) {

        try {

            String sqlSoli = \"SELECT s.id_solicitud, s.tipo_solicitud,
s.estado, s.fecha_solicitud, s.observaciones, \" +

                             \"p.titulo, u.correo,
CONCAT(COALESCE(pf.nombres, \'\'), \' \', COALESCE(pf.apellidos, \'\'))
AS nombre_cliente \" +

                             \"FROM solicitud s \" +

                             \"INNER JOIN propiedad p ON s.id_propiedad
= p.id_propiedad \" +

                             \"INNER JOIN usuario u ON s.id_cliente =
u.id_usuario \" +

                             \"LEFT JOIN perfil pf ON u.id_usuario =
pf.id_usuario \" +

                             \"WHERE p.id_inmobiliaria = ? \" +

                             \"ORDER BY s.fecha_solicitud DESC\";

            stmtSoli = conn.prepareStatement(sqlSoli);

            stmtSoli.setInt(1, idInmobiliaria);

            rsSoli = stmtSoli.executeQuery();

            String sqlCita = \"SELECT c.id_cita, c.fecha_hora, c.estado,
c.observaciones, \" +

                             \"p.titulo, u.correo,
CONCAT(COALESCE(pf.nombres, \'\'), \' \', COALESCE(pf.apellidos, \'\'))
AS nombre_cliente \" +

                             \"FROM cita c \" +

                             \"INNER JOIN propiedad p ON c.id_propiedad
= p.id_propiedad \" +

                             \"INNER JOIN usuario u ON c.id_cliente =
u.id_usuario \" +

                             \"LEFT JOIN perfil pf ON u.id_usuario =
pf.id_usuario \" +

                             \"WHERE p.id_inmobiliaria = ? \" +

                             \"ORDER BY c.fecha_hora DESC\";

            stmtCita = conn.prepareStatement(sqlCita);

            stmtCita.setInt(1, idInmobiliaria);

            rsCitas = stmtCita.executeQuery();

        } catch (SQLException e) {

            mensajeError = \"Error al cargar solicitudes y citas: \" +
e.getMessage();

        }

    }

%\>

\<div class=\"container my-5\"\>

    \<div class=\"d-flex justify-content-between align-items-center
mb-4\"\>

        \<div\>

            \<h2 class=\"fw-bold m-0\"\>Solicitudes y Citas de mis
Propiedades\</h2\>

            \<p class=\"text-muted m-0\"\>Aprueba, rechaza o confirma
solicitudes de clientes\</p\>

        \</div\>

        \<a href=\"index.jsp\" class=\"btn
btn-outline-secondary\"\>&larr; Volver al Panel\</a\>

    \</div\>

    \<% if (mensajeExito != null) { %\>

        \<div class=\"alert alert-success alert-dismissible fade show\"
role=\"alert\"\>

            \<%= mensajeExito %\>

            \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

        \</div\>

    \<% } %\>

    \<% if (mensajeError != null) { %\>

        \<div class=\"alert alert-danger alert-dismissible fade show\"
role=\"alert\"\>

            \<%= mensajeError %\>

            \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

        \</div\>

    \<% } %\>

    \<!\-- SECCIÓN 1: SOLICITUDES (COMPRA / ARRIENDO) \--\>

    \<div class=\"card shadow-sm border-0 mb-5\"\>

        \<div class=\"card-header bg-primary text-white py-3\"\>

            \<h5 class=\"m-0 fw-bold\"\>Solicitudes de Compra y
Arriendo\</h5\>

        \</div\>

        \<div class=\"card-body p-0\"\>

            \<div class=\"table-responsive\"\>

                \<table class=\"table table-hover align-middle mb-0\"\>

                    \<thead class=\"table-light\"\>

                        \<tr\>

                            \<th\># ID\</th\>

                            \<th\>Cliente\</th\>

                            \<th\>Propiedad\</th\>

                            \<th\>Tipo\</th\>

                            \<th\>Fecha\</th\>

                            \<th\>Estado\</th\>

                            \<th class=\"text-end
px-4\"\>Acciones\</th\>

                        \</tr\>

                    \</thead\>

                    \<tbody\>

                        \<%

                            boolean haySolicitudes = false;

                            if (rsSoli != null) {

                                while (rsSoli.next()) {

                                    haySolicitudes = true;

                                    int idS =
rsSoli.getInt(\"id_solicitud\");

                                    String est =
rsSoli.getString(\"estado\");

                                    String cliente =
rsSoli.getString(\"nombre_cliente\");

                                    if (cliente == null \|\|
cliente.trim().isEmpty()) cliente = rsSoli.getString(\"correo\");

                        %\>

                        \<tr\>

                            \<td class=\"fw-bold\"\>#\<%= idS %\>\</td\>

                            \<td\>\<%= cliente %\>\</td\>

                            \<td class=\"fw-semibold\"\>\<%=
rsSoli.getString(\"titulo\") %\>\</td\>

                            \<td\>\<span class=\"badge
bg-secondary\"\>\<%= rsSoli.getString(\"tipo_solicitud\")
%\>\</span\>\</td\>

                            \<td\>\<small class=\"text-muted\"\>\<%=
rsSoli.getTimestamp(\"fecha_solicitud\") %\>\</small\>\</td\>

                            \<td\>

                                \<% if (\"PENDIENTE\".equals(est)) { %\>

                                    \<span class=\"badge bg-warning
text-dark\"\>Pendiente\</span\>

                                \<% } else if (\"APROBADA\".equals(est))
{ %\>

                                    \<span class=\"badge
bg-success\"\>Aprobada\</span\>

                                \<% } else { %\>

                                    \<span class=\"badge
bg-danger\"\>Rechazada\</span\>

                                \<% } %\>

                            \</td\>

                            \<td class=\"text-end px-4\"\>

                                \<% if (\"PENDIENTE\".equals(est)) { %\>

                                    \<a
href=\"solicitudes.jsp?tipo=solicitud&id=\<%= idS
%\>&nuevo_estado=APROBADA\"

                                       class=\"btn btn-sm btn-success
me-1\"\>Aprobar\</a\>

                                    \<a
href=\"solicitudes.jsp?tipo=solicitud&id=\<%= idS
%\>&nuevo_estado=RECHAZADA\"

                                       class=\"btn btn-sm
btn-outline-danger\"\>Rechazar\</a\>

                                \<% } else { %\>

                                    \<span class=\"text-muted
small\"\>Procesada\</span\>

                                \<% } %\>

                            \</td\>

                        \</tr\>

                        \<%

                                }

                            }

                            if (!haySolicitudes) {

                        %\>

                        \<tr\>

                            \<td colspan=\"7\" class=\"text-center py-4
text-muted\"\>No hay solicitudes para tus propiedades.\</td\>

                        \</tr\>

                        \<% } %\>

                    \</tbody\>

                \</table\>

            \</div\>

        \</div\>

    \</div\>

    \<!\-- SECCIÓN 2: CITAS PROGRAMADAS \--\>

    \<div class=\"card shadow-sm border-0\"\>

        \<div class=\"card-header bg-dark text-white py-3\"\>

            \<h5 class=\"m-0 fw-bold\"\>Citas de Visita
Programadas\</h5\>

        \</div\>

        \<div class=\"card-body p-0\"\>

            \<div class=\"table-responsive\"\>

                \<table class=\"table table-hover align-middle mb-0\"\>

                    \<thead class=\"table-light\"\>

                        \<tr\>

                            \<th\># Cita\</th\>

                            \<th\>Cliente\</th\>

                            \<th\>Propiedad\</th\>

                            \<th\>Fecha y Hora\</th\>

                            \<th\>Estado\</th\>

                            \<th class=\"text-end
px-4\"\>Acciones\</th\>

                        \</tr\>

                    \</thead\>

                    \<tbody\>

                        \<%

                            boolean hayCitas = false;

                            if (rsCitas != null) {

                                while (rsCitas.next()) {

                                    hayCitas = true;

                                    int idC =
rsCitas.getInt(\"id_cita\");

                                    String estC =
rsCitas.getString(\"estado\");

                                    String clienteC =
rsCitas.getString(\"nombre_cliente\");

                                    if (clienteC == null \|\|
clienteC.trim().isEmpty()) clienteC = rsCitas.getString(\"correo\");

                        %\>

                        \<tr\>

                            \<td class=\"fw-bold\"\>#\<%= idC %\>\</td\>

                            \<td\>\<%= clienteC %\>\</td\>

                            \<td class=\"fw-semibold\"\>\<%=
rsCitas.getString(\"titulo\") %\>\</td\>

                            \<td\>\<strong\>\<%=
rsCitas.getTimestamp(\"fecha_hora\") %\>\</strong\>\</td\>

                            \<td\>

                                \<% if (\"PENDIENTE\".equals(estC)) {
%\>

                                    \<span class=\"badge bg-warning
text-dark\"\>Pendiente\</span\>

                                \<% } else if
(\"CONFIRMADA\".equals(estC)) { %\>

                                    \<span class=\"badge
bg-success\"\>Confirmada\</span\>

                                \<% } else if
(\"REALIZADA\".equals(estC)) { %\>

                                    \<span class=\"badge bg-info
text-dark\"\>Realizada\</span\>

                                \<% } else if
(\"RECHAZADA\".equals(estC)) { %\>

                                    \<span class=\"badge
bg-danger\"\>Rechazada\</span\>

                                \<% } else { %\>

                                    \<span class=\"badge
bg-secondary\"\>Cancelada\</span\>

                                \<% } %\>

                            \</td\>

                            \<td class=\"text-end px-4\"\>

                                \<% if (\"PENDIENTE\".equals(estC)) {
%\>

                                    \<a
href=\"solicitudes.jsp?tipo=cita&id=\<%= idC
%\>&nuevo_estado=CONFIRMADA\"

                                       class=\"btn btn-sm btn-success
me-1\"\>Confirmar\</a\>

                                    \<a
href=\"solicitudes.jsp?tipo=cita&id=\<%= idC
%\>&nuevo_estado=RECHAZADA\"

                                       class=\"btn btn-sm
btn-outline-danger\"\>Rechazar\</a\>

                                \<% } else if
(\"CONFIRMADA\".equals(estC)) { %\>

                                    \<a
href=\"solicitudes.jsp?tipo=cita&id=\<%= idC
%\>&nuevo_estado=REALIZADA\"

                                       class=\"btn btn-sm btn-info
text-dark\"\>Marcar Realizada\</a\>

                                \<% } else { %\>

                                    \<span class=\"text-muted
small\"\>Finalizada\</span\>

                                \<% } %\>

                            \</td\>

                        \</tr\>

                        \<%

                                }

                            }

                            if (!hayCitas) {

                        %\>

                        \<tr\>

                            \<td colspan=\"6\" class=\"text-center py-4
text-muted\"\>No hay citas para tus propiedades.\</td\>

                        \</tr\>

                        \<% } %\>

                    \</tbody\>

                \</table\>

            \</div\>

        \</div\>

    \</div\>

\</div\>

\<%

    if (rsSoli != null) try { rsSoli.close(); } catch (Exception e) {}

    if (rsCitas != null) try { rsCitas.close(); } catch (Exception e) {}

    if (stmtSoli != null) try { stmtSoli.close(); } catch (Exception e)
{}

    if (stmtCita != null) try { stmtCita.close(); } catch (Exception e)
{}

    if (conn != null) try { conn.close(); } catch (Exception e) {}

%\>

\<%@ include file=\"/WEB-INF/jspf/footer.jspf\" %\>

El guardado de una propiedad, en inmobiliaria/formulario_propiedad.jsp,
sigue el mismo patrón de tres pasos que el registro de usuario:

+-----------------------------------------------------------------------+
| String sqlIns = \"INSERT INTO propiedad (matricula_inmobiliaria,      |
| id_inmobiliaria, id_ciudad, id_tipo, \" +                             |
|                                                                       |
| \"titulo, descripcion, precio, area_m2, habitaciones, banos, estado)  |
| \" +                                                                  |
|                                                                       |
| \"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)\";                         |
|                                                                       |
| // \... obtiene el id_propiedad generado \...                         |
|                                                                       |
| // Sincroniza caracteristicas seleccionadas                           |
|                                                                       |
| \"DELETE FROM propiedad_caracteristica WHERE id_propiedad = ?\"       |
|                                                                       |
| \"INSERT INTO propiedad_caracteristica (id_propiedad,                 |
| id_caracteristica) VALUES (?, ?)\"                                    |
|                                                                       |
| // Agrega imagenes nuevas                                             |
|                                                                       |
| \"INSERT INTO imagen_propiedad (id_propiedad, url_imagen, es_portada) |
| VALUES (?, ?, ?)\"                                                    |
+=======================================================================+
+-----------------------------------------------------------------------+

# **12. Panel de administración**

Las páginas de /admin/\* combinan la protección del Filtro (rol
ADMINISTRADOR) con una verificación propia explícita dentro de cada JSP,
como respaldo adicional.

+-----------------------------------------------------------------------+
| Integer idUsuario = (Integer) session.getAttribute(\"id_usuario\");   |
|                                                                       |
| if (idUsuario == null) {                                              |
| response.sendRedirect(\"../login.jsp?redirect=admin/\...\"); return;  |
| }                                                                     |
|                                                                       |
| String rolSesionAdmin = (String) session.getAttribute(\"rol\");       |
|                                                                       |
| if (!(\"ADMINISTRADOR\".equalsIgnoreCase(rolSesionAdmin) \|\|         |
| \"ADMIN\".equalsIgnoreCase(rolSesionAdmin))) {                        |
|                                                                       |
| response.sendRedirect(\"../acceso_denegado.jsp\");                    |
|                                                                       |
| return;                                                               |
|                                                                       |
| }                                                                     |
+=======================================================================+
+-----------------------------------------------------------------------+

  -------------------------------------------------------------------------------
  **Página**                       **Qué hace**
  -------------------------------- ----------------------------------------------
  admin/index.jsp                  Panel general: totales de usuarios, de
                                   propiedades y otros indicadores globales.

  admin/admin_propiedades.jsp      Consulta el detalle de cualquier propiedad de
                                   la plataforma (misma consulta que
                                   detalle_propiedad.jsp, sin el filtro de
                                   activo).

  admin/formulario_propiedad.jsp   Alta/edición de propiedades desde el rol
                                   administrador; misma lógica que la versión de
                                   inmobiliaria/, pero sin restringir el
                                   id_inmobiliaria a uno solo.

  admin/usuarios.jsp               Listado de todos los usuarios; accion=bloquear
                                   o accion=activar cambia usuario.estado entre
                                   INACTIVO y ACTIVO.

  admin/solicitudes_admin.jsp      Gestión de todas las citas y solicitudes de la
                                   plataforma (sin filtrar por agente).

  admin/reportes.jsp               Indicadores agregados: por ejemplo,
                                   propiedades por ciudad, por tipo, o
                                   solicitudes por estado.
  -------------------------------------------------------------------------------

## 12.1 admin/index.jsp

\<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\"%\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ include file=\"/WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/header.jspf\" %\>

\<%

    // Verificación de sesión de administrador

    Integer idUsuario = (Integer) session.getAttribute(\"id_usuario\");

    if (idUsuario == null) {

       
response.sendRedirect(\"../login.jsp?redirect=admin/index.jsp\");

        return;

    }

    String rolSesionAdmin = (String) session.getAttribute(\"rol\");

    if (!(\"ADMINISTRADOR\".equalsIgnoreCase(rolSesionAdmin) \|\|
\"ADMIN\".equalsIgnoreCase(rolSesionAdmin))) {

        response.sendRedirect(\"../acceso_denegado.jsp\");

        return;

    }

%\>

\<div class=\"container my-4\"\>

    \<div class=\"d-flex justify-content-between align-items-center
mb-4\"\>

        \<div\>

            \<h2 class=\"fw-bold m-0\"\>Panel de Administración\</h2\>

            \<p class=\"text-muted m-0\"\>Resumen general y accesos del
sistema\</p\>

        \</div\>

    \</div\>

    \<%

        int totalUsuarios = 0;

        int totalPropiedades = 0;

        int totalSolicitudes = 0;

        Connection conn = obtenerConexion();

        if (conn != null) {

            try {

                // Total usuarios

                Statement st1 = conn.createStatement();

                ResultSet rs1 = st1.executeQuery(\"SELECT COUNT(\*) FROM
usuario\");

                if (rs1.next()) totalUsuarios = rs1.getInt(1);

                rs1.close(); st1.close();

                // Total propiedades activas

                Statement st2 = conn.createStatement();

                ResultSet rs2 = st2.executeQuery(\"SELECT COUNT(\*) FROM
propiedad WHERE activo = TRUE\");

                if (rs2.next()) totalPropiedades = rs2.getInt(1);

                rs2.close(); st2.close();

                // Total solicitudes pendientes

                Statement st3 = conn.createStatement();

                ResultSet rs3 = st3.executeQuery(\"SELECT COUNT(\*) FROM
solicitud WHERE estado = \'PENDIENTE\'\");

                if (rs3.next()) totalSolicitudes = rs3.getInt(1);

                rs3.close(); st3.close();

            } catch (SQLException e) {

                out.println(\"\<div class=\'alert alert-danger\'\>Error
al cargar métricas: \" + e.getMessage() + \"\</div\>\");

            } finally {

                try { conn.close(); } catch (Exception e) {}

            }

        } else {

            out.println(\"\<div class=\'alert alert-warning\'\>No se
pudo conectar a la base de datos. Revisa la configuración de
conexion.jspf.\</div\>\");

        }

    %\>

    \<!\-- TARJETAS DE MÉTRICAS \--\>

    \<div class=\"row g-3 mb-4\"\>

        \<div class=\"col-md-4\"\>

            \<div class=\"card bg-primary text-white p-3 shadow-sm\"\>

                \<h5\>Usuarios Registrados\</h5\>

                \<h3 class=\"fw-bold\"\>\<%= totalUsuarios %\>\</h3\>

            \</div\>

        \</div\>

        \<div class=\"col-md-4\"\>

            \<div class=\"card bg-success text-white p-3 shadow-sm\"\>

                \<h5\>Propiedades Activas\</h5\>

                \<h3 class=\"fw-bold\"\>\<%= totalPropiedades %\>\</h3\>

            \</div\>

        \</div\>

        \<div class=\"col-md-4\"\>

            \<div class=\"card bg-warning text-dark p-3 shadow-sm\"\>

                \<h5\>Solicitudes Pendientes\</h5\>

                \<h3 class=\"fw-bold\"\>\<%= totalSolicitudes %\>\</h3\>

            \</div\>

        \</div\>

    \</div\>

    \<!\-- ACCESOS RÁPIDOS \--\>

    \<h4 class=\"mb-3 fw-bold\"\>Gestión del Sistema\</h4\>

    \<div class=\"d-flex flex-wrap gap-2 mb-4\"\>

        \<a href=\"admin_propiedades.jsp\" class=\"btn
btn-outline-primary\"\>

            🏠 Gestionar Propiedades

        \</a\>

        \<a href=\"formulario_propiedad.jsp\" class=\"btn
btn-success\"\>

            ➕ Nueva Propiedad

        \</a\>

        \<a href=\"usuarios.jsp\" class=\"btn btn-outline-dark\"\>

            👥 Gestionar Usuarios

        \</a\>

        \<a href=\"solicitudes_admin.jsp\" class=\"btn
btn-outline-warning text-dark\"\>

            📋 Solicitudes y Citas

        \</a\>

    \</div\>

\</div\>

\<%@ include file=\"/WEB-INF/jspf/footer.jspf\" %\>

## 12.2 admin/admin_propiedades.jsp

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ include file=\"/WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/header.jspf\" %\>

\<%@ include file=\"/WEB-INF/jspf/imagenes.jspf\" %\>

\<%

    String idStr = request.getParameter(\"id\");

    int idPropiedad = 0;

    if (idStr != null && !idStr.trim().isEmpty()) {

        try {

            idPropiedad = Integer.parseInt(idStr);

        } catch (NumberFormatException e) {

            idPropiedad = 0;

        }

    }

    Connection conn = obtenerConexion();

    PreparedStatement stmtProp = null;

    ResultSet rsProp = null;

    PreparedStatement stmtFotos = null;

    ResultSet rsFotos = null;

    boolean existePropiedad = false;

    if (conn != null && idPropiedad \> 0) {

        String sqlProp = \"SELECT p.\*, c.nombre_ciudad, c.departamento,
t.nombre_tipo, i.nombre_comercial, i.telefono_contacto \" +

                         \"FROM propiedad p \" +

                         \"INNER JOIN ciudad c ON p.id_ciudad =
c.id_ciudad \" +

                         \"INNER JOIN tipo_propiedad t ON p.id_tipo =
t.id_tipo \" +

                         \"INNER JOIN inmobiliaria i ON
p.id_inmobiliaria = i.id_inmobiliaria \" +

                         \"WHERE p.id_propiedad = ? AND p.activo =
TRUE\";

        stmtProp = conn.prepareStatement(sqlProp);

        stmtProp.setInt(1, idPropiedad);

        rsProp = stmtProp.executeQuery();

        if (rsProp.next()) {

            existePropiedad = true;

        }

        String sqlFotos = \"SELECT \* FROM imagen_propiedad WHERE
id_propiedad = ? ORDER BY es_portada DESC, id_imagen ASC\";

        stmtFotos = conn.prepareStatement(sqlFotos);

        stmtFotos.setInt(1, idPropiedad);

        rsFotos = stmtFotos.executeQuery();

    }

    // Características del inmueble (relación N:M propiedad \<-\>
caracteristica vía propiedad_caracteristica)

    PreparedStatement stmtCarac = null;

    ResultSet rsCarac = null;

    if (conn != null && existePropiedad) {

        String sqlCarac = \"SELECT c.nombre_caracteristica \" +

                           \"FROM propiedad_caracteristica pc \" +

                           \"INNER JOIN caracteristica c ON
pc.id_caracteristica = c.id_caracteristica \" +

                           \"WHERE pc.id_propiedad = ? \" +

                           \"ORDER BY c.nombre_caracteristica\";

        stmtCarac = conn.prepareStatement(sqlCarac);

        stmtCarac.setInt(1, idPropiedad);

        rsCarac = stmtCarac.executeQuery();

    }

%\>

\<div class=\"container my-4\"\>

    \<% if (!existePropiedad) { %\>

        \<div class=\"alert alert-warning text-center my-5 shadow-sm\"
role=\"alert\"\>

            \<h4 class=\"alert-heading\"\>¡Propiedad no
encontrada!\</h4\>

            \<p\>El inmueble especificado no existe o ha sido
desactivado.\</p\>

            \<hr\>

            \<a href=\"index.jsp\" class=\"btn btn-primary\"\>Volver al
catálogo\</a\>

        \</div\>

    \<% } else { %\>

        \<a href=\"index.jsp\" class=\"btn btn-outline-secondary
mb-3\"\>&larr; Volver a las propiedades\</a\>

        \<div class=\"row\"\>

            \<!\-- Columna Izquierda: Galería e Información General
\--\>

            \<div class=\"col-md-8\"\>

                \<h2\>\<%= rsProp.getString(\"titulo\") %\>\</h2\>

                \<p class=\"text-muted mb-3\"\>

                    \<i class=\"bi bi-geo-alt\"\>\</i\> \<%=
rsProp.getString(\"nombre_ciudad\") %\>, \<%=
rsProp.getString(\"departamento\") %\>

                    \<span class=\"ms-3 badge bg-outline-dark border
text-dark\"\>Matrícula: \<%=
rsProp.getString(\"matricula_inmobiliaria\") %\>\</span\>

                \</p\>

               

                \<!\-- Carrusel de fotos \--\>

                \<div id=\"carouselPropiedad\" class=\"carousel slide
mb-4 shadow rounded overflow-hidden bg-light\"
data-bs-ride=\"carousel\"\>

                    \<div class=\"carousel-inner\"\>

                        \<%

                            boolean primeraFoto = true;

                            if (rsFotos != null &&
rsFotos.isBeforeFirst()) {

                                while (rsFotos.next()) {

                        %\>

                                    \<div class=\"carousel-item \<%=
primeraFoto ? \"active\" : \"\" %\>\"\>

                                        \<img src=\"\<%=
rsFotos.getString(\"url_imagen\") %\>\" class=\"d-block w-100\"
alt=\"Foto Inmueble\" style=\"max-height: 480px; object-fit: cover;\"\>

                                    \</div\>

                        \<%

                                    primeraFoto = false;

                                }

                            } else {

                        %\>

                                \<div class=\"carousel-item active\"\>

                                    \<img src=\"\<%=
imagenPorTipo(rsProp.getString(\"nombre_tipo\"), idPropiedad) %\>\"
class=\"d-block w-100\" alt=\"\<%= rsProp.getString(\"titulo\") %\>\"
style=\"max-height: 480px; object-fit: cover;\"\>

                                \</div\>

                        \<% } %\>

                    \</div\>

                    \<button class=\"carousel-control-prev\"
type=\"button\" data-bs-target=\"#carouselPropiedad\"
data-bs-slide=\"prev\"\>

                        \<span class=\"carousel-control-prev-icon\"
aria-hidden=\"true\"\>\</span\>

                        \<span
class=\"visually-hidden\"\>Anterior\</span\>

                    \</button\>

                    \<button class=\"carousel-control-next\"
type=\"button\" data-bs-target=\"#carouselPropiedad\"
data-bs-slide=\"next\"\>

                        \<span class=\"carousel-control-next-icon\"
aria-hidden=\"true\"\>\</span\>

                        \<span
class=\"visually-hidden\"\>Siguiente\</span\>

                    \</button\>

                \</div\>

                \<!\-- Descripción detallada \--\>

                \<div class=\"card shadow-sm mb-4\"\>

                    \<div class=\"card-body\"\>

                        \<h4 class=\"card-title mb-3\"\>Descripción de
la Propiedad\</h4\>

                        \<p class=\"card-text text-secondary\"
style=\"white-space: pre-line;\"\>\<%= rsProp.getString(\"descripcion\")
!= null ? rsProp.getString(\"descripcion\") : \"Sin descripción
disponible.\" %\>\</p\>

                    \</div\>

                \</div\>

            \</div\>

            \<!\-- Columna Derecha: Tarjeta de Precio, Características e
Inmobiliaria \--\>

            \<div class=\"col-md-4\"\>

                \<div class=\"card shadow-sm sticky-top\" style=\"top:
20px;\"\>

                    \<div class=\"card-body\"\>

                        \<span class=\"badge bg-info text-dark
mb-2\"\>\<%= rsProp.getString(\"nombre_tipo\") %\>\</span\>

                        \<span class=\"badge bg-success mb-2\"\>\<%=
rsProp.getString(\"estado\") %\>\</span\>

                        \<h3 class=\"text-primary fw-bold my-2\"\>\$\<%=
String.format(\"%,.0f\", rsProp.getDouble(\"precio\")) %\>\</h3\>

                       

                        \<hr\>

                        \<h5 class=\"fw-bold
mb-3\"\>Características\</h5\>

                        \<ul class=\"list-group list-group-flush
mb-4\"\>

                            \<li class=\"list-group-item d-flex
justify-content-between align-items-center px-0\"\>

                                Área \<span\>\<%=
rsProp.getDouble(\"area_m2\") %\> m²\</span\>

                            \</li\>

                            \<li class=\"list-group-item d-flex
justify-content-between align-items-center px-0\"\>

                                Habitaciones \<span\>\<%=
rsProp.getInt(\"habitaciones\") %\>\</span\>

                            \</li\>

                            \<li class=\"list-group-item d-flex
justify-content-between align-items-center px-0\"\>

                                Baños \<span\>\<%=
rsProp.getInt(\"banos\") %\>\</span\>

                            \</li\>

                        \</ul\>

                        \<%

                            boolean hayCaracteristicas = false;

                            if (rsCarac != null) {

                                while (rsCarac.next()) {

                                    if (!hayCaracteristicas) { %\>

                                        \<div class=\"mb-4\"\>

                                            \<h6
class=\"fw-bold\"\>Comodidades\</h6\>

                        \<%

                                    }

                                    hayCaracteristicas = true;

                        %\>

                                    \<span class=\"badge bg-secondary
me-1 mb-1\"\>\<%= rsCarac.getString(\"nombre_caracteristica\")
%\>\</span\>

                        \<%

                                }

                                if (hayCaracteristicas) { %\>

                                    \</div\>

                        \<% }

                            }

                        %\>

                        \<div class=\"alert alert-light border\"\>

                            \<small class=\"text-muted
d-block\"\>Publicado por:\</small\>

                            \<strong\>\<%=
rsProp.getString(\"nombre_comercial\") %\>\</strong\>\<br\>

                            \<small\>Tel: \<%=
rsProp.getString(\"telefono_contacto\") != null ?
rsProp.getString(\"telefono_contacto\") : \"No disponible\"
%\>\</small\>

                        \</div\>

                        \<div class=\"d-grid gap-2\"\>

                            \<a href=\"contactar.jsp?id=\<%= idPropiedad
%\>\" class=\"btn btn-success btn-lg\"\>Agendar Cita / Contactar\</a\>

                        \</div\>

                    \</div\>

                \</div\>

            \</div\>

        \</div\>

    \<%

        }

        // Cierre de conexiones

        if (rsCarac != null) try { rsCarac.close(); } catch (Exception
e) {}

        if (stmtCarac != null) try { stmtCarac.close(); } catch
(Exception e) {}

        if (rsFotos != null) try { rsFotos.close(); } catch (Exception
e) {}

        if (stmtFotos != null) try { stmtFotos.close(); } catch
(Exception e) {}

        if (rsProp != null) try { rsProp.close(); } catch (Exception e)
{}

        if (stmtProp != null) try { stmtProp.close(); } catch (Exception
e) {}

        if (conn != null) try { conn.close(); } catch (Exception e) {}

    %\>

\</div\>

\<%@ include file=\"/WEB-INF/jspf/footer.jspf\" %\>

## 12.3 admin/formulario_propiedad.jsp

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ page import=\"java.util.Date\" %\>

\<%@ page import=\"java.util.Set\" %\>

\<%@ page import=\"java.util.HashSet\" %\>

\<%@ include file=\"../WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"../WEB-INF/jspf/header.jspf\" %\>

\<%

    // Verificación de sesión

    Integer idUsuario = (Integer) session.getAttribute(\"id_usuario\");

    if (idUsuario == null) {

       
response.sendRedirect(\"../login.jsp?redirect=admin/admin_propiedades.jsp\");

        return;

    }

    String rolSesionAdmin = (String) session.getAttribute(\"rol\");

    if (!(\"ADMINISTRADOR\".equalsIgnoreCase(rolSesionAdmin) \|\|
\"ADMIN\".equalsIgnoreCase(rolSesionAdmin))) {

        response.sendRedirect(\"../acceso_denegado.jsp\");

        return;

    }

    String idPropStr = request.getParameter(\"id\");

    int idPropiedad = 0;

    boolean esEdicion = false;

   

    if (idPropStr != null && !idPropStr.trim().isEmpty()) {

        try {

            idPropiedad = Integer.parseInt(idPropStr);

            esEdicion = (idPropiedad \> 0);

        } catch (NumberFormatException e) {

            idPropiedad = 0;

        }

    }

    Connection conn = obtenerConexion();

    String mensajeExito = null;

    String mensajeError = null;

    // Variables ajustadas a la tabla \'propiedad\'

    String matricula = \"\", titulo = \"\", descripcion = \"\", estado =
\"DISPONIBLE\";

    int idInmobiliaria = 1, idTipo = 0, idCiudad = 0, habitaciones = 0,
banos = 0;

    double areaM2 = 0.0, precio = 0.0;

    // IDs de las características (N:M) actualmente marcadas para esta
propiedad

    Set\<Integer\> caracteristicasSeleccionadas = new
HashSet\<Integer\>();

    // Texto con las URLs de las fotos de la propiedad (una por línea)

    String urlsImagenes = \"\";

    // Obtener id_inmobiliaria por defecto

    if (conn != null) {

        try {

            PreparedStatement stmtInmo = conn.prepareStatement(\"SELECT
id_inmobiliaria FROM inmobiliaria LIMIT 1\");

            ResultSet rsInmo = stmtInmo.executeQuery();

            if (rsInmo.next()) {

                idInmobiliaria = rsInmo.getInt(\"id_inmobiliaria\");

            }

            rsInmo.close();

            stmtInmo.close();

        } catch (Exception e) {}

    }

    // 1. PROCESAR GUARDADO (INSERT O UPDATE)

    if (\"POST\".equalsIgnoreCase(request.getMethod())) {

        titulo = request.getParameter(\"titulo\");

        descripcion = request.getParameter(\"descripcion\");

        estado = request.getParameter(\"estado\");

        matricula = request.getParameter(\"matricula_inmobiliaria\");

       

        if (matricula == null \|\| matricula.trim().isEmpty()) {

            matricula = \"MAT-\" + (new Date()).getTime();

        }

        try { idTipo =
Integer.parseInt(request.getParameter(\"id_tipo\")); } catch (Exception
e) {}

        try { idCiudad =
Integer.parseInt(request.getParameter(\"id_ciudad\")); } catch
(Exception e) {}

        try { habitaciones =
Integer.parseInt(request.getParameter(\"habitaciones\")); } catch
(Exception e) {}

        try { banos = Integer.parseInt(request.getParameter(\"banos\"));
} catch (Exception e) {}

       

        // Manejo seguro para evitar \'Out of range value for column
area_m2\'

        try {

            String areaStr = request.getParameter(\"area_m2\");

            if (areaStr != null && !areaStr.trim().isEmpty()) {

                areaM2 = Double.parseDouble(areaStr.replace(\",\",
\".\"));

            }

        } catch (Exception e) { areaM2 = 0.0; }

        try {

            String precioStr = request.getParameter(\"precio\");

            if (precioStr != null && !precioStr.trim().isEmpty()) {

                precio = Double.parseDouble(precioStr.replace(\",\",
\".\"));

            }

        } catch (Exception e) { precio = 0.0; }

        PreparedStatement stmtSave = null;

        try {

            if (esEdicion) {

                String sqlUpd = \"UPDATE propiedad SET id_tipo=?,
id_ciudad=?, titulo=?, descripcion=?, \" +

                                \"precio=?, area_m2=?, habitaciones=?,
banos=?, estado=?, matricula_inmobiliaria=? \" +

                                \"WHERE id_propiedad=?\";

                stmtSave = conn.prepareStatement(sqlUpd);

                stmtSave.setInt(1, idTipo);

                stmtSave.setInt(2, idCiudad);

                stmtSave.setString(3, titulo);

                stmtSave.setString(4, descripcion);

                stmtSave.setDouble(5, precio);

                stmtSave.setDouble(6, areaM2);

                stmtSave.setInt(7, habitaciones);

                stmtSave.setInt(8, banos);

                stmtSave.setString(9, estado);

                stmtSave.setString(10, matricula);

                stmtSave.setInt(11, idPropiedad);

                stmtSave.executeUpdate();

                mensajeExito = \"Propiedad actualizada con éxito.\";

            } else {

                String sqlIns = \"INSERT INTO propiedad
(matricula_inmobiliaria, id_inmobiliaria, id_ciudad, id_tipo, \" +

                                \"titulo, descripcion, precio, area_m2,
habitaciones, banos, estado) \" +

                                \"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
?)\";

                stmtSave = conn.prepareStatement(sqlIns,
Statement.RETURN_GENERATED_KEYS);

                stmtSave.setString(1, matricula);

                stmtSave.setInt(2, idInmobiliaria);

                stmtSave.setInt(3, idCiudad);

                stmtSave.setInt(4, idTipo);

                stmtSave.setString(5, titulo);

                stmtSave.setString(6, descripcion);

                stmtSave.setDouble(7, precio);

                stmtSave.setDouble(8, areaM2);

                stmtSave.setInt(9, habitaciones);

                stmtSave.setInt(10, banos);

                stmtSave.setString(11, estado);

                stmtSave.executeUpdate();

                ResultSet rsKeys = stmtSave.getGeneratedKeys();

                if (rsKeys.next()) {

                    idPropiedad = rsKeys.getInt(1);

                    esEdicion = true;

                }

                mensajeExito = \"Propiedad registrada exitosamente en la
base de datos.\";

            }

        } catch (SQLException e) {

            mensajeError = \"Error al guardar los datos de la propiedad:
\" + e.getMessage();

        } finally {

            if (stmtSave != null) try { stmtSave.close(); } catch
(Exception e) {}

        }

        // 1.b GUARDAR CARACTERÍSTICAS (relación N:M propiedad \<-\>
característica)

        if (mensajeError == null && idPropiedad \> 0) {

            String\[\] idsCaracteristicas =
request.getParameterValues(\"caracteristicas\");

            PreparedStatement stmtDelCar = null;

            PreparedStatement stmtInsCar = null;

            try {

                stmtDelCar = conn.prepareStatement(\"DELETE FROM
propiedad_caracteristica WHERE id_propiedad = ?\");

                stmtDelCar.setInt(1, idPropiedad);

                stmtDelCar.executeUpdate();

                if (idsCaracteristicas != null) {

                    stmtInsCar = conn.prepareStatement(

                        \"INSERT INTO propiedad_caracteristica
(id_propiedad, id_caracteristica) VALUES (?, ?)\");

                    for (String idCarStr : idsCaracteristicas) {

                        try {

                            int idCar = Integer.parseInt(idCarStr);

                            caracteristicasSeleccionadas.add(idCar);

                            stmtInsCar.setInt(1, idPropiedad);

                            stmtInsCar.setInt(2, idCar);

                            stmtInsCar.executeUpdate();

                        } catch (NumberFormatException nfe) { /\*
ignorar valor inválido \*/ }

                    }

                }

            } catch (SQLException e) {

                mensajeError = \"La propiedad se guardó, pero hubo un
error al guardar sus características: \" + e.getMessage();

            } finally {

                if (stmtInsCar != null) try { stmtInsCar.close(); }
catch (Exception e) {}

                if (stmtDelCar != null) try { stmtDelCar.close(); }
catch (Exception e) {}

            }

        }

        // 1.c GUARDAR IMÁGENES (1:N propiedad -\> imagen_propiedad)

        // Se reemplazan todas: se borran las que tenía y se insertan
las URLs pegadas ahora.

        // La primera línea del textarea queda marcada como es_portada.

        if (mensajeError == null && idPropiedad \> 0) {

            urlsImagenes = request.getParameter(\"urls_imagenes\");

            PreparedStatement stmtDelImg = null;

            PreparedStatement stmtInsImg = null;

            try {

                stmtDelImg = conn.prepareStatement(\"DELETE FROM
imagen_propiedad WHERE id_propiedad = ?\");

                stmtDelImg.setInt(1, idPropiedad);

                stmtDelImg.executeUpdate();

                if (urlsImagenes != null &&
!urlsImagenes.trim().isEmpty()) {

                    stmtInsImg = conn.prepareStatement(

                        \"INSERT INTO imagen_propiedad (id_propiedad,
url_imagen, es_portada) VALUES (?, ?, ?)\");

                    String\[\] lineas =
urlsImagenes.split(\"\\\\r?\\\\n\");

                    boolean primera = true;

                    for (String linea : lineas) {

                        String url = linea.trim();

                        if (url.isEmpty()) continue;

                        stmtInsImg.setInt(1, idPropiedad);

                        stmtInsImg.setString(2, url);

                        stmtInsImg.setBoolean(3, primera);

                        stmtInsImg.executeUpdate();

                        primera = false;

                    }

                }

            } catch (SQLException e) {

                mensajeError = \"La propiedad se guardó, pero hubo un
error al guardar sus fotos: \" + e.getMessage();

            } finally {

                if (stmtInsImg != null) try { stmtInsImg.close(); }
catch (Exception e) {}

                if (stmtDelImg != null) try { stmtDelImg.close(); }
catch (Exception e) {}

            }

        }

    }

    // 2. CARGAR DATOS SI ES EDICIÓN

    if (esEdicion && !\"POST\".equalsIgnoreCase(request.getMethod())) {

        PreparedStatement stmtLoad = null;

        ResultSet rsLoad = null;

        try {

            String sql = \"SELECT \* FROM propiedad WHERE id_propiedad =
?\";

            stmtLoad = conn.prepareStatement(sql);

            stmtLoad.setInt(1, idPropiedad);

            rsLoad = stmtLoad.executeQuery();

            if (rsLoad.next()) {

                matricula =
rsLoad.getString(\"matricula_inmobiliaria\");

                idTipo = rsLoad.getInt(\"id_tipo\");

                idCiudad = rsLoad.getInt(\"id_ciudad\");

                titulo = rsLoad.getString(\"titulo\");

                descripcion = rsLoad.getString(\"descripcion\");

                precio = rsLoad.getDouble(\"precio\");

                areaM2 = rsLoad.getDouble(\"area_m2\");

                habitaciones = rsLoad.getInt(\"habitaciones\");

                banos = rsLoad.getInt(\"banos\");

                estado = rsLoad.getString(\"estado\");

            }

        } catch (SQLException e) {

            mensajeError = \"Error al cargar la propiedad: \" +
e.getMessage();

        } finally {

            if (rsLoad != null) try { rsLoad.close(); } catch (Exception
e) {}

            if (stmtLoad != null) try { stmtLoad.close(); } catch
(Exception e) {}

        }

        // Cargar las características que esta propiedad ya tiene
marcadas

        PreparedStatement stmtCarSel = null;

        ResultSet rsCarSel = null;

        try {

            stmtCarSel = conn.prepareStatement(

                \"SELECT id_caracteristica FROM propiedad_caracteristica
WHERE id_propiedad = ?\");

            stmtCarSel.setInt(1, idPropiedad);

            rsCarSel = stmtCarSel.executeQuery();

            while (rsCarSel.next()) {

               
caracteristicasSeleccionadas.add(rsCarSel.getInt(\"id_caracteristica\"));

            }

        } catch (SQLException e) {

            mensajeError = \"Error al cargar las características: \" +
e.getMessage();

        } finally {

            if (rsCarSel != null) try { rsCarSel.close(); } catch
(Exception e) {}

            if (stmtCarSel != null) try { stmtCarSel.close(); } catch
(Exception e) {}

        }

        // Cargar las URLs de las fotos que esta propiedad ya tiene
registradas

        PreparedStatement stmtImgSel = null;

        ResultSet rsImgSel = null;

        try {

            stmtImgSel = conn.prepareStatement(

                \"SELECT url_imagen FROM imagen_propiedad WHERE
id_propiedad = ? ORDER BY es_portada DESC, id_imagen ASC\");

            stmtImgSel.setInt(1, idPropiedad);

            rsImgSel = stmtImgSel.executeQuery();

            StringBuilder sbImgs = new StringBuilder();

            while (rsImgSel.next()) {

                if (sbImgs.length() \> 0) sbImgs.append(\"\\n\");

                sbImgs.append(rsImgSel.getString(\"url_imagen\"));

            }

            urlsImagenes = sbImgs.toString();

        } catch (SQLException e) {

            mensajeError = \"Error al cargar las fotos: \" +
e.getMessage();

        } finally {

            if (rsImgSel != null) try { rsImgSel.close(); } catch
(Exception e) {}

            if (stmtImgSel != null) try { stmtImgSel.close(); } catch
(Exception e) {}

        }

    }

    // Consultar combos

    Statement stmtCombos = conn.createStatement();

    ResultSet rsTipos = stmtCombos.executeQuery(\"SELECT \* FROM
tipo_propiedad ORDER BY nombre_tipo\");

   

    Statement stmtCiudades = conn.createStatement();

    ResultSet rsCiudades = stmtCiudades.executeQuery(\"SELECT \* FROM
ciudad ORDER BY nombre_ciudad\");

    // Catálogo completo de características disponibles (para pintar los
checkboxes)

    Statement stmtCaracteristicas = conn.createStatement();

    ResultSet rsCaracteristicas = stmtCaracteristicas.executeQuery(

        \"SELECT \* FROM caracteristica ORDER BY
nombre_caracteristica\");

%\>

\<div class=\"container my-5\" style=\"max-width: 900px;\"\>

    \<div class=\"d-flex justify-content-between align-items-center
mb-4\"\>

        \<h2 class=\"fw-bold\"\>\<%= esEdicion ? \"Editar Propiedad
#\" + idPropiedad : \"Publicar Nueva Propiedad\" %\>\</h2\>

        \<a href=\"admin_propiedades.jsp\" class=\"btn
btn-outline-secondary\"\>&larr; Volver al Panel\</a\>

    \</div\>

    \<% if (mensajeExito != null) { %\>

        \<div class=\"alert alert-success alert-dismissible fade show\"
role=\"alert\"\>

            \<%= mensajeExito %\>

            \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

        \</div\>

    \<% } %\>

    \<% if (mensajeError != null) { %\>

        \<div class=\"alert alert-danger alert-dismissible fade show\"
role=\"alert\"\>

            \<%= mensajeError %\>

            \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

        \</div\>

    \<% } %\>

    \<div class=\"card shadow-sm border-0\"\>

        \<div class=\"card-body p-4\"\>

            \<form method=\"POST\" action=\"formulario_propiedad.jsp\<%=
esEdicion ? \"?id=\" + idPropiedad : \"\" %\>\"\>

                \<div class=\"row g-3\"\>

                   

                    \<div class=\"col-md-8\"\>

                        \<label for=\"titulo\" class=\"form-label
fw-bold\"\>Título de la Publicación \*\</label\>

                        \<input type=\"text\" class=\"form-control\"
id=\"titulo\" name=\"titulo\" value=\"\<%= titulo %\>\" required
placeholder=\"Ej: Hermoso Apartamento en Girón\"\>

                    \</div\>

                    \<div class=\"col-md-4\"\>

                        \<label for=\"matricula_inmobiliaria\"
class=\"form-label fw-bold\"\>Matrícula Inmobiliaria \*\</label\>

                        \<input type=\"text\" class=\"form-control\"
id=\"matricula_inmobiliaria\" name=\"matricula_inmobiliaria\"
value=\"\<%= matricula %\>\" placeholder=\"Ej: MAT-102030\"\>

                    \</div\>

                    \<div class=\"col-md-4\"\>

                        \<label for=\"id_tipo\" class=\"form-label
fw-bold\"\>Tipo de Inmueble \*\</label\>

                        \<select class=\"form-select\" id=\"id_tipo\"
name=\"id_tipo\" required\>

                            \<% while (rsTipos.next()) {

                                int idT = rsTipos.getInt(\"id_tipo\");

                            %\>

                                \<option value=\"\<%= idT %\>\" \<%= idT
== idTipo ? \"selected\" : \"\" %\>\>\<%=
rsTipos.getString(\"nombre_tipo\") %\>\</option\>

                            \<% } %\>

                        \</select\>

                    \</div\>

                    \<div class=\"col-md-4\"\>

                        \<label for=\"id_ciudad\" class=\"form-label
fw-bold\"\>Ciudad \*\</label\>

                        \<select class=\"form-select\" id=\"id_ciudad\"
name=\"id_ciudad\" required\>

                            \<% while (rsCiudades.next()) {

                                int idC =
rsCiudades.getInt(\"id_ciudad\");

                            %\>

                                \<option value=\"\<%= idC %\>\" \<%= idC
== idCiudad ? \"selected\" : \"\" %\>\>\<%=
rsCiudades.getString(\"nombre_ciudad\") %\>\</option\>

                            \<% } %\>

                        \</select\>

                    \</div\>

                    \<div class=\"col-md-4\"\>

                        \<label for=\"estado\" class=\"form-label
fw-bold\"\>Estado \*\</label\>

                        \<select class=\"form-select\" id=\"estado\"
name=\"estado\" required\>

                            \<option value=\"DISPONIBLE\" \<%=
\"DISPONIBLE\".equals(estado) ? \"selected\" : \"\"
%\>\>Disponible\</option\>

                            \<option value=\"RESERVADA\" \<%=
\"RESERVADA\".equals(estado) ? \"selected\" : \"\"
%\>\>Reservada\</option\>

                            \<option value=\"VENDIDA\" \<%=
\"VENDIDA\".equals(estado) ? \"selected\" : \"\" %\>\>Vendida\</option\>

                            \<option value=\"ARRENDADA\" \<%=
\"ARRENDADA\".equals(estado) ? \"selected\" : \"\"
%\>\>Arrendada\</option\>

                            \<option value=\"INACTIVA\" \<%=
\"INACTIVA\".equals(estado) ? \"selected\" : \"\"
%\>\>Inactiva\</option\>

                        \</select\>

                    \</div\>

                    \<div class=\"col-md-6\"\>

                        \<label for=\"precio\" class=\"form-label
fw-bold\"\>Precio (\$ COP) \*\</label\>

                        \<input type=\"number\" step=\"0.01\"
class=\"form-control\" id=\"precio\" name=\"precio\" value=\"\<%= precio
\> 0 ? precio : \"\" %\>\" required placeholder=\"Ej: 250000000\"\>

                    \</div\>

                    \<div class=\"col-md-6\"\>

                        \<label for=\"area_m2\" class=\"form-label
fw-bold\"\>Área (m²) \*\</label\>

                        \<input type=\"number\" step=\"0.01\"
class=\"form-control\" id=\"area_m2\" name=\"area_m2\" value=\"\<%=
areaM2 \> 0 ? areaM2 : \"\" %\>\" required placeholder=\"Ej: 75.5\"\>

                    \</div\>

                    \<div class=\"col-md-6\"\>

                        \<label for=\"habitaciones\" class=\"form-label
fw-bold\"\>Habitaciones\</label\>

                        \<input type=\"number\" class=\"form-control\"
id=\"habitaciones\" name=\"habitaciones\" value=\"\<%= habitaciones
%\>\" min=\"0\"\>

                    \</div\>

                    \<div class=\"col-md-6\"\>

                        \<label for=\"banos\" class=\"form-label
fw-bold\"\>Baños\</label\>

                        \<input type=\"number\" class=\"form-control\"
id=\"banos\" name=\"banos\" value=\"\<%= banos %\>\" min=\"0\"\>

                    \</div\>

                    \<div class=\"col-12\"\>

                        \<label for=\"descripcion\" class=\"form-label
fw-bold\"\>Descripción Completa\</label\>

                        \<textarea class=\"form-control\"
id=\"descripcion\" name=\"descripcion\" rows=\"4\"\>\<%= descripcion
%\>\</textarea\>

                    \</div\>

                    \<div class=\"col-12\"\>

                        \<label for=\"urls_imagenes\" class=\"form-label
fw-bold\"\>Fotos del Inmueble (una URL por línea)\</label\>

                        \<textarea class=\"form-control\"
id=\"urls_imagenes\" name=\"urls_imagenes\" rows=\"3\"
placeholder=\"https://ejemplo.com/foto1.jpg&#10;https://ejemplo.com/foto2.jpg\"\>\<%=
urlsImagenes %\>\</textarea\>

                        \<small class=\"text-muted\"\>La primera URL
queda como foto de portada. Si la dejas vacía, se mostrará una foto
genérica según el tipo de inmueble.\</small\>

                    \</div\>

                    \<div class=\"col-12\"\>

                        \<label class=\"form-label
fw-bold\"\>Características\</label\>

                        \<div class=\"row\"\>

                            \<%

                                while (rsCaracteristicas.next()) {

                                    int idCarac =
rsCaracteristicas.getInt(\"id_caracteristica\");

                                    String nombreCarac =
rsCaracteristicas.getString(\"nombre_caracteristica\");

                                    boolean marcado =
caracteristicasSeleccionadas.contains(idCarac);

                            %\>

                                \<div class=\"col-md-3 col-6 form-check
mb-2\"\>

                                    \<input class=\"form-check-input\"
type=\"checkbox\" name=\"caracteristicas\"

                                           value=\"\<%= idCarac %\>\"
id=\"carac\<%= idCarac %\>\" \<%= marcado ? \"checked\" : \"\" %\>\>

                                    \<label class=\"form-check-label\"
for=\"carac\<%= idCarac %\>\"\>\<%= nombreCarac %\>\</label\>

                                \</div\>

                            \<% } %\>

                        \</div\>

                    \</div\>

                \</div\>

                \<div class=\"mt-4 text-end\"\>

                    \<a href=\"admin_propiedades.jsp\" class=\"btn
btn-secondary me-2\"\>Cancelar\</a\>

                    \<button type=\"submit\" class=\"btn btn-primary
px-4 fw-bold\"\>

                        \<%= esEdicion ? \"Guardar Cambios\" : \"Crear
Propiedad\" %\>

                    \</button\>

                \</div\>

            \</form\>

        \</div\>

    \</div\>

\</div\>

\<%

    if (rsTipos != null) try { rsTipos.close(); } catch (Exception e) {}

    if (rsCiudades != null) try { rsCiudades.close(); } catch (Exception
e) {}

    if (rsCaracteristicas != null) try { rsCaracteristicas.close(); }
catch (Exception e) {}

    if (stmtCombos != null) try { stmtCombos.close(); } catch (Exception
e) {}

    if (stmtCiudades != null) try { stmtCiudades.close(); } catch
(Exception e) {}

    if (stmtCaracteristicas != null) try { stmtCaracteristicas.close();
} catch (Exception e) {}

    if (conn != null) try { conn.close(); } catch (Exception e) {}

%\>

\<%@ include file=\"../WEB-INF/jspf/footer.jspf\" %\>

## 12.4 admin/usuarios.jsp

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ page import=\"java.util.\*\" %\>

\<%@ include file=\"../WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"../WEB-INF/jspf/header.jspf\" %\>

\<%

    Integer idUsuario = (Integer) session.getAttribute(\"id_usuario\");

    if (idUsuario == null) {

       
response.sendRedirect(\"../login.jsp?redirect=admin/usuarios.jsp\");

        return;

    }

    String rolSesionAdmin = (String) session.getAttribute(\"rol\");

    if (!(\"ADMINISTRADOR\".equalsIgnoreCase(rolSesionAdmin) \|\|
\"ADMIN\".equalsIgnoreCase(rolSesionAdmin))) {

        response.sendRedirect(\"../acceso_denegado.jsp\");

        return;

    }

    Connection conn = obtenerConexion();

    String mensajeExito = null;

    String mensajeError = null;

    String accion = request.getParameter(\"accion\");

    String idUsrTarget = request.getParameter(\"id\");

    // Cambiar estado de usuario (Bloquear / Activar)

    if ((\"bloquear\".equals(accion) \|\| \"activar\".equals(accion)) &&
idUsrTarget != null && conn != null) {

        PreparedStatement stmtState = null;

        try {

            String nuevoEstado = \"bloquear\".equals(accion) ?
\"INACTIVO\" : \"ACTIVO\";

            stmtState = conn.prepareStatement(\"UPDATE usuario SET
estado = ? WHERE id_usuario = ?\");

            stmtState.setString(1, nuevoEstado);

            stmtState.setInt(2, Integer.parseInt(idUsrTarget));

            stmtState.executeUpdate();

            mensajeExito = \"Estado del usuario actualizado a \" +
nuevoEstado;

        } catch (SQLException e) {

            mensajeError = \"Error al actualizar estado: \" +
e.getMessage();

        } finally {

            if (stmtState != null) try { stmtState.close(); } catch
(Exception e) {}

        }

    }

    // Guardar roles asignados a un usuario (checkboxes del modal)

    if (\"guardar_roles\".equals(accion) && idUsrTarget != null && conn
!= null) {

        String\[\] rolesSeleccionados =
request.getParameterValues(\"roles\");

        PreparedStatement stmtDelRoles = null;

        PreparedStatement stmtInsRol = null;

        try {

            conn.setAutoCommit(false);

            stmtDelRoles = conn.prepareStatement(\"DELETE FROM
usuario_rol WHERE id_usuario = ?\");

            stmtDelRoles.setInt(1, Integer.parseInt(idUsrTarget));

            stmtDelRoles.executeUpdate();

            if (rolesSeleccionados != null) {

                stmtInsRol = conn.prepareStatement(\"INSERT INTO
usuario_rol (id_usuario, id_rol) VALUES (?, ?)\");

                for (String idRolStr : rolesSeleccionados) {

                    stmtInsRol.setInt(1, Integer.parseInt(idUsrTarget));

                    stmtInsRol.setInt(2, Integer.parseInt(idRolStr));

                    stmtInsRol.addBatch();

                }

                stmtInsRol.executeBatch();

            }

            conn.commit();

            mensajeExito = \"Roles actualizados correctamente.\";

        } catch (SQLException e) {

            try { conn.rollback(); } catch (SQLException ex) {}

            mensajeError = \"Error al actualizar roles: \" +
e.getMessage();

        } finally {

            try { conn.setAutoCommit(true); } catch (Exception e) {}

            if (stmtDelRoles != null) try { stmtDelRoles.close(); }
catch (Exception e) {}

            if (stmtInsRol != null) try { stmtInsRol.close(); } catch
(Exception e) {}

        }

    }

    // Catálogo completo de roles (para los checkboxes)

    List\<Object\[\]\> listaRoles = new ArrayList\<\>();

    if (conn != null) {

        try {

            Statement stmtRoles = conn.createStatement();

            ResultSet rsRoles = stmtRoles.executeQuery(\"SELECT id_rol,
nombre_rol FROM rol ORDER BY id_rol\");

            while (rsRoles.next()) {

                listaRoles.add(new Object\[\]{
rsRoles.getInt(\"id_rol\"), rsRoles.getString(\"nombre_rol\") });

            }

            rsRoles.close(); stmtRoles.close();

        } catch (SQLException e) { /\* ignorar \*/ }

    }

    // \-\-\-\-\-\-\-\-\-- 1ra pasada: cargar TODOS los datos en memoria
(una sola vez) \-\-\-\-\-\-\-\-\--

    // Guardamos cada usuario como Map para poder recorrerlo dos veces
sin volver a consultar:

    // una vez para pintar la tabla, y otra (fuera de la tabla) para
pintar los modales.

    List\<Map\<String,Object\>\> usuarios = new ArrayList\<\>();

    String mensajeErrorConsulta = null;

    if (conn != null) {

        Statement stmtUsers = null;

        ResultSet rsUsers = null;

        try {

            String sql = \"SELECT u.id_usuario, u.correo, u.estado,
u.fecha_registro, \" +

                         \"p.nombres, p.apellidos, p.documento,
p.telefono, \" +

                         \"GROUP_CONCAT(r.nombre_rol SEPARATOR \', \')
AS roles \" +

                         \"FROM usuario u \" +

                         \"LEFT JOIN perfil p ON u.id_usuario =
p.id_usuario \" +

                         \"LEFT JOIN usuario_rol ur ON u.id_usuario =
ur.id_usuario \" +

                         \"LEFT JOIN rol r ON ur.id_rol = r.id_rol \" +

                         \"GROUP BY u.id_usuario ORDER BY u.id_usuario
DESC\";

            stmtUsers = conn.createStatement();

            rsUsers = stmtUsers.executeQuery(sql);

            while (rsUsers.next()) {

                int idU = rsUsers.getInt(\"id_usuario\");

                Set\<Integer\> rolesIdsUsuario = new HashSet\<\>();

                try {

                    PreparedStatement stmtRolesUser =
conn.prepareStatement(

                        \"SELECT id_rol FROM usuario_rol WHERE
id_usuario = ?\");

                    stmtRolesUser.setInt(1, idU);

                    ResultSet rsRolesUser =
stmtRolesUser.executeQuery();

                    while (rsRolesUser.next())
rolesIdsUsuario.add(rsRolesUser.getInt(\"id_rol\"));

                    rsRolesUser.close(); stmtRolesUser.close();

                } catch (SQLException e) { /\* ignorar \*/ }

                Map\<String,Object\> u = new HashMap\<\>();

                u.put(\"id\", idU);

                u.put(\"estado\", rsUsers.getString(\"estado\"));

                u.put(\"nombres\", rsUsers.getString(\"nombres\"));

                u.put(\"apellidos\", rsUsers.getString(\"apellidos\"));

                u.put(\"correo\", rsUsers.getString(\"correo\"));

                u.put(\"documento\", rsUsers.getString(\"documento\"));

                u.put(\"roles\", rsUsers.getString(\"roles\"));

                u.put(\"rolesIds\", rolesIdsUsuario);

                usuarios.add(u);

            }

        } catch (SQLException e) {

            mensajeErrorConsulta = \"Error al consultar usuarios: \" +
e.getMessage();

        } finally {

            if (rsUsers != null) try { rsUsers.close(); } catch
(Exception e) {}

            if (stmtUsers != null) try { stmtUsers.close(); } catch
(Exception e) {}

        }

    }

    if (mensajeErrorConsulta != null) mensajeError =
mensajeErrorConsulta;

    if (conn != null) try { conn.close(); } catch (Exception e) {}

%\>

\<div class=\"container my-5\"\>

    \<div class=\"d-flex justify-content-between align-items-center
mb-4\"\>

        \<div\>

            \<h2 class=\"fw-bold m-0\"\>Gestión de Usuarios\</h2\>

            \<p class=\"text-muted m-0\"\>Administra cuentas, perfiles,
roles y estados de usuarios\</p\>

        \</div\>

        \<a href=\"index.jsp\" class=\"btn
btn-outline-secondary\"\>&larr; Volver al Panel\</a\>

    \</div\>

    \<% if (mensajeExito != null) { %\>

        \<div class=\"alert alert-success alert-dismissible fade show\"
role=\"alert\"\>

            \<%= mensajeExito %\>

            \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

        \</div\>

    \<% } %\>

    \<% if (mensajeError != null) { %\>

        \<div class=\"alert alert-danger alert-dismissible fade show\"
role=\"alert\"\>

            \<%= mensajeError %\>

            \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

        \</div\>

    \<% } %\>

    \<div class=\"card shadow-sm border-0\"\>

        \<div class=\"card-body p-0\"\>

            \<div class=\"table-responsive\"\>

                \<table class=\"table table-hover align-middle mb-0\"\>

                    \<thead class=\"table-light\"\>

                        \<tr\>

                            \<th\># ID\</th\>

                            \<th\>Nombre Completo\</th\>

                            \<th\>Correo Electrónico\</th\>

                            \<th\>Documento\</th\>

                            \<th\>Roles\</th\>

                            \<th\>Estado\</th\>

                            \<th class=\"text-end
px-4\"\>Acciones\</th\>

                        \</tr\>

                    \</thead\>

                    \<tbody\>

                        \<% if (usuarios.isEmpty()) { %\>

                        \<tr\>

                            \<td colspan=\"7\" class=\"text-center py-4
text-muted\"\>No se encontraron usuarios registrados.\</td\>

                        \</tr\>

                        \<% } %\>

                        \<% for (Map\<String,Object\> u : usuarios) {

                            int idU = (Integer) u.get(\"id\");

                            String estadoU = (String) u.get(\"estado\");

                            String nom = (String) u.get(\"nombres\");

                            String ape = (String) u.get(\"apellidos\");

                            String roles = (String) u.get(\"roles\");

                        %\>

                        \<tr\>

                            \<td class=\"fw-bold\"\>#\<%= idU %\>\</td\>

                            \<td\>\<%= (nom != null ? nom + \" \" + (ape
!= null ? ape : \"\") : \"Sin Perfil\") %\>\</td\>

                            \<td\>\<%= u.get(\"correo\") %\>\</td\>

                            \<td\>\<%= (u.get(\"documento\") != null ?
u.get(\"documento\") : \"-\") %\>\</td\>

                            \<td\>\<span class=\"badge
bg-primary\"\>\<%= (roles != null ? roles : \"Sin Rol\")
%\>\</span\>\</td\>

                            \<td\>

                                \<% if (\"ACTIVO\".equals(estadoU)) {
%\>

                                    \<span class=\"badge
bg-success\"\>Activo\</span\>

                                \<% } else { %\>

                                    \<span class=\"badge
bg-danger\"\>Inactivo\</span\>

                                \<% } %\>

                            \</td\>

                            \<td class=\"text-end px-4\"\>

                                \<a href=\"#\" class=\"btn btn-sm
btn-outline-primary me-1\"

                                   data-bs-toggle=\"modal\"
data-bs-target=\"#modalRoles\<%= idU %\>\"\>Roles\</a\>

                                \<% if (\"ACTIVO\".equals(estadoU)) {
%\>

                                    \<a
href=\"usuarios.jsp?accion=bloquear&id=\<%= idU %\>\"

                                       class=\"btn btn-sm
btn-outline-danger\"

                                       onclick=\"return
confirm(\'¿Desactivar esta cuenta?\');\"\>Desactivar\</a\>

                                \<% } else { %\>

                                    \<a
href=\"usuarios.jsp?accion=activar&id=\<%= idU %\>\"

                                       class=\"btn btn-sm
btn-outline-success\"\>Activar\</a\>

                                \<% } %\>

                            \</td\>

                        \</tr\>

                        \<% } %\>

                    \</tbody\>

                \</table\>

            \</div\>

        \</div\>

    \</div\>

\</div\>

\<!\-- =========================================================

     MODALES DE ROLES --- fuera de la tabla a propósito.

     Un \<div\> dentro de \<tbody\>/\<tr\> es HTML inválido: el

     navegador lo reubica solo y el modal queda \"roto\"

     (aparece el fondo oscuro pero no se puede interactuar).

     ========================================================= \--\>

\<% for (Map\<String,Object\> u : usuarios) {

    int idU = (Integer) u.get(\"id\");

    String nom = (String) u.get(\"nombres\");

    \@SuppressWarnings(\"unchecked\")

    Set\<Integer\> rolesIdsUsuario = (Set\<Integer\>)
u.get(\"rolesIds\");

%\>

\<div class=\"modal fade\" id=\"modalRoles\<%= idU %\>\"
tabindex=\"-1\"\>

  \<div class=\"modal-dialog\"\>

    \<div class=\"modal-content\"\>

      \<form method=\"POST\" action=\"usuarios.jsp\"\>

        \<input type=\"hidden\" name=\"accion\"
value=\"guardar_roles\"\>

        \<input type=\"hidden\" name=\"id\" value=\"\<%= idU %\>\"\>

        \<div class=\"modal-header\"\>

          \<h5 class=\"modal-title\"\>Roles --- \<%= (nom != null ? nom
: u.get(\"correo\")) %\>\</h5\>

          \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"modal\"\>\</button\>

        \</div\>

        \<div class=\"modal-body\"\>

          \<% for (Object\[\] rolItem : listaRoles) {

                int idRolItem = (Integer) rolItem\[0\];

                String nombreRolItem = (String) rolItem\[1\];

                boolean marcado = rolesIdsUsuario.contains(idRolItem);

          %\>

          \<div class=\"form-check\"\>

            \<input class=\"form-check-input\" type=\"checkbox\"
name=\"roles\"

                   value=\"\<%= idRolItem %\>\" id=\"rol\<%= idU
%\>\_\<%= idRolItem %\>\"

                   \<%= marcado ? \"checked\" : \"\" %\>\>

            \<label class=\"form-check-label\" for=\"rol\<%= idU
%\>\_\<%= idRolItem %\>\"\>\<%= nombreRolItem %\>\</label\>

          \</div\>

          \<% } %\>

        \</div\>

        \<div class=\"modal-footer\"\>

          \<button type=\"button\" class=\"btn btn-secondary\"
data-bs-dismiss=\"modal\"\>Cancelar\</button\>

          \<button type=\"submit\" class=\"btn btn-primary\"\>Guardar
Roles\</button\>

        \</div\>

      \</form\>

    \</div\>

  \</div\>

\</div\>

\<% } %\>

\<%@ include file=\"../WEB-INF/jspf/footer.jspf\" %\>

## 12.5 admin/solicitudes_admin.jsp

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ include file=\"../WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"../WEB-INF/jspf/header.jspf\" %\>

\<%

    // Verificación de sesión de administrador

    Integer idUsuario = (Integer) session.getAttribute(\"id_usuario\");

    if (idUsuario == null) {

       
response.sendRedirect(\"../login.jsp?redirect=admin/solicitudes_admin.jsp\");

        return;

    }

    String rolSesionAdmin = (String) session.getAttribute(\"rol\");

    if (!(\"ADMINISTRADOR\".equalsIgnoreCase(rolSesionAdmin) \|\|
\"ADMIN\".equalsIgnoreCase(rolSesionAdmin))) {

        response.sendRedirect(\"../acceso_denegado.jsp\");

        return;

    }

    Connection conn = obtenerConexion();

    String mensajeExito = null;

    String mensajeError = null;

    // Procesar actualización de estado para Solicitud o Cita

    String tipoAccion = request.getParameter(\"tipo\"); // \"solicitud\"
o \"cita\"

    String idTarget = request.getParameter(\"id\");

    String nuevoEstado = request.getParameter(\"nuevo_estado\");

    if (tipoAccion != null && idTarget != null && nuevoEstado != null &&
conn != null) {

        PreparedStatement stmtUpd = null;

        try {

            if (\"solicitud\".equals(tipoAccion)) {

                String sql = \"UPDATE solicitud SET estado = ? WHERE
id_solicitud = ?\";

                stmtUpd = conn.prepareStatement(sql);

                stmtUpd.setString(1, nuevoEstado);

                stmtUpd.setInt(2, Integer.parseInt(idTarget));

                stmtUpd.executeUpdate();

                mensajeExito = \"Estado de la solicitud #\" + idTarget +
\" actualizado a \" + nuevoEstado + \".\";

            } else if (\"cita\".equals(tipoAccion)) {

                String sql = \"UPDATE cita SET estado = ? WHERE id_cita
= ?\";

                stmtUpd = conn.prepareStatement(sql);

                stmtUpd.setString(1, nuevoEstado);

                stmtUpd.setInt(2, Integer.parseInt(idTarget));

                stmtUpd.executeUpdate();

                mensajeExito = \"Estado de la cita #\" + idTarget + \"
actualizado a \" + nuevoEstado + \".\";

            }

        } catch (SQLException e) {

            mensajeError = \"Error al actualizar estado: \" +
e.getMessage();

        } finally {

            if (stmtUpd != null) try { stmtUpd.close(); } catch
(Exception e) {}

        }

    }

    // Consultar Solicitudes pendientes o procesadas

    Statement stmtSoli = null;

    ResultSet rsSoli = null;

   

    // Consultar Citas programadas

    Statement stmtCita = null;

    ResultSet rsCitas = null;

    if (conn != null) {

        try {

            String sqlSoli = \"SELECT s.id_solicitud, s.tipo_solicitud,
s.estado, s.fecha_solicitud, s.observaciones, \" +

                             \"p.titulo, u.correo,
CONCAT(COALESCE(pf.nombres, \'\'), \' \', COALESCE(pf.apellidos, \'\'))
AS nombre_cliente \" +

                             \"FROM solicitud s \" +

                             \"INNER JOIN propiedad p ON s.id_propiedad
= p.id_propiedad \" +

                             \"INNER JOIN usuario u ON s.id_cliente =
u.id_usuario \" +

                             \"LEFT JOIN perfil pf ON u.id_usuario =
pf.id_usuario \" +

                             \"ORDER BY s.fecha_solicitud DESC\";

            stmtSoli = conn.createStatement();

            rsSoli = stmtSoli.executeQuery(sqlSoli);

            String sqlCita = \"SELECT c.id_cita, c.fecha_hora, c.estado,
c.observaciones, \" +

                             \"p.titulo, u.correo,
CONCAT(COALESCE(pf.nombres, \'\'), \' \', COALESCE(pf.apellidos, \'\'))
AS nombre_cliente \" +

                             \"FROM cita c \" +

                             \"INNER JOIN propiedad p ON c.id_propiedad
= p.id_propiedad \" +

                             \"INNER JOIN usuario u ON c.id_cliente =
u.id_usuario \" +

                             \"LEFT JOIN perfil pf ON u.id_usuario =
pf.id_usuario \" +

                             \"ORDER BY c.fecha_hora DESC\";

            stmtCita = conn.createStatement();

            rsCitas = stmtCita.executeQuery(sqlCita);

        } catch (SQLException e) {

            mensajeError = \"Error al cargar solicitudes y citas: \" +
e.getMessage();

        }

    }

%\>

\<div class=\"container my-5\"\>

    \<div class=\"d-flex justify-content-between align-items-center
mb-4\"\>

        \<div\>

            \<h2 class=\"fw-bold m-0\"\>Gestión de Solicitudes y
Citas\</h2\>

            \<p class=\"text-muted m-0\"\>Aaprueba, rechaza o confirma
solicitudes de clientes\</p\>

        \</div\>

        \<a href=\"index.jsp\" class=\"btn
btn-outline-secondary\"\>&larr; Volver al Panel\</a\>

    \</div\>

    \<% if (mensajeExito != null) { %\>

        \<div class=\"alert alert-success alert-dismissible fade show\"
role=\"alert\"\>

            \<%= mensajeExito %\>

            \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

        \</div\>

    \<% } %\>

    \<% if (mensajeError != null) { %\>

        \<div class=\"alert alert-danger alert-dismissible fade show\"
role=\"alert\"\>

            \<%= mensajeError %\>

            \<button type=\"button\" class=\"btn-close\"
data-bs-dismiss=\"alert\" aria-label=\"Close\"\>\</button\>

        \</div\>

    \<% } %\>

    \<!\-- SECCIÓN 1: SOLICITUDES (COMPRA / ARRIENDO) \--\>

    \<div class=\"card shadow-sm border-0 mb-5\"\>

        \<div class=\"card-header bg-primary text-white py-3\"\>

            \<h5 class=\"m-0 fw-bold\"\>Solicitudes de Compra y
Arriendo\</h5\>

        \</div\>

        \<div class=\"card-body p-0\"\>

            \<div class=\"table-responsive\"\>

                \<table class=\"table table-hover align-middle mb-0\"\>

                    \<thead class=\"table-light\"\>

                        \<tr\>

                            \<th\># ID\</th\>

                            \<th\>Cliente\</th\>

                            \<th\>Propiedad\</th\>

                            \<th\>Tipo\</th\>

                            \<th\>Fecha\</th\>

                            \<th\>Estado\</th\>

                            \<th class=\"text-end
px-4\"\>Acciones\</th\>

                        \</tr\>

                    \</thead\>

                    \<tbody\>

                        \<%

                            boolean haySolicitudes = false;

                            if (rsSoli != null) {

                                while (rsSoli.next()) {

                                    haySolicitudes = true;

                                    int idS =
rsSoli.getInt(\"id_solicitud\");

                                    String est =
rsSoli.getString(\"estado\");

                                    String cliente =
rsSoli.getString(\"nombre_cliente\");

                                    if (cliente == null \|\|
cliente.trim().isEmpty()) cliente = rsSoli.getString(\"correo\");

                        %\>

                        \<tr\>

                            \<td class=\"fw-bold\"\>#\<%= idS %\>\</td\>

                            \<td\>\<%= cliente %\>\</td\>

                            \<td class=\"fw-semibold\"\>\<%=
rsSoli.getString(\"titulo\") %\>\</td\>

                            \<td\>\<span class=\"badge
bg-secondary\"\>\<%= rsSoli.getString(\"tipo_solicitud\")
%\>\</span\>\</td\>

                            \<td\>\<small class=\"text-muted\"\>\<%=
rsSoli.getTimestamp(\"fecha_solicitud\") %\>\</small\>\</td\>

                            \<td\>

                                \<% if (\"PENDIENTE\".equals(est)) { %\>

                                    \<span class=\"badge bg-warning
text-dark\"\>Pendiente\</span\>

                                \<% } else if (\"APROBADA\".equals(est))
{ %\>

                                    \<span class=\"badge
bg-success\"\>Aprobada\</span\>

                                \<% } else { %\>

                                    \<span class=\"badge
bg-danger\"\>Rechazada\</span\>

                                \<% } %\>

                            \</td\>

                            \<td class=\"text-end px-4\"\>

                                \<% if (\"PENDIENTE\".equals(est)) { %\>

                                    \<a
href=\"solicitudes_admin.jsp?tipo=solicitud&id=\<%= idS
%\>&nuevo_estado=APROBADA\"

                                       class=\"btn btn-sm btn-success
me-1\"\>Aprobar\</a\>

                                    \<a
href=\"solicitudes_admin.jsp?tipo=solicitud&id=\<%= idS
%\>&nuevo_estado=RECHAZADA\"

                                       class=\"btn btn-sm
btn-outline-danger\"\>Rechazar\</a\>

                                \<% } else { %\>

                                    \<span class=\"text-muted
small\"\>Procesada\</span\>

                                \<% } %\>

                            \</td\>

                        \</tr\>

                        \<%

                                }

                            }

                            if (!haySolicitudes) {

                        %\>

                        \<tr\>

                            \<td colspan=\"7\" class=\"text-center py-4
text-muted\"\>No hay solicitudes registradas.\</td\>

                        \</tr\>

                        \<% } %\>

                    \</tbody\>

                \</table\>

            \</div\>

        \</div\>

    \</div\>

    \<!\-- SECCIÓN 2: CITAS PROGRAMADAS \--\>

    \<div class=\"card shadow-sm border-0\"\>

        \<div class=\"card-header bg-dark text-white py-3\"\>

            \<h5 class=\"m-0 fw-bold\"\>Citas de Visita
Programadas\</h5\>

        \</div\>

        \<div class=\"card-body p-0\"\>

            \<div class=\"table-responsive\"\>

                \<table class=\"table table-hover align-middle mb-0\"\>

                    \<thead class=\"table-light\"\>

                        \<tr\>

                            \<th\># Cita\</th\>

                            \<th\>Cliente\</th\>

                            \<th\>Propiedad\</th\>

                            \<th\>Fecha y Hora\</th\>

                            \<th\>Estado\</th\>

                            \<th class=\"text-end
px-4\"\>Acciones\</th\>

                        \</tr\>

                    \</thead\>

                    \<tbody\>

                        \<%

                            boolean hayCitas = false;

                            if (rsCitas != null) {

                                while (rsCitas.next()) {

                                    hayCitas = true;

                                    int idC =
rsCitas.getInt(\"id_cita\");

                                    String estC =
rsCitas.getString(\"estado\");

                                    String clienteC =
rsCitas.getString(\"nombre_cliente\");

                                    if (clienteC == null \|\|
clienteC.trim().isEmpty()) clienteC = rsCitas.getString(\"correo\");

                        %\>

                        \<tr\>

                            \<td class=\"fw-bold\"\>#\<%= idC %\>\</td\>

                            \<td\>\<%= clienteC %\>\</td\>

                            \<td class=\"fw-semibold\"\>\<%=
rsCitas.getString(\"titulo\") %\>\</td\>

                            \<td\>\<strong\>\<%=
rsCitas.getTimestamp(\"fecha_hora\") %\>\</strong\>\</td\>

                            \<td\>

                                \<% if (\"PENDIENTE\".equals(estC)) {
%\>

                                    \<span class=\"badge bg-warning
text-dark\"\>Pendiente\</span\>

                                \<% } else if
(\"CONFIRMADA\".equals(estC)) { %\>

                                    \<span class=\"badge
bg-success\"\>Confirmada\</span\>

                                \<% } else if
(\"REALIZADA\".equals(estC)) { %\>

                                    \<span class=\"badge bg-info
text-dark\"\>Realizada\</span\>

                                \<% } else if
(\"RECHAZADA\".equals(estC)) { %\>

                                    \<span class=\"badge
bg-danger\"\>Rechazada\</span\>

                                \<% } else { %\>

                                    \<span class=\"badge
bg-secondary\"\>Cancelada\</span\>

                                \<% } %\>

                            \</td\>

                            \<td class=\"text-end px-4\"\>

                                \<% if (\"PENDIENTE\".equals(estC)) {
%\>

                                    \<a
href=\"solicitudes_admin.jsp?tipo=cita&id=\<%= idC
%\>&nuevo_estado=CONFIRMADA\"

                                       class=\"btn btn-sm btn-success
me-1\"\>Confirmar\</a\>

                                    \<a
href=\"solicitudes_admin.jsp?tipo=cita&id=\<%= idC
%\>&nuevo_estado=RECHAZADA\"

                                       class=\"btn btn-sm
btn-outline-danger\"\>Rechazar\</a\>

                                \<% } else if
(\"CONFIRMADA\".equals(estC)) { %\>

                                    \<a
href=\"solicitudes_admin.jsp?tipo=cita&id=\<%= idC
%\>&nuevo_estado=REALIZADA\"

                                       class=\"btn btn-sm btn-info
text-dark\"\>Marcar Realizada\</a\>

                                \<% } else { %\>

                                    \<span class=\"text-muted
small\"\>Finalizada\</span\>

                                \<% } %\>

                            \</td\>

                        \</tr\>

                        \<%

                                }

                            }

                            if (!hayCitas) {

                        %\>

                        \<tr\>

                            \<td colspan=\"6\" class=\"text-center py-4
text-muted\"\>No hay citas registradas.\</td\>

                        \</tr\>

                        \<% } %\>

                    \</tbody\>

                \</table\>

            \</div\>

        \</div\>

    \</div\>

\</div\>

\<%

    if (rsSoli != null) try { rsSoli.close(); } catch (Exception e) {}

    if (rsCitas != null) try { rsCitas.close(); } catch (Exception e) {}

    if (stmtSoli != null) try { stmtSoli.close(); } catch (Exception e)
{}

    if (stmtCita != null) try { stmtCita.close(); } catch (Exception e)
{}

    if (conn != null) try { conn.close(); } catch (Exception e) {}

%\>

\<%@ include file=\"../WEB-INF/jspf/footer.jspf\" %\>

## 12.6 admin/reportes.jsp

\<%@ page contentType=\"text/html; charset=UTF-8\"
pageEncoding=\"UTF-8\" %\>

\<%@ page import=\"java.sql.\*\" %\>

\<%@ include file=\"../WEB-INF/jspf/conexion.jspf\" %\>

\<%@ include file=\"../WEB-INF/jspf/header.jspf\" %\>

\<%

    // Verificación de sesión de administrador (además del Filter, por
si acaso)

    Integer idUsuario = (Integer) session.getAttribute(\"id_usuario\");

    if (idUsuario == null) {

       
response.sendRedirect(\"../login.jsp?redirect=admin/reportes.jsp\");

        return;

    }

    String rolSesionAdmin = (String) session.getAttribute(\"rol\");

    if (!(\"ADMINISTRADOR\".equalsIgnoreCase(rolSesionAdmin) \|\|
\"ADMIN\".equalsIgnoreCase(rolSesionAdmin))) {

        response.sendRedirect(\"../acceso_denegado.jsp\");

        return;

    }

    Connection conn = obtenerConexion();

    String mensajeError = null;

%\>

\<div class=\"container my-4\"\>

    \<h2 class=\"fw-bold mb-4\"\>\<i class=\"bi bi-bar-chart-line
me-2\"\>\</i\>Reportes\</h2\>

    \<% if (mensajeError != null) { %\>

        \<div class=\"alert alert-danger\"\>\<%= mensajeError
%\>\</div\>

    \<% } %\>

    \<div class=\"row g-4\"\>

        \<!\--
================================================================

             REPORTE 1: Propiedades disponibles por ciudad y estado

             (INNER JOIN entre 3 tablas + GROUP BY)

       
================================================================= \--\>

        \<div class=\"col-md-6\"\>

            \<div class=\"card shadow-sm h-100\"\>

                \<div class=\"card-header bg-primary text-white
fw-bold\"\>

                    Propiedades por ciudad y estado

                \</div\>

                \<div class=\"card-body\"\>

                    \<table class=\"table table-sm table-striped\"\>

                        \<thead\>

                           
\<tr\>\<th\>Ciudad\</th\>\<th\>Estado\</th\>\<th
class=\"text-end\"\>Cantidad\</th\>\</tr\>

                        \</thead\>

                        \<tbody\>

                        \<%

                            String sqlR1 =

                                \"SELECT c.nombre_ciudad, p.estado,
COUNT(\*) AS total \" +

                                \"FROM propiedad p \" +

                                \"INNER JOIN ciudad c ON p.id_ciudad =
c.id_ciudad \" +

                                \"INNER JOIN tipo_propiedad t ON
p.id_tipo = t.id_tipo \" +

                                \"WHERE p.activo = TRUE \" +

                                \"GROUP BY c.nombre_ciudad, p.estado \"
+

                                \"ORDER BY c.nombre_ciudad, p.estado\";

                            Statement stR1 = null;

                            ResultSet rsR1 = null;

                            boolean hayR1 = false;

                            try {

                                stR1 = conn.createStatement();

                                rsR1 = stR1.executeQuery(sqlR1);

                                while (rsR1.next()) {

                                    hayR1 = true;

                        %\>

                                    \<tr\>

                                        \<td\>\<%=
rsR1.getString(\"nombre_ciudad\") %\>\</td\>

                                        \<td\>\<%=
rsR1.getString(\"estado\") %\>\</td\>

                                        \<td class=\"text-end\"\>\<%=
rsR1.getInt(\"total\") %\>\</td\>

                                    \</tr\>

                        \<%

                                }

                            } catch (SQLException e) {

                                mensajeError = \"Error en reporte 1:
\" + e.getMessage();

                            } finally {

                                if (rsR1 != null) try { rsR1.close(); }
catch (Exception e) {}

                                if (stR1 != null) try { stR1.close(); }
catch (Exception e) {}

                            }

                            if (!hayR1) { %\>

                                \<tr\>\<td colspan=\"3\"
class=\"text-center text-muted\"\>Sin datos.\</td\>\</tr\>

                            \<% } %\>

                        \</tbody\>

                    \</table\>

                \</div\>

            \</div\>

        \</div\>

        \<!\--
================================================================

             REPORTE 2: Citas por estado

             (INNER JOIN + GROUP BY, alimenta un indicador operativo)

       
================================================================= \--\>

        \<div class=\"col-md-6\"\>

            \<div class=\"card shadow-sm h-100\"\>

                \<div class=\"card-header bg-primary text-white
fw-bold\"\>

                    Citas por estado

                \</div\>

                \<div class=\"card-body\"\>

                    \<table class=\"table table-sm table-striped\"\>

                        \<thead\>

                            \<tr\>\<th\>Estado\</th\>\<th
class=\"text-end\"\>Cantidad\</th\>\</tr\>

                        \</thead\>

                        \<tbody\>

                        \<%

                            String sqlR2 =

                                \"SELECT ci.estado, COUNT(\*) AS total
\" +

                                \"FROM cita ci \" +

                                \"INNER JOIN propiedad p ON
ci.id_propiedad = p.id_propiedad \" +

                                \"INNER JOIN inmobiliaria i ON
p.id_inmobiliaria = i.id_inmobiliaria \" +

                                \"GROUP BY ci.estado \" +

                                \"ORDER BY total DESC\";

                            Statement stR2 = null;

                            ResultSet rsR2 = null;

                            boolean hayR2 = false;

                            try {

                                stR2 = conn.createStatement();

                                rsR2 = stR2.executeQuery(sqlR2);

                                while (rsR2.next()) {

                                    hayR2 = true;

                        %\>

                                    \<tr\>

                                        \<td\>\<%=
rsR2.getString(\"estado\") %\>\</td\>

                                        \<td class=\"text-end\"\>\<%=
rsR2.getInt(\"total\") %\>\</td\>

                                    \</tr\>

                        \<%

                                }

                            } catch (SQLException e) {

                                mensajeError = \"Error en reporte 2:
\" + e.getMessage();

                            } finally {

                                if (rsR2 != null) try { rsR2.close(); }
catch (Exception e) {}

                                if (stR2 != null) try { stR2.close(); }
catch (Exception e) {}

                            }

                            if (!hayR2) { %\>

                                \<tr\>\<td colspan=\"2\"
class=\"text-center text-muted\"\>Sin datos.\</td\>\</tr\>

                            \<% } %\>

                        \</tbody\>

                    \</table\>

                \</div\>

            \</div\>

        \</div\>

        \<!\--
================================================================

             REPORTE 3: Solicitudes por inmobiliaria

             (GROUP BY \... HAVING: solo inmobiliarias con al menos 1
solicitud)

       
================================================================= \--\>

        \<div class=\"col-md-6\"\>

            \<div class=\"card shadow-sm h-100\"\>

                \<div class=\"card-header bg-success text-white
fw-bold\"\>

                    Solicitudes por inmobiliaria \<small
class=\"fw-normal\"\>(HAVING &gt;= 1)\</small\>

                \</div\>

                \<div class=\"card-body\"\>

                    \<table class=\"table table-sm table-striped\"\>

                        \<thead\>

                            \<tr\>\<th\>Inmobiliaria\</th\>\<th
class=\"text-end\"\>Total solicitudes\</th\>\</tr\>

                        \</thead\>

                        \<tbody\>

                        \<%

                            // GROUP BY + HAVING: se filtran los GRUPOS
(no las filas) para mostrar

                            // solo las inmobiliarias que ya han
recibido al menos una solicitud.

                            String sqlR3 =

                                \"SELECT i.nombre_comercial, COUNT(\*)
AS total_solicitudes \" +

                                \"FROM solicitud s \" +

                                \"INNER JOIN propiedad p ON
s.id_propiedad = p.id_propiedad \" +

                                \"INNER JOIN inmobiliaria i ON
p.id_inmobiliaria = i.id_inmobiliaria \" +

                                \"GROUP BY i.nombre_comercial \" +

                                \"HAVING COUNT(\*) \>= 1 \" +

                                \"ORDER BY total_solicitudes DESC\";

                            Statement stR3 = null;

                            ResultSet rsR3 = null;

                            boolean hayR3 = false;

                            try {

                                stR3 = conn.createStatement();

                                rsR3 = stR3.executeQuery(sqlR3);

                                while (rsR3.next()) {

                                    hayR3 = true;

                        %\>

                                    \<tr\>

                                        \<td\>\<%=
rsR3.getString(\"nombre_comercial\") %\>\</td\>

                                        \<td class=\"text-end\"\>\<%=
rsR3.getInt(\"total_solicitudes\") %\>\</td\>

                                    \</tr\>

                        \<%

                                }

                            } catch (SQLException e) {

                                mensajeError = \"Error en reporte 3:
\" + e.getMessage();

                            } finally {

                                if (rsR3 != null) try { rsR3.close(); }
catch (Exception e) {}

                                if (stR3 != null) try { stR3.close(); }
catch (Exception e) {}

                            }

                            if (!hayR3) { %\>

                                \<tr\>\<td colspan=\"2\"
class=\"text-center text-muted\"\>Ninguna inmobiliaria tiene solicitudes
todavía.\</td\>\</tr\>

                            \<% } %\>

                        \</tbody\>

                    \</table\>

                \</div\>

            \</div\>

        \</div\>

        \<!\--
================================================================

             REPORTE 4: Propiedades activas sin ninguna cita agendada

             (LEFT JOIN: se conservan las propiedades aunque no tengan
cita)

       
================================================================= \--\>

        \<div class=\"col-md-6\"\>

            \<div class=\"card shadow-sm h-100\"\>

                \<div class=\"card-header bg-warning fw-bold\"\>

                    Propiedades sin citas agendadas \<small
class=\"fw-normal\"\>(LEFT JOIN)\</small\>

                \</div\>

                \<div class=\"card-body\" style=\"max-height: 320px;
overflow-y: auto;\"\>

                    \<table class=\"table table-sm table-striped\"\>

                        \<thead\>

                           
\<tr\>\<th\>Propiedad\</th\>\<th\>Ciudad\</th\>\</tr\>

                        \</thead\>

                        \<tbody\>

                        \<%

                            // LEFT JOIN: trae TODAS las propiedades
activas, tengan o no cita;

                            // el WHERE ci.id_cita IS NULL se queda solo
con las que nunca tuvieron una.

                            String sqlR4 =

                                \"SELECT p.titulo, c.nombre_ciudad \" +

                                \"FROM propiedad p \" +

                                \"INNER JOIN ciudad c ON p.id_ciudad =
c.id_ciudad \" +

                                \"LEFT JOIN cita ci ON ci.id_propiedad =
p.id_propiedad \" +

                                \"WHERE p.activo = TRUE AND ci.id_cita
IS NULL \" +

                                \"ORDER BY p.titulo\";

                            Statement stR4 = null;

                            ResultSet rsR4 = null;

                            boolean hayR4 = false;

                            try {

                                stR4 = conn.createStatement();

                                rsR4 = stR4.executeQuery(sqlR4);

                                while (rsR4.next()) {

                                    hayR4 = true;

                        %\>

                                    \<tr\>

                                        \<td\>\<%=
rsR4.getString(\"titulo\") %\>\</td\>

                                        \<td\>\<%=
rsR4.getString(\"nombre_ciudad\") %\>\</td\>

                                    \</tr\>

                        \<%

                                }

                            } catch (SQLException e) {

                                mensajeError = \"Error en reporte 4:
\" + e.getMessage();

                            } finally {

                                if (rsR4 != null) try { rsR4.close(); }
catch (Exception e) {}

                                if (stR4 != null) try { stR4.close(); }
catch (Exception e) {}

                            }

                            if (!hayR4) { %\>

                                \<tr\>\<td colspan=\"2\"
class=\"text-center text-muted\"\>Todas las propiedades activas ya
tienen al menos una cita.\</td\>\</tr\>

                            \<% } %\>

                        \</tbody\>

                    \</table\>

                \</div\>

            \</div\>

        \</div\>

    \</div\>

\</div\>

\<%

    if (conn != null) try { conn.close(); } catch (Exception e) {}

%\>

\<%@ include file=\"../WEB-INF/jspf/footer.jspf\" %\>

# **13. Desplegar y probar la aplicación**

## **13.1 Puesta en marcha**

  ------------------------------------------------------------------------------------------
  **\#**   **Acción**                         **Resultado esperado**
  -------- ---------------------------------- ----------------------------------------------
  1        Iniciar MySQL (XAMPP local, o      El servicio queda disponible.
           dejar USAR_NUBE = true para la     
           base en Clever Cloud).             

  2        Ejecutar el script de creación del Todas las tablas del apartado 3.1 quedan
           esquema db_inmobiliaria.           creadas, con los catálogos base (ciudad,
                                              tipo_propiedad, caracteristica, rol) poblados.

  3        Comprobar que                      El .jar se ve dentro de la carpeta del
           mysql-connector-j-9.7.0.jar está   proyecto desplegado.
           en WEB-INF/lib.                    

  4        Ajustar USAR_NUBE y, si aplica,    Coinciden con la instalación de MySQL que se
           las credenciales locales en        vaya a usar.
           conexion.jspf.                     

  5        Ejecutar el proyecto en Tomcat.    Se abre
                                              http://localhost:8080/InmobiliariaSantander/

  6        Registrar un usuario de prueba     Queda creado con rol CLIENTE por defecto.
           desde registro.jsp e iniciar       
           sesión.                            
  ------------------------------------------------------------------------------------------

## **13.2 Guion de prueba sugerido**

  -------------------------------------------------------------------------------
  **\#**   **Usuario**   **Acción**                      **Qué debe ocurrir**
  -------- ------------- ------------------------------- ------------------------
  1        visitante     Entrar a index.jsp y filtrar    El catálogo se actualiza
                         por ciudad.                     según el filtro.

  2        visitante     Escribir directamente la URL    El Filtro redirige a
                         /cliente/index.jsp en el        login.jsp (no hay
                         navegador.                      sesión).

  3        cliente1      Registrarse e iniciar sesión.   Queda con rol CLIENTE y
                                                         entra a
                                                         cliente/index.jsp.

  4        cliente1      Abrir el detalle de una         Se inserta en cita con
                         propiedad y agendar una cita.   estado inicial
                                                         pendiente.

  5        cliente1      Agendar otra cita para la misma Mensaje \"Ya existe una
                         propiedad y el mismo horario.   cita agendada\...\"
                                                         (restricción UNIQUE,
                                                         error 1062).

  6        cliente1      Marcar una propiedad como       Aparece en la lista
                         favorita y revisar              mientras dure la sesión.
                         cliente/favoritos.jsp.          

  7        cliente1      Iniciar sesión con rol CLIENTE  El Filtro redirige a
                         e intentar entrar a             acceso_denegado.jsp (rol
                         /admin/index.jsp.               incorrecto).

  8        agente1       Iniciar sesión como agente y    Queda en propiedad con
                         publicar una propiedad nueva.   su id_inmobiliaria.

  9        agente1       Revisar                         Solo ve las
                         inmobiliaria/solicitudes.jsp.   citas/solicitudes de sus
                                                         propias propiedades.

  10       admin         Entrar a admin/usuarios.jsp y   usuario.estado pasa a
                         bloquear a cliente1.            INACTIVO.

  11       cliente1      Intentar iniciar sesión de      Mensaje \"Tu cuenta se
           (bloqueado)   nuevo.                          encuentra inactiva\...\"
  -------------------------------------------------------------------------------

[]{#_Toc240484091 .anchor}

**14. Errores frecuentes y observaciones**

  -------------------------------------------------------------------------------------------
  **Mensaje o síntoma**              **Causa probable**      **Solución**
  ---------------------------------- ----------------------- --------------------------------
  ClassNotFoundException:            El driver no está en    Copiar
  com.mysql.cj.jdbc.Driver           WEB-INF/lib.            mysql-connector-j-9.7.0.jar
                                                             dentro de WEB-INF/lib y
                                                             reiniciar Tomcat.

  obtenerConexion() devuelve null y  El catch de             Mientras se depura, agregar
  la página no avisa por qué         conexion.jspf está      temporalmente un log
                                     diseñado para fallar en (e.printStackTrace() o
                                     silencio.               out.println) dentro del catch
                                                             para ver la causa real.

  Ya existe una cita agendada en esa Restricción UNIQUE en   Es el comportamiento esperado;
  propiedad para el horario          cita sobre              elegir otro horario.
  seleccionado                       (id_propiedad,          
                                     fecha_hora).            

  Acceso Denegado (403) al entrar a  El rol de la sesión no  Verificar el rol asignado al
  un panel                           coincide con el prefijo usuario en usuario_rol, o
                                     de la URL, según        iniciar sesión con la cuenta
                                     FiltroControlAcceso.    correcta.

  El usuario entra al login pero     El valor de rol         Revisar que rol.nombre_rol use
  nunca llega a /admin ni a          guardado en la tabla    esos tres valores tal cual; el
  /inmobiliaria                      rol no coincide         filtro compara con
                                     EXACTAMENTE con         equalsIgnoreCase pero exige el
                                     ADMINISTRADOR,          mismo texto.
                                     INMOBILIARIA o CLIENTE. 

  jakarta.servlet.ServletException / Incompatibilidad Tomcat Usar
  javax.servlet no existe            9 vs 10/11.             web-tomcat10-11-REFERENCIA.xml y
                                                             actualizar los imports de
                                                             FiltroControlAcceso.java a
                                                             jakarta.servlet.\*.

  Las tildes salen como caracteres   Falta la codificación   Revisar pageEncoding, el meta
  raros                              UTF-8 en algún punto.   charset de header.jspf y
                                                             characterEncoding en la URL de
                                                             conexión.

  La propiedad no aparece en el      El campo activo quedó   Revisar el valor de activo y que
  catálogo tras crearla              en false, o falta el    id_ciudad / id_tipo existan en
                                     JOIN con                sus tablas.
                                     ciudad/tipo_propiedad   
                                     por un id inválido.     
  -------------------------------------------------------------------------------------------

# **Anexo A. Inventario de archivos entregados**

  ---------------------------------------------------------------------------------------------
  **Archivo**                                                         **Contenido**
  ------------------------------------------------------------------- -------------------------
  sql/db_inmobiliaria.sql (por agregar)                               Esquema completo,
                                                                      catálogos iniciales
                                                                      (ciudad, tipo_propiedad,
                                                                      caracteristica, rol) y
                                                                      usuarios de prueba.

  WEB-INF/jspf/conexion.jspf                                          Conexión JDBC local/nube.

  WEB-INF/jspf/header.jspf                                            Cabecera y barra de
                                                                      navegación por rol.

  WEB-INF/jspf/footer.jspf                                            Cierre y JavaScript de
                                                                      Bootstrap.

  WEB-INF/jspf/imagenes.jspf                                          Imagen de relleno por
                                                                      tipo de propiedad.

  WEB-INF/classes/com/inmobiliaria/filtros/FiltroControlAcceso.java   Filtro de control de
                                                                      acceso por rol.

  index.jsp, login.jsp, registro.jsp, logout.jsp                      Entrada, autenticación y
                                                                      salida.

  catalogo.jsp, detalle_propiedad.jsp, contactar.jsp,                 Módulo público y de
  mis_solicitudes.jsp, favorito_toggle.jsp, acceso_denegado.jsp       contacto.

  cliente/index.jsp, perfil.jsp, favoritos.jsp, solicitudes.jsp       Panel del cliente.

  inmobiliaria/index.jsp, propiedades.jsp, formulario_propiedad.jsp,  Panel del agente.
  solicitudes.jsp                                                     

  admin/index.jsp, admin_propiedades.jsp, formulario_propiedad.jsp,   Panel de administración.
  usuarios.jsp, solicitudes_admin.jsp, reportes.jsp                   

  css/estilos.css                                                     Ajustes propios sobre
                                                                      Bootstrap.

  WEB-INF/web.xml y web-tomcat10-11-REFERENCIA.xml                    Descriptor de despliegue
                                                                      y su variante para Tomcat
                                                                      10/11.
  ---------------------------------------------------------------------------------------------
