/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import classes.Autor;
import classes.Categoria;
import classes.Editora;
import classes.Livro;
import classes.Upload;
import dao.Dao;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
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
@WebServlet(name = "ServletLivro", urlPatterns = {"/ServletLivro"})
public class ServletLivro extends HttpServlet {

    public final String dir = "/files/";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("op");
        HttpSession session = request.getSession();
        Dao<Autor> daoAutor = new Dao<Autor>(Autor.class);

        if (op.equalsIgnoreCase("inserirAutor")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Autor autor = daoAutor.get(id);
            List<Autor> autores = (List<Autor>) session.getAttribute("autores");
            if (autores == null) {
                autores = new ArrayList<Autor>();
                autores.add(autor);
            } if (request.getSession().getAttribute("autores") != null) {
                autores = (List<Autor>) request.getSession().getAttribute("autores");
            } else {
                autores = new ArrayList<Autor>();
                request.getSession().setAttribute("autores", autores);
            }
            autores.add(autor);
            session.setAttribute("autores", autores);
            response.sendRedirect("livro.jsp");

        }

        if (op.equalsIgnoreCase("removerAutor")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Autor autor = daoAutor.get(id);
            List<Autor> autores = (List<Autor>) session.getAttribute("autores");
            autores.remove(autor);
            session.setAttribute("autores", autores);
            response.sendRedirect("livro.jsp");

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        Dao<Livro> daoLivro = new Dao<Livro>(Livro.class);
        Dao<Categoria> daoCategoria = new Dao<Categoria>(Categoria.class);
        Dao<Editora> daoEditora = new Dao<Editora>(Editora.class);
        Livro l = new Livro();
        Upload upload = new Upload(getServletContext().getRealPath(dir));
        // Retorna um list com todos os componentes de uma requisição
        List list = upload.processRequest(request);
        // Neste Map você obteve todos os campos do formulário.
        Map<String, String> map = upload.getFormValues(list);

        String op = map.get("op");
        if ("Buscar".equalsIgnoreCase(op)) {
            session.setAttribute("nomeBusca", map.get("nomeBusca"));
            response.sendRedirect("GerenciaLivro.jsp");
        }
        if ("Gerenciar".equalsIgnoreCase(op)) {
            session.setAttribute("nomeBusca", "nao");
            response.sendRedirect("GerenciaLivro.jsp");
        }

        if ("Inserir".equalsIgnoreCase(op)) {

            session.setAttribute("nomeBusca", "nao");
            String nome = map.get("nome");
            String ano = map.get("ano");
            String sinopse = map.get("sinopse");
            String foto = map.get("imagem");
            int idCategoria = Integer.parseInt(map.get("categoria"));
            int idEditora = Integer.parseInt(map.get("editora"));
            List<Autor> autores = (List<Autor>) session.getAttribute("autores");

            Categoria categoria = daoCategoria.get(idCategoria);
            Editora editora = daoEditora.get(idEditora);

            l.setNome(nome);
            l.setCategoria(categoria);
            l.setEditora(editora);
            l.setAno(Integer.parseInt(ano));
            l.setSinopse(sinopse);
            l.setFoto(foto);

            l.setAutores(autores);

            daoLivro.insert(l);

            session.removeAttribute("nome");
            session.removeAttribute("sinopse");
            session.removeAttribute("ano");
            session.removeAttribute("categoria");
            session.removeAttribute("editora");
            session.removeAttribute("autores");
            session.removeAttribute("imagem");
            session.removeAttribute("foto");

            response.sendRedirect("livro.jsp");

        }

        if ("addAutor".equalsIgnoreCase(op)) {
            String nome = map.get("nome");
            String ano = map.get("ano");
            String sinopse = map.get("sinopse");
            String foto = map.get("imagem");
            int idCategoria = Integer.parseInt(map.get("categoria"));
            int idEditora = Integer.parseInt(map.get("editora"));
            Categoria categoria = daoCategoria.get(idCategoria);
            Editora editora = daoEditora.get(idEditora);


            session.setAttribute("nome", nome);
            session.setAttribute("ano", ano);
            session.setAttribute("sinopse", sinopse);
            session.setAttribute("categoria", categoria);
            session.setAttribute("editora", editora);
            session.setAttribute("imagem", foto);


            response.sendRedirect("addAutor.jsp");

        }




    }
}