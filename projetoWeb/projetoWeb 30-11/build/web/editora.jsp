<%
            if (session.getAttribute("isLogado") == null) {
                response.sendRedirect("login.jsp");
            }
%>
<%-- 
    Document   : editora
    Created on : 08/10/2011, 15:25:02
    Author     : Andressa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editora</title>
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
                <form action="ServletEditora" method="POST">
                    Editora:<br/>
                    <input type="text" name="nomeEditora" value="" size="40" />
                    <input type="submit" value="Salvar" name="op" /><br/><br/>
                    <input type="submit" value="Gerenciar" name="op" />

                </form>
            </div>
        </div>
    </body>
</html>
