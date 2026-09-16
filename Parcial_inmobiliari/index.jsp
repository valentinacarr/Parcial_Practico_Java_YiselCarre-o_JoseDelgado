<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="/WEB-INF/jspf/conexion.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<%@ include file="/WEB-INF/jspf/imagenes.jspf" %>

<%
    String filtroCiudad = request.getParameter("ciudad");
    String filtroTipo = request.getParameter("tipo");
    String filtroPrecio = request.getParameter("precio_max");

    Connection conn = obtenerConexion();
    PreparedStatement stmtCiudades = null;
    ResultSet rsCiudades = null;
    PreparedStatement stmtTipos = null;
    ResultSet rsTipos = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    if (conn != null) {
        stmtCiudades = conn.prepareStatement("SELECT * FROM ciudad ORDER BY nombre_ciudad");
        rsCiudades = stmtCiudades.executeQuery();

        stmtTipos = conn.prepareStatement("SELECT * FROM tipo_propiedad ORDER BY nombre_tipo");
        rsTipos = stmtTipos.executeQuery();

        StringBuilder query = new StringBuilder(
            "SELECT p.*, c.nombre_ciudad, t.nombre_tipo, img.url_imagen " +
            "FROM propiedad p " +
            "INNER JOIN ciudad c ON p.id_ciudad = c.id_ciudad " +
            "INNER JOIN tipo_propiedad t ON p.id_tipo = t.id_tipo " +
            "LEFT JOIN imagen_propiedad img ON p.id_propiedad = img.id_propiedad AND img.es_portada = TRUE " +
            "WHERE p.activo = TRUE "
        );

        if (filtroCiudad != null && !filtroCiudad.trim().isEmpty()) {
            query.append(" AND p.id_ciudad = ").append(Integer.parseInt(filtroCiudad));
        }
        if (filtroTipo != null && !filtroTipo.trim().isEmpty()) {
            query.append(" AND p.id_tipo = ").append(Integer.parseInt(filtroTipo));
        }
        if (filtroPrecio != null && !filtroPrecio.trim().isEmpty()) {
            query.append(" AND p.precio <= ").append(Double.parseDouble(filtroPrecio));
        }

        query.append(" ORDER BY p.id_propiedad DESC");
        stmt = conn.prepareStatement(query.toString());
        rs = stmt.executeQuery();
    }
%>

<div class="container my-4">

<!-- Banner Principal -->
<div class="hero-banner p-5 mb-4 shadow">
    <div class="container-fluid py-3">
        <p class="hero-eyebrow">Inmobiliaria en Santander</p>
        <h1 class="display-5 fw-bold">Encuentra tu inmueble ideal</h1>
        <p class="fs-5">Explora el catálogo de propiedades disponibles en Santander.</p>
    </div>
</div>

<!-- Filtros de Búsqueda -->
<div class="card filter-card shadow-sm mb-4">
    <div class="card-body">
        <form method="GET" action="index.jsp" class="row g-3">
            <div class="col-md-4">
                <label for="ciudad" class="form-label fw-bold">Ciudad</label>
                <select name="ciudad" id="ciudad" class="form-select">
                    <option value="">Todas las ciudades</option>
                    <% 
                        if (rsCiudades != null) {
                            while(rsCiudades.next()) {
                                String selected = (filtroCiudad != null && filtroCiudad.equals(String.valueOf(rsCiudades.getInt("id_ciudad")))) ? "selected" : "";
                    %>
                                <option value="<%= rsCiudades.getInt("id_ciudad") %>" <%= selected %>>
                                    <%= rsCiudades.getString("nombre_ciudad") %>
                                </option>
                    <% 
                            }
                        } 
                    %>
                </select>
            </div>
            
            <div class="col-md-4">
                <label for="tipo" class="form-label fw-bold">Tipo de Inmueble</label>
                <select name="tipo" id="tipo" class="form-select">
                    <option value="">Todos los tipos</option>
                    <% 
                        if (rsTipos != null) {
                            while(rsTipos.next()) {
                                String selected = (filtroTipo != null && filtroTipo.equals(String.valueOf(rsTipos.getInt("id_tipo")))) ? "selected" : "";
                    %>
                                <option value="<%= rsTipos.getInt("id_tipo") %>" <%= selected %>>
                                    <%= rsTipos.getString("nombre_tipo") %>
                                </option>
                    <% 
                            }
                        } 
                    %>
                </select>
            </div>

            <div class="col-md-4">
                <label for="precio_max" class="form-label fw-bold">Precio Máximo ($)</label>
                <input type="number" name="precio_max" id="precio_max" class="form-control" placeholder="Ej: 300000000" value="<%= (filtroPrecio != null) ? filtroPrecio : "" %>">
            </div>

            <div class="col-12 text-end">
                <a href="index.jsp" class="btn btn-outline-secondary me-2">Limpiar Filtros</a>
                <button type="submit" class="btn btn-primary px-4">Buscar</button>
            </div>
        </form>
    </div>
</div>

<!-- Catálogo de Propiedades -->
<div class="row row-cols-1 row-cols-md-3 g-4">
    <% 
        if (rs != null && rs.isBeforeFirst()) {
            while (rs.next()) {
                String img = rs.getString("url_imagen");
                int idProp = rs.getInt("id_propiedad");
                // Las URLs locales tipo /img/... no existen como archivos reales todavia,
                // asi que mientras no subas fotos propias, se usa una foto real y acorde
                // al tipo de inmueble (siempre la misma para la misma propiedad).
                if (img == null || img.trim().isEmpty() || img.startsWith("/img/")) {
                    img = imagenPorTipo(rs.getString("nombre_tipo"), idProp);
                }
    %>
        <div class="col">
            <div class="card property-card h-100 shadow-sm">
                <img src="<%= img %>" class="card-img-top" alt="<%= rs.getString("titulo") %>">
                <div class="card-body">
                    <span class="badge bg-info text-dark mb-2"><%= rs.getString("nombre_tipo") %></span>
                    <span class="badge bg-secondary mb-2"><%= rs.getString("nombre_ciudad") %></span>
                    <h5 class="card-title text-truncate"><%= rs.getString("titulo") %></h5>
                    <p class="card-text text-muted small mb-1">
                        <strong>Área:</strong> <%= rs.getDouble("area_m2") %> m² | 
                        <strong>Hab:</strong> <%= rs.getInt("habitaciones") %> | 
                        <strong>Baños:</strong> <%= rs.getInt("banos") %>
                    </p>
                    <h4 class="price">$<%= String.format("%,.0f", rs.getDouble("precio")) %></h4>
                </div>
                <div class="card-footer bg-white border-top-0 d-grid">
                    <a href="detalle_propiedad.jsp?id=<%= idProp %>" class="btn btn-outline-primary">Ver Detalle</a>
                </div>
            </div>
        </div>
    <% 
            }
        } else {
    %>
        <div class="col-12 text-center py-5">
            <h4 class="text-muted">No se encontraron propiedades disponibles con esos criterios.</h4>
        </div>
    <% 
        }

        // Cierre de conexiones
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
        if (rsCiudades != null) try { rsCiudades.close(); } catch (Exception e) {}
        if (stmtCiudades != null) try { stmtCiudades.close(); } catch (Exception e) {}
        if (rsTipos != null) try { rsTipos.close(); } catch (Exception e) {}
        if (stmtTipos != null) try { stmtTipos.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    %>
</div>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>