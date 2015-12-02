/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import classes.Autor;
import classes.Livro;
import classes.Util;
import dao.Dao;
import java.io.IOException;
import java.util.Date;
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
@WebServlet(name = "ServletAutores", urlPatterns = {"/ServletAutores"})
public class ServletAutores extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("op");
        HttpSession session = request.getSession();
        Dao<Autor> dao = new Dao<Autor>(Autor.class);
        if (op.equalsIgnoreCase("Atualizar")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Autor autor = dao.get(id);
            session.setAttribute("autor", autor);


        }
        if (op.equalsIgnoreCase("Remover")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Dao<Livro> daoLivro = new Dao<Livro>(Livro.class);
            Dao<Autor> daoAutor = new Dao<Autor>(Autor.class);
            List<Livro> livro = daoLivro.list();
            boolean ok = true;
           
            for (Livro l : livro) {
                for (Autor a : l.getAutores()) {
                    if (a.getId() == id) {
                        ok = false;
                        break;
                    }
                }
                if (ok == false) {
                    break;
                }
            }
            if (ok) {
                session.setAttribute("remover", "sim");
                daoAutor.remove(id);
            } else {
                session.setAttribute("remover", "nao");
            }
        }
        response.sendRedirect("GerenciaAutor.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("op");
        Dao<Autor> daoAutor = new Dao<Autor>(Autor.class);
        HttpSession session = request.getSession();
        if (op.equalsIgnoreCase("inserir")) {
            String nome = request.getParameter("nome");
            Date data = Util.stringToDate(request.getParameter("data"));
            String descricao = request.getParameter("descricao");
            Autor autor = new Autor();

            autor.setNome(nome);
            autor.setDataNasc(data);
            autor.setDescricao(descricao);
            daoAutor.insert(autor);
            response.sendRedirect("autores.jsp");
        }
        if (op.equals("Gerenciar")) {
            session.setAttribute("nomeBusca", "nao");
            response.sendRedirect("GerenciaAutor.jsp");
        }
        if (op.equalsIgnoreCase("Buscar")) {
            session.setAttribute("nomeBusca", request.getParameter("nomeBusca"));
            response.sendRedirect("GerenciaAutor.jsp");
        }
        if (op.equalsIgnoreCase("Atualizar")) {
            String nome = request.getParameter("nomeA");
            Date data = Util.stringToDate(request.getParameter("data"));
            String descricao = request.getParameter("descricao");
            Autor autor = (Autor) session.getAttribute("autor");
            autor.setNome(nome);
            autor.setDataNasc(data);
            autor.setDescricao(descricao);
            daoAutor.update(autor);
            session.removeAttribute("autor");
            response.sendRedirect("GerenciaAutor.jsp");

        }
        if (op.equalsIgnoreCase("OK")) {
            session.removeAttribute("remover");
            response.sendRedirect("GerenciaAutor.jsp");
        }

    }
}
