<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ include file="/WEB-INF/jspf/conexion.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<%!
    // Genera un salt aleatorio de 16 bytes en hexadecimal (32 caracteres)
    private String generarSalt() {
        java.security.SecureRandom random = new java.security.SecureRandom();
        byte[] saltBytes = new byte[16];
        random.nextBytes(saltBytes);
        StringBuilder hexString = new StringBuilder();
        for (byte b : saltBytes) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }
        return hexString.toString();
    }

    // Hash SHA-256 de (salt + password), nativo de Java (sin librerías externas)
    private String hashPassword(String password, String salt) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest((salt + password).getBytes("UTF-8"));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            return password; // Fallback
        }
    }
%>

<%
    String mensajeExito = null;
    String mensajeError = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String correo = request.getParameter("correo");
        String password = request.getParameter("password");
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String documento = request.getParameter("documento");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");

        if (correo != null && password != null && nombres != null && documento != null &&
            !correo.trim().isEmpty() && !password.trim().isEmpty() && !nombres.trim().isEmpty() && !documento.trim().isEmpty()) {

            Connection conn = obtenerConexion();
            PreparedStatement stmtUser = null;
            PreparedStatement stmtPerfil = null;
            PreparedStatement stmtRol = null;
            ResultSet rsUser = null;

            if (conn != null) {
                try {
                    conn.setAutoCommit(false); // Iniciar transacción atómica

                    // 1. Generar salt único y cifrar la contraseña (salt + password)
                    String salt = generarSalt();
                    String passHash = hashPassword(password, salt);

                    // 2. Insertar en tabla 'usuario'
                    String sqlUser = "INSERT INTO usuario (correo, contrasena_hash, salt, estado) VALUES (?, ?, ?, 'ACTIVO')";
                    stmtUser = conn.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
                    stmtUser.setString(1, correo.trim());
                    stmtUser.setString(2, passHash);
                    stmtUser.setString(3, salt);
                    stmtUser.executeUpdate();

                    rsUser = stmtUser.getGeneratedKeys();
                    int idUsuarioGenerado = 0;
                    if (rsUser.next()) {
                        idUsuarioGenerado = rsUser.getInt(1);
                    }

                    // 3. Insertar en tabla 'perfil' (Relación 1:1)
                    String sqlPerfil = "INSERT INTO perfil (id_usuario, nombres, apellidos, documento, telefono, direccion) VALUES (?, ?, ?, ?, ?, ?)";
                    stmtPerfil = conn.prepareStatement(sqlPerfil);
                    stmtPerfil.setInt(1, idUsuarioGenerado);
                    stmtPerfil.setString(2, nombres.trim());
                    stmtPerfil.setString(3, apellidos != null ? apellidos.trim() : "");
                    stmtPerfil.setString(4, documento.trim());
                    stmtPerfil.setString(5, telefono != null ? telefono.trim() : "");
                    stmtPerfil.setString(6, direccion != null ? direccion.trim() : "");
                    stmtPerfil.executeUpdate();

                    // 4. Asignar rol CLIENTE por defecto (Relación N:M usuario_rol)
                    stmtRol = conn.prepareStatement(
                        "INSERT INTO usuario_rol (id_usuario, id_rol) " +
                        "SELECT ?, id_rol FROM rol WHERE nombre_rol = 'CLIENTE' LIMIT 1");
                    stmtRol.setInt(1, idUsuarioGenerado);
                    stmtRol.executeUpdate();

                    conn.commit(); // Confirmar cambios en la BD
                    mensajeExito = "¡Registro exitoso! Ya puedes iniciar sesión con tu cuenta.";

                } catch (SQLException e) {
                    if (conn != null) {
                        try { conn.rollback(); } catch (SQLException ex) { /* Ignore */ }
                    }

                    if (e.getErrorCode() == 1062) { // UNIQUE constraint violado
                        if (e.getMessage().contains("uk_usuario_correo")) {
                            mensajeError = "El correo electrónico ya se encuentra registrado.";
                        } else if (e.getMessage().contains("uk_perfil_documento")) {
                            mensajeError = "El número de documento ya está registrado.";
                        } else {
                            mensajeError = "Ya existe un registro con esos datos únicos en el sistema.";
                        }
                    } else {
                        mensajeError = "Error al completar el registro: " + e.getMessage();
                    }
                } finally {
                    try { conn.setAutoCommit(true); } catch (Exception e) {}
                    if (rsUser != null) try { rsUser.close(); } catch (Exception e) {}
                    if (stmtUser != null) try { stmtUser.close(); } catch (Exception e) {}
                    if (stmtPerfil != null) try { stmtPerfil.close(); } catch (Exception e) {}
                    if (stmtRol != null) try { stmtRol.close(); } catch (Exception e) {}
                    if (conn != null) try { conn.close(); } catch (Exception e) {}
                }
            }
        } else {
            mensajeError = "Por favor completa todos los campos obligatorios.";
        }
    }
%>

<div class="container my-5" style="max-width: 600px;">
    <div class="card auth-card">
        <div class="card-header bg-primary text-white text-center py-3">
            <h4 class="mb-0 fw-bold">Registro de Usuario</h4>
        </div>
        <div class="card-body p-4">

            <% if (mensajeExito != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <%= mensajeExito %>
                    <div class="mt-2">
                        <a href="login.jsp" class="btn btn-sm btn-success">Ir a Iniciar Sesión</a>
                    </div>
                </div>
            <% } %>

            <% if (mensajeError != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= mensajeError %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <form method="POST" action="registro.jsp">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="nombres" class="form-label fw-bold">Nombres *</label>
                        <input type="text" class="form-control" id="nombres" name="nombres" required>
                    </div>
                    <div class="col-md-6">
                        <label for="apellidos" class="form-label fw-bold">Apellidos</label>
                        <input type="text" class="form-control" id="apellidos" name="apellidos">
                    </div>
                    <div class="col-md-6">
                        <label for="documento" class="form-label fw-bold">Documento de Identidad *</label>
                        <input type="text" class="form-control" id="documento" name="documento" required>
                    </div>
                    <div class="col-md-6">
                        <label for="telefono" class="form-label fw-bold">Teléfono</label>
                        <input type="text" class="form-control" id="telefono" name="telefono">
                    </div>
                    <div class="col-12">
                        <label for="direccion" class="form-label fw-bold">Dirección</label>
                        <input type="text" class="form-control" id="direccion" name="direccion">
                    </div>
                    <div class="col-12">
                        <label for="correo" class="form-label fw-bold">Correo Electrónico *</label>
                        <input type="email" class="form-control" id="correo" name="correo" required placeholder="ejemplo@correo.com">
                    </div>
                    <div class="col-12">
                        <label for="password" class="form-label fw-bold">Contraseña *</label>
                        <input type="password" class="form-control" id="password" name="password" required placeholder="••••••••">
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-100 py-2 mt-4 fw-bold">Crear Cuenta</button>
            </form>
        </div>
        <div class="card-footer text-center bg-light py-3">
            <small class="text-muted">¿Ya tienes una cuenta? <a href="login.jsp" class="text-primary fw-bold">Inicia Sesión aquí</a></small>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
