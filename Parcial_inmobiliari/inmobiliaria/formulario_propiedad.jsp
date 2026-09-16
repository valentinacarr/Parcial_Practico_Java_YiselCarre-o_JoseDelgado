<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ include file="/WEB-INF/jspf/conexion.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<%
    // Verificación de sesión de agente
    Integer idUsuario = (Integer) session.getAttribute("id_usuario");
    Integer idInmobiliaria = (Integer) session.getAttribute("id_inmobiliaria");
    if (idUsuario == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?redirect=inmobiliaria/propiedades.jsp");
        return;
    }
    if (idInmobiliaria == null) {
        response.sendRedirect(request.getContextPath() + "/acceso_denegado.jsp");
        return;
    }

    String idPropStr = request.getParameter("id");
    int idPropiedad = 0;
    boolean esEdicion = false;

    if (idPropStr != null && !idPropStr.trim().isEmpty()) {
        try {
            idPropiedad = Integer.parseInt(idPropStr);
            esEdicion = (idPropiedad > 0);
        } catch (NumberFormatException e) {
            idPropiedad = 0;
        }
    }

    Connection conn = obtenerConexion();
    String mensajeExito = null;
    String mensajeError = null;

    // Variables ajustadas a la tabla 'propiedad'
    String matricula = "", titulo = "", descripcion = "", estado = "DISPONIBLE";
    int idTipo = 0, idCiudad = 0, habitaciones = 0, banos = 0;
    double areaM2 = 0.0, precio = 0.0;

    // IDs de las características (N:M) actualmente marcadas para esta propiedad
    Set<Integer> caracteristicasSeleccionadas = new HashSet<Integer>();

    // Texto con las URLs de las fotos de la propiedad (una por línea)
    String urlsImagenes = "";

    // Si es edición, verificar de una vez que la propiedad pertenezca a este agente
    if (esEdicion && conn != null) {
        try {
            PreparedStatement stmtCheck = conn.prepareStatement(
                "SELECT id_inmobiliaria FROM propiedad WHERE id_propiedad = ?");
            stmtCheck.setInt(1, idPropiedad);
            ResultSet rsCheck = stmtCheck.executeQuery();
            boolean esPropia = rsCheck.next() && rsCheck.getInt("id_inmobiliaria") == idInmobiliaria;
            rsCheck.close(); stmtCheck.close();
            if (!esPropia) {
                response.sendRedirect(request.getContextPath() + "/acceso_denegado.jsp");
                return;
            }
        } catch (SQLException e) {
            mensajeError = "Error al verificar la propiedad: " + e.getMessage();
        }
    }

    // 1. PROCESAR GUARDADO (INSERT O UPDATE)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        titulo = request.getParameter("titulo");
        descripcion = request.getParameter("descripcion");
        estado = request.getParameter("estado");
        matricula = request.getParameter("matricula_inmobiliaria");

        if (matricula == null || matricula.trim().isEmpty()) {
            matricula = "MAT-" + (new Date()).getTime();
        }

        try { idTipo = Integer.parseInt(request.getParameter("id_tipo")); } catch (Exception e) {}
        try { idCiudad = Integer.parseInt(request.getParameter("id_ciudad")); } catch (Exception e) {}
        try { habitaciones = Integer.parseInt(request.getParameter("habitaciones")); } catch (Exception e) {}
        try { banos = Integer.parseInt(request.getParameter("banos")); } catch (Exception e) {}

        try {
            String areaStr = request.getParameter("area_m2");
            if (areaStr != null && !areaStr.trim().isEmpty()) {
                areaM2 = Double.parseDouble(areaStr.replace(",", "."));
            }
        } catch (Exception e) { areaM2 = 0.0; }

        try {
            String precioStr = request.getParameter("precio");
            if (precioStr != null && !precioStr.trim().isEmpty()) {
                precio = Double.parseDouble(precioStr.replace(",", "."));
            }
        } catch (Exception e) { precio = 0.0; }

        PreparedStatement stmtSave = null;
        try {
            if (esEdicion) {
                // El WHERE incluye id_inmobiliaria como segundo candado: nunca se edita una propiedad ajena
                String sqlUpd = "UPDATE propiedad SET id_tipo=?, id_ciudad=?, titulo=?, descripcion=?, " +
                                "precio=?, area_m2=?, habitaciones=?, banos=?, estado=?, matricula_inmobiliaria=? " +
                                "WHERE id_propiedad=? AND id_inmobiliaria=?";
                stmtSave = conn.prepareStatement(sqlUpd);
                stmtSave.setInt(1, idTipo);
                stmtSave.setInt(2, idCiudad);
                stmtSave.setString(3, titulo);
                stmtSave.setString(4, descripcion);
                stmtSave.setDouble(5, precio);
                stmtSave.setDouble(6, areaM2);
                stmtSave.setInt(7, habitaciones);
                stmtSave.setInt(8, banos);
                stmtSave.setString(9, estado);
                stmtSave.setString(10, matricula);
                stmtSave.setInt(11, idPropiedad);
                stmtSave.setInt(12, idInmobiliaria);

                stmtSave.executeUpdate();
                mensajeExito = "Propiedad actualizada con éxito.";
            } else {
                // id_inmobiliaria SIEMPRE se toma de la sesión, nunca de un campo del formulario
                String sqlIns = "INSERT INTO propiedad (matricula_inmobiliaria, id_inmobiliaria, id_ciudad, id_tipo, " +
                                "titulo, descripcion, precio, area_m2, habitaciones, banos, estado) " +
                                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                stmtSave = conn.prepareStatement(sqlIns, Statement.RETURN_GENERATED_KEYS);
                stmtSave.setString(1, matricula);
                stmtSave.setInt(2, idInmobiliaria);
                stmtSave.setInt(3, idCiudad);
                stmtSave.setInt(4, idTipo);
                stmtSave.setString(5, titulo);
                stmtSave.setString(6, descripcion);
                stmtSave.setDouble(7, precio);
                stmtSave.setDouble(8, areaM2);
                stmtSave.setInt(9, habitaciones);
                stmtSave.setInt(10, banos);
                stmtSave.setString(11, estado);

                stmtSave.executeUpdate();
                ResultSet rsKeys = stmtSave.getGeneratedKeys();
                if (rsKeys.next()) {
                    idPropiedad = rsKeys.getInt(1);
                    esEdicion = true;
                }
                mensajeExito = "Propiedad registrada exitosamente en la base de datos.";
            }
        } catch (SQLException e) {
            mensajeError = "Error al guardar los datos de la propiedad: " + e.getMessage();
        } finally {
            if (stmtSave != null) try { stmtSave.close(); } catch (Exception e) {}
        }

        // 1.b GUARDAR CARACTERÍSTICAS (relación N:M propiedad <-> característica)
        // Se reemplazan todas: primero se borran las que tenía y luego se insertan las marcadas ahora.
        if (mensajeError == null && idPropiedad > 0) {
            String[] idsCaracteristicas = request.getParameterValues("caracteristicas");
            PreparedStatement stmtDelCar = null;
            PreparedStatement stmtInsCar = null;
            try {
                stmtDelCar = conn.prepareStatement("DELETE FROM propiedad_caracteristica WHERE id_propiedad = ?");
                stmtDelCar.setInt(1, idPropiedad);
                stmtDelCar.executeUpdate();

                if (idsCaracteristicas != null) {
                    stmtInsCar = conn.prepareStatement(
                        "INSERT INTO propiedad_caracteristica (id_propiedad, id_caracteristica) VALUES (?, ?)");
                    for (String idCarStr : idsCaracteristicas) {
                        try {
                            int idCar = Integer.parseInt(idCarStr);
                            caracteristicasSeleccionadas.add(idCar);
                            stmtInsCar.setInt(1, idPropiedad);
                            stmtInsCar.setInt(2, idCar);
                            stmtInsCar.executeUpdate();
                        } catch (NumberFormatException nfe) { /* ignorar valor inválido */ }
                    }
                }
            } catch (SQLException e) {
                mensajeError = "La propiedad se guardó, pero hubo un error al guardar sus características: " + e.getMessage();
            } finally {
                if (stmtInsCar != null) try { stmtInsCar.close(); } catch (Exception e) {}
                if (stmtDelCar != null) try { stmtDelCar.close(); } catch (Exception e) {}
            }
        }

        // 1.c GUARDAR IMÁGENES (1:N propiedad -> imagen_propiedad)
        // Se reemplazan todas: se borran las que tenía y se insertan las URLs pegadas ahora.
        // La primera línea del textarea queda marcada como es_portada.
        if (mensajeError == null && idPropiedad > 0) {
            urlsImagenes = request.getParameter("urls_imagenes");
            PreparedStatement stmtDelImg = null;
            PreparedStatement stmtInsImg = null;
            try {
                stmtDelImg = conn.prepareStatement("DELETE FROM imagen_propiedad WHERE id_propiedad = ?");
                stmtDelImg.setInt(1, idPropiedad);
                stmtDelImg.executeUpdate();

                if (urlsImagenes != null && !urlsImagenes.trim().isEmpty()) {
                    stmtInsImg = conn.prepareStatement(
                        "INSERT INTO imagen_propiedad (id_propiedad, url_imagen, es_portada) VALUES (?, ?, ?)");
                    String[] lineas = urlsImagenes.split("\\r?\\n");
                    boolean primera = true;
                    for (String linea : lineas) {
                        String url = linea.trim();
                        if (url.isEmpty()) continue;
                        stmtInsImg.setInt(1, idPropiedad);
                        stmtInsImg.setString(2, url);
                        stmtInsImg.setBoolean(3, primera);
                        stmtInsImg.executeUpdate();
                        primera = false;
                    }
                }
            } catch (SQLException e) {
                mensajeError = "La propiedad se guardó, pero hubo un error al guardar sus fotos: " + e.getMessage();
            } finally {
                if (stmtInsImg != null) try { stmtInsImg.close(); } catch (Exception e) {}
                if (stmtDelImg != null) try { stmtDelImg.close(); } catch (Exception e) {}
            }
        }
    }

    // 2. CARGAR DATOS SI ES EDICIÓN
    if (esEdicion && !"POST".equalsIgnoreCase(request.getMethod())) {
        PreparedStatement stmtLoad = null;
        ResultSet rsLoad = null;
        try {
            String sql = "SELECT * FROM propiedad WHERE id_propiedad = ? AND id_inmobiliaria = ?";
            stmtLoad = conn.prepareStatement(sql);
            stmtLoad.setInt(1, idPropiedad);
            stmtLoad.setInt(2, idInmobiliaria);
            rsLoad = stmtLoad.executeQuery();
            if (rsLoad.next()) {
                matricula = rsLoad.getString("matricula_inmobiliaria");
                idTipo = rsLoad.getInt("id_tipo");
                idCiudad = rsLoad.getInt("id_ciudad");
                titulo = rsLoad.getString("titulo");
                descripcion = rsLoad.getString("descripcion");
                precio = rsLoad.getDouble("precio");
                areaM2 = rsLoad.getDouble("area_m2");
                habitaciones = rsLoad.getInt("habitaciones");
                banos = rsLoad.getInt("banos");
                estado = rsLoad.getString("estado");
            }
        } catch (SQLException e) {
            mensajeError = "Error al cargar la propiedad: " + e.getMessage();
        } finally {
            if (rsLoad != null) try { rsLoad.close(); } catch (Exception e) {}
            if (stmtLoad != null) try { stmtLoad.close(); } catch (Exception e) {}
        }

        // Cargar las características que esta propiedad ya tiene marcadas
        PreparedStatement stmtCarSel = null;
        ResultSet rsCarSel = null;
        try {
            stmtCarSel = conn.prepareStatement(
                "SELECT id_caracteristica FROM propiedad_caracteristica WHERE id_propiedad = ?");
            stmtCarSel.setInt(1, idPropiedad);
            rsCarSel = stmtCarSel.executeQuery();
            while (rsCarSel.next()) {
                caracteristicasSeleccionadas.add(rsCarSel.getInt("id_caracteristica"));
            }
        } catch (SQLException e) {
            mensajeError = "Error al cargar las características: " + e.getMessage();
        } finally {
            if (rsCarSel != null) try { rsCarSel.close(); } catch (Exception e) {}
            if (stmtCarSel != null) try { stmtCarSel.close(); } catch (Exception e) {}
        }

        // Cargar las URLs de las fotos que esta propiedad ya tiene registradas
        PreparedStatement stmtImgSel = null;
        ResultSet rsImgSel = null;
        try {
            stmtImgSel = conn.prepareStatement(
                "SELECT url_imagen FROM imagen_propiedad WHERE id_propiedad = ? ORDER BY es_portada DESC, id_imagen ASC");
            stmtImgSel.setInt(1, idPropiedad);
            rsImgSel = stmtImgSel.executeQuery();
            StringBuilder sbImgs = new StringBuilder();
            while (rsImgSel.next()) {
                if (sbImgs.length() > 0) sbImgs.append("\n");
                sbImgs.append(rsImgSel.getString("url_imagen"));
            }
            urlsImagenes = sbImgs.toString();
        } catch (SQLException e) {
            mensajeError = "Error al cargar las fotos: " + e.getMessage();
        } finally {
            if (rsImgSel != null) try { rsImgSel.close(); } catch (Exception e) {}
            if (stmtImgSel != null) try { stmtImgSel.close(); } catch (Exception e) {}
        }
    }

    // Consultar combos
    Statement stmtCombos = conn.createStatement();
    ResultSet rsTipos = stmtCombos.executeQuery("SELECT * FROM tipo_propiedad ORDER BY nombre_tipo");

    Statement stmtCiudades = conn.createStatement();
    ResultSet rsCiudades = stmtCiudades.executeQuery("SELECT * FROM ciudad ORDER BY nombre_ciudad");

    // Catálogo completo de características disponibles (para pintar los checkboxes)
    Statement stmtCaracteristicas = conn.createStatement();
    ResultSet rsCaracteristicas = stmtCaracteristicas.executeQuery(
        "SELECT * FROM caracteristica ORDER BY nombre_caracteristica");
