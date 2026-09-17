<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="/WEB-INF/jspf/conexion.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<%@ include file="/WEB-INF/jspf/imagenes.jspf" %>

<%
    // Verificación de sesión de administrador
    Integer idUsuario = (Integer) session.getAttribute("id_usuario");
    if (idUsuario == null) {
        response.sendRedirect("../login.jsp?redirect=admin/admin_propiedades.jsp");
        return;
    }
    String rolSesionAdmin = (String) session.getAttribute("rol");
    if (!("ADMINISTRADOR".equalsIgnoreCase(rolSesionAdmin) || "ADMIN".equalsIgnoreCase(rolSesionAdmin))) {
        response.sendRedirect("../acceso_denegado.jsp");
        return;
    }

    Connection conn = obtenerConexion();
    String mensajeExito = request.getParameter("exito");
    String mensajeError = null;

    // Procesar acción de cambio de estado (activar/desactivar).
    // A diferencia de inmobiliaria/propiedades.jsp, el admin puede tocar CUALQUIER propiedad,
    // sin filtrar por id_inmobiliaria.
    String accion = request.getParameter("accion");
    String idAccionStr = request.getParameter("id");

    if (accion != null && idAccionStr != null && conn != null) {
        PreparedStatement stmtAccion = null;
        try {
            int idAccion = Integer.parseInt(idAccionStr);
            if ("eliminar".equals(accion)) {
                stmtAccion = conn.prepareStatement("UPDATE propiedad SET activo = FALSE WHERE id_propiedad = ?");
                stmtAccion.setInt(1, idAccion);
                stmtAccion.executeUpdate();
                mensajeExito = "Propiedad desactivada correctamente.";
            } else if ("activar".equals(accion)) {
                stmtAccion = conn.prepareStatement("UPDATE propiedad SET activo = TRUE WHERE id_propiedad = ?");
                stmtAccion.setInt(1, idAccion);
                stmtAccion.executeUpdate();
                mensajeExito = "Propiedad reactivada correctamente.";
            }
        } catch (SQLException e) {
            mensajeError = "Error al procesar la acción: " + e.getMessage();
        } catch (NumberFormatException nfe) {
            mensajeError = "ID de propiedad inválido.";
        } finally {
            if (stmtAccion != null) try { stmtAccion.close(); } catch (Exception e) {}
        }
    }

    // Consulta de TODAS las propiedades del sistema (todas las inmobiliarias)
    PreparedStatement stmtProp = null;
    ResultSet rsProp = null;
    if (conn != null) {
        try {
            String sqlList = "SELECT p.id_propiedad, p.matricula_inmobiliaria, p.titulo, p.precio, p.area_m2, " +
                             "p.habitaciones, p.banos, p.estado, p.activo, " +
                             "c.nombre_ciudad, t.nombre_tipo, i.nombre_comercial, " +
                             "(SELECT ip.url_imagen FROM imagen_propiedad ip " +
                             "  WHERE ip.id_propiedad = p.id_propiedad " +
                             "  ORDER BY ip.es_portada DESC, ip.id_imagen ASC LIMIT 1) AS foto_portada " +
                             "FROM propiedad p " +
                             "INNER JOIN ciudad c ON p.id_ciudad = c.id_ciudad " +
                             "INNER JOIN tipo_propiedad t ON p.id_tipo = t.id_tipo " +
                             "INNER JOIN inmobiliaria i ON p.id_inmobiliaria = i.id_inmobiliaria " +
                             "ORDER BY p.id_propiedad DESC";
            stmtProp = conn.prepareStatement(sqlList);
            rsProp = stmtProp.executeQuery();
        } catch (SQLException e) {
            mensajeError = "Error al listar propiedades: " + e.getMessage();
        }
    }
