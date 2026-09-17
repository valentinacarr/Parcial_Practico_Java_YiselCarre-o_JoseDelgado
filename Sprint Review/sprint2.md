# Sprint 2 – Núcleo del negocio

**Duración:** 7 días
**Objetivo del sprint:** Implementar el CRUD de propiedades con imágenes (1:N) y características (N:M), el buscador con filtros, el perfil de usuario (1:1) y los paneles diferenciados por rol.

---

## Sprint Planning

Historias de usuario abordadas en este sprint (tomadas del backlog priorizado):

| # | Historia de usuario | Estimación | Prioridad |
|---|---|---|---|
| 5 | Como cliente, quiero completar mi perfil con documento, teléfono y dirección asociados a mi cuenta para agilizar mis trámites. | 1 día | Media |
| 6 | Como agente de la inmobiliaria, quiero registrar y editar propiedades con fotos, características y precio para mantener el catálogo actualizado. | 2 días | Alta |
| 7 | Como cliente, quiero buscar y filtrar propiedades por ciudad, tipo, precio y características para encontrar las opciones que se ajusten a mis necesidades. | 2 días | Alta |
| — | Como usuario, quiero acceder a un panel (dashboard) diferenciado según mi rol para ver únicamente las opciones que me corresponden. | 2 días | Alta |

**Criterios de aceptación (DoD) generales del sprint:**
- El CRUD de propiedades permite crear, editar, listar y dar de baja (baja lógica) un inmueble.
- Cada propiedad puede tener una o varias imágenes asociadas (relación 1:N con `imagen_propiedad`).
- Cada propiedad puede tener varias características, y cada característica aplica a varias propiedades (relación N:M vía `propiedad_caracteristica`).
- El buscador filtra correctamente por ciudad, tipo, precio y características.
- El perfil del usuario (relación 1:1 `usuario`–`perfil`) se puede consultar y editar.
- Cada rol (administrador, inmobiliaria, cliente) ve únicamente su panel y sus opciones correspondientes, tanto en la interfaz como validado en el servidor.

---

## Sprint Review

Al cierre del sprint se demostró funcionando:

- **CRUD de propiedades:** formulario de creación y edición con campos de tipo, ciudad, precio, matrícula inmobiliaria y descripción; listado con baja lógica del inmueble.
- **Galería de imágenes (1:N):** se agregó un campo de URLs de imágenes en el formulario de propiedad (`formulario_propiedad.jsp`) que permite asociar varias imágenes por inmueble en la tabla `imagen_propiedad`.
- **Características (N:M):** selección de características (piscina, parqueadero, ascensor, gimnasio, etc.) asociadas a la propiedad mediante `propiedad_caracteristica`.
- **Buscador con filtros:** consulta por ciudad, tipo de propiedad, rango de precio y características.
- **Perfil de usuario (1:1):** edición de datos personales (nombres, documento, teléfono, dirección) ligados a la cuenta.
- **Paneles por rol:** dashboards diferenciados para administrador, inmobiliaria y cliente, con control de acceso validado también en el servidor (no solo ocultando opciones en la vista).

---

## Sprint Retrospective

**Qué salió bien:**
- La relación N:M de características se integró sin mayores problemas usando la tabla intermedia `propiedad_caracteristica`.
- El control de acceso por rol (paneles diferenciados) quedó funcionando tanto en la interfaz como en el servidor.

**Qué no salió bien / dificultades encontradas:**
- El formulario de crear/editar propiedad inicialmente no contemplaba la carga de fotos, por lo que la tabla `imagen_propiedad` nunca se llenaba. Se corrigió agregando un campo de URLs de imágenes en el formulario.

**Mejoras para el siguiente sprint:**
- Reforzar validaciones de formato (precio, fechas, teléfono) antes de avanzar con citas y solicitudes en el Sprint 3.
- Revisar que la cadena de conexión a la base de datos no quede expuesta en texto plano en el repositorio antes de subir el código a Git público.
