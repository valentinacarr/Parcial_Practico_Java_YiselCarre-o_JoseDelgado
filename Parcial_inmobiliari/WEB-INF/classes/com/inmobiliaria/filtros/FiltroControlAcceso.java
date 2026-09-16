package com.inmobiliaria.filtros;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Filtro de control de acceso por rol.
 *
 * Intercepta TODAS las peticiones (ver mapping en web.xml) y decide,
 * según el prefijo de la URL, si el usuario puede pasar:
 *
 *   /admin/*         -> requiere rol ADMINISTRADOR
 *   /inmobiliaria/*  -> requiere rol INMOBILIARIA
 *   /cliente/*       -> requiere rol CLIENTE
 *   cualquier otra   -> pública (landing, catálogo, login, registro, etc.)
 *
 * Esto cumple el requisito del enunciado: si alguien no autenticado, o
 * autenticado sin el rol correcto, escribe la URL directamente en el
 * navegador, el filtro lo redirige a login.jsp o a acceso_denegado.jsp
 * ANTES de que el JSP se ejecute. Es la validación en el servidor:
 * ocultar el menú en la vista no cuenta como control de acceso.
 */
public class FiltroControlAcceso implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No se requiere inicialización especial
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        // No forzamos la creación de una sesión nueva: si no existe, session = null
        HttpSession session = request.getSession(false);

        String contextPath = request.getContextPath();
        String uri = request.getRequestURI();
        // path = la URL relativa a la app, ej: "/admin/index.jsp"
        String path = uri.substring(contextPath.length());

        // 1. Determinar qué rol exige la ruta solicitada
        String rolRequerido = null;
        if (path.startsWith("/admin/")) {
            rolRequerido = "ADMINISTRADOR";
        } else if (path.startsWith("/inmobiliaria/")) {
            rolRequerido = "INMOBILIARIA";
        } else if (path.startsWith("/cliente/")) {
            rolRequerido = "CLIENTE";
        }

        // 2. Si la ruta no es privada (landing, catalogo, login, registro,
        //    detalle_propiedad, css, img, etc.) dejamos pasar sin restricción
        if (rolRequerido == null) {
            chain.doFilter(req, res);
            return;
        }

        // 3. Ruta privada: exigir sesión activa
        Integer idUsuario = (session != null) ? (Integer) session.getAttribute("id_usuario") : null;
        if (idUsuario == null) {
            // Guardamos a dónde quería ir, para redirigirlo después del login (opcional)
            response.sendRedirect(contextPath + "/login.jsp?redirect=" + path.substring(1));
            return;
        }

        // 4. Sesión activa: exigir que el rol coincida con el requerido por la ruta
        String rolSesion = (String) session.getAttribute("rol");

        // El administrador puede entrar a cualquier panel (ajusta esta línea si
        // tu profesor exige que los roles sean estrictamente exclusivos).
        boolean esAdmin = "ADMINISTRADOR".equalsIgnoreCase(rolSesion) || "ADMIN".equalsIgnoreCase(rolSesion);
        boolean tieneRolCorrecto = rolRequerido.equalsIgnoreCase(rolSesion);

        if (!tieneRolCorrecto && !esAdmin) {
            response.sendRedirect(contextPath + "/acceso_denegado.jsp");
            return;
        }

        // 5. Todo correcto: la petición continúa su curso normal hacia el JSP
        chain.doFilter(req, res);
    }

    @Override
    public void destroy() {
        // No se requiere liberar recursos
    }
}
