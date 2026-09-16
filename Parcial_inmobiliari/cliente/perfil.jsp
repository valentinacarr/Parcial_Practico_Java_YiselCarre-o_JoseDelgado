<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="/WEB-INF/jspf/conexion.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<%
    // Verificación de sesión (idUsuarioSesion ya viene declarada por header.jspf)
    if (idUsuarioSesion == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?redirect=cliente/perfil.jsp");
        return;
    }

    String mensajeExito = null;
    String mensajeError = null;
    Connection conn = obtenerConexion();

    // ---------- Guardar cambios (POST) ----------
    if ("POST".equalsIgnoreCase(request.getMethod()) && conn != null) {
        String documento = request.getParameter("documento");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");

        if (documento != null && !documento.trim().isEmpty()) {
            PreparedStatement stmtUpd = null;
            try {
                String sqlUpd = "UPDATE perfil SET documento = ?, telefono = ?, direccion = ? WHERE id_usuario = ?";
                stmtUpd = conn.prepareStatement(sqlUpd);
                stmtUpd.setString(1, documento.trim());
                stmtUpd.setString(2, telefono != null ? telefono.trim() : "");
                stmtUpd.setString(3, direccion != null ? direccion.trim() : "");
                stmtUpd.setInt(4, idUsuarioSesion);
                int filas = stmtUpd.executeUpdate();

                if (filas > 0) {
                    mensajeExito = "Tu perfil se actualizó correctamente.";
                } else {
                    mensajeError = "No se encontró un perfil asociado a tu cuenta.";
                }
            } catch (SQLException e) {
                if (e.getErrorCode() == 1062) { // UNIQUE constraint violado (uk_perfil_documento)
                    mensajeError = "Ese número de documento ya está registrado por otro usuario.";
                } else {
                    mensajeError = "Error al actualizar el perfil: " + e.getMessage();
                }
            } finally {
                if (stmtUpd != null) try { stmtUpd.close(); } catch (Exception e) {}
            }
        } else {
            mensajeError = "El documento es obligatorio.";
        }
    }

    // ---------- Cargar datos actuales (siempre, para repintar el formulario) ----------
    String nombresActual = "", apellidosActual = "", documentoActual = "", telefonoActual = "", direccionActual = "";
    String correoActual = "";
    if (conn != null) {
        PreparedStatement stmtGet = null;
        ResultSet rsGet = null;
        try {
            stmtGet = conn.prepareStatement(
                "SELECT u.correo, p.nombres, p.apellidos, p.documento, p.telefono, p.direccion " +
                "FROM usuario u LEFT JOIN perfil p ON u.id_usuario = p.id_usuario " +
                "WHERE u.id_usuario = ?");
            stmtGet.setInt(1, idUsuarioSesion);
            rsGet = stmtGet.executeQuery();
            if (rsGet.next()) {
                correoActual = rsGet.getString("correo");
                nombresActual = rsGet.getString("nombres") != null ? rsGet.getString("nombres") : "";
                apellidosActual = rsGet.getString("apellidos") != null ? rsGet.getString("apellidos") : "";
                documentoActual = rsGet.getString("documento") != null ? rsGet.getString("documento") : "";
                telefonoActual = rsGet.getString("telefono") != null ? rsGet.getString("telefono") : "";
                direccionActual = rsGet.getString("direccion") != null ? rsGet.getString("direccion") : "";
            }
        } catch (SQLException e) {
            if (mensajeError == null) mensajeError = "Error al cargar tu perfil: " + e.getMessage();
        } finally {
            if (rsGet != null) try { rsGet.close(); } catch (Exception e) {}
            if (stmtGet != null) try { stmtGet.close(); } catch (Exception e) {}
        }
    }
    if (conn != null) try { conn.close(); } catch (Exception e) {}
%>

<div class="container my-5" style="max-width: 600px;">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold m-0">Mi Perfil</h2>
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

    <div class="card shadow-sm border-0">
        <div class="card-body p-4">
            <div class="mb-3">
                <label class="form-label fw-bold">Nombre completo</label>
                <input type="text" class="form-control" value="<%= nombresActual %> <%= apellidosActual %>" disabled>
                <div class="form-text">Para cambiar tu nombre contacta al administrador.</div>
            </div>
            <div class="mb-4">
                <label class="form-label fw-bold">Correo electrónico</label>
                <input type="text" class="form-control" value="<%= correoActual %>" disabled>
            </div>

            <form method="POST" action="perfil.jsp">
                <div class="mb-3">
                    <label for="documento" class="form-label fw-bold">Documento de Identidad *</label>
                    <input type="text" class="form-control" id="documento" name="documento"
                           value="<%= documentoActual %>" required>
                </div>
                <div class="mb-3">
                    <label for="telefono" class="form-label fw-bold">Teléfono</label>
                    <input type="text" class="form-control" id="telefono" name="telefono"
                           value="<%= telefonoActual %>">
                </div>
                <div class="mb-4">
                    <label for="direccion" class="form-label fw-bold">Dirección</label>
                    <input type="text" class="form-control" id="direccion" name="direccion"
                           value="<%= direccionActual %>">
                </div>

                <button type="submit" class="btn btn-primary w-100 py-2 fw-bold">Guardar Cambios</button>
            </form>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
