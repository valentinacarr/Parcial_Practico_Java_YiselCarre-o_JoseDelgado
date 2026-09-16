<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<div class="row justify-content-center my-5">
    <div class="col-md-6 text-center">
        <div class="card border-danger shadow">
            <div class="card-body p-5">
                <h1 class="display-1 fw-bold text-danger">403</h1>
                <h2 class="mb-3">Acceso Denegado</h2>
                <p class="lead text-muted mb-4">
                    No tienes los permisos necesarios para acceder a este módulo o sección del sistema.
                </p>
                <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                    <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-primary btn-lg px-4 gap-3">Volver al Inicio</a>
                    <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-outline-secondary btn-lg px-4">Cambiar de Cuenta</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>