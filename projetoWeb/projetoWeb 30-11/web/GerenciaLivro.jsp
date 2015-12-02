<%
            if (session.getAttribute("isLogado") == null) {
                response.sendRedirect("login.jsp");
            }
%>
<%-- 
    Document   : GerenciaLivro
    Created on : 08/10/2011, 17:57:54
    Author     : Andressa
--%>

<%@page import="classes.Autor"%>
<%@page import="classes.Categoria"%>
<%@page import="java.util.List"%>
<%@page import="dao.Dao"%>
<%@page import="classes.Livro"%>
<%@page import="classes.Editora"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gerenciar Livros</title>
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
            <div id="blocomenuLivro">
                <ul>
                    <li><a href="categoria.jsp"> Categoria</a></li>
                    <li><a href="editora.jsp"> Editora </a> </li>
                    <li><a href="autores.jsp"> Autores</a></li>
                    <li><a href="livro.jsp"> Livros</a></li>
                    <li> <a href="AdSugestao.jsp"> Sugestao</a> </li>

                </ul>
                <img src="images/logo.jpg"/>
            </div>
            <div id="bodyLivro">
                <form action="ServletAtualizaLivro" method="POST"
                      id="formSendFile"
                      name="formSendFile"
                      enctype="multipart/form-data" >
                    <div  id="bLivro">
                        Buscar livro:<br/>
                        <input type="text" name="nomeBusca" value="" size="40" />
                        <input type="submit" value="Buscar" name="op" />
                        
                        <%
                            String nomeB = (String) session.getAttribute("nomeBusca");
                            dao.Dao<Livro> daoc = new Dao<Livro>(Livro.class);
                            List<Livro> list;
                            if (nomeB.equals("nao")) {
                                list = null;
                            }
                            if (nomeB.equals("")) {
                                list = daoc.list();
                            } else {
                                list = daoc.listbyNome(nomeB);
                            }
                            if (!list.isEmpty()) {
                                out.println("<br/><br/>Livros Encontradas:");

                                out.println("<table border=\"1\">");
                                out.println("<tr>");
                                out.println("<th> Foto </th>");
                                out.println("<th> Nome </th>");
                                out.println("<th> Ano </th>");

                                out.println("<th colspan=\"2\"> Operação </th>");
                                out.println("</tr>");
                                
                                for (Livro l : list) {
                                    out.println("<tr>");
                                    out.println("<td> <img src=\"files/" + l.getFoto() + "\" /></td>");
                                    out.println("<td> " + l.getNome() + " </td>");
                                    out.println("<td> " + l.getAno() + " </td>");

                                    out.println("<td> <a href=\"ServletAtualizaLivro?op=editarLivro&id=" + l.getId() + "\">Editar</a> </td>");
                                    out.println("<td> <a href=\"ServletAtualizaLivro?op=removerLivro&id=" + l.getId() + "\">Remover</a> </td>");
                                    out.println("</tr>");
                                }
                                out.println("</table>");
                            }
                        %>
                    </div>
                   
                </form>
            </div>
        </div>
    </body>
</html>
