<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="/WEB-INF/jspf/conexion.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<%
    // Verificación de sesión de administrador
    Integer idUsuario = (Integer) session.getAttribute("id_usuario");
    if (idUsuario == null) {
        response.sendRedirect("../login.jsp?redirect=admin/index.jsp");
        return;
    }
    String rolSesionAdmin = (String) session.getAttribute("rol");
    if (!("ADMINISTRADOR".equalsIgnoreCase(rolSesionAdmin) || "ADMIN".equalsIgnoreCase(rolSesionAdmin))) {
        response.sendRedirect("../acceso_denegado.jsp");
        return;
    }
%>

<div class="container my-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold m-0">Panel de Administración</h2>
            <p class="text-muted m-0">Resumen general y accesos del sistema</p>
        </div>
    </div>

    <%
        int totalUsuarios = 0;
        int totalPropiedades = 0;
        int totalSolicitudes = 0;

        Connection conn = obtenerConexion();

        if (conn != null) {
            try {
                // Total usuarios
                Statement st1 = conn.createStatement();
                ResultSet rs1 = st1.executeQuery("SELECT COUNT(*) FROM usuario");
                if (rs1.next()) totalUsuarios = rs1.getInt(1);
                rs1.close(); st1.close();

                // Total propiedades activas
                Statement st2 = conn.createStatement();
                ResultSet rs2 = st2.executeQuery("SELECT COUNT(*) FROM propiedad WHERE activo = TRUE");
                if (rs2.next()) totalPropiedades = rs2.getInt(1);
                rs2.close(); st2.close();

                // Total solicitudes pendientes
                Statement st3 = conn.createStatement();
                ResultSet rs3 = st3.executeQuery("SELECT COUNT(*) FROM solicitud WHERE estado = 'PENDIENTE'");
                if (rs3.next()) totalSolicitudes = rs3.getInt(1);
                rs3.close(); st3.close();

            } catch (SQLException e) {
                out.println("<div class='alert alert-danger'>Error al cargar métricas: " + e.getMessage() + "</div>");
            } finally {
                try { conn.close(); } catch (Exception e) {}
            }
        } else {
            out.println("<div class='alert alert-warning'>No se pudo conectar a la base de datos. Revisa la configuración de conexion.jspf.</div>");
        }
    %>

    <!-- TARJETAS DE MÉTRICAS -->
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="card bg-primary text-white p-3 shadow-sm">
                <h5>Usuarios Registrados</h5>
                <h3 class="fw-bold"><%= totalUsuarios %></h3>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-success text-white p-3 shadow-sm">
                <h5>Propiedades Activas</h5>
                <h3 class="fw-bold"><%= totalPropiedades %></h3>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-warning text-dark p-3 shadow-sm">
                <h5>Solicitudes Pendientes</h5>
                <h3 class="fw-bold"><%= totalSolicitudes %></h3>
            </div>
        </div>
    </div>

    <!-- ACCESOS RÁPIDOS -->
    <h4 class="mb-3 fw-bold">Gestión del Sistema</h4>
    <div class="d-flex flex-wrap gap-2 mb-4">
        <a href="admin_propiedades.jsp" class="btn btn-outline-primary">
            🏠 Gestionar Propiedades
        </a>
        <a href="formulario_propiedad.jsp" class="btn btn-success">
            ➕ Nueva Propiedad
        </a>
        <a href="usuarios.jsp" class="btn btn-outline-dark">
            👥 Gestionar Usuarios
        </a>
        <a href="solicitudes_admin.jsp" class="btn btn-outline-warning text-dark">
            📋 Solicitudes y Citas
        </a>
    </div>
</div>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>