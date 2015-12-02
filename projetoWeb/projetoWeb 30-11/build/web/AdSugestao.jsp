<%
            if (session.getAttribute("isLogado") == null) {
                response.sendRedirect("login.jsp");
            }
%>
<%-- 
    Document   : AdSugestao
    Created on : 10/10/2011, 20:06:47
    Author     : Andressa
--%>

<%@page import="java.util.List"%>
<%@page import="dao.Dao"%>
<%@page import="classes.Perfil"%>
<%@page import="classes.Sugestao"%>
<%@page import="classes.Util"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sugestao</title>
        <link href="admim.css" rel="stylesheet" type="text/css"/>
    </head>
    <body><div id="tudo">
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

                 <form action="ServletSugestao" method="POST"
              id="formSendFile" 
              name="formSendFile" 
              enctype="multipart/form-data"     
              >
                    <%
                        Dao<Sugestao> daoSugestao = new Dao<Sugestao>(Sugestao.class);
                        List<Sugestao> list = daoSugestao.list();
                        if (list != null) {
                            out.println("<table border=\"1\">");
                            out.println("<tr>");
                            out.println("<th> Sugestao </th>");
                            out.println("<th> Usuario </th>");
                            out.println("<th> Data </th>");
                            out.println("<th> Lida </th>");
                            out.println("<th> Salvar </th>");
                            out.println("</tr>");
                            for (Sugestao s : list) {
                                if (!s.isLida()) {
                                    out.println("<tr>");
                                    out.println("<td> " + s.getDica() + " </td>");
                                    out.println("<td> " + s.getPerfil().getNome() + " </td>");
                                    out.println("<td> " + Util.dateToString(s.getDataSug()) + " </td>");
                                    out.println("<td><input type=\"checkbox\" name=\"lida\" value=\"" + s.getId() + "\"/></td>");
                                    out.println("<td> <input type=\"submit\" value=\"Salvar\" name=\"op\" /></td>");


                                    out.println("</tr>");
                                }
                            }
                            out.println("</table>");
                        }
                    %>

                </form>
            </div>
        </div>
    </body>
</html>
