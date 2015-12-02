/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import classes.Perfil;
import classes.Sugestao;
import classes.Upload;
import classes.Util;
import dao.Dao;
import java.io.IOException;
import java.util.Date;
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
@WebServlet(name = "ServletSugestao", urlPatterns = {"/ServletSugestao"})
public class ServletSugestao extends HttpServlet {

    public final String dir = "/files/";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Dao<Sugestao> daoSugestao = new Dao<Sugestao>(Sugestao.class);
        daoSugestao.remove(id);
        response.sendRedirect("sugestao.jsp");
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
        String sugestao = map.get("sugestao");
        HttpSession session = request.getSession();

        Dao<Sugestao> daoSugestao = new Dao<Sugestao>(Sugestao.class);
        Sugestao s = new Sugestao();
        if (op.equals("Enviar")) {

            Perfil p = (Perfil) session.getAttribute("perfil");
            Date d = new Date();
            String dat = Util.dateToString(d);
            Date data = Util.stringToDate(dat);
            s.setDataSug(data);
            s.setDica(sugestao);
            s.setPerfil(p);
            s.setLida(false);
            daoSugestao.insert(s);
            response.sendRedirect("sugestao.jsp");
        }
        if (op.equals("Salvar")) {
            int lida = Integer.parseInt(map.get("lida"));
            if (lida > 0) {
                s = daoSugestao.get(lida);
                s.setLida(true);

            }
            response.sendRedirect("AdSugestao.jsp");

        }
    }
}
