<%
            if (session.getAttribute("isLogado") == null) {
                response.sendRedirect("login.jsp");
            }
%>
<%-- 
    Document   : autores
    Created on : 08/10/2011, 15:48:36
    Author     : Andressa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Autor</title>
        <script type="text/javascript"  language="javascript">
            function barra(objeto){
            if (objeto.value.length == 2 || objeto.value.length == 5 ){
            objeto.value = objeto.value+"/";
            }

            }
        </script>
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
                <form action="ServletAutores" method="POST">

                    Nome:<br/>
                    <input type="text" name="nome" value="" size="50" /><br/><br/>

                    Data de Nascimento:<br/>
                    <input type="text" name="data" value="" onkeyup="barra(this)" maxlength="10" size="10"/><br/><br/>

                    Descrição:<br/>
                    <textarea name="descricao" rows="10" cols="30"> </textarea> <br/>
                    <br/>
                    <input type="submit" value="Inserir" name="op"/><br/><br/>
                    <input type="submit" value="Gerenciar" name="op"/>
                </form>
            </div>
        </div>
    </body>
</html>