%>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold m-0">Administrar Propiedades</h2>
            <p class="text-muted m-0">Todos los inmuebles registrados en el sistema</p>
        </div>
        <div>
            <a href="index.jsp" class="btn btn-outline-secondary me-2">&larr; Volver al Panel</a>
            <a href="formulario_propiedad.jsp" class="btn btn-success fw-bold">+ Nueva Propiedad</a>
        </div>
    </div>

    <% if (mensajeExito != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <%= mensajeExito %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <% if (mensajeError != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <%= mensajeError %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Foto</th>
                            <th># ID</th>
                            <th>Matrícula</th>
                            <th>Título</th>
                            <th>Tipo</th>
                            <th>Ciudad</th>
                            <th>Inmobiliaria</th>
                            <th>Estado</th>
                            <th>Precio ($ COP)</th>
                            <th>Visibilidad</th>
                            <th class="text-end px-4">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            boolean hayPropiedades = false;
                            if (rsProp != null) {
                                while (rsProp.next()) {
                                    hayPropiedades = true;
                                    int idP = rsProp.getInt("id_propiedad");
                                    boolean estaActivo = rsProp.getBoolean("activo");
                                    String est = rsProp.getString("estado");
                                    String foto = rsProp.getString("foto_portada");
                                    if (foto == null || foto.trim().isEmpty()) {
                                        foto = imagenPorTipo(rsProp.getString("nombre_tipo"), idP);
                                    }
                        %>
                        <tr class="<%= !estaActivo ? "table-secondary text-muted" : "" %>">
                            <td>
                                <img src="<%= foto %>" alt="Foto propiedad"
                                     style="width:64px; height:48px; object-fit:cover; border-radius:6px;">
                            </td>
                            <td class="fw-bold">#<%= idP %></td>
                            <td><small class="text-muted"><%= rsProp.getString("matricula_inmobiliaria") %></small></td>
                            <td class="fw-semibold"><%= rsProp.getString("titulo") %></td>
                            <td><span class="badge bg-secondary"><%= rsProp.getString("nombre_tipo") %></span></td>
                            <td><%= rsProp.getString("nombre_ciudad") %></td>
                            <td><small><%= rsProp.getString("nombre_comercial") %></small></td>
                            <td>
                                <% if ("DISPONIBLE".equals(est)) { %>
                                    <span class="badge bg-success">Disponible</span>
                                <% } else if ("RESERVADA".equals(est)) { %>
                                    <span class="badge bg-warning text-dark">Reservada</span>
                                <% } else if ("VENDIDA".equals(est)) { %>
                                    <span class="badge bg-danger">Vendida</span>
                                <% } else if ("ARRENDADA".equals(est)) { %>
                                    <span class="badge bg-info text-dark">Arrendada</span>
                                <% } else { %>
                                    <span class="badge bg-dark">Inactiva</span>
                                <% } %>
                            </td>
                            <td class="text-success fw-bold">$<%= String.format("%,.2f", rsProp.getDouble("precio")) %></td>
                            <td>
                                <% if (estaActivo) { %>
                                    <span class="badge bg-success-subtle text-success border border-success">Activa</span>
                                <% } else { %>
                                    <span class="badge bg-danger-subtle text-danger border border-danger">Desactivada</span>
                                <% } %>
                            </td>
                            <td class="text-end px-4">
                                <a href="../detalle_propiedad.jsp?id=<%= idP %>" class="btn btn-sm btn-outline-secondary me-1" title="Ver">
                                    Ver
                                </a>
                                <a href="formulario_propiedad.jsp?id=<%= idP %>" class="btn btn-sm btn-outline-primary me-1" title="Editar">
                                    Editar
                                </a>
                                <% if (estaActivo) { %>
                                    <a href="admin_propiedades.jsp?accion=eliminar&id=<%= idP %>"
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('¿Deseas desactivar esta propiedad?');"
                                       title="Desactivar">
                                        Desactivar
                                    </a>
                                <% } else { %>
                                    <a href="admin_propiedades.jsp?accion=activar&id=<%= idP %>"
                                       class="btn btn-sm btn-outline-success"
                                       title="Activar">
                                        Activar
                                    </a>
                                <% } %>
                            </td>
                        </tr>
                        <%
                                }
                            }
                            if (!hayPropiedades) {
                        %>
                        <tr>
                            <td colspan="11" class="text-center py-4 text-muted">
                                No hay propiedades registradas todavía.
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%
    if (rsProp != null) try { rsProp.close(); } catch (Exception e) {}
    if (stmtProp != null) try { stmtProp.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
%>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
