<%
            if (session.getAttribute("isLogado") == null) {
                response.sendRedirect("login.jsp");
            }
%>
<%-- 
    Document   : index
    Created on : 07/10/2011, 15:25:43
    Author     : Andressa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>Inicio</title>
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
            </div>
        </div>


    </body>
</html>
