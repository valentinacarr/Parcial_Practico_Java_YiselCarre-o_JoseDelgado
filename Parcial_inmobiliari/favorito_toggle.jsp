<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%
    // Solo un usuario con sesion iniciada puede tener favoritos
    Integer idUsuarioSesion = (Integer) session.getAttribute("id_usuario");
    if (idUsuarioSesion == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String idParam = request.getParameter("id");
    String redirect = request.getParameter("redirect");
    if (redirect == null || redirect.trim().isEmpty()) {
        redirect = "cliente/index.jsp";
    }

    if (idParam != null) {
        try {
            int idPropiedad = Integer.parseInt(idParam);

            @SuppressWarnings("unchecked")
            Set<Integer> favoritos = (Set<Integer>) session.getAttribute("favoritos");
            if (favoritos == null) {
                favoritos = new HashSet<Integer>();
            }

            if (favoritos.contains(idPropiedad)) {
                favoritos.remove(idPropiedad);
            } else {
                favoritos.add(idPropiedad);
            }
            session.setAttribute("favoritos", favoritos);
        } catch (NumberFormatException e) {
            // id invalido, se ignora
        }
    }

    response.sendRedirect(request.getContextPath() + "/" + redirect);
%>
