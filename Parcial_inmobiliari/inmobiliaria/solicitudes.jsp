<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="/WEB-INF/jspf/conexion.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<%
    // Verificación de sesión de agente
    Integer idUsuario = (Integer) session.getAttribute("id_usuario");
    Integer idInmobiliaria = (Integer) session.getAttribute("id_inmobiliaria");
    if (idUsuario == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?redirect=inmobiliaria/solicitudes.jsp");
        return;
    }
    if (idInmobiliaria == null) {
        response.sendRedirect(request.getContextPath() + "/acceso_denegado.jsp");
        return;
    }

    Connection conn = obtenerConexion();
    String mensajeExito = null;
    String mensajeError = null;

    // Procesar actualización de estado para Solicitud o Cita.
    // Cada UPDATE hace JOIN con propiedad y filtra por id_inmobiliaria: un agente
    // jamás puede cambiar el estado de una solicitud/cita que no sea de sus propiedades.
    String tipoAccion = request.getParameter("tipo"); // "solicitud" o "cita"
    String idTarget = request.getParameter("id");
    String nuevoEstado = request.getParameter("nuevo_estado");

    if (tipoAccion != null && idTarget != null && nuevoEstado != null && conn != null) {
        PreparedStatement stmtUpd = null;
        try {
            if ("solicitud".equals(tipoAccion)) {
                String sql = "UPDATE solicitud s " +
                             "INNER JOIN propiedad p ON s.id_propiedad = p.id_propiedad " +
                             "SET s.estado = ? WHERE s.id_solicitud = ? AND p.id_inmobiliaria = ?";
                stmtUpd = conn.prepareStatement(sql);
                stmtUpd.setString(1, nuevoEstado);
                stmtUpd.setInt(2, Integer.parseInt(idTarget));
                stmtUpd.setInt(3, idInmobiliaria);
                int filas = stmtUpd.executeUpdate();
                if (filas > 0) {
                    mensajeExito = "Estado de la solicitud #" + idTarget + " actualizado a " + nuevoEstado + ".";
                } else {
                    mensajeError = "No tienes permiso sobre esa solicitud.";
                }
            } else if ("cita".equals(tipoAccion)) {
                String sql = "UPDATE cita c " +
                             "INNER JOIN propiedad p ON c.id_propiedad = p.id_propiedad " +
                             "SET c.estado = ? WHERE c.id_cita = ? AND p.id_inmobiliaria = ?";
                stmtUpd = conn.prepareStatement(sql);
                stmtUpd.setString(1, nuevoEstado);
                stmtUpd.setInt(2, Integer.parseInt(idTarget));
                stmtUpd.setInt(3, idInmobiliaria);
                int filas = stmtUpd.executeUpdate();
                if (filas > 0) {
                    mensajeExito = "Estado de la cita #" + idTarget + " actualizado a " + nuevoEstado + ".";
                } else {
                    mensajeError = "No tienes permiso sobre esa cita.";
                }
            }
        } catch (SQLException e) {
            mensajeError = "Error al actualizar estado: " + e.getMessage();
        } finally {
            if (stmtUpd != null) try { stmtUpd.close(); } catch (Exception e) {}
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
            String sqlSoli = "SELECT s.id_solicitud, s.tipo_solicitud, s.estado, s.fecha_solicitud, s.observaciones, " +
                             "p.titulo, u.correo, CONCAT(COALESCE(pf.nombres, ''), ' ', COALESCE(pf.apellidos, '')) AS nombre_cliente " +
                             "FROM solicitud s " +
                             "INNER JOIN propiedad p ON s.id_propiedad = p.id_propiedad " +
                             "INNER JOIN usuario u ON s.id_cliente = u.id_usuario " +
                             "LEFT JOIN perfil pf ON u.id_usuario = pf.id_usuario " +
                             "WHERE p.id_inmobiliaria = ? " +
                             "ORDER BY s.fecha_solicitud DESC";
            stmtSoli = conn.prepareStatement(sqlSoli);
            stmtSoli.setInt(1, idInmobiliaria);
            rsSoli = stmtSoli.executeQuery();

            String sqlCita = "SELECT c.id_cita, c.fecha_hora, c.estado, c.observaciones, " +
                             "p.titulo, u.correo, CONCAT(COALESCE(pf.nombres, ''), ' ', COALESCE(pf.apellidos, '')) AS nombre_cliente " +
                             "FROM cita c " +
                             "INNER JOIN propiedad p ON c.id_propiedad = p.id_propiedad " +
                             "INNER JOIN usuario u ON c.id_cliente = u.id_usuario " +
                             "LEFT JOIN perfil pf ON u.id_usuario = pf.id_usuario " +
                             "WHERE p.id_inmobiliaria = ? " +
                             "ORDER BY c.fecha_hora DESC";
            stmtCita = conn.prepareStatement(sqlCita);
            stmtCita.setInt(1, idInmobiliaria);
            rsCitas = stmtCita.executeQuery();

        } catch (SQLException e) {
            mensajeError = "Error al cargar solicitudes y citas: " + e.getMessage();
        }
    }
