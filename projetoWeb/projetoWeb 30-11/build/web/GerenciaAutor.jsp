
<%
            if (session.getAttribute("isLogado") == null) {
                response.sendRedirect("login.jsp");
            }
%>
<%-- 
    Document   : GerenciaAutor
    Created on : 08/10/2011, 16:07:16
    Author     : Andressa
--%>

<%@page import="classes.Util"%>
<%@page import="dao.Dao"%>
<%@page import="java.util.List"%>
<%@page import="classes.Autor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gerenciar Autor</title>
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
                    <div  id="b">
                        Buscar autor:<br/>
                        <input type="text" name="nomeBusca" value="" size="40" />
                        <input type="submit" value="Buscar" name="op" />
                        <%
                            String nome = (String) session.getAttribute("nomeBusca");
                            dao.Dao<Autor> daoc = new Dao<Autor>(Autor.class);
                            List<Autor> list;
                            if (nome.equals("nao")) {
                                list = null;
                            }
                            if (nome.equals("")) {
                                list = daoc.list();
                            } else {
                                list = daoc.listbyNome(nome);
                            }
                            if (!list.isEmpty()) {
                                out.println("<br/><br/>Editoras Encontradas:");

                                out.println("<table border=\"1\">");
                                out.println("<tr>");
                                out.println("<th>Id</th>");
                                out.println("<th>Nome</th>");
                                out.println("<th>Descrição</th>");
                                out.println("<th colspan=\"2\">Operadores</th>");
                                out.println("</tr");
                                for (Autor c : list) {
                                    out.println("<tr>");
                                    out.println("<td>" + c.getId() + "</td>");
                                    out.println("<td>" + c.getNome() + "</td>");
                                    out.println("<td>" + c.getDescricao() + "</td>");
                                    out.println("<td><a href=\"ServletAutores?id=" + c.getId() + "&op=Remover\">Remover</a></td>");
                                    out.println("<td><a href=\"ServletAutores?id=" + c.getId() + "&op=Atualizar\">Editar</a></td>");
                                    out.println("</tr>");
                                }
                                out.println("</table>");
                            }
                        %>
                    </div>
                    <div  id="b1">

                        <%
                        String remover = (String) session.getAttribute("remover");
                            if ("nao".equals(remover)) {
                                out.print("<div id=\"blocoremover\">");
                                out.print("Este autor nao pode ser removido!\n Ha livros cadastrados");
                                out.println("<br/><input type=\"submit\" value=\"Ok\" name=\"op\" />");
                                out.print("</div>");
                            }
                            Autor c = (Autor) session.getAttribute("autor");
                            if (c != null) {
                                out.println("Nome:<br/>");
                                out.println("<input type=\"text\" name=\"nomeA\" value=\"" + c.getNome() + "\" size=\"40\" /> <br/>");
                                out.println("<br/>Data de Nascimento :<br/>");
                                out.println("<input type=\"text\" name=\"data\" value=\""+Util.dateToString(c.getDataNasc())+"\" onkeyup=\"barra(this)\" maxlength=\"10\" size=\"10\"/> <br/>");
                                out.println("<br/>Descriçao:<br/>");
                                out.println("<textarea name=\"descricao\" rows=\"10\" cols=\"30\">"+c.getDescricao()+"</textarea> <br/>");
                                out.println("<br/><input type=\"submit\" value=\"Atualizar\" name=\"op\" />");

                            }%>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
