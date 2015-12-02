package controle;

import classes.Categoria;
import classes.Livro;
import dao.Dao;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "ServletCategoria", urlPatterns = {"/ServletCategoria"})
public class ServletCategoria extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("op");
        int id = Integer.parseInt(request.getParameter("id"));
        dao.Dao<Categoria> daoC = new Dao<Categoria>(Categoria.class);
        HttpSession session = request.getSession(true);
        dao.Dao<Livro> daoL = new Dao<Livro>(Livro.class);
        if (op.equalsIgnoreCase("Atualizar")) {
            Categoria c = (Categoria) daoC.get(id);
            session.setAttribute("categoria", c);
        }
        if (op.equals("Remover")) {
            Categoria c = (Categoria) daoC.get(id);
            String nome = c.getNome();
            List<Livro> livro = daoL.list();
            boolean ok = true;
            for (Livro l : livro) {
                if (l.getCategoria().getNome().equals(nome)) {
                    ok = false;
                    break;
                }

            }
            if (ok == true) {
                daoC.remove(id);
                session.setAttribute("remover", "sim");
            } else {
                session.setAttribute("remover", "nao");
            }
        }

        response.sendRedirect("GerenciaCategoria.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("op");
        HttpSession session = request.getSession(true);

        Categoria c = new Categoria();
        dao.Dao<Categoria> daoC = new Dao<Categoria>(Categoria.class);
        if (op.equals("Salvar")) {
            c.setNome(request.getParameter("nomeCategoria"));
            daoC.insert(c);
            
            response.sendRedirect("categoria.jsp");
        }
        if (op.equals("Gerenciar")) {
            session.setAttribute("nomeBusca", "nao");
            response.sendRedirect("GerenciaCategoria.jsp");
        }
        if (op.equalsIgnoreCase("Buscar")) {
            session.setAttribute("nomeBusca", request.getParameter("nomeBusca"));
            response.sendRedirect("GerenciaCategoria.jsp");
        }
        if (op.equals("Atualizar")) {
            c = (Categoria) session.getAttribute("categoria");
            c.setNome(request.getParameter("nomeC"));
            daoC.update(c);
            session.removeAttribute("categoria");
            response.sendRedirect("GerenciaCategoria.jsp");
        }
        if (op.equalsIgnoreCase("OK")) {
            session.removeAttribute("remover");
            response.sendRedirect("GerenciaCategoria.jsp");
        }

    }
}
