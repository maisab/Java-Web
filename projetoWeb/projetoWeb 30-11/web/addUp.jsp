<%
            if (session.getAttribute("isLogado") == null) {
                response.sendRedirect("login.jsp");
            }
%>
<%-- 
    Document   : addUp
    Created on : 09/10/2011, 14:53:16
    Author     : Andressa
--%>

<%@page import="dao.Dao"%>
<%@page import="java.util.List"%>
<%@page import="classes.Autor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="admim.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
       <div id="tudo">
            <div id="header">
                <div id="logo">
                    <div id="sair">
                        <a href="LoginServlet?op=sair">Sair</a>
                    </div>
                </div>
            </div>    

            <div id="blocomenu">
                <ul>
                    <li><a href="categoria.jsp"> Categoria</a></li>
                    <li><a href="editora.jsp"> Editora </a> </li>
                    <li><a href="autores.jsp"> Autores</a></li>
                    <li><a href="livro.jsp"> Livros</a></li>
                    <li> <a href="AdSugestao.jsp"> Sugestao</a> </li>

                </ul>
                <img src="images/logo.jpg"/>
            </div>
            <div id="body2">
                <table border="1">
                    <tr>
                        <th>Nome</th>  
                    </tr>
                    <%

                        Dao<Autor> daoAutor = new Dao<Autor>(Autor.class);
                        List<Autor> autores = daoAutor.list();
                        if (!autores.isEmpty()) {
                            for (Autor a : autores) {
                                out.println("<tr>");
                                out.println("<td>" + a.getNome() + "<td>");
                                out.println("<a href=\"ServletAtualizaLivro?op=inserirAutor&id=" + a.getId() + "\">Inserir</a>");
                                out.println("</tr>");
                            }
                        }

                    %>
                </table>
            </div>
        </div>
    </body>
</html>
