<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="/WEB-INF/jspf/conexion.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<%
    // Verificación de sesión de agente: debe haber iniciado sesión Y tener ficha en la tabla 'inmobiliaria'
    Integer idUsuario = (Integer) session.getAttribute("id_usuario");
    Integer idInmobiliaria = (Integer) session.getAttribute("id_inmobiliaria");
    if (idUsuario == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?redirect=inmobiliaria/index.jsp");
        return;
    }
    if (idInmobiliaria == null) {
        response.sendRedirect(request.getContextPath() + "/acceso_denegado.jsp");
        return;
    }
%>

<div class="container my-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold m-0">Panel del Agente</h2>
            <p class="text-muted m-0">Resumen de tu inmobiliaria y accesos rápidos</p>
        </div>
    </div>

    <%
        String nombreComercial = "Mi Inmobiliaria";
        int totalPropiedades = 0;
        int solicitudesPendientes = 0;
        int citasPendientes = 0;

        Connection conn = obtenerConexion();

        if (conn != null) {
            try {
                PreparedStatement stmtInmo = conn.prepareStatement(
                    "SELECT nombre_comercial FROM inmobiliaria WHERE id_inmobiliaria = ?");
                stmtInmo.setInt(1, idInmobiliaria);
                ResultSet rsInmo = stmtInmo.executeQuery();
                if (rsInmo.next()) nombreComercial = rsInmo.getString("nombre_comercial");
                rsInmo.close(); stmtInmo.close();

                PreparedStatement stmt1 = conn.prepareStatement(
                    "SELECT COUNT(*) FROM propiedad WHERE id_inmobiliaria = ? AND activo = TRUE");
                stmt1.setInt(1, idInmobiliaria);
                ResultSet rs1 = stmt1.executeQuery();
                if (rs1.next()) totalPropiedades = rs1.getInt(1);
                rs1.close(); stmt1.close();

                PreparedStatement stmt2 = conn.prepareStatement(
                    "SELECT COUNT(*) FROM solicitud s INNER JOIN propiedad p ON s.id_propiedad = p.id_propiedad " +
                    "WHERE p.id_inmobiliaria = ? AND s.estado = 'PENDIENTE'");
                stmt2.setInt(1, idInmobiliaria);
                ResultSet rs2 = stmt2.executeQuery();
                if (rs2.next()) solicitudesPendientes = rs2.getInt(1);
                rs2.close(); stmt2.close();

                PreparedStatement stmt3 = conn.prepareStatement(
                    "SELECT COUNT(*) FROM cita c INNER JOIN propiedad p ON c.id_propiedad = p.id_propiedad " +
                    "WHERE p.id_inmobiliaria = ? AND c.estado = 'PENDIENTE'");
                stmt3.setInt(1, idInmobiliaria);
                ResultSet rs3 = stmt3.executeQuery();
                if (rs3.next()) citasPendientes = rs3.getInt(1);
                rs3.close(); stmt3.close();

            } catch (SQLException e) {
                out.println("<div class='alert alert-danger'>Error al cargar métricas: " + e.getMessage() + "</div>");
            } finally {
                try { conn.close(); } catch (Exception e) {}
            }
        } else {
            out.println("<div class='alert alert-warning'>No se pudo conectar a la base de datos.</div>");
        }
    %>

    <div class="alert alert-primary fw-bold">
        <i class="bi bi-briefcase me-2"></i><%= nombreComercial %>
    </div>

    <!-- TARJETAS DE MÉTRICAS -->
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="card bg-primary text-white p-3 shadow-sm">
                <h5>Mis Propiedades Activas</h5>
                <h3 class="fw-bold"><%= totalPropiedades %></h3>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-warning text-dark p-3 shadow-sm">
                <h5>Solicitudes Pendientes</h5>
                <h3 class="fw-bold"><%= solicitudesPendientes %></h3>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-info text-dark p-3 shadow-sm">
                <h5>Citas Pendientes</h5>
                <h3 class="fw-bold"><%= citasPendientes %></h3>
            </div>
        </div>
    </div>

    <!-- ACCESOS RÁPIDOS -->
    <h4 class="mb-3 fw-bold">Gestión de mi Inmobiliaria</h4>
    <div class="d-flex flex-wrap gap-2 mb-4">
        <a href="propiedades.jsp" class="btn btn-outline-primary">
            🏠 Mis Propiedades
        </a>
        <a href="formulario_propiedad.jsp" class="btn btn-success">
            ➕ Nueva Propiedad
        </a>
        <a href="solicitudes.jsp" class="btn btn-outline-warning text-dark">
            📋 Solicitudes y Citas
        </a>
    </div>
</div>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
