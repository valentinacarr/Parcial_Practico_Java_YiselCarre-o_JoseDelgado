<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="/WEB-INF/jspf/conexion.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<%
    // CONTROL DE SEGURIDAD: Verificar que el usuario inició sesión
    Integer idCliente = (Integer) session.getAttribute("id_usuario");
    String idPropStr = request.getParameter("id");
    
    if (idCliente == null) {
        // Redirige al login guardando el destino original
        response.sendRedirect("login.jsp?redirect=contactar.jsp?id=" + (idPropStr != null ? idPropStr : ""));
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
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String tipoAccion = request.getParameter("tipo_accion"); 
        String observaciones = request.getParameter("observaciones");

        if ("CITA".equals(tipoAccion)) {
            String fechaHora = request.getParameter("fecha_hora");
            if (fechaHora != null && !fechaHora.isEmpty()) {
                fechaHora = fechaHora.replace("T", " ") + ":00";
                
                PreparedStatement stmtCita = null;
                try {
                    String sqlCita = "INSERT INTO cita (id_propiedad, id_cliente, fecha_hora, observaciones) VALUES (?, ?, ?, ?)";
                    stmtCita = conn.prepareStatement(sqlCita);
                    stmtCita.setInt(1, idPropiedad);
                    stmtCita.setInt(2, idCliente);
                    stmtCita.setString(3, fechaHora);
                    stmtCita.setString(4, observaciones);
                    
                    stmtCita.executeUpdate();
                    mensajeExito = "¡Tu cita ha sido agendada con éxito! Estado: PENDIENTE de confirmación por la inmobiliaria.";
                } catch (SQLException e) {
                    if (e.getErrorCode() == 1062) {
                        mensajeError = "Ya existe una cita agendada en esa propiedad para el horario seleccionado.";
                    } else {
                        mensajeError = "Error al agendar la cita: " + e.getMessage();
                    }
                } finally {
                    if (stmtCita != null) try { stmtCita.close(); } catch (Exception e) {}
                }
            } else {
                mensajeError = "Selecciona una fecha y hora válidas.";
            }
        } else if ("SOLICITUD".equals(tipoAccion)) {
            String tipoSolicitud = request.getParameter("tipo_solicitud");
            PreparedStatement stmtSol = null;
            try {
                String sqlSol = "INSERT INTO solicitud (id_propiedad, id_cliente, tipo_solicitud, observaciones) VALUES (?, ?, ?, ?)";
                stmtSol = conn.prepareStatement(sqlSol);
                stmtSol.setInt(1, idPropiedad);
                stmtSol.setInt(2, idCliente);
                stmtSol.setString(3, tipoSolicitud);
                stmtSol.setString(4, observaciones);
                
                stmtSol.executeUpdate();
                mensajeExito = "¡Solicitud enviada correctamente! La inmobiliaria revisará tus datos.";
            } catch (SQLException e) {
                mensajeError = "Error al enviar la solicitud: " + e.getMessage();
            } finally {
                if (stmtSol != null) try { stmtSol.close(); } catch (Exception e) {}
            }
        }
    }

    // Consulta de los datos de la propiedad
    boolean existePropiedad = false;
    if (conn != null && idPropiedad > 0) {
        String sql = "SELECT p.titulo, p.precio, c.nombre_ciudad, t.nombre_tipo " +
                     "FROM propiedad p " +
                     "INNER JOIN ciudad c ON p.id_ciudad = c.id_ciudad " +
                     "INNER JOIN tipo_propiedad t ON p.id_tipo = t.id_tipo " +
                     "WHERE p.id_propiedad = ?";
        stmtProp = conn.prepareStatement(sql);
        stmtProp.setInt(1, idPropiedad);
        rsProp = stmtProp.executeQuery();
        if (rsProp.next()) {
            existePropiedad = true;
        }
    }
%>

<div class="container my-5" style="max-width: 800px;">
    <% if (!existePropiedad) { %>
        <div class="alert alert-warning text-center" role="alert">
            <h4>Propiedad no especificada</h4>
            <p>Por favor selecciona un inmueble del catálogo para contactar.</p>
            <a href="index.jsp" class="btn btn-primary">Ver Inmuebles</a>
        </div>
    <% } else { %>
        <a href="detalle_propiedad.jsp?id=<%= idPropiedad %>" class="btn btn-outline-secondary mb-4">&larr; Volver al inmueble</a>

        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white py-3">
                <h4 class="mb-0">Contactar por: <%= rsProp.getString("titulo") %></h4>
                <small><%= rsProp.getString("nombre_tipo") %> en <%= rsProp.getString("nombre_ciudad") %> — $<%= String.format("%,.0f", rsProp.getDouble("precio")) %></small>
            </div>
            <div class="card-body p-4">

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

                <ul class="nav nav-tabs mb-4" id="contactTab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active fw-bold" id="cita-tab" data-bs-toggle="tab" data-bs-target="#cita-pane" type="button" role="tab">Agendar Cita</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link fw-bold" id="solicitud-tab" data-bs-toggle="tab" data-bs-target="#solicitud-pane" type="button" role="tab">Enviar Solicitud (Compra/Arriendo)</button>
                    </li>
                </ul>

                <div class="tab-content" id="contactTabContent">
                    <!-- Formulario de Cita -->
                    <div class="tab-pane fade show active" id="cita-pane" role="tabpanel">
                        <form method="POST" action="contactar.jsp?id=<%= idPropiedad %>">
                            <input type="hidden" name="tipo_accion" value="CITA">

                            <div class="mb-3">
                                <label for="fecha_hora" class="form-label fw-bold">Fecha y Hora Preferida</label>
                                <input type="datetime-local" class="form-control" id="fecha_hora" name="fecha_hora" required>
                            </div>

                            <div class="mb-3">
                                <label for="obsCita" class="form-label fw-bold">Observaciones o Comentarios</label>
                                <textarea class="form-control" id="obsCita" name="observaciones" rows="3" placeholder="Ej: Prefiero la visita en horas de la mañana..."></textarea>
                            </div>

                            <button type="submit" class="btn btn-primary w-100 py-2">Confirmar Cita</button>
                        </form>
                    </div>

                    <!-- Formulario de Solicitud -->
                    <div class="tab-pane fade" id="solicitud-pane" role="tabpanel">
                        <form method="POST" action="contactar.jsp?id=<%= idPropiedad %>">
                            <input type="hidden" name="tipo_accion" value="SOLICITUD">

                            <div class="mb-3">
                                <label for="tipo_solicitud" class="form-label fw-bold">Tipo de Solicitud</label>
                                <select class="form-select" id="tipo_solicitud" name="tipo_solicitud" required>
                                    <option value="COMPRA">Interés de Compra</option>
                                    <option value="ARRIENDO">Interés de Arriendo</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="obsSol" class="form-label fw-bold">Observaciones / Detalles</label>
                                <textarea class="form-control" id="obsSol" name="observaciones" rows="4" placeholder="Indica detalles como fecha estimada de mudanza, forma de pago, etc."></textarea>
                            </div>

                            <button type="submit" class="btn btn-success w-100 py-2">Enviar Solicitud</button>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    <% 
        }

        if (rsProp != null) try { rsProp.close(); } catch (Exception e) {}
        if (stmtProp != null) try { stmtProp.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    %>
</div>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>