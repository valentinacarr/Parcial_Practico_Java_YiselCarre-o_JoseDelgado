<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="/WEB-INF/jspf/conexion.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<%@ include file="/WEB-INF/jspf/imagenes.jspf" %>

<%
    String idStr = request.getParameter("id");
    int idPropiedad = 0;
    if (idStr != null && !idStr.trim().isEmpty()) {
        try {
            idPropiedad = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            idPropiedad = 0;
        }
    }

    Connection conn = obtenerConexion();
    PreparedStatement stmtProp = null;
    ResultSet rsProp = null;
    PreparedStatement stmtFotos = null;
    ResultSet rsFotos = null;

    boolean existePropiedad = false;

    if (conn != null && idPropiedad > 0) {
        String sqlProp = "SELECT p.*, c.nombre_ciudad, c.departamento, t.nombre_tipo, i.nombre_comercial, i.telefono_contacto " +
                         "FROM propiedad p " +
                         "INNER JOIN ciudad c ON p.id_ciudad = c.id_ciudad " +
                         "INNER JOIN tipo_propiedad t ON p.id_tipo = t.id_tipo " +
                         "INNER JOIN inmobiliaria i ON p.id_inmobiliaria = i.id_inmobiliaria " +
                         "WHERE p.id_propiedad = ? AND p.activo = TRUE";
        stmtProp = conn.prepareStatement(sqlProp);
        stmtProp.setInt(1, idPropiedad);
        rsProp = stmtProp.executeQuery();

        if (rsProp.next()) {
            existePropiedad = true;
        }

        String sqlFotos = "SELECT * FROM imagen_propiedad WHERE id_propiedad = ? ORDER BY es_portada DESC, id_imagen ASC";
        stmtFotos = conn.prepareStatement(sqlFotos);
        stmtFotos.setInt(1, idPropiedad);
        rsFotos = stmtFotos.executeQuery();
    }

    // Características del inmueble (relación N:M propiedad <-> caracteristica vía propiedad_caracteristica)
    PreparedStatement stmtCarac = null;
    ResultSet rsCarac = null;
    if (conn != null && existePropiedad) {
        String sqlCarac = "SELECT c.nombre_caracteristica " +
                           "FROM propiedad_caracteristica pc " +
                           "INNER JOIN caracteristica c ON pc.id_caracteristica = c.id_caracteristica " +
                           "WHERE pc.id_propiedad = ? " +
                           "ORDER BY c.nombre_caracteristica";
        stmtCarac = conn.prepareStatement(sqlCarac);
        stmtCarac.setInt(1, idPropiedad);
        rsCarac = stmtCarac.executeQuery();
    }
%>

