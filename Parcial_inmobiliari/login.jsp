<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ include file="WEB-INF/jspf/conexion.jspf" %>

<%!
    // MISMO método usado en registro.jsp: hash SHA-256 de (salt + password)
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
    String mensajeError = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String correo = request.getParameter("correo");
        String clave = request.getParameter("clave");

        if (correo != null && clave != null && !correo.trim().isEmpty() && !clave.trim().isEmpty()) {
            Connection conn = obtenerConexion();
            if (conn != null) {
                PreparedStatement stmtLogin = null;
                ResultSet rsLogin = null;
                try {
                    // Se trae hash + salt y se valida en Java (no en el SQL)
                    String sql = "SELECT u.id_usuario, u.correo, u.estado, u.contrasena_hash, u.salt, " +
                                 "CONCAT(COALESCE(p.nombres, ''), ' ', COALESCE(p.apellidos, '')) AS nombre_completo, " +
                                 "r.nombre_rol " +
                                 "FROM usuario u " +
                                 "LEFT JOIN perfil p ON u.id_usuario = p.id_usuario " +
                                 "LEFT JOIN usuario_rol ur ON u.id_usuario = ur.id_usuario " +
                                 "LEFT JOIN rol r ON ur.id_rol = r.id_rol " +
                                 "WHERE u.correo = ?";

                    stmtLogin = conn.prepareStatement(sql);
                    stmtLogin.setString(1, correo.trim());
                    rsLogin = stmtLogin.executeQuery();

                    if (rsLogin.next()) {
                        String estado = rsLogin.getString("estado");
                        String hashGuardado = rsLogin.getString("contrasena_hash");
                        String saltGuardado = rsLogin.getString("salt");

                        // Se hashea la clave ingresada con el mismo salt guardado del usuario
                        // y se compara contra el hash guardado en la BD.
                        boolean claveValida = hashPassword(clave.trim(), saltGuardado != null ? saltGuardado : "").equals(hashGuardado);

                        if (!claveValida) {
                            mensajeError = "Correo electrónico o contraseña incorrectos.";
                        } else if ("INACTIVO".equalsIgnoreCase(estado)) {
                            // El DDL solo define ACTIVO/INACTIVO en el ENUM de usuario.estado
                            mensajeError = "Tu cuenta se encuentra inactiva. Contacta al administrador.";
                        } else {
                            // Guardar datos en la sesión
                            int idUsuario = rsLogin.getInt("id_usuario");
                            String nombre = rsLogin.getString("nombre_completo");
                            String rol = rsLogin.getString("nombre_rol");

                            if (nombre == null || nombre.trim().isEmpty()) {
                                nombre = rsLogin.getString("correo");
                            }

                            session.setAttribute("id_usuario", idUsuario);
                            session.setAttribute("correo", rsLogin.getString("correo"));
                            session.setAttribute("nombre_usuario", nombre);
                            session.setAttribute("rol", rol != null ? rol.toUpperCase() : "CLIENTE");

                            // Verificar si el usuario tiene una ficha de AGENTE (tabla inmobiliaria es 1:1 con usuario).
                            // Esto es más robusto que fiarse solo del texto guardado en rol.nombre_rol.
                            int idInmobiliariaSesion = 0;
                            PreparedStatement stmtInmo = null;
                            ResultSet rsInmo = null;
                            try {
                                stmtInmo = conn.prepareStatement(
                                    "SELECT id_inmobiliaria FROM inmobiliaria WHERE id_usuario = ?");
                                stmtInmo.setInt(1, idUsuario);
                                rsInmo = stmtInmo.executeQuery();
                                if (rsInmo.next()) {
                                    idInmobiliariaSesion = rsInmo.getInt("id_inmobiliaria");
                                }
                            } catch (SQLException ex) {
                                // Si falla, simplemente no se trata como agente
                            } finally {
                                if (rsInmo != null) try { rsInmo.close(); } catch (Exception ex) {}
                                if (stmtInmo != null) try { stmtInmo.close(); } catch (Exception ex) {}
                            }

                            boolean esAgente = idInmobiliariaSesion > 0;
                            if (esAgente) {
                                session.setAttribute("id_inmobiliaria", idInmobiliariaSesion);
                            } else {
                                session.removeAttribute("id_inmobiliaria");
                            }

                            // REDIRECCIÓN SEGÚN ROL
                            String redirectParam = request.getParameter("redirect");
                            if (redirectParam != null && !redirectParam.trim().isEmpty()) {
                                response.sendRedirect(redirectParam);
                            } else if ("ADMINISTRADOR".equalsIgnoreCase(rol) || "ADMIN".equalsIgnoreCase(rol)) {
                                response.sendRedirect("admin/index.jsp");
                            } else if (esAgente) {
                                response.sendRedirect("inmobiliaria/index.jsp");
                            } else {
                                response.sendRedirect("cliente/index.jsp");
                            }
                            return;
                        }
                    } else {
                        mensajeError = "Correo electrónico o contraseña incorrectos.";
                    }
                } catch (SQLException e) {
                    mensajeError = "Error al autenticar: " + e.getMessage();
                } finally {
                    if (rsLogin != null) try { rsLogin.close(); } catch (Exception e) {}
                    if (stmtLogin != null) try { stmtLogin.close(); } catch (Exception e) {}
                    if (conn != null) try { conn.close(); } catch (Exception e) {}
                }
            } else {
                mensajeError = "No se pudo conectar a la base de datos.";
            }
        } else {
            mensajeError = "Por favor completa todos los campos.";
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión - Nexo Inmobiliaria</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/estilos.css">
</head>
<body class="d-flex align-items-center min-vh-100">

<div class="container" style="max-width: 420px;">
    <div class="card auth-card">
        <div class="card-body p-4">
            <div class="text-center mb-4">
                <img src="<%= request.getContextPath() %>/img/logo-recortado.png" alt="Nexo Inmobiliaria" class="auth-logo">
                <p class="text-muted small mt-2">Ingresa tus credenciales para acceder</p>
            </div>

            <% if (mensajeError != null) { %>
                <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                    <%= mensajeError %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <form method="POST" action="login.jsp">
                <div class="mb-3">
                    <label for="correo" class="form-label fw-semibold">Correo Electrónico</label>
                    <input type="email" class="form-control" id="correo" name="correo" required placeholder="correo@ejemplo.com">
                </div>

                <div class="mb-3">
                    <label for="clave" class="form-label fw-semibold">Contraseña</label>
                    <input type="password" class="form-control" id="clave" name="clave" required placeholder="••••••••">
                </div>

                <button type="submit" class="btn btn-primary w-100 fw-bold py-2">Iniciar Sesión</button>
            </form>

            <div class="text-center mt-3">
                <a href="index.jsp" class="text-secondary small">&larr; Volver al catálogo</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
