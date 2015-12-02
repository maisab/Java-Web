/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import classes.Perfil;
import dao.Dao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Andressa
 */
@WebServlet(name = "ServletVerPerfil", urlPatterns = {"/ServletVerPerfil"})
public class ServletVerPerfil extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("detalhes");
        String pagina = request.getParameter("pagina");
        int id = Integer.parseInt(request.getParameter("id"));

        dao.Dao<Perfil> perfil = new Dao<Perfil>(Perfil.class);
        Perfil p = perfil.get(id);
        HttpSession session = request.getSession(true);
        session.setAttribute("perfildetalhe", p);
        session.setAttribute("pagina", pagina);
        response.sendRedirect("verdetalhePerfil.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
