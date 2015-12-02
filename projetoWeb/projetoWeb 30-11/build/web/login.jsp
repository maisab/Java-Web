<%-- 
    Document   : PaginaInicial
    Created on : 25/08/2011, 10:43:23
    Author     : aluno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body >
        <div id="tela">
            <div id="b1"> </div> 

            <div id="b2">

                <div id="form-login">  
                    <h1>Seja Bem-vindo</h1>   
                    <form action="LoginServlet" method="POST">
                        <br/>Login:
                        <input type="text" name="login" value="" />
                        <br/>Senha:
                        <input type="password" name="senha" value=""/>
                        <br/><input type="submit" value="Enviar" name="op" style="width: 100px;"/>
                        <br/><br/>Não possui cadastro? <a href="LoginServlet?op=cadastro">Cadastre-se</a> já :)
                    </form>
                </div>

            </div>
            <div id="b3">
            </div>   
        </div>
    </body>
</html>
