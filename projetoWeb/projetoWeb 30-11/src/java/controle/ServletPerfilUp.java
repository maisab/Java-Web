/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import classes.Estado;
import classes.Perfil;
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
 * @author a968552
 */
@WebServlet(name = "ServletPerfilUp", urlPatterns = {"/ServletPerfilUp"})
public class ServletPerfilUp extends HttpServlet {

    public final String dir = "/files/";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
        //String email = map.get("email");
        String senha = map.get("senha");
        String cidade = map.get("cidade");
        String dta = map.get("data");
        String sexo = map.get("sexo");
        String foto = map.get("imagem");

        int idEstado = Integer.parseInt(map.get("estado"));
        
        Date data;
        if (dta.isEmpty()) {
            data = null;
        } else {
            data = Util.stringToDate(dta);
        }

        dao.Dao<Estado> daoE = new Dao<Estado>(Estado.class);
        Dao<Perfil> dao = new Dao<Perfil>(Perfil.class);

        HttpSession session = request.getSession(true);

        if ("editar".equalsIgnoreCase(op)) {

            Perfil p =(Perfil) session.getAttribute("perfil");
            p.setNome(nome);
            p.setCidade(cidade);
            p.setEstado(daoE.get(idEstado));
            p.setSenha(senha);
            p.setDataNasc(data);
            p.setSexo(sexo.charAt(0));
            //p.setEmail("m@l");
            p.setFoto(foto);
            
            dao.update(p);
            
            session.setAttribute("perfil", p);
            
            response.sendRedirect("perfilUsuario.jsp");                    

        }
    }
}