%>

<div class="container my-5" style="max-width: 900px;">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold"><%= esEdicion ? "Editar Propiedad #" + idPropiedad : "Publicar Nueva Propiedad" %></h2>
        <a href="propiedades.jsp" class="btn btn-outline-secondary">&larr; Volver al Panel</a>
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
            <form method="POST" action="formulario_propiedad.jsp<%= esEdicion ? "?id=" + idPropiedad : "" %>">
                <div class="row g-3">

                    <div class="col-md-8">
                        <label for="titulo" class="form-label fw-bold">Título de la Publicación *</label>
                        <input type="text" class="form-control" id="titulo" name="titulo" value="<%= titulo %>" required placeholder="Ej: Hermoso Apartamento en Girón">
                    </div>

                    <div class="col-md-4">
                        <label for="matricula_inmobiliaria" class="form-label fw-bold">Matrícula Inmobiliaria *</label>
                        <input type="text" class="form-control" id="matricula_inmobiliaria" name="matricula_inmobiliaria" value="<%= matricula %>" placeholder="Ej: MAT-102030">
                    </div>

                    <div class="col-md-4">
                        <label for="id_tipo" class="form-label fw-bold">Tipo de Inmueble *</label>
                        <select class="form-select" id="id_tipo" name="id_tipo" required>
                            <% while (rsTipos.next()) {
                                int idT = rsTipos.getInt("id_tipo");
                            %>
                                <option value="<%= idT %>" <%= idT == idTipo ? "selected" : "" %>><%= rsTipos.getString("nombre_tipo") %></option>
                            <% } %>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label for="id_ciudad" class="form-label fw-bold">Ciudad *</label>
                        <select class="form-select" id="id_ciudad" name="id_ciudad" required>
                            <% while (rsCiudades.next()) {
                                int idC = rsCiudades.getInt("id_ciudad");
                            %>
                                <option value="<%= idC %>" <%= idC == idCiudad ? "selected" : "" %>><%= rsCiudades.getString("nombre_ciudad") %></option>
                            <% } %>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label for="estado" class="form-label fw-bold">Estado *</label>
                        <select class="form-select" id="estado" name="estado" required>
                            <option value="DISPONIBLE" <%= "DISPONIBLE".equals(estado) ? "selected" : "" %>>Disponible</option>
                            <option value="RESERVADA" <%= "RESERVADA".equals(estado) ? "selected" : "" %>>Reservada</option>
                            <option value="VENDIDA" <%= "VENDIDA".equals(estado) ? "selected" : "" %>>Vendida</option>
                            <option value="ARRENDADA" <%= "ARRENDADA".equals(estado) ? "selected" : "" %>>Arrendada</option>
                            <option value="INACTIVA" <%= "INACTIVA".equals(estado) ? "selected" : "" %>>Inactiva</option>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label for="precio" class="form-label fw-bold">Precio ($ COP) *</label>
                        <input type="number" step="0.01" class="form-control" id="precio" name="precio" value="<%= precio > 0 ? precio : "" %>" required placeholder="Ej: 250000000">
                    </div>

                    <div class="col-md-6">
                        <label for="area_m2" class="form-label fw-bold">Área (m²) *</label>
                        <input type="number" step="0.01" class="form-control" id="area_m2" name="area_m2" value="<%= areaM2 > 0 ? areaM2 : "" %>" required placeholder="Ej: 75.5">
                    </div>

                    <div class="col-md-6">
                        <label for="habitaciones" class="form-label fw-bold">Habitaciones</label>
                        <input type="number" class="form-control" id="habitaciones" name="habitaciones" value="<%= habitaciones %>" min="0">
                    </div>

                    <div class="col-md-6">
                        <label for="banos" class="form-label fw-bold">Baños</label>
                        <input type="number" class="form-control" id="banos" name="banos" value="<%= banos %>" min="0">
                    </div>

                    <div class="col-12">
                        <label for="descripcion" class="form-label fw-bold">Descripción Completa</label>
                        <textarea class="form-control" id="descripcion" name="descripcion" rows="4"><%= descripcion %></textarea>
                    </div>

                    <div class="col-12">
                        <label for="urls_imagenes" class="form-label fw-bold">Fotos del Inmueble (una URL por línea)</label>
                        <textarea class="form-control" id="urls_imagenes" name="urls_imagenes" rows="3" placeholder="https://ejemplo.com/foto1.jpg&#10;https://ejemplo.com/foto2.jpg"><%= urlsImagenes %></textarea>
                        <small class="text-muted">La primera URL queda como foto de portada. Si la dejas vacía, se mostrará una foto genérica según el tipo de inmueble.</small>
                    </div>

                    <div class="col-12">
                        <label class="form-label fw-bold">Características</label>
                        <div class="row">
                            <%
                                while (rsCaracteristicas.next()) {
                                    int idCarac = rsCaracteristicas.getInt("id_caracteristica");
                                    String nombreCarac = rsCaracteristicas.getString("nombre_caracteristica");
                                    boolean marcado = caracteristicasSeleccionadas.contains(idCarac);
                            %>
                                <div class="col-md-3 col-6 form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="caracteristicas"
                                           value="<%= idCarac %>" id="carac<%= idCarac %>" <%= marcado ? "checked" : "" %>>
                                    <label class="form-check-label" for="carac<%= idCarac %>"><%= nombreCarac %></label>
                                </div>
                            <% } %>
                        </div>
                    </div>

                </div>

                <div class="mt-4 text-end">
                    <a href="propiedades.jsp" class="btn btn-secondary me-2">Cancelar</a>
                    <button type="submit" class="btn btn-primary px-4 fw-bold">
                        <%= esEdicion ? "Guardar Cambios" : "Crear Propiedad" %>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<%
    if (rsTipos != null) try { rsTipos.close(); } catch (Exception e) {}
    if (rsCiudades != null) try { rsCiudades.close(); } catch (Exception e) {}
    if (rsCaracteristicas != null) try { rsCaracteristicas.close(); } catch (Exception e) {}
    if (stmtCombos != null) try { stmtCombos.close(); } catch (Exception e) {}
    if (stmtCiudades != null) try { stmtCiudades.close(); } catch (Exception e) {}
    if (stmtCaracteristicas != null) try { stmtCaracteristicas.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
%>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