%>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold m-0">Solicitudes y Citas de mis Propiedades</h2>
            <p class="text-muted m-0">Aprueba, rechaza o confirma solicitudes de clientes</p>
        </div>
        <a href="index.jsp" class="btn btn-outline-secondary">&larr; Volver al Panel</a>
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

    <!-- SECCIÓN 1: SOLICITUDES (COMPRA / ARRIENDO) -->
    <div class="card shadow-sm border-0 mb-5">
        <div class="card-header bg-primary text-white py-3">
            <h5 class="m-0 fw-bold">Solicitudes de Compra y Arriendo</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th># ID</th>
                            <th>Cliente</th>
                            <th>Propiedad</th>
                            <th>Tipo</th>
                            <th>Fecha</th>
                            <th>Estado</th>
                            <th class="text-end px-4">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            boolean haySolicitudes = false;
                            if (rsSoli != null) {
                                while (rsSoli.next()) {
                                    haySolicitudes = true;
                                    int idS = rsSoli.getInt("id_solicitud");
                                    String est = rsSoli.getString("estado");
                                    String cliente = rsSoli.getString("nombre_cliente");
                                    if (cliente == null || cliente.trim().isEmpty()) cliente = rsSoli.getString("correo");
                        %>
                        <tr>
                            <td class="fw-bold">#<%= idS %></td>
                            <td><%= cliente %></td>
                            <td class="fw-semibold"><%= rsSoli.getString("titulo") %></td>
                            <td><span class="badge bg-secondary"><%= rsSoli.getString("tipo_solicitud") %></span></td>
                            <td><small class="text-muted"><%= rsSoli.getTimestamp("fecha_solicitud") %></small></td>
                            <td>
                                <% if ("PENDIENTE".equals(est)) { %>
                                    <span class="badge bg-warning text-dark">Pendiente</span>
                                <% } else if ("APROBADA".equals(est)) { %>
                                    <span class="badge bg-success">Aprobada</span>
                                <% } else { %>
                                    <span class="badge bg-danger">Rechazada</span>
                                <% } %>
                            </td>
                            <td class="text-end px-4">
                                <% if ("PENDIENTE".equals(est)) { %>
                                    <a href="solicitudes.jsp?tipo=solicitud&id=<%= idS %>&nuevo_estado=APROBADA"
                                       class="btn btn-sm btn-success me-1">Aprobar</a>
                                    <a href="solicitudes.jsp?tipo=solicitud&id=<%= idS %>&nuevo_estado=RECHAZADA"
                                       class="btn btn-sm btn-outline-danger">Rechazar</a>
                                <% } else { %>
                                    <span class="text-muted small">Procesada</span>
                                <% } %>
                            </td>
                        </tr>
                        <%
                                }
                            }
                            if (!haySolicitudes) {
                        %>
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">No hay solicitudes para tus propiedades.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- SECCIÓN 2: CITAS PROGRAMADAS -->
    <div class="card shadow-sm border-0">
        <div class="card-header bg-dark text-white py-3">
            <h5 class="m-0 fw-bold">Citas de Visita Programadas</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th># Cita</th>
                            <th>Cliente</th>
                            <th>Propiedad</th>
                            <th>Fecha y Hora</th>
                            <th>Estado</th>
                            <th class="text-end px-4">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            boolean hayCitas = false;
                            if (rsCitas != null) {
                                while (rsCitas.next()) {
                                    hayCitas = true;
                                    int idC = rsCitas.getInt("id_cita");
                                    String estC = rsCitas.getString("estado");
                                    String clienteC = rsCitas.getString("nombre_cliente");
                                    if (clienteC == null || clienteC.trim().isEmpty()) clienteC = rsCitas.getString("correo");
                        %>
                        <tr>
                            <td class="fw-bold">#<%= idC %></td>
                            <td><%= clienteC %></td>
                            <td class="fw-semibold"><%= rsCitas.getString("titulo") %></td>
                            <td><strong><%= rsCitas.getTimestamp("fecha_hora") %></strong></td>
                            <td>
                                <% if ("PENDIENTE".equals(estC)) { %>
                                    <span class="badge bg-warning text-dark">Pendiente</span>
                                <% } else if ("CONFIRMADA".equals(estC)) { %>
                                    <span class="badge bg-success">Confirmada</span>
                                <% } else if ("REALIZADA".equals(estC)) { %>
                                    <span class="badge bg-info text-dark">Realizada</span>
                                <% } else if ("RECHAZADA".equals(estC)) { %>
                                    <span class="badge bg-danger">Rechazada</span>
                                <% } else { %>
                                    <span class="badge bg-secondary">Cancelada</span>
                                <% } %>
                            </td>
                            <td class="text-end px-4">
                                <% if ("PENDIENTE".equals(estC)) { %>
                                    <a href="solicitudes.jsp?tipo=cita&id=<%= idC %>&nuevo_estado=CONFIRMADA"
                                       class="btn btn-sm btn-success me-1">Confirmar</a>
                                    <a href="solicitudes.jsp?tipo=cita&id=<%= idC %>&nuevo_estado=RECHAZADA"
                                       class="btn btn-sm btn-outline-danger">Rechazar</a>
                                <% } else if ("CONFIRMADA".equals(estC)) { %>
                                    <a href="solicitudes.jsp?tipo=cita&id=<%= idC %>&nuevo_estado=REALIZADA"
                                       class="btn btn-sm btn-info text-dark">Marcar Realizada</a>
                                <% } else { %>
                                    <span class="text-muted small">Finalizada</span>
                                <% } %>
                            </td>
                        </tr>
                        <%
                                }
                            }
                            if (!hayCitas) {
                        %>
                        <tr>
                            <td colspan="6" class="text-center py-4 text-muted">No hay citas para tus propiedades.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%
    if (rsSoli != null) try { rsSoli.close(); } catch (Exception e) {}
    if (rsCitas != null) try { rsCitas.close(); } catch (Exception e) {}
    if (stmtSoli != null) try { stmtSoli.close(); } catch (Exception e) {}
    if (stmtCita != null) try { stmtCita.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
%>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
