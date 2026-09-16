<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %>
<%@ include file="../WEB-INF/jspf/header.jspf" %>

<%
    // Verificación de sesión de cliente
    Integer idUsuario = (Integer) session.getAttribute("id_usuario");
    if (idUsuario == null) {
        response.sendRedirect("../login.jsp?redirect=cliente/solicitudes.jsp");
        return;
    }

    Connection conn = obtenerConexion();
    String mensajeExito = null;
    String mensajeError = null;

    // 1. PROCESAR ACCIONES (NUEVA SOLICITUD O CANCELACIÓN)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String accion = request.getParameter("accion");

        if ("crear".equals(accion)) {
            String idPropStr = request.getParameter("id_propiedad");
            String tipoSolicitud = request.getParameter("tipo_solicitud");
            String observaciones = request.getParameter("observaciones");

            if (idPropStr != null && tipoSolicitud != null &&
                observaciones != null && !observaciones.trim().isEmpty()) {
                PreparedStatement stmtIns = null;
                try {
                    int idProp = Integer.parseInt(idPropStr);
                    // La tabla real es "solicitud" (no "solicitud_contacto"),
                    // con columna id_cliente (no id_usuario) y tipo_solicitud obligatorio (COMPRA/ARRIENDO).
                    // estado y fecha_solicitud se llenan solos por defecto (PENDIENTE / NOW()).
                    String sqlIns = "INSERT INTO solicitud (id_propiedad, id_cliente, tipo_solicitud, observaciones) " +
                                    "VALUES (?, ?, ?, ?)";
                    stmtIns = conn.prepareStatement(sqlIns);
                    stmtIns.setInt(1, idProp);
                    stmtIns.setInt(2, idUsuario);
                    stmtIns.setString(3, tipoSolicitud);
                    stmtIns.setString(4, observaciones.trim());
                    stmtIns.executeUpdate();

                    mensajeExito = "Tu solicitud ha sido enviada correctamente. Un asesor se pondrá en contacto contigo pronto.";
                } catch (SQLException e) {
                    mensajeError = "Error al registrar la solicitud: " + e.getMessage();
                } catch (NumberFormatException e) {
                    mensajeError = "La propiedad seleccionada no es válida.";
                } finally {
                    if (stmtIns != null) try { stmtIns.close(); } catch (Exception e) {}
                }
            } else {
                mensajeError = "Por favor selecciona una propiedad, el tipo de solicitud y escribe un mensaje.";
            }
        } else if ("cancelar".equals(accion)) {
            String idSolStr = request.getParameter("id_solicitud");
            if (idSolStr != null) {
                PreparedStatement stmtCan = null;
                try {
                    int idSol = Integer.parseInt(idSolStr);
                    // El ENUM de estado solo admite PENDIENTE/APROBADA/RECHAZADA (no CANCELADO),
                    // asi que "cancelar" retira la solicitud mientras siga PENDIENTE.
                    String sqlCan = "DELETE FROM solicitud WHERE id_solicitud = ? AND id_cliente = ? AND estado = 'PENDIENTE'";
                    stmtCan = conn.prepareStatement(sqlCan);
                    stmtCan.setInt(1, idSol);
                    stmtCan.setInt(2, idUsuario);
                    int filas = stmtCan.executeUpdate();

                    if (filas > 0) {
                        mensajeExito = "La solicitud fue cancelada y retirada exitosamente.";
                    } else {
                        mensajeError = "No se pudo cancelar: la solicitud ya no está pendiente o no existe.";
                    }
                } catch (SQLException e) {
                    mensajeError = "Error al cancelar la solicitud: " + e.getMessage();
                } finally {
                    if (stmtCan != null) try { stmtCan.close(); } catch (Exception e) {}
                }
            }
        }
    }

    // 2. CONSULTAR LISTADO DE SOLICITUDES DEL CLIENTE
    PreparedStatement stmtList = null;
    ResultSet rsList = null;
    try {
        String sqlList = "SELECT s.*, p.titulo AS titulo_propiedad, p.precio, c.nombre_ciudad " +
                         "FROM solicitud s " +
                         "INNER JOIN propiedad p ON s.id_propiedad = p.id_propiedad " +
                         "INNER JOIN ciudad c ON p.id_ciudad = c.id_ciudad " +
                         "WHERE s.id_cliente = ? " +
                         "ORDER BY s.fecha_solicitud DESC";
        stmtList = conn.prepareStatement(sqlList);
        stmtList.setInt(1, idUsuario);
        rsList = stmtList.executeQuery();
    } catch (SQLException e) {
        mensajeError = "Error al cargar las solicitudes: " + e.getMessage();
    }

    // 3. CONSULTAR PROPIEDADES DISPONIBLES PARA EL COMBOBOX DE NUEVA SOLICITUD
    Statement stmtPropList = conn.createStatement();
    ResultSet rsProps = stmtPropList.executeQuery("SELECT id_propiedad, titulo FROM propiedad WHERE estado = 'DISPONIBLE' ORDER BY titulo");
