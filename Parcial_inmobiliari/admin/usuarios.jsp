<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %>
<%@ include file="../WEB-INF/jspf/header.jspf" %>

<%
    Integer idUsuario = (Integer) session.getAttribute("id_usuario");
    if (idUsuario == null) {
        response.sendRedirect("../login.jsp?redirect=admin/usuarios.jsp");
        return;
    }
    String rolSesionAdmin = (String) session.getAttribute("rol");
    if (!("ADMINISTRADOR".equalsIgnoreCase(rolSesionAdmin) || "ADMIN".equalsIgnoreCase(rolSesionAdmin))) {
        response.sendRedirect("../acceso_denegado.jsp");
        return;
    }

    Connection conn = obtenerConexion();
    String mensajeExito = null;
    String mensajeError = null;

    String accion = request.getParameter("accion");
    String idUsrTarget = request.getParameter("id");

    // Cambiar estado de usuario (Bloquear / Activar)
    if (("bloquear".equals(accion) || "activar".equals(accion)) && idUsrTarget != null && conn != null) {
        PreparedStatement stmtState = null;
        try {
            String nuevoEstado = "bloquear".equals(accion) ? "INACTIVO" : "ACTIVO";
            stmtState = conn.prepareStatement("UPDATE usuario SET estado = ? WHERE id_usuario = ?");
            stmtState.setString(1, nuevoEstado);
            stmtState.setInt(2, Integer.parseInt(idUsrTarget));
            stmtState.executeUpdate();
            mensajeExito = "Estado del usuario actualizado a " + nuevoEstado;
        } catch (SQLException e) {
            mensajeError = "Error al actualizar estado: " + e.getMessage();
        } finally {
            if (stmtState != null) try { stmtState.close(); } catch (Exception e) {}
        }
    }

    // Guardar roles asignados a un usuario (checkboxes del modal)
    if ("guardar_roles".equals(accion) && idUsrTarget != null && conn != null) {
        String[] rolesSeleccionados = request.getParameterValues("roles");
        PreparedStatement stmtDelRoles = null;
        PreparedStatement stmtInsRol = null;
        try {
            conn.setAutoCommit(false);
            stmtDelRoles = conn.prepareStatement("DELETE FROM usuario_rol WHERE id_usuario = ?");
            stmtDelRoles.setInt(1, Integer.parseInt(idUsrTarget));
            stmtDelRoles.executeUpdate();

            if (rolesSeleccionados != null) {
                stmtInsRol = conn.prepareStatement("INSERT INTO usuario_rol (id_usuario, id_rol) VALUES (?, ?)");
                for (String idRolStr : rolesSeleccionados) {
                    stmtInsRol.setInt(1, Integer.parseInt(idUsrTarget));
                    stmtInsRol.setInt(2, Integer.parseInt(idRolStr));
                    stmtInsRol.addBatch();
                }
                stmtInsRol.executeBatch();
            }
            conn.commit();
            mensajeExito = "Roles actualizados correctamente.";
        } catch (SQLException e) {
            try { conn.rollback(); } catch (SQLException ex) {}
            mensajeError = "Error al actualizar roles: " + e.getMessage();
        } finally {
            try { conn.setAutoCommit(true); } catch (Exception e) {}
            if (stmtDelRoles != null) try { stmtDelRoles.close(); } catch (Exception e) {}
            if (stmtInsRol != null) try { stmtInsRol.close(); } catch (Exception e) {}
        }
    }

    // Catálogo completo de roles (para los checkboxes)
    List<Object[]> listaRoles = new ArrayList<>();
    if (conn != null) {
        try {
            Statement stmtRoles = conn.createStatement();
            ResultSet rsRoles = stmtRoles.executeQuery("SELECT id_rol, nombre_rol FROM rol ORDER BY id_rol");
            while (rsRoles.next()) {
                listaRoles.add(new Object[]{ rsRoles.getInt("id_rol"), rsRoles.getString("nombre_rol") });
            }
            rsRoles.close(); stmtRoles.close();
        } catch (SQLException e) { /* ignorar */ }
    }

    // ---------- 1ra pasada: cargar TODOS los datos en memoria (una sola vez) ----------
    // Guardamos cada usuario como Map para poder recorrerlo dos veces sin volver a consultar:
    // una vez para pintar la tabla, y otra (fuera de la tabla) para pintar los modales.
    List<Map<String,Object>> usuarios = new ArrayList<>();
    String mensajeErrorConsulta = null;
    if (conn != null) {
        Statement stmtUsers = null;
        ResultSet rsUsers = null;
        try {
            String sql = "SELECT u.id_usuario, u.correo, u.estado, u.fecha_registro, " +
                         "p.nombres, p.apellidos, p.documento, p.telefono, " +
                         "GROUP_CONCAT(r.nombre_rol SEPARATOR ', ') AS roles " +
                         "FROM usuario u " +
                         "LEFT JOIN perfil p ON u.id_usuario = p.id_usuario " +
                         "LEFT JOIN usuario_rol ur ON u.id_usuario = ur.id_usuario " +
                         "LEFT JOIN rol r ON ur.id_rol = r.id_rol " +
                         "GROUP BY u.id_usuario ORDER BY u.id_usuario DESC";
            stmtUsers = conn.createStatement();
            rsUsers = stmtUsers.executeQuery(sql);
            while (rsUsers.next()) {
                int idU = rsUsers.getInt("id_usuario");

                Set<Integer> rolesIdsUsuario = new HashSet<>();
                try {
                    PreparedStatement stmtRolesUser = conn.prepareStatement(
                        "SELECT id_rol FROM usuario_rol WHERE id_usuario = ?");
                    stmtRolesUser.setInt(1, idU);
                    ResultSet rsRolesUser = stmtRolesUser.executeQuery();
                    while (rsRolesUser.next()) rolesIdsUsuario.add(rsRolesUser.getInt("id_rol"));
                    rsRolesUser.close(); stmtRolesUser.close();
                } catch (SQLException e) { /* ignorar */ }

                Map<String,Object> u = new HashMap<>();
                u.put("id", idU);
                u.put("estado", rsUsers.getString("estado"));
                u.put("nombres", rsUsers.getString("nombres"));
                u.put("apellidos", rsUsers.getString("apellidos"));
                u.put("correo", rsUsers.getString("correo"));
                u.put("documento", rsUsers.getString("documento"));
                u.put("roles", rsUsers.getString("roles"));
                u.put("rolesIds", rolesIdsUsuario);
                usuarios.add(u);
            }
        } catch (SQLException e) {
            mensajeErrorConsulta = "Error al consultar usuarios: " + e.getMessage();
        } finally {
            if (rsUsers != null) try { rsUsers.close(); } catch (Exception e) {}
            if (stmtUsers != null) try { stmtUsers.close(); } catch (Exception e) {}
        }
    }
    if (mensajeErrorConsulta != null) mensajeError = mensajeErrorConsulta;
    if (conn != null) try { conn.close(); } catch (Exception e) {}
