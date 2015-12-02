/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import classes.Autor;
import classes.Livro;
import classes.Perfil;
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
@WebServlet(name = "ServletDetalhes", urlPatterns = {"/ServletDetalhes"})
public class ServletDetalhes extends HttpServlet {

    public final String dir = "/files/";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("detalhes");
        String pagina=request.getParameter("voltar");
        int id = Integer.parseInt(request.getParameter("id"));
        dao.Dao<Livro> livro = new Dao<Livro>(Livro.class);
        Livro l = livro.get(id);
        HttpSession session = request.getSession(true);
        // List<Perfil> listPerfil = null;
        //  List<Livro> listLivro = null;

        session.setAttribute("livro", l);
        session.setAttribute("voltar", pagina);
        session.setAttribute("BuscaLivroNome", "");
        
        //session.setAttribute("ListaPerfil", listPerfil);
        // session.setAttribute("ListaLivro", listLivro);

        response.sendRedirect("verdetalhes.jsp");

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

        HttpSession session = request.getSession(true);
        String op = map.get("op");
        dao.Dao<Livro> daoL = new Dao<Livro>(Livro.class);
        dao.Dao<Perfil> daoP = new Dao<Perfil>(Perfil.class);

        Livro l = (Livro) session.getAttribute("livro");
        Perfil p = (Perfil) session.getAttribute("perfil");

        //O livro q adiciona o perfil 
        // List<Perfil> listPerfil = (List<Perfil>) session.getAttribute("listaPerfil");
        List<Perfil> listPerfil = new ArrayList<Perfil>();
        listPerfil = l.getPerfil();
        List<Livro> listLivro = new ArrayList<Livro>();
        listLivro = p.getLivros();
        if (op.equalsIgnoreCase("Adicionar")) {
            listLivro.add(l);
            p.setLivros(listLivro);
            daoP.update(p);
            listPerfil.add(p);
            l.setPerfil(listPerfil);
            daoL.update(l);
            session.setAttribute("perfil", p);
            session.setAttribute("livro", l);

        }
        if (op.equalsIgnoreCase("Remover")) {
            listPerfil.remove(p);
            listLivro.remove(l);
            daoL.update(l);
            daoP.update(p);
            session.setAttribute("perfil", p);
            session.setAttribute("livro", l);
        }
        response.sendRedirect("verdetalhes.jsp");
    }
}