%>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold mb-0"><i class="bi bi-chat-dots text-success me-2"></i>Mis Solicitudes</h2>
            <p class="text-muted small">Consulta el estado de tus solicitudes de compra o arriendo enviadas a la inmobiliaria</p>
        </div>
        <div>
            <a href="index.jsp" class="btn btn-outline-secondary me-2">&larr; Volver al Panel</a>
            <button type="button" class="btn btn-primary fw-bold" data-bs-toggle="modal" data-bs-target="#modalNuevaSolicitud">
                <i class="bi bi-plus-circle me-1"></i> Nueva Solicitud
            </button>
        </div>
    </div>

    <% if (mensajeExito != null) { %>
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i><%= mensajeExito %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <% if (mensajeError != null) { %>
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i><%= mensajeError %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Propiedad</th>
                            <th>Ubicación</th>
                            <th>Tipo</th>
                            <th>Observaciones</th>
                            <th>Fecha</th>
                            <th>Estado</th>
                            <th class="text-center">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            if (rsList != null && rsList.isBeforeFirst()) {
                                while (rsList.next()) {
                                    int idSol = rsList.getInt("id_solicitud");
                                    int idProp = rsList.getInt("id_propiedad");
                                    String estado = rsList.getString("estado");
                                    String tipoSolicitud = rsList.getString("tipo_solicitud");
                                    String observaciones = rsList.getString("observaciones");
                                    Timestamp fecha = rsList.getTimestamp("fecha_solicitud");

                                    String badgeClass = "bg-warning text-dark";
                                    if ("APROBADA".equalsIgnoreCase(estado)) {
                                        badgeClass = "bg-success";
                                    } else if ("RECHAZADA".equalsIgnoreCase(estado)) {
                                        badgeClass = "bg-danger";
                                    }
                        %>
                                    <tr>
                                        <td><strong>#<%= idSol %></strong></td>
                                        <td>
                                            <a href="../detalle_propiedad.jsp?id=<%= idProp %>" class="fw-bold text-decoration-none text-dark">
                                                <%= rsList.getString("titulo_propiedad") %>
                                            </a>
                                            <div class="small text-muted">
                                                $<%= String.format("%,.0f", rsList.getDouble("precio")) %>
                                            </div>
                                        </td>
                                        <td><%= rsList.getString("nombre_ciudad") %></td>
                                        <td><span class="badge bg-secondary"><%= tipoSolicitud %></span></td>
                                        <td style="max-width: 260px;">
                                            <span class="d-inline-block text-truncate" style="max-width: 240px;" title="<%= observaciones %>">
                                                <%= observaciones != null ? observaciones : "" %>
                                            </span>
                                        </td>
                                        <td class="small text-muted">
                                            <%= fecha != null ? fecha.toString().substring(0, 16) : "N/A" %>
                                        </td>
                                        <td>
                                            <span class="badge <%= badgeClass %>"><%= estado %></span>
                                        </td>
                                        <td class="text-center">
                                            <div class="btn-group btn-group-sm">
                                                <a href="../detalle_propiedad.jsp?id=<%= idProp %>" class="btn btn-outline-primary" title="Ver Inmueble">
                                                    <i class="bi bi-eye-fill"></i>
                                                </a>

                                                <% if ("PENDIENTE".equalsIgnoreCase(estado)) { %>
                                                    <form method="POST" action="solicitudes.jsp" class="d-inline" onsubmit="return confirm('¿Seguro que deseas cancelar esta solicitud?');">
                                                        <input type="hidden" name="accion" value="cancelar">
                                                        <input type="hidden" name="id_solicitud" value="<%= idSol %>">
                                                        <button type="submit" class="btn btn-outline-danger" title="Cancelar Solicitud">
                                                            Cancelar
                                                        </button>
                                                    </form>
                                                <% } %>
                                            </div>
                                        </td>
                                    </tr>
                        <% 
                                }
                            } else {
                        %>
                                <tr>
                                    <td colspan="8" class="text-center py-5 text-muted">
                                        <i class="bi bi-inbox display-4 d-block mb-2 text-secondary"></i>
                                        No has enviado ninguna solicitud aún.<br>
                                        <button type="button" class="btn btn-primary btn-sm mt-3 fw-bold" data-bs-toggle="modal" data-bs-target="#modalNuevaSolicitud">
                                            Enviar Primera Solicitud
                                        </button>
                                    </td>
                                </tr>
                        <%  } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- MODAL PARA NUEVA SOLICITUD -->
<div class="modal fade" id="modalNuevaSolicitud" tabindex="-1" aria-labelledby="modalNuevaSolicitudLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form method="POST" action="solicitudes.jsp">
        <input type="hidden" name="accion" value="crear">
        <div class="modal-header">
          <h5 class="modal-title fw-bold" id="modalNuevaSolicitudLabel"><i class="bi bi-send me-2"></i>Nueva Solicitud sobre Inmueble</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <label for="id_propiedad" class="form-label fw-bold">Selecciona el Inmueble *</label>
            <select class="form-select" id="id_propiedad" name="id_propiedad" required>
                <option value="" disabled selected>-- Selecciona un inmueble --</option>
                <% while (rsProps.next()) { %>
                    <option value="<%= rsProps.getInt("id_propiedad") %>">
                        #<%= rsProps.getInt("id_propiedad") %> - <%= rsProps.getString("titulo") %>
                    </option>
                <% } %>
            </select>
          </div>
          <div class="mb-3">
            <label for="tipo_solicitud" class="form-label fw-bold">Tipo de Solicitud *</label>
            <select class="form-select" id="tipo_solicitud" name="tipo_solicitud" required>
                <option value="" disabled selected>-- Selecciona una opción --</option>
                <option value="COMPRA">Compra</option>
                <option value="ARRIENDO">Arriendo</option>
            </select>
          </div>
          <div class="mb-3">
            <label for="observaciones" class="form-label fw-bold">Tu Mensaje / Inquietud *</label>
            <textarea class="form-control" id="observaciones" name="observaciones" rows="4" required placeholder="Escribe aquí tus dudas sobre el precio, agenda de visita o condiciones del contrato..."></textarea>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
          <button type="submit" class="btn btn-primary fw-bold">Enviar Solicitud</button>
        </div>
      </form>
    </div>
  </div>
</div>

<%
    if (rsList != null) try { rsList.close(); } catch (Exception e) {}
    if (stmtList != null) try { stmtList.close(); } catch (Exception e) {}
    if (rsProps != null) try { rsProps.close(); } catch (Exception e) {}
    if (stmtPropList != null) try { stmtPropList.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
%>

<%@ include file="../WEB-INF/jspf/footer.jspf" %>
