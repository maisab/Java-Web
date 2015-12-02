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
@WebServlet(name = "ServletAtualizaLivro", urlPatterns = {"/ServletAtualizaLivro"})
public class ServletAtualizaLivro extends HttpServlet {

    public final String dir = "/files/";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("op");
        HttpSession session = request.getSession();
        Dao<Livro> daoLivro = new Dao<Livro>(Livro.class);
        Dao<Categoria> daoCategoria = new Dao<Categoria>(Categoria.class);
        int id = Integer.parseInt(request.getParameter("id"));
        Dao<Editora> daoEditora = new Dao<Editora>(Editora.class);
        Dao<Autor> daoAutor = new Dao<Autor>(Autor.class);
        if (op.equalsIgnoreCase("editarLivro")) {
            Livro l = daoLivro.get(id);
            List<Autor> autores = l.getAutores();
            session.setAttribute("livro", l);
            session.setAttribute("autores", autores);
            response.sendRedirect("LivroUp.jsp");
        }
        if (op.equalsIgnoreCase("removerLivro")) {
            List<Livro> livros = daoLivro.list();
            Livro l = daoLivro.get(id);
            for (Livro livro : livros) {
                if (l.getId() == livro.getId()) {
                    daoLivro.remove(id);
                    
                }
            }
            
            response.sendRedirect("GerenciaLivro.jsp");
        }
        if (op.equalsIgnoreCase("inserirAutor")) {
            Autor autor = daoAutor.get(id);
            List<Autor> autores = (List<Autor>) session.getAttribute("autores");
            if (autores == null) {
                autores = new ArrayList<Autor>();
            }
            if (request.getSession().getAttribute("autores") != null) {
                autores = (List<Autor>) request.getSession().getAttribute("autores");
            } else {
                autores = new ArrayList<Autor>();
                request.getSession().setAttribute("autores", autores);
            }
            autores.add(autor);
            session.setAttribute("autores", autores);
            response.sendRedirect("LivroUp.jsp");

        }
        if (op.equalsIgnoreCase("removerAutor")) {
            Autor autor = daoAutor.get(id);
            List<Autor> autores = (List<Autor>) session.getAttribute("autores");
            autores.remove(autor);
            session.setAttribute("autores", autores);
            response.sendRedirect("LivroUp.jsp");

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Dao<Livro> daoLivro = new Dao<Livro>(Livro.class);
        Dao<Categoria> daoCategoria = new Dao<Categoria>(Categoria.class);
        Dao<Editora> daoEditora = new Dao<Editora>(Editora.class);
        Upload upload = new Upload(getServletContext().getRealPath(dir));
        // Retorna um list com todos os componentes de uma requisição
        List list = upload.processRequest(request);
        // Neste Map você obteve todos os campos do formulário.
        Map<String, String> map = upload.getFormValues(list);
        String op = map.get("op");
        if ("Atualizar".equalsIgnoreCase(op)) {
            String nome = map.get("nome");
            String ano = map.get("ano");
            String sinopse = map.get("sinopse");
            String foto = map.get("imagem");
            int idCategoria = Integer.parseInt(map.get("categoria"));
            int idEditora = Integer.parseInt(map.get("editora"));
            List<Autor> autores = (List<Autor>) session.getAttribute("autores");
            Categoria categoria = daoCategoria.get(idCategoria);
            Editora editora = daoEditora.get(idEditora);

            Livro livro = (Livro) session.getAttribute("livro");

            livro.setNome(nome);
            livro.setAno(Integer.parseInt(ano));
            livro.setEditora(editora);
            livro.setCategoria(categoria);
            livro.setSinopse(sinopse);
            livro.setFoto(foto);
            livro.setAutores(autores);

            daoLivro.update(livro);
            session.removeAttribute("livro");

            session.removeAttribute("nome");
            session.removeAttribute("sinopse");
            session.removeAttribute("ano");
            session.removeAttribute("categoria");
            session.removeAttribute("editora");
            session.removeAttribute("autores");
            session.removeAttribute("imagem");
            session.removeAttribute("foto");

            response.sendRedirect("GerenciaLivro.jsp");
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


            response.sendRedirect("addUp.jsp");

        }
        if ("Buscar".equalsIgnoreCase(op)) {
            session.setAttribute("nomeBusca", map.get("nomeBusca"));
            response.sendRedirect("GerenciaLivro.jsp");
        }
    }
}
