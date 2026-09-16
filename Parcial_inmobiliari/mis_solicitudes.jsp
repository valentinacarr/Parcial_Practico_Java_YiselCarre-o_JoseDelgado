<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="/WEB-INF/jspf/conexion.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<%
    // Verificar autenticación de usuario
    Integer idUsuario = (Integer) session.getAttribute("id_usuario");
    if (idUsuario == null) {
        response.sendRedirect("login.jsp?redirect=mis_solicitudes.jsp");
        return;
    }

    Connection conn = obtenerConexion();
    PreparedStatement stmtAccion = null;
    String mensajeExito = null;
    String mensajeError = null;

    // Procesar actualización de estado (Confirmar, Rechazar, Cancelar, etc.)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String tipoAccion = request.getParameter("tipo_registro"); // "CITA" o "SOLICITUD"
        String nuevoEstado = request.getParameter("nuevo_estado");
        String idRegStr = request.getParameter("id_registro");

        if (idRegStr != null && nuevoEstado != null) {
            try {
                int idRegistro = Integer.parseInt(idRegStr);
                if ("CITA".equals(tipoAccion)) {
                    String sqlUpd = "UPDATE cita SET estado = ? WHERE id_cita = ?";
                    stmtAccion = conn.prepareStatement(sqlUpd);
                    stmtAccion.setString(1, nuevoEstado);
                    stmtAccion.setInt(2, idRegistro);
                    stmtAccion.executeUpdate();
                    mensajeExito = "Estado de la cita actualizado correctamente.";
                } else if ("SOLICITUD".equals(tipoAccion)) {
                    String sqlUpd = "UPDATE solicitud SET estado = ? WHERE id_solicitud = ?";
                    stmtAccion = conn.prepareStatement(sqlUpd);
                    stmtAccion.setString(1, nuevoEstado);
                    stmtAccion.setInt(2, idRegistro);
                    stmtAccion.executeUpdate();
                    mensajeExito = "Estado de la solicitud actualizado correctamente.";
                }
            } catch (SQLException e) {
                mensajeError = "Error al actualizar el estado: " + e.getMessage();
            } finally {
                if (stmtAccion != null) try { stmtAccion.close(); } catch (Exception e) {}
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
        // Query para traer las citas del cliente con información del inmueble
        String sqlCitas = "SELECT c.*, p.titulo, p.precio, ciu.nombre_ciudad " +
                          "FROM cita c " +
                          "INNER JOIN propiedad p ON c.id_propiedad = p.id_propiedad " +
                          "INNER JOIN ciudad ciu ON p.id_ciudad = ciu.id_ciudad " +
                          "WHERE c.id_cliente = ? " +
                          "ORDER BY c.fecha_hora DESC";
        stmtCitas = conn.prepareStatement(sqlCitas);
        stmtCitas.setInt(1, idUsuario);
        rsCitas = stmtCitas.executeQuery();

        // Query para traer las solicitudes del cliente con información del inmueble
        String sqlSol = "SELECT s.*, p.titulo, p.precio, ciu.nombre_ciudad " +
                        "FROM solicitud s " +
                        "INNER JOIN propiedad p ON s.id_propiedad = p.id_propiedad " +
                        "INNER JOIN ciudad ciu ON p.id_ciudad = ciu.id_ciudad " +
                        "WHERE s.id_cliente = ? " +
                        "ORDER BY s.fecha_solicitud DESC";
        stmtSol = conn.prepareStatement(sqlSol);
        stmtSol.setInt(1, idUsuario);
        rsSol = stmtSol.executeQuery();
    }
%>

<div class="container my-5">
    <h2 class="fw-bold mb-4">Gestión de Citas y Solicitudes</h2>

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

    <!-- Tabs para alternar entre Citas y Solicitudes -->
    <ul class="nav nav-tabs mb-4" id="panelTab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active fw-bold" id="citas-tab" data-bs-toggle="tab" data-bs-target="#citas-pane" type="button" role="tab">Mis Citas Agendadas</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link fw-bold" id="solicitudes-tab" data-bs-toggle="tab" data-bs-target="#solicitudes-pane" type="button" role="tab">Mis Solicitudes (Compra/Arriendo)</button>
        </li>
    </ul>

    <div class="tab-content" id="panelTabContent">
        
        <!-- PANE DE CITAS -->
        <div class="tab-pane fade show active" id="citas-pane" role="tabpanel">
            <div class="card shadow-sm border-0">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th>Propiedad</th>
                                    <th>Ciudad</th>
                                    <th>Fecha y Hora</th>
                                    <th>Observaciones</th>
                                    <th>Estado</th>
                                    <th class="text-center">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    if (rsCitas != null && rsCitas.isBeforeFirst()) {
                                        while (rsCitas.next()) {
                                            String estado = rsCitas.getString("estado");
                                            String badgeClass = "bg-warning text-dark";
                                            if ("CONFIRMADA".equals(estado)) badgeClass = "bg-success";
                                            else if ("RECHAZADA".equals(estado) || "CANCELADA".equals(estado)) badgeClass = "bg-danger";
                                            else if ("REALIZADA".equals(estado)) badgeClass = "bg-info text-dark";
                                %>
                                            <tr>
                                                <td class="fw-bold"><%= rsCitas.getString("titulo") %></td>
                                                <td><%= rsCitas.getString("nombre_ciudad") %></td>
                                                <td><%= rsCitas.getTimestamp("fecha_hora") %></td>
                                                <td><small class="text-muted"><%= rsCitas.getString("observaciones") != null ? rsCitas.getString("observaciones") : "-" %></small></td>
                                                <td><span class="badge <%= badgeClass %>"><%= estado %></span></td>
                                                <td class="text-center">
                                                    <% if ("PENDIENTE".equals(estado)) { %>
                                                        <form method="POST" action="mis_solicitudes.jsp" class="d-inline">
                                                            <input type="hidden" name="tipo_registro" value="CITA">
                                                            <input type="hidden" name="id_registro" value="<%= rsCitas.getInt("id_cita") %>">
                                                            <input type="hidden" name="nuevo_estado" value="CANCELADA">
                                                            <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('¿Deseas cancelar esta cita?');">Cancelar</button>
                                                        </form>
                                                    <% } else { %>
                                                        <span class="text-muted small">Sin acciones</span>
                                                    <% } %>
                                                </td>
                                            </tr>
                                <% 
                                        }
                                    } else {
                                %>
                                        <tr>
                                            <td colspan="6" class="text-center py-4 text-muted">No tienes citas registradas.</td>
                                        </tr>
                                <%  } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- PANE DE SOLICITUDES -->
        <div class="tab-pane fade" id="solicitudes-pane" role="tabpanel">
            <div class="card shadow-sm border-0">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th>Propiedad</th>
                                    <th>Tipo</th>
                                    <th>Fecha Solicitud</th>
                                    <th>Observaciones</th>
                                    <th>Estado</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    if (rsSol != null && rsSol.isBeforeFirst()) {
                                        while (rsSol.next()) {
                                            String estadoSol = rsSol.getString("estado");
                                            String badgeClassSol = "bg-warning text-dark";
                                            if ("APROBADA".equals(estadoSol)) badgeClassSol = "bg-success";
                                            else if ("RECHAZADA".equals(estadoSol)) badgeClassSol = "bg-danger";
                                %>
                                            <tr>
                                                <td class="fw-bold"><%= rsSol.getString("titulo") %></td>
                                                <td><span class="badge bg-secondary"><%= rsSol.getString("tipo_solicitud") %></span></td>
                                                <td><%= rsSol.getTimestamp("fecha_solicitud") %></td>
                                                <td><small class="text-muted"><%= rsSol.getString("observaciones") != null ? rsSol.getString("observaciones") : "-" %></small></td>
                                                <td><span class="badge <%= badgeClassSol %>"><%= estadoSol %></span></td>
                                            </tr>
                                <% 
                                        }
                                    } else {
                                %>
                                        <tr>
                                            <td colspan="5" class="text-center py-4 text-muted">No tienes solicitudes de compra/arriendo registradas.</td>
                                        </tr>
                                <%  } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <%
        if (rsCitas != null) try { rsCitas.close(); } catch (Exception e) {}
        if (stmtCitas != null) try { stmtCitas.close(); } catch (Exception e) {}
        if (rsSol != null) try { rsSol.close(); } catch (Exception e) {}
        if (stmtSol != null) try { stmtSol.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    %>
</div>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>