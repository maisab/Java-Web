/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import classes.Editora;
import classes.Livro;
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
@WebServlet(name = "ServletEditora", urlPatterns = {"/ServletEditora"})
public class ServletEditora extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("op");

        dao.Dao<Editora> daoE = new Dao<Editora>(Editora.class);
        dao.Dao<Livro> daoL = new Dao<Livro>(Livro.class);
        HttpSession session = request.getSession(true);

        if (op.equalsIgnoreCase("Atualizar")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Editora c = (Editora) daoE.get(id);
            session.setAttribute("editora", c);
        }

        if (op.equals("Remover")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Editora e = (Editora) daoE.get(id);
            String nome = e.getNome();
            List<Livro> livro = daoL.list();
            boolean ok = true;
            for (Livro l : livro) {
                if (l.getEditora().getNome().equals(nome)) {
                    ok = false;
                    break;
                }

            }
            if (ok == true) {
                daoE.remove(id);
                session.setAttribute("remover", "sim");
            } else {
                session.setAttribute("remover", "nao");
            }
        }

        response.sendRedirect("GerenciaEditora.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("op");
        HttpSession session = request.getSession(true);

        Editora e = new Editora();
        dao.Dao<Editora> daoC = new Dao<Editora>(Editora.class);
        if (op.equals("Salvar")) {
            e.setNome(request.getParameter("nomeEditora"));
            daoC.insert(e);

            response.sendRedirect("editora.jsp");
        }
        if (op.equals("Gerenciar")) {
            session.setAttribute("nomeBusca", "nao");
            response.sendRedirect("GerenciaEditora.jsp");
        }
        if (op.equalsIgnoreCase("Buscar")) {
            session.setAttribute("nomeBusca", request.getParameter("nomeBusca"));
            response.sendRedirect("GerenciaEditora.jsp");
        }
        if (op.equals("Atualizar")) {
            e = (Editora) session.getAttribute("editora");
            e.setNome(request.getParameter("nomeE"));
            daoC.update(e);
            session.removeAttribute("editora");
            response.sendRedirect("GerenciaEditora.jsp");
        }

        if (op.equals("Ok")) {
            session.removeAttribute("remover");
            response.sendRedirect("GerenciaEditora.jsp");

        }

    }
}
