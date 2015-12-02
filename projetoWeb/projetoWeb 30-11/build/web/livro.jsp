<%
            if (session.getAttribute("isLogado") == null) {
                response.sendRedirect("login.jsp");
            }
%>
<%-- 
    Document   : Livro
    Created on : 08/10/2011, 17:18:09
    Author     : Andressa
--%>

<%@page import="java.util.List"%>
<%@page import="dao.Dao"%>
<%@page import="classes.Livro"%>
<%@page import="classes.Autor"%>
<%@page import="classes.Editora"%>
<%@page import="classes.Categoria"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Livro</title>
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
            <form action="ServletLivro" method="POST"
                  id="formSendFile"
                  name="formSendFile"
                  enctype="multipart/form-data" >
                <div id="bLivro">
                    <%
                        Dao<Livro> daoLivro = new Dao<Livro>(Livro.class);
                        Dao<Categoria> daoCAtegoria = new Dao<Categoria>(Categoria.class);
                        List<Categoria> categorias = daoCAtegoria.list();
                        Dao<Editora> daoEditora = new Dao<Editora>(Editora.class);
                        List<Editora> editoras = daoEditora.list();
                        String nome = (String) session.getAttribute("nome");
                        String sinopse = (String) session.getAttribute("sinopse");
                        Categoria categoria = (Categoria) session.getAttribute("categoria");
                        Editora editora = (Editora) session.getAttribute("editora");
                        String ano = (String) session.getAttribute("ano");
                        List<Autor> autores = (List<Autor>) session.getAttribute("autores");
                        if (nome != null) {
                            out.println("Nome:<br/>"
                                    + "<input type=\"text\" name=\"nome\" value=\"" + nome + "\" /><br/><br/>");
                        }
                        if (ano != null) {
                            out.println("Ano:<br/>"
                                    + "<input type=\"text\" name=\"ano\" value=\"" + ano + "\" size=\"4\" maxlength=\"4\" /><br/><br/>");
                        }

                        if (sinopse != null) {
                            out.println("Sinopse:<br/>"
                                    + "<textarea name=\"sinopse\" rows=\"10\" cols=\"50\">");

                            out.println(sinopse);
                            out.println("</textarea> <br/><br/>");
                        }


                        if (categoria != null) {
                            out.println("Categoria:");
                            out.println("<select name=\"categoria\">");
                            out.println("<br/>");

                            if (!categorias.isEmpty()) {
                                
                                out.println("<option value=\"" + categoria.getId() + "\">" + categoria.getNome() + "</option>");
                                for (Categoria c : categorias) {
                                    out.println("<option value=\"" + c.getId() + "\">" + c.getNome() + "</option>");
                                }
                            }

                            out.println("</select> <br/><br/> ");
                        }


                        if (editora != null) {
                            out.println("Editora:");

                            out.println("<select name=\"editora\">");

                            if (!editoras.isEmpty()) {
                                out.println("<option value=\"" + editora.getId() + "\">" + editora.getNome() + "</option>");
                                for (Editora e : editoras) {
                                    out.println("<option value=\"" + e.getId() + "\">" + e.getNome() + "</option>");
                                }
                            }

                            out.println("</select> <br/><br/> ");
                        }


                        if (autores != null) {
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
                                    out.println("<td> <a href=\"ServletLivro?op=removerAutor&id=" + a.getId() + "\">Remover</a>  </td>");
                                    out.println("</tr>");
                                }

                            }
                            out.println("</table>");
                            out.println("<input type=\"submit\" value=\"addAutor\" name=\"op\"/>  <br/><br/>");

                            out.println("Foto:<br/>");
                            out.println("<input name=\"imagem\" type=\"file\" value=\"\" maxlength=\"60\"  /><br/><br/>");

                            out.println("<input type=\"submit\" value=\"Inserir\" name=\"op\"/> <br/><br/> ");
                        }
                        if (autores == null) {

                    %>
                    Nome:<br/>
                    <input type="text" name="nome" value="" /><br/><br/>

                    Ano:<br/>
                    <input type="text" name="ano" value="" size="4" maxlength="4"/><br/><br/>

                    Sinopse:<br/>
                    <textarea name="sinopse" rows="10" cols="50">
                    </textarea> <br/><br/>

                    Categoria:<br/>
                    <select name="categoria">
                        <%
                            out.println("<option value=\"-1\">Escolha uma categoria </option>");
                            if (!categorias.isEmpty()) {
                                for (Categoria c : categorias) {
                                    out.println("<option value=\"" + c.getId() + "\"> " + c.getNome() + " </option>");
                                }
                            }
                        %>
                    </select> <br/><br/>

                    Editora:<br/>
                    <select name="editora">
                        <%

                            out.println("<option value=\"-1\">Escolha uma Editora </option>");
                            if (!editoras.isEmpty()) {
                                for (Editora e : editoras) {
                                    out.println("<option value=\"" + e.getId() + "\"> " + e.getNome() + " </option>");
                                }
                            }

                        %>
                    </select> <br/><br/>

                    Autor(es) Adicionados:<br/>

                    <%
                        out.println("Adicione Algum Autor! ");
                    %>

                    <input type="submit" value="addAutor" name="op" />  <br/><br/>

                    Foto:<br/>
                    <input name="imagem" type="file" value=""  maxlength="60"    /> <br/><br/>

                    <input type="submit" value="Inserir" name="op"/><br><br/>
                </div>

                <div id="b1Livro">
                    <input type="submit" value="Gerenciar" name="op"/><br><br/>
                </div>
                <%  }//fechamneto%>
            </form>
        </div>

    </div>

    </body>
</html>
