<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="/WEB-INF/jspf/conexion.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<%
    // Verificación de sesión de agente
    Integer idUsuario = (Integer) session.getAttribute("id_usuario");
    Integer idInmobiliaria = (Integer) session.getAttribute("id_inmobiliaria");
    if (idUsuario == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?redirect=inmobiliaria/propiedades.jsp");
        return;
    }
    if (idInmobiliaria == null) {
        response.sendRedirect(request.getContextPath() + "/acceso_denegado.jsp");
        return;
    }

    Connection conn = obtenerConexion();
    String mensajeExito = request.getParameter("exito");
    String mensajeError = null;

    // Procesar acción de cambio de estado (activar/desactivar), SIEMPRE validando que la propiedad
    // pertenezca a este agente (id_inmobiliaria) para no permitir tocar propiedades ajenas.
    String accion = request.getParameter("accion");
    String idEliminar = request.getParameter("id");

    if (accion != null && idEliminar != null && conn != null) {
        PreparedStatement stmtAccion = null;
        try {
            if ("eliminar".equals(accion)) {
                String sqlDel = "UPDATE propiedad SET activo = FALSE WHERE id_propiedad = ? AND id_inmobiliaria = ?";
                stmtAccion = conn.prepareStatement(sqlDel);
                stmtAccion.setInt(1, Integer.parseInt(idEliminar));
                stmtAccion.setInt(2, idInmobiliaria);
                int filas = stmtAccion.executeUpdate();
                mensajeExito = filas > 0 ? "Propiedad desactivada correctamente." : null;
                if (filas == 0) mensajeError = "No tienes permiso sobre esa propiedad.";
            } else if ("activar".equals(accion)) {
                String sqlAct = "UPDATE propiedad SET activo = TRUE WHERE id_propiedad = ? AND id_inmobiliaria = ?";
                stmtAccion = conn.prepareStatement(sqlAct);
                stmtAccion.setInt(1, Integer.parseInt(idEliminar));
                stmtAccion.setInt(2, idInmobiliaria);
                int filas = stmtAccion.executeUpdate();
                mensajeExito = filas > 0 ? "Propiedad reactivada correctamente." : null;
                if (filas == 0) mensajeError = "No tienes permiso sobre esa propiedad.";
            }
        } catch (SQLException e) {
            mensajeError = "Error al procesar la acción: " + e.getMessage();
        } finally {
            if (stmtAccion != null) try { stmtAccion.close(); } catch (Exception e) {}
        }
    }

    // Consulta de propiedades, SOLO las de este agente (id_inmobiliaria de la sesión)
    PreparedStatement stmtProp = null;
    ResultSet rsProp = null;
    if (conn != null) {
        try {
            String sqlList = "SELECT p.id_propiedad, p.matricula_inmobiliaria, p.titulo, p.precio, p.area_m2, " +
                             "p.habitaciones, p.banos, p.estado, p.activo, c.nombre_ciudad, t.nombre_tipo " +
                             "FROM propiedad p " +
                             "INNER JOIN ciudad c ON p.id_ciudad = c.id_ciudad " +
                             "INNER JOIN tipo_propiedad t ON p.id_tipo = t.id_tipo " +
                             "WHERE p.id_inmobiliaria = ? " +
                             "ORDER BY p.id_propiedad DESC";
            stmtProp = conn.prepareStatement(sqlList);
            stmtProp.setInt(1, idInmobiliaria);
            rsProp = stmtProp.executeQuery();
        } catch (SQLException e) {
            mensajeError = "Error al listar propiedades: " + e.getMessage();
        }
    }
%>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold m-0">Mis Propiedades</h2>
            <p class="text-muted m-0">Inmuebles publicados por tu inmobiliaria</p>
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
                            <th># ID</th>
                            <th>Matrícula</th>
                            <th>Título</th>
                            <th>Tipo</th>
                            <th>Ciudad</th>
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
                        %>
                        <tr class="<%= !estaActivo ? "table-secondary text-muted" : "" %>">
                            <td class="fw-bold">#<%= idP %></td>
                            <td><small class="text-muted"><%= rsProp.getString("matricula_inmobiliaria") %></small></td>
                            <td class="fw-semibold"><%= rsProp.getString("titulo") %></td>
                            <td><span class="badge bg-secondary"><%= rsProp.getString("nombre_tipo") %></span></td>
                            <td><%= rsProp.getString("nombre_ciudad") %></td>
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
                                <a href="formulario_propiedad.jsp?id=<%= idP %>" class="btn btn-sm btn-outline-primary me-1" title="Editar">
                                    Editar
                                </a>
                                <% if (estaActivo) { %>
                                    <a href="propiedades.jsp?accion=eliminar&id=<%= idP %>"
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('¿Deseas desactivar esta propiedad?');"
                                       title="Desactivar">
                                        Desactivar
                                    </a>
                                <% } else { %>
                                    <a href="propiedades.jsp?accion=activar&id=<%= idP %>"
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
                            <td colspan="9" class="text-center py-4 text-muted">
                                Aún no has publicado ninguna propiedad.
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
