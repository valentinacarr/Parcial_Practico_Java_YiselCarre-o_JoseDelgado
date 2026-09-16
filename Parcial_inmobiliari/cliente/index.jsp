<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/WEB-INF/jspf/conexion.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<%@ include file="/WEB-INF/jspf/imagenes.jspf" %>

<%
    // Verificación de sesión de cliente
    // (idUsuarioSesion ya fue declarada por header.jspf, la reutilizamos)
    if (idUsuarioSesion == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?redirect=cliente/index.jsp");
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
        <h2>Bienvenido a tu Panel de Cliente</h2>
        <div class="d-flex gap-2">
            <a href="perfil.jsp" class="btn btn-outline-secondary"><i class="bi bi-person-fill me-1"></i>Mi Perfil</a>
            <a href="favoritos.jsp" class="btn btn-outline-danger"><i class="bi bi-heart-fill me-1"></i>Mis Favoritos</a>
            <a href="solicitudes.jsp" class="btn btn-outline-info">Ver Mis Solicitudes</a>
        </div>
    </div>

    <h4 class="mb-3">Propiedades Disponibles</h4>
    <div class="row g-3">
        <%
            Connection conn = obtenerConexion(); // <--- LLAMADA A TU FUNCIÓN

            if (conn != null) {
                try {
                    String query = "SELECT p.id_propiedad, p.titulo, p.precio, p.descripcion, c.nombre_ciudad, t.nombre_tipo, img.url_imagen " +
                                   "FROM propiedad p " +
                                   "INNER JOIN ciudad c ON p.id_ciudad = c.id_ciudad " +
                                   "INNER JOIN tipo_propiedad t ON p.id_tipo = t.id_tipo " +
                                   "LEFT JOIN imagen_propiedad img ON p.id_propiedad = img.id_propiedad AND img.es_portada = TRUE " +
                                   "WHERE p.estado = 'DISPONIBLE' AND p.activo = TRUE LIMIT 6";
                    Statement st = conn.createStatement();
                    ResultSet rs = st.executeQuery(query);

                    while (rs.next()) {
                        int idProp = rs.getInt("id_propiedad");
                        String img = rs.getString("url_imagen");
                        if (img == null || img.trim().isEmpty() || img.startsWith("/img/")) {
                            img = imagenPorTipo(rs.getString("nombre_tipo"), idProp);
                        }
                        boolean esFavorito = favoritos.contains(idProp);
        %>
            <div class="col-md-4">
                <div class="card property-card h-100 shadow-sm">
                    <a href="<%= request.getContextPath() %>/favorito_toggle.jsp?id=<%= idProp %>&redirect=cliente/index.jsp"
                       class="fav-toggle <%= esFavorito ? "is-fav" : "" %>"
                       title="<%= esFavorito ? "Quitar de favoritos" : "Agregar a favoritos" %>">
                        <i class="bi <%= esFavorito ? "bi-heart-fill" : "bi-heart" %>"></i>
                    </a>
                    <img src="<%= img %>" class="card-img-top" alt="<%= rs.getString("titulo") %>">
                    <div class="card-body">
                        <span class="badge bg-secondary mb-2"><%= rs.getString("nombre_tipo") %></span>
                        <h5 class="card-title"><%= rs.getString("titulo") %></h5>
                        <p class="text-muted"><%= rs.getString("nombre_ciudad") %></p>
                        <p class="card-text"><%= rs.getString("descripcion") %></p>
                        <h6 class="price">$<%= String.format("%,.0f", rs.getBigDecimal("precio")) %></h6>
                    </div>
                    <div class="card-footer bg-white border-top-0">
                        <a href="../detalle_propiedad.jsp?id=<%= idProp %>" class="btn btn-primary btn-sm w-100">Ver Detalle</a>
                    </div>
                </div>
            </div>
        <%
                    }
                    rs.close();
                    st.close();
                } catch (SQLException e) {
                    out.println("<div class='alert alert-danger'>Error al cargar propiedades: " + e.getMessage() + "</div>");
                } finally {
                    try { conn.close(); } catch (Exception e) {}
                }
            } else {
                out.println("<div class='alert alert-warning'>No hay conexión con la base de datos.</div>");
            }
        %>
    </div>
</div>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
