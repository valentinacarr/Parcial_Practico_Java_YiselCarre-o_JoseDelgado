<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Invalida la sesión actual y remueve todos los atributos guardados
    if (session != null) {
        session.invalidate();
    }
    // Redirige al inicio o al login
    response.sendRedirect("login.jsp");
%>