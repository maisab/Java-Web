
<%@page import="classes.Livro"%>
<%@page import="java.util.List"%>
<%
    if (session.getAttribute("isLogado") == null) {
        response.sendRedirect("login.jsp");
    }
%><%-- 
    Document   : newjsp
    Created on : 04/10/2011, 13:30:30
    Author     : Tarde
--%>

<%@page import="dao.Dao"%>
<%@page import="classes.Perfil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil</title>
        <link href="newstyle.css" rel="stylesheet" type="text/css"/>
    </head>
    <body> 
        <form action="LoginServlet" method="POST"
              id="formSendFile" 
              name="formSendFile" 
              enctype="multipart/form-data"     
              >
            <%
                Perfil p = (Perfil) session.getAttribute("perfil");
            %>
            <div id="tudo">
                <div id="header">
                    <div id="sair">
                        <a href="LoginServlet?op=sair">Sair</a>
                    </div>
                    <p class="acesso">
                        <% if (p.getSexo() == 'F') {
                                out.println("Bem-vinda " + p.getNome() + "<br/>");
                            } else {
                                out.println("Bem-vindo " + p.getNome() + "<br/>");
                            }
                        %>
                    </p>    
                    <div id="logo">
                    </div>
                </div>

                <div id="blocodetalhes">
                    <div id="blocoFoto"> <img src="files/<% out.println(p.getFoto());%>" /></div>
                    <div id="blocoM">
                        <ul>
                            <li><a href="perfilUsuario.jsp"> Perfil</a></li>
                            <li><a href="ServletBusca?op=BuscaLivro.jsp&paginaAnterior=0&paginas=1"> Livros</a></li>
                            <li><a href="EditoraPerfil.jsp"> Editoras </a> </li>
                            <li><a href="PerfilAutores.jsp"> Autores</a></li>
                            <li> <a href="sugestao.jsp"> Sugestao</a> </li>
                        </ul>
                    </div>
                </div>
                <div  id="blocop">

                    <div id="blocoMeusLivros">
                        <h4>Novos Livros</h4>

                        <%
                            dao.Dao<Livro> daoc = new Dao<Livro>(Livro.class);
                            List<Livro> list = daoc.list();
                            int cont = 0;
                            if (!list.isEmpty()) {

                                for (int i = (list.size() - 1); i >= 0; i--) {
                                    Livro l = list.get(i);
                                    ++cont;
                                    out.println("<div id=\"blocolivro\">");

                                    //64px a imagem
                                    out.println("<p class=\"p\">" + l.getNome() + " </p> ");
                                    out.println("<p class=\"img\"><img src=\"files/" + l.getFoto() + "\"></p> ");
                                     out.println("<p class=\"al1 \"><a href=\"ServletDetalhes?voltar=perfil.jsp&op=detalhes&id=" + l.getId() + "\">Ver detalhes</a></p>");
                                    out.println("</div>");
                                    if (cont == 6) {
                                        break;
                                    }
                                }



                            }
                        %>
                        <%--<p class="al"> <a href="BuscaLivro.jsp">Ver mais</a></p>--%>
                        <p class="al"> <a href="ServletBusca?op=BuscaLivro.jsp&paginaAnterior=0&paginas=1">Ver mais</a></p>

                    </div>

                    <hr/>
                    <h4>Meus Livros:)</h4>
                    <div id="bloconovos">
                        <%
                            cont = 0;

                            List<Livro> lista = p.getLivros();
                            if (!lista.isEmpty()) {
                                for (Livro livro : lista) {
                                    out.println("<div id=\"blocolivro\">");
                                    //64px a imagem
                                    out.println("<p class=\"p\">" + livro.getNome() + " </p> ");
                                    out.println("<p class=\"img\"><img src=\"files/" + livro.getFoto() + "\"></p> ");
                                     out.println("<p class=\"al1 \"><a href=\"ServletDetalhes?voltar=perfil.jsp&op=detalhes&id=" + livro.getId() + "\">Ver detalhes</a></p>");
                                    out.println("</div>");
                                    
                                }
                            }

                        %>

                        <%-- <p class="al"> <a href="MeusLivros.jsp">Ver mais</a></p>--%>
                        <p class="al"> <a href="ServletBusca?op=MeusLivros.jsp&paginaAnterior=0&paginas=1">Ver mais</a></p>
                    </div>
                </div>
            </div>

        </form>
    </body>
</html>
