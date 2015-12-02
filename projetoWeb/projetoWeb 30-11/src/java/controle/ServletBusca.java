/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import classes.Autor;
import classes.Editora;
import classes.Livro;
import classes.Perfil;
import classes.Upload;
import dao.Dao;
import java.io.IOException;
import java.io.PrintWriter;
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
 * @author a968307
 */
@WebServlet(name = "ServletBusca", urlPatterns = {"/ServletBusca"})
public class ServletBusca extends HttpServlet {

    public final String dir = "/files/";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("op");
        int pagina = Integer.parseInt(request.getParameter("paginas"));//
        int paginaAnterior = Integer.parseInt(request.getParameter("paginaAnterior"));//
        HttpSession session = request.getSession(false);
        if (op.equals("BuscaLivro.jsp")) {

            dao.Dao<Livro> livros = new Dao<Livro>(Livro.class);
            List<Livro> l = livros.list();

            int quantidade = 0;
            if (l.size() % 2 == 0) {
                quantidade = l.size() / 2;
            } else {
                quantidade = (l.size() / 2) + 1;
            }

            session.removeAttribute("quantidadepaginas");
            session.setAttribute("quantidadepaginas", quantidade);
            session.removeAttribute("paginaatual");
            session.setAttribute("paginaatual", pagina);
            session.removeAttribute("paginaAnterior");
            session.setAttribute("paginaAnterior", paginaAnterior);

        }
        if (op.equals("MeusLivros.jsp")) {
            Perfil p = (Perfil) session.getAttribute("perfil");
            List<Livro> l = p.getLivros();

            int quantidade = 0;
            if (l.size() % 2 == 0) {
                quantidade = l.size() / 2;
            } else {
                quantidade = (l.size() / 2) + 1;
            }
            session.removeAttribute("quantidadepaginas");
            session.setAttribute("quantidadepaginas", quantidade);
            session.removeAttribute("paginaatual");
            session.setAttribute("paginaatual", pagina);
            session.removeAttribute("paginaAnterior");
            session.setAttribute("paginaAnterior", paginaAnterior);


        }
        if (op.equals("leitores.jsp")) {
            Livro l = (Livro) session.getAttribute("livro");
            List<Perfil> p = l.getPerfil();

            int quantidade = 0;
            if (p.size() % 2 == 0) {
                quantidade = p.size() / 2;
            } else {
                quantidade = (p.size() / 2) + 1;
            }
            session.removeAttribute("quantidadepaginas");
            session.setAttribute("quantidadepaginas", quantidade);
            session.removeAttribute("paginaatual");
            session.setAttribute("paginaatual", pagina);
            session.removeAttribute("paginaAnterior");
            session.setAttribute("paginaAnterior", paginaAnterior);

        }
        if (op.equals("buscaEditoras.jsp")) {
            Dao<Editora> editora = new Dao<Editora>(Editora.class);
            List<Editora> list = editora.list();
            int quantidade = 0;
            if (list.size() % 2 == 0) {
                quantidade = list.size() / 2;
            } else {
                quantidade = (list.size() / 2) + 1;
            }
            session.removeAttribute("quantidadepaginas");
            session.setAttribute("quantidadepaginas", quantidade);
            session.removeAttribute("paginaatual");
            session.setAttribute("paginaatual", pagina);
            session.removeAttribute("paginaAnterior");
            session.setAttribute("paginaAnterior", paginaAnterior);

        }
        if (op.equals("buscaAutores.jsp")) {
            Dao<Autor> a = new Dao<Autor>(Autor.class);
            List<Autor> list = a.list();
            int quantidade = 0;
            if (list.size() % 2 == 0) {
                quantidade = list.size() / 2;
            } else {
                quantidade = (list.size() / 2) + 1;
            }
            session.removeAttribute("quantidadepaginas");
            session.setAttribute("quantidadepaginas", quantidade);
            session.removeAttribute("paginaatual");
            session.setAttribute("paginaatual", pagina);
            session.removeAttribute("paginaAnterior");
            session.setAttribute("paginaAnterior", paginaAnterior);

        }
        response.sendRedirect(op);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Cria um objeto upload já setando e criando o diretorio que os
        // arquivos serão armazenados
        Upload upload = new Upload(getServletContext().getRealPath(dir));

        // Retorna um list com todos os componentes de uma requisição
        List list = upload.processRequest(request);

        // Neste Map você obteve todos os campos do formulário.
        Map<String, String> map = upload.getFormValues(list);

        String op = map.get("op");
        String nome = map.get("nome");
        HttpSession session = request.getSession(true);
        session.removeAttribute("paginaatual");
        int pagina = 1;
        if (op.equals("BuscaLivro.jsp")) {//todos os livros


            dao.Dao<Livro> livros = new Dao<Livro>(Livro.class);
            List<Livro> l = livros.listbyNome(nome);

            int quantidade = 0;
            if (l.size() % 2 == 0) {
                quantidade = l.size() / 2;
            } else {
                quantidade = (l.size() / 2) + 1;
            }
            session.removeAttribute("quantidadepaginas");
            session.setAttribute("quantidadepaginas", quantidade);

            session.setAttribute("paginaatual", pagina);

        }
        if (op.equals("MeusLivros.jsp")) {// so os cadastrados pelo usuario


            Perfil perfil = (Perfil) session.getAttribute("perfil");
            List<Livro> l = perfil.getLivros();

            int quantidade = 0;
            if (l.size() % 2 == 0) {
                quantidade = l.size() / 2;
            } else {
                quantidade = (l.size() / 2) + 1;
            }
            session.removeAttribute("quantidadepaginas");
            session.setAttribute("quantidadepaginas", quantidade);

            session.setAttribute("paginaatual", pagina);

        }
        if (op.equals("leitores.jsp")) {

//perfil    
            Livro l = (Livro) session.getAttribute("livro");
            List<Perfil> p = l.getPerfil();


            int quantidade = 0;
            if (p.size() % 2 == 0) {
                quantidade = p.size() / 2;
            } else {
                quantidade = (p.size() / 2) + 1;
            }
            session.removeAttribute("quantidadepaginas");
            session.setAttribute("quantidadepaginas", quantidade);

            session.setAttribute("paginaatual", pagina);

        }
        if (op.equals("buscaAutores.jsp")) {
            Dao<Autor> a = new Dao<Autor>(Autor.class);
            List<Autor> lista = a.list();
            int quantidade = 0;
            if (lista.size() % 2 == 0) {
                quantidade = lista.size() / 2;
            } else {
                quantidade = (lista.size() / 2) + 1;
            }
            session.removeAttribute("quantidadepaginas");
            session.setAttribute("quantidadepaginas", quantidade);

            session.setAttribute("paginaatual", pagina);

        }

        session.setAttribute("BuscaLivroNome", nome);
        response.sendRedirect(op);


    }
}