<div class="container my-4">
    <% if (!existePropiedad) { %>
        <div class="alert alert-warning text-center my-5 shadow-sm" role="alert">
            <h4 class="alert-heading">¡Propiedad no encontrada!</h4>
            <p>El inmueble especificado no existe o ha sido desactivado.</p>
            <hr>
            <a href="index.jsp" class="btn btn-primary">Volver al catálogo</a>
        </div>
    <% } else { %>
        <a href="index.jsp" class="btn btn-outline-secondary mb-3">&larr; Volver a las propiedades</a>

        <div class="row">
            <!-- Columna Izquierda: Galería e Información General -->
            <div class="col-md-8">
                <h2><%= rsProp.getString("titulo") %></h2>
                <p class="text-muted mb-3">
                    <i class="bi bi-geo-alt"></i> <%= rsProp.getString("nombre_ciudad") %>, <%= rsProp.getString("departamento") %>
                    <span class="ms-3 badge bg-outline-dark border text-dark">Matrícula: <%= rsProp.getString("matricula_inmobiliaria") %></span>
                </p>
                
                <!-- Carrusel de fotos -->
                <div id="carouselPropiedad" class="carousel slide mb-4 shadow rounded overflow-hidden bg-light" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <% 
                            boolean primeraFoto = true;
                            if (rsFotos != null && rsFotos.isBeforeFirst()) {
                                while (rsFotos.next()) {
                        %>
                                    <div class="carousel-item <%= primeraFoto ? "active" : "" %>">
                                        <img src="<%= rsFotos.getString("url_imagen") %>" class="d-block w-100" alt="Foto Inmueble" style="max-height: 480px; object-fit: cover;">
                                    </div>
                        <% 
                                    primeraFoto = false;
                                }
                            } else {
                        %>
                                <div class="carousel-item active">
                                    <img src="<%= imagenPorTipo(rsProp.getString("nombre_tipo"), idPropiedad) %>" class="d-block w-100" alt="<%= rsProp.getString("titulo") %>" style="max-height: 480px; object-fit: cover;">
                                </div>
                        <% } %>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselPropiedad" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Anterior</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselPropiedad" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Siguiente</span>
                    </button>
                </div>

                <!-- Descripción detallada -->
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <h4 class="card-title mb-3">Descripción de la Propiedad</h4>
                        <p class="card-text text-secondary" style="white-space: pre-line;"><%= rsProp.getString("descripcion") != null ? rsProp.getString("descripcion") : "Sin descripción disponible." %></p>
                    </div>
                </div>
            </div>

            <!-- Columna Derecha: Tarjeta de Precio, Características e Inmobiliaria -->
            <div class="col-md-4">
                <div class="card shadow-sm sticky-top" style="top: 20px;">
                    <div class="card-body">
                        <span class="badge bg-info text-dark mb-2"><%= rsProp.getString("nombre_tipo") %></span>
                        <span class="badge bg-success mb-2"><%= rsProp.getString("estado") %></span>
                        <h3 class="text-primary fw-bold my-2">$<%= String.format("%,.0f", rsProp.getDouble("precio")) %></h3>
                        
                        <hr>

                        <h5 class="fw-bold mb-3">Características</h5>
                        <ul class="list-group list-group-flush mb-4">
                            <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                Área <span><%= rsProp.getDouble("area_m2") %> m²</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                Habitaciones <span><%= rsProp.getInt("habitaciones") %></span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                Baños <span><%= rsProp.getInt("banos") %></span>
                            </li>
                        </ul>

                        <%
                            boolean hayCaracteristicas = false;
                            if (rsCarac != null) {
                                while (rsCarac.next()) {
                                    if (!hayCaracteristicas) { %>
                                        <div class="mb-4">
                                            <h6 class="fw-bold">Comodidades</h6>
                        <% 
                                    }
                                    hayCaracteristicas = true;
                        %>
                                    <span class="badge bg-secondary me-1 mb-1"><%= rsCarac.getString("nombre_caracteristica") %></span>
                        <%
                                }
                                if (hayCaracteristicas) { %>
                                    </div>
                        <% }
                            }
                        %>

                        <div class="alert alert-light border">
                            <small class="text-muted d-block">Publicado por:</small>
                            <strong><%= rsProp.getString("nombre_comercial") %></strong><br>
                            <small>Tel: <%= rsProp.getString("telefono_contacto") != null ? rsProp.getString("telefono_contacto") : "No disponible" %></small>
                        </div>

                        <div class="d-grid gap-2">
                            <a href="contactar.jsp?id=<%= idPropiedad %>" class="btn btn-success btn-lg">Agendar Cita / Contactar</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <% 
        }

        // Cierre de conexiones
        if (rsCarac != null) try { rsCarac.close(); } catch (Exception e) {}
        if (stmtCarac != null) try { stmtCarac.close(); } catch (Exception e) {}
        if (rsFotos != null) try { rsFotos.close(); } catch (Exception e) {}
        if (stmtFotos != null) try { stmtFotos.close(); } catch (Exception e) {}
        if (rsProp != null) try { rsProp.close(); } catch (Exception e) {}
        if (stmtProp != null) try { stmtProp.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    %>
</div>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>