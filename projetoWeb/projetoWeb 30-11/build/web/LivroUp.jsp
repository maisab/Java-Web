<%
            if (session.getAttribute("isLogado") == null) {
                response.sendRedirect("login.jsp");
            }
%>
<%-- 
    Document   : LivroUp
    Created on : 09/10/2011, 13:02:21
    Author     : Andressa
--%>

<%@page import="java.util.List"%>
<%@page import="classes.Livro"%>
<%@page import="classes.Categoria"%>
<%@page import="dao.Dao"%>
<%@page import="classes.Autor"%>
<%@page import="classes.Editora"%>
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
                    <%
                        Livro l = (Livro) session.getAttribute("livro");
                        if (l != null) {
                    %>
                    Nome:<br/>
                    <%
                            out.println("<input type=\"text\" name=\"nome\" value=\"" + l.getNome() + "\" /><br/><br/>");%> 

                    Ano:<br/>
                    <%
                        out.println("<input type=\"text\" name=\"ano\" value=\"" + l.getAno() + "\" size=\"4\" maxlength=\"4\"/><br/><br/>");
                    %> 


                    Sinopse:<br/>
                    <% out.println(" <textarea name=\"sinopse\" rows=\"10\" cols=\"50\">"+l.getSinopse()+"</textarea> <br/><br/>");%>


                    Categoria:<br/>
                    <select name="categoria">
                        <%
                            Dao<Categoria> daoCAtegoria = new Dao<Categoria>(Categoria.class);
                            out.println("<option value=\"" + l.getCategoria().getId() + "\">" + l.getCategoria().getNome() + " </option>");
                            if (daoCAtegoria.list().isEmpty()) {
                                for (Categoria c : daoCAtegoria.list()) {
                                    out.println("<option value=\"" + c.getId() + "\"> " + c.getNome() + " </option>");
                                }
                            }
                        %>
                    </select> <br/><br/>

                    Editora:<br/>
                    <select name="editora">
                        <%
                            Dao<Editora> daoEditora = new Dao<Editora>(Editora.class);
                            out.println("<option value=\"" + l.getEditora().getId() + "\">" + l.getEditora().getNome() + "</option>");
                            if (daoEditora.list().isEmpty()) {
                                for (Editora e : daoEditora.list()) {
                                    out.println("<option value=\"" + e.getId() + "\"> " + e.getNome() + " </option>");
                                }
                            }

                        %>
                    </select> <br/><br/>

                    Autor(es) Adicionados:<br/>

                    <%
                    List<Autor> autores=(List<Autor>) session.getAttribute("autores");
                        out.println("Autor(es):");
                        out.println("<table border=\"1\">");
                        if (!autores.isEmpty()) {
                            out.println("<tr>");
                            out.println("<th> Nome: </th>");
                            out.println("<th> Operação: </th>");
                            out.println("</tr>");
                            for (Autor a : autores) {
                                out.println("<tr>");
                                out.println("<td>" + a.getNome() + "</td>");
                                out.println("<td> <a href=\"ServletAtualizaLivro?op=removerAutor&id=" + a.getId() + "\">Remover</a>  </td>");
                                out.println("</tr>");
                            }
                        }
                         out.println("</table>");
                    %>

                    <input type="submit" value="addAutor" name="op" />  <br/><br/>

                    Foto:<br/>
                    <%
                        out.println("<input name=\"imagem\" type=\"file\" value=\"files/"+l.getFoto()+"\"  maxlength=\"60\"/> <br/><br/>");
                    %>
                    <input type="submit" value="Atualizar" name="op"/><br><br/>
                    <%}%>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
