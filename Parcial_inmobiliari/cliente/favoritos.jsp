<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/WEB-INF/jspf/conexion.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<%@ include file="/WEB-INF/jspf/imagenes.jspf" %>

<%
    // Verificación de sesión de cliente
    if (idUsuarioSesion == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?redirect=cliente/favoritos.jsp");
        return;
    }

    @SuppressWarnings("unchecked")
    Set<Integer> favoritos = (Set<Integer>) session.getAttribute("favoritos");
    if (favoritos == null) {
        favoritos = new HashSet<Integer>();
    }
%>

<div class="container my-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="bi bi-heart-fill text-danger me-2"></i>Mis Favoritos</h2>
        <a href="index.jsp" class="btn btn-outline-secondary">&larr; Volver a mi panel</a>
    </div>

    <div class="row row-cols-1 row-cols-md-3 g-4">
        <%
            if (favoritos.isEmpty()) {
        %>
            <div class="col-12 text-center py-5">
                <i class="bi bi-heart" style="font-size: 3rem; color: var(--line);"></i>
                <h4 class="text-muted mt-3">Todavía no has guardado propiedades favoritas.</h4>
                <p class="text-muted">Explora el catálogo y toca el corazón de las propiedades que te interesen.</p>
                <a href="<%= request.getContextPath() %>/catalogo.jsp" class="btn btn-primary mt-2">Explorar catálogo</a>
            </div>
        <%
            } else {
                Connection conn = obtenerConexion();
                if (conn != null) {
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    try {
                        StringBuilder placeholders = new StringBuilder();
                        for (int i = 0; i < favoritos.size(); i++) {
                            placeholders.append(i == 0 ? "?" : ",?");
                        }
                        String sql = "SELECT p.*, c.nombre_ciudad, t.nombre_tipo, img.url_imagen " +
                                     "FROM propiedad p " +
                                     "INNER JOIN ciudad c ON p.id_ciudad = c.id_ciudad " +
                                     "INNER JOIN tipo_propiedad t ON p.id_tipo = t.id_tipo " +
                                     "LEFT JOIN imagen_propiedad img ON p.id_propiedad = img.id_propiedad AND img.es_portada = TRUE " +
                                     "WHERE p.id_propiedad IN (" + placeholders + ")";
                        stmt = conn.prepareStatement(sql);
                        int idx = 1;
                        for (Integer fid : favoritos) {
                            stmt.setInt(idx++, fid);
                        }
                        rs = stmt.executeQuery();

                        boolean hayResultados = false;
                        while (rs.next()) {
                            hayResultados = true;
                            int idProp = rs.getInt("id_propiedad");
                            String img = rs.getString("url_imagen");
                            if (img == null || img.trim().isEmpty() || img.startsWith("/img/")) {
                                img = imagenPorTipo(rs.getString("nombre_tipo"), idProp);
                            }
        %>
            <div class="col">
                <div class="card property-card h-100 shadow-sm">
                    <a href="<%= request.getContextPath() %>/favorito_toggle.jsp?id=<%= idProp %>&redirect=cliente/favoritos.jsp"
                       class="fav-toggle is-fav" title="Quitar de favoritos">
                        <i class="bi bi-heart-fill"></i>
                    </a>
                    <img src="<%= img %>" class="card-img-top" alt="<%= rs.getString("titulo") %>">
                    <div class="card-body">
                        <span class="badge bg-info text-dark mb-2"><%= rs.getString("nombre_tipo") %></span>
                        <span class="badge bg-secondary mb-2"><%= rs.getString("nombre_ciudad") %></span>
                        <h5 class="card-title text-truncate"><%= rs.getString("titulo") %></h5>
                        <h4 class="price">$<%= String.format("%,.0f", rs.getDouble("precio")) %></h4>
                    </div>
                    <div class="card-footer bg-white border-top-0 d-grid">
                        <a href="<%= request.getContextPath() %>/detalle_propiedad.jsp?id=<%= idProp %>" class="btn btn-outline-primary">Ver Detalle</a>
                    </div>
                </div>
            </div>
        <%
                        }
                        if (!hayResultados) {
        %>
            <div class="col-12 text-center py-5">
                <h4 class="text-muted">Las propiedades que habías guardado ya no están disponibles.</h4>
            </div>
        <%
                        }
                    } catch (SQLException e) {
                        out.println("<div class='col-12'><div class='alert alert-danger'>Error al cargar tus favoritos: " + e.getMessage() + "</div></div>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (Exception e) {}
                        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
                        try { conn.close(); } catch (Exception e) {}
                    }
                } else {
        %>
            <div class="col-12"><div class="alert alert-warning">No hay conexión con la base de datos.</div></div>
        <%
                }
            }
        %>
    </div>
</div>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
