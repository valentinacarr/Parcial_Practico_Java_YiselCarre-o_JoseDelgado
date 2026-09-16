<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %>
<%@ include file="../WEB-INF/jspf/header.jspf" %>

<%
    // Verificación de sesión de administrador (además del Filter, por si acaso)
    Integer idUsuario = (Integer) session.getAttribute("id_usuario");
    if (idUsuario == null) {
        response.sendRedirect("../login.jsp?redirect=admin/reportes.jsp");
        return;
    }
    String rolSesionAdmin = (String) session.getAttribute("rol");
    if (!("ADMINISTRADOR".equalsIgnoreCase(rolSesionAdmin) || "ADMIN".equalsIgnoreCase(rolSesionAdmin))) {
        response.sendRedirect("../acceso_denegado.jsp");
        return;
    }

    Connection conn = obtenerConexion();
    String mensajeError = null;
%>

<div class="container my-4">
    <h2 class="fw-bold mb-4"><i class="bi bi-bar-chart-line me-2"></i>Reportes</h2>

    <% if (mensajeError != null) { %>
        <div class="alert alert-danger"><%= mensajeError %></div>
    <% } %>

    <div class="row g-4">

        <!-- ================================================================
             REPORTE 1: Propiedades disponibles por ciudad y estado
             (INNER JOIN entre 3 tablas + GROUP BY)
        ================================================================= -->
        <div class="col-md-6">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-primary text-white fw-bold">
                    Propiedades por ciudad y estado
                </div>
                <div class="card-body">
                    <table class="table table-sm table-striped">
                        <thead>
                            <tr><th>Ciudad</th><th>Estado</th><th class="text-end">Cantidad</th></tr>
                        </thead>
                        <tbody>
                        <%
                            String sqlR1 =
                                "SELECT c.nombre_ciudad, p.estado, COUNT(*) AS total " +
                                "FROM propiedad p " +
                                "INNER JOIN ciudad c ON p.id_ciudad = c.id_ciudad " +
                                "INNER JOIN tipo_propiedad t ON p.id_tipo = t.id_tipo " +
                                "WHERE p.activo = TRUE " +
                                "GROUP BY c.nombre_ciudad, p.estado " +
                                "ORDER BY c.nombre_ciudad, p.estado";
                            Statement stR1 = null;
                            ResultSet rsR1 = null;
                            boolean hayR1 = false;
                            try {
                                stR1 = conn.createStatement();
                                rsR1 = stR1.executeQuery(sqlR1);
                                while (rsR1.next()) {
                                    hayR1 = true;
                        %>
                                    <tr>
                                        <td><%= rsR1.getString("nombre_ciudad") %></td>
                                        <td><%= rsR1.getString("estado") %></td>
                                        <td class="text-end"><%= rsR1.getInt("total") %></td>
                                    </tr>
                        <%
                                }
                            } catch (SQLException e) {
                                mensajeError = "Error en reporte 1: " + e.getMessage();
                            } finally {
                                if (rsR1 != null) try { rsR1.close(); } catch (Exception e) {}
                                if (stR1 != null) try { stR1.close(); } catch (Exception e) {}
                            }
                            if (!hayR1) { %>
                                <tr><td colspan="3" class="text-center text-muted">Sin datos.</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- ================================================================
             REPORTE 2: Citas por estado
             (INNER JOIN + GROUP BY, alimenta un indicador operativo)
        ================================================================= -->
        <div class="col-md-6">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-primary text-white fw-bold">
                    Citas por estado
                </div>
                <div class="card-body">
                    <table class="table table-sm table-striped">
                        <thead>
                            <tr><th>Estado</th><th class="text-end">Cantidad</th></tr>
                        </thead>
                        <tbody>
                        <%
                            String sqlR2 =
                                "SELECT ci.estado, COUNT(*) AS total " +
                                "FROM cita ci " +
                                "INNER JOIN propiedad p ON ci.id_propiedad = p.id_propiedad " +
                                "INNER JOIN inmobiliaria i ON p.id_inmobiliaria = i.id_inmobiliaria " +
                                "GROUP BY ci.estado " +
                                "ORDER BY total DESC";
                            Statement stR2 = null;
                            ResultSet rsR2 = null;
                            boolean hayR2 = false;
                            try {
                                stR2 = conn.createStatement();
                                rsR2 = stR2.executeQuery(sqlR2);
                                while (rsR2.next()) {
                                    hayR2 = true;
                        %>
                                    <tr>
                                        <td><%= rsR2.getString("estado") %></td>
                                        <td class="text-end"><%= rsR2.getInt("total") %></td>
                                    </tr>
                        <%
                                }
                            } catch (SQLException e) {
                                mensajeError = "Error en reporte 2: " + e.getMessage();
                            } finally {
                                if (rsR2 != null) try { rsR2.close(); } catch (Exception e) {}
                                if (stR2 != null) try { stR2.close(); } catch (Exception e) {}
                            }
                            if (!hayR2) { %>
                                <tr><td colspan="2" class="text-center text-muted">Sin datos.</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- ================================================================
             REPORTE 3: Solicitudes por inmobiliaria
             (GROUP BY ... HAVING: solo inmobiliarias con al menos 1 solicitud)
        ================================================================= -->
        <div class="col-md-6">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-success text-white fw-bold">
                    Solicitudes por inmobiliaria <small class="fw-normal">(HAVING &gt;= 1)</small>
                </div>
                <div class="card-body">
                    <table class="table table-sm table-striped">
                        <thead>
                            <tr><th>Inmobiliaria</th><th class="text-end">Total solicitudes</th></tr>
                        </thead>
                        <tbody>
                        <%
                            // GROUP BY + HAVING: se filtran los GRUPOS (no las filas) para mostrar
                            // solo las inmobiliarias que ya han recibido al menos una solicitud.
                            String sqlR3 =
                                "SELECT i.nombre_comercial, COUNT(*) AS total_solicitudes " +
                                "FROM solicitud s " +
                                "INNER JOIN propiedad p ON s.id_propiedad = p.id_propiedad " +
                                "INNER JOIN inmobiliaria i ON p.id_inmobiliaria = i.id_inmobiliaria " +
                                "GROUP BY i.nombre_comercial " +
                                "HAVING COUNT(*) >= 1 " +
                                "ORDER BY total_solicitudes DESC";
                            Statement stR3 = null;
                            ResultSet rsR3 = null;
                            boolean hayR3 = false;
                            try {
                                stR3 = conn.createStatement();
                                rsR3 = stR3.executeQuery(sqlR3);
                                while (rsR3.next()) {
                                    hayR3 = true;
                        %>
                                    <tr>
                                        <td><%= rsR3.getString("nombre_comercial") %></td>
                                        <td class="text-end"><%= rsR3.getInt("total_solicitudes") %></td>
                                    </tr>
                        <%
                                }
                            } catch (SQLException e) {
                                mensajeError = "Error en reporte 3: " + e.getMessage();
                            } finally {
                                if (rsR3 != null) try { rsR3.close(); } catch (Exception e) {}
                                if (stR3 != null) try { stR3.close(); } catch (Exception e) {}
                            }
                            if (!hayR3) { %>
                                <tr><td colspan="2" class="text-center text-muted">Ninguna inmobiliaria tiene solicitudes todavía.</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- ================================================================
             REPORTE 4: Propiedades activas sin ninguna cita agendada
             (LEFT JOIN: se conservan las propiedades aunque no tengan cita)
        ================================================================= -->
        <div class="col-md-6">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-warning fw-bold">
                    Propiedades sin citas agendadas <small class="fw-normal">(LEFT JOIN)</small>
                </div>
                <div class="card-body" style="max-height: 320px; overflow-y: auto;">
                    <table class="table table-sm table-striped">
                        <thead>
                            <tr><th>Propiedad</th><th>Ciudad</th></tr>
                        </thead>
                        <tbody>
                        <%
                            // LEFT JOIN: trae TODAS las propiedades activas, tengan o no cita;
                            // el WHERE ci.id_cita IS NULL se queda solo con las que nunca tuvieron una.
                            String sqlR4 =
                                "SELECT p.titulo, c.nombre_ciudad " +
                                "FROM propiedad p " +
                                "INNER JOIN ciudad c ON p.id_ciudad = c.id_ciudad " +
                                "LEFT JOIN cita ci ON ci.id_propiedad = p.id_propiedad " +
                                "WHERE p.activo = TRUE AND ci.id_cita IS NULL " +
                                "ORDER BY p.titulo";
                            Statement stR4 = null;
                            ResultSet rsR4 = null;
                            boolean hayR4 = false;
                            try {
                                stR4 = conn.createStatement();
                                rsR4 = stR4.executeQuery(sqlR4);
                                while (rsR4.next()) {
                                    hayR4 = true;
                        %>
                                    <tr>
                                        <td><%= rsR4.getString("titulo") %></td>
                                        <td><%= rsR4.getString("nombre_ciudad") %></td>
                                    </tr>
                        <%
                                }
                            } catch (SQLException e) {
                                mensajeError = "Error en reporte 4: " + e.getMessage();
                            } finally {
                                if (rsR4 != null) try { rsR4.close(); } catch (Exception e) {}
                                if (stR4 != null) try { stR4.close(); } catch (Exception e) {}
                            }
                            if (!hayR4) { %>
                                <tr><td colspan="2" class="text-center text-muted">Todas las propiedades activas ya tienen al menos una cita.</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

<%
    if (conn != null) try { conn.close(); } catch (Exception e) {}
%>

<%@ include file="../WEB-INF/jspf/footer.jspf" %>
