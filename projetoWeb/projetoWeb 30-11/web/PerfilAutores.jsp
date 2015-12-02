<%-- 
    Document   : PerfilAutores
    Created on : 30/11/2011, 20:13:01
    Author     : Andressa
--%>


<%@page import="java.util.List"%>
<%@page import="dao.Dao"%>
<%@page import="classes.Autor"%>
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
                           <li><a href="perfil.jsp"> Perfil</a></li>
                            <li><a href="ServletBusca?op=BuscaLivro.jsp&paginaAnterior=0&paginas=1"> Livros</a></li>
                            <li><a href="EditoraPerfil.jsp"> Editoras </a> </li>
                            <li><a href="PerfilAutores.jsp"> Autores</a></li>
                            <li> <a href="sugestao.jsp"> Sugestao</a> </li>
                        </ul>
                    </div>
                </div>
                <div  id="blocop">
                    <center>  <h4> Lista de Editoras</h4></center>

                    <%
                        Dao<Autor> autores = new Dao<Autor>(Autor.class);
                        List<Autor> list = autores.list();
                        int cont = 0;
                        if (!list.isEmpty()) {
                            out.println("<table>");
                            out.println("<tr>");
                            out.println("<th>Id</th>");
                            out.println("<th></th>");
                            out.println("<th>Editora</th>");
                            out.println("</tr");
                            for (int i = (list.size() - 1); i >= 0; i--) {

                                Autor a = list.get(i);
                                ++cont;
                                out.println("<tr>");
                                out.println("<td>" + a.getId() + "</td>");
                                out.println("<th></th>");
                                out.println("<td>" + a.getNome() + "</td>");
                                out.println("</tr>");


                                if (cont == 3) {
                                    break;
                                }

                            }
                            out.println("</table>");
                        }
                    %>
                    <p class="al"> <a href="ServletBusca?op=buscaAutores.jsp&paginaAnterior=0&paginas=1">Ver mais</a></p>
                </div>
            </div>

        </form>
    </body>
</html>
