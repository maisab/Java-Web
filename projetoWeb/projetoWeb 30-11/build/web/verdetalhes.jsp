<%-- 
    Document   : verdetalhes
    Created on : 10/11/2011, 17:54:32
    Author     : Andressa
--%>

<%@page import="java.util.List"%>
<%@page import="dao.Dao"%>
<%@page import="classes.Livro"%>
<%@page import="classes.Perfil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="newstyle.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <form action="ServletDetalhes" method="POST"
              id="formSendFile" 
              name="formSendFile" 
              enctype="multipart/form-data"     
              >
            <%
                Perfil p = (Perfil) session.getAttribute("perfil");
                Livro l = (Livro) session.getAttribute("livro");
            %>
            <div id="tudo">
                <div id="header">
                    <div id="sair">
                        <a href="LoginServlet?op=sair">Sair</a>
                    </div>

                    <div id="logo">
                    </div>
                </div>

                <div id="blocodetalhes">
                    <div id="blocoFoto"> <img src="files/<% out.println(p.getFoto());%>" /></div>
                    <div id="blocoM">
                        <ul>
                            <li><a href="perfil.jsp"> Perfil</a></li>
                            <li><a href="ServletBusca?op=BuscaLivro.jsp&paginaAnterior=0&paginas=1"> Livros</a></li>
                            <li><a href="EditoraPerfil.jsp"> Editoras </a> </li>
                            <li><a href="PerfilAutores.jsp"> Autores</a></li>
                            <li> <a href="sugestao.jsp"> Sugestao</a> </li>
                        </ul>
                    </div>
                </div>
                <div  id="blocop">
                    <h2 style="text-align: center"><% out.println(l.getNome());%></h2>
                    <div id="blocolivro1">
                        <img width="150px" height="140px" src="files/<% out.println(l.getFoto());%>" />
                    </div>
                    <h4 style="padding-left: 30px;">Sinopse</h4>
                    <p style="padding-left: 50px;"><% out.println(l.getSinopse());%></p>

                    <h4 style="padding-left: 30px;">Ano de publicação</h4>
                    <p style="padding-left: 50px;"><% out.println(l.getAno());%></p>

                    <%
                        boolean ok = false;
                        List<Perfil> lista = l.getPerfil();
                        if (!lista.isEmpty()) {
                            for (Perfil perfil : lista) {
                                if (perfil.getId() == p.getId()) {

                                    out.println("<p style=\"padding-left: 30px;\"><input type=\"submit\" value=\"Remover\" name=\"op\" /></p>");
                                    ok = true;
                                    break;
                                }
                            }
                            if (!ok) {

                                out.println("<p style=\"padding-left: 30px;\"><input type=\"submit\" value=\"Adicionar\" name=\"op\" /></p>");

                            }
                        } else {
                            out.println("<p style=\"padding-left: 30px;\"><input type=\"submit\" value=\"Adicionar\" name=\"op\" /></p>");

                        }


                    %>

                    <%String pagina = (String) session.getAttribute("voltar");%>

                    <p class="center"> <a href="<%out.println(pagina);%>">Voltar</a></p>
                    <br/>

                    <hr/>
                    <br/><br/>
                    <div id="bloconovos">
                        <h4>Leitores em comum</h4>
                        <%

                            if (!lista.isEmpty()) {
                                for (int i = lista.size() - 1; i >= 0; i--) {
                                    Perfil perfil = lista.get(i);
                                    if (p.getId() == perfil.getId()) {

                                        if (i == 0) {
                                            break;
                                        }
                                        i--;
                                        perfil = lista.get(i);

                                    }

                                    out.println("<div id=\"blocolivro\">");
                                    //64px a imagem
                                    out.println("<p class=\"p\">" + perfil.getNome() + " </p> ");
                                    out.println("<p class=\"img\"><img width=\"64px\" height=\"64px\" src=\"files/" + perfil.getFoto() + "\"></p> ");
                                    out.println("</div>");

                                }
                            }

                        %>
                        <p class="al"> <a href="ServletBusca?op=leitores.jsp&paginaAnterior=0&paginas=1">Ver mais</a></p>
                    </div>  
                </div>
            </div>
        </form>
    </body>
</html>
