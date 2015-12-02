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
 * @author Andressa
 */
@WebServlet(name = "ServletCadastroPerfil", urlPatterns = {"/ServletCadastroPerfil"})
public class ServletCadastroPerfil extends HttpServlet {

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
        String email = map.get("email");
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

        Perfil p = new Perfil();
        p.setNome(nome);
        p.setCidade(cidade);
        p.setEstado(daoE.get(idEstado));
        p.setSenha(senha);
        p.setDataNasc(data);
        p.setSexo(sexo.charAt(0));
        p.setEmail(email);
        p.setFoto(foto);

        List<Perfil> lista = dao.list();

        if (op.equalsIgnoreCase("Verificar")) {
            if (!lista.isEmpty()) {
                for (Perfil perfil : lista) {
                    if (perfil.getEmail().equals(email)) {
                        session.setAttribute("verifica", "false");
                        break;
                    }
                    session.setAttribute("verifica", "true");

                }
            } else {
                session.setAttribute("verifica", "true");
            }
            session.setAttribute("valida", p);
            session.setAttribute("email", "true");
            response.sendRedirect("cadastro.jsp");

        }



        if ("Enviar".equals(op)) {
            session.setAttribute("email", "false");
            if (nome.length() == 0 || cidade.length() == 0 || idEstado == -1
                    || email.length() == 0 || data == null || senha.length() == 0) {
                session.setAttribute("valida", p);
                response.sendRedirect("cadastro.jsp");
            } else {

                dao.insert(p);
                response.sendRedirect("login.jsp");
                session.removeAttribute("valida");
                session.removeAttribute("email");
                session.removeAttribute("verifica");
            }

        }
    }
}