%>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold m-0">Gestión de Usuarios</h2>
            <p class="text-muted m-0">Administra cuentas, perfiles, roles y estados de usuarios</p>
        </div>
        <a href="index.jsp" class="btn btn-outline-secondary">&larr; Volver al Panel</a>
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
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th># ID</th>
                            <th>Nombre Completo</th>
                            <th>Correo Electrónico</th>
                            <th>Documento</th>
                            <th>Roles</th>
                            <th>Estado</th>
                            <th class="text-end px-4">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (usuarios.isEmpty()) { %>
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">No se encontraron usuarios registrados.</td>
                        </tr>
                        <% } %>
                        <% for (Map<String,Object> u : usuarios) {
                            int idU = (Integer) u.get("id");
                            String estadoU = (String) u.get("estado");
                            String nom = (String) u.get("nombres");
                            String ape = (String) u.get("apellidos");
                            String roles = (String) u.get("roles");
                        %>
                        <tr>
                            <td class="fw-bold">#<%= idU %></td>
                            <td><%= (nom != null ? nom + " " + (ape != null ? ape : "") : "Sin Perfil") %></td>
                            <td><%= u.get("correo") %></td>
                            <td><%= (u.get("documento") != null ? u.get("documento") : "-") %></td>
                            <td><span class="badge bg-primary"><%= (roles != null ? roles : "Sin Rol") %></span></td>
                            <td>
                                <% if ("ACTIVO".equals(estadoU)) { %>
                                    <span class="badge bg-success">Activo</span>
                                <% } else { %>
                                    <span class="badge bg-danger">Inactivo</span>
                                <% } %>
                            </td>
                            <td class="text-end px-4">
                                <a href="#" class="btn btn-sm btn-outline-primary me-1"
                                   data-bs-toggle="modal" data-bs-target="#modalRoles<%= idU %>">Roles</a>
                                <% if ("ACTIVO".equals(estadoU)) { %>
                                    <a href="usuarios.jsp?accion=bloquear&id=<%= idU %>"
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('¿Desactivar esta cuenta?');">Desactivar</a>
                                <% } else { %>
                                    <a href="usuarios.jsp?accion=activar&id=<%= idU %>"
                                       class="btn btn-sm btn-outline-success">Activar</a>
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- =========================================================
     MODALES DE ROLES — fuera de la tabla a propósito.
     Un <div> dentro de <tbody>/<tr> es HTML inválido: el
     navegador lo reubica solo y el modal queda "roto"
     (aparece el fondo oscuro pero no se puede interactuar).
     ========================================================= -->
<% for (Map<String,Object> u : usuarios) {
    int idU = (Integer) u.get("id");
    String nom = (String) u.get("nombres");
    @SuppressWarnings("unchecked")
    Set<Integer> rolesIdsUsuario = (Set<Integer>) u.get("rolesIds");
%>
<div class="modal fade" id="modalRoles<%= idU %>" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <form method="POST" action="usuarios.jsp">
        <input type="hidden" name="accion" value="guardar_roles">
        <input type="hidden" name="id" value="<%= idU %>">
        <div class="modal-header">
          <h5 class="modal-title">Roles — <%= (nom != null ? nom : u.get("correo")) %></h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <% for (Object[] rolItem : listaRoles) {
                int idRolItem = (Integer) rolItem[0];
                String nombreRolItem = (String) rolItem[1];
                boolean marcado = rolesIdsUsuario.contains(idRolItem);
          %>
          <div class="form-check">
            <input class="form-check-input" type="checkbox" name="roles"
                   value="<%= idRolItem %>" id="rol<%= idU %>_<%= idRolItem %>"
                   <%= marcado ? "checked" : "" %>>
            <label class="form-check-label" for="rol<%= idU %>_<%= idRolItem %>"><%= nombreRolItem %></label>
          </div>
          <% } %>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
          <button type="submit" class="btn btn-primary">Guardar Roles</button>
        </div>
      </form>
    </div>
  </div>
</div>
<% } %>

<%@ include file="../WEB-INF/jspf/footer.jspf" %>
