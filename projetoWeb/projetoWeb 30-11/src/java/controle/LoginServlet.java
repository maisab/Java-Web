/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import classes.Perfil;
import dao.Dao;
import java.io.IOException;
import java.util.List;
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
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       HttpSession session = request.getSession(false);
        String op = request.getParameter("op");
        if (op.equals("cadastro")) {
            response.sendRedirect("cadastro.jsp");
            return;
        }

        if (op.equals("editar")) {
            
          response.sendRedirect("perfilUp.jsp");

        }
        if ("sair".equals(op)) {
            //session.removeAttribute("perfil");
            if (session != null) {
                session.invalidate();
            }

            response.sendRedirect("login.jsp");
        }   
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String login = request.getParameter("login");
        String senha = request.getParameter("senha");

        HttpSession session = request.getSession(true);

        Dao<Perfil> daoPerfil = new Dao<Perfil>(Perfil.class);
        List<Perfil> list = daoPerfil.list();

        String op = request.getParameter("op");

        if (("AndressaMaiara".equalsIgnoreCase(login) || "MaisaBarreto".equalsIgnoreCase(login))
                && senha.equals("Admim")) {
            session.setAttribute("isLogado", "true");
            response.sendRedirect("index.jsp");

        } else {
            boolean logado = false;

            for (Perfil p : list) {
                if (p.getEmail().equals(login) && p.getSenha().equals(senha)) {
                    
                    session.setAttribute("isLogado", "true");
                    
                    session.setAttribute("perfil", p);
                    
                    session.setAttribute("BuscaLivroNome", "");
                    
                   
                    logado = true;
                    break;

                } else {
                    session.setAttribute("isLogado", "false");

                }
            }

            if (logado) {
                response.sendRedirect("perfil.jsp");
            } else {
                response.sendRedirect("login.jsp");
            }
            
        }
    }

}
