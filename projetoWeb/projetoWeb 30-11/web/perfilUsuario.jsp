<%-- 
    Document   : perfilUsuario
    Created on : 17/11/2011, 10:00:50
    Author     : a968552
--%>

<%@page import="classes.Util"%>
<%@page import="classes.Perfil"%>
<%@page import="dao.Dao"%>
<%@page import="java.util.List"%>
<%@page import="classes.Livro"%>
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
                            <li><a href="perfil.jsp"> Perfil</a></li>
                            <li><a href="ServletBusca?op=BuscaLivro.jsp&paginaAnterior=0&paginas=1"> Livros</a></li>
                            <li><a href="EditoraPerfil.jsp"> Editoras </a> </li>
                            <li><a href="PerfilAutores.jsp"> Autores</a></li>
                            <li> <a href="sugestao.jsp"> Sugestao</a> </li>
                        </ul>
                    </div>
                </div>
                <div  id="blocop">

                    <div id="blocoMeusLivros">
                        <h4>Perfil do Usuario</h4>

                        <%
                            out.println("<h5>  Nome: " + p.getNome() + "</h5>");
                            out.println("<h5>  Email: " + p.getEmail() + "</h5>");
                            out.println("<h5>  Sexo: " + p.getSexo() + "</h5>");
                            out.println("<h5>  Data Nacimento: " + Util.dateToString(p.getDataNasc()) + "</h5>");
                            out.println("<h5>  Cidade: " + p.getCidade() + "</h5>");
                            out.println("<h5>  Estado: " + p.getEstado().getNome() + "</h5>");

                        %>
                        <p class="al"> <a href="LoginServlet?op=editar">Editar</a></p>

                    </div>
                </div>
            </div>

        </form>
    </body>
</html>
