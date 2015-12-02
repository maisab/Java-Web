<%
    if (session.getAttribute("isLogado") == null) {
        response.sendRedirect("login.jsp");
    }
%>

<%--     Document   : sugestao
    Created on : 05/10/2011, 21:34:41
    Author     : Barreto
--%>

<%@page import="classes.Perfil"%>
<%@page import="classes.Util"%>
<%@page import="java.util.List"%>
<%@page import="dao.Dao"%>
<%@page import="classes.Sugestao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sugestao</title>
        <link href="newstyle.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <form action="ServletSugestao" method="POST"
              id="formSendFile" 
              name="formSendFile" 
              enctype="multipart/form-data"     
              >
            <%
                Perfil pe = (Perfil) session.getAttribute("perfil");
            %>
            <div id="tudo">
                <div id="header">
                    <div id="sair">
                        <a href="LoginServlet?op=sair">Sair</a>
                    </div>
                    <div id="logo">
                    </div>
                </div>

                <div id="blocodetalhes">
                    <div id="blocoFoto"> <img src="files/<% out.println(pe.getFoto());%>" /></div>
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
                <div  id="blocop"><h2>Sugestoes:</h2>

                    Sugestão:<br/>
                    <textarea name="sugestao" rows="10" cols="50"> 
                    </textarea> <br/><br/> 
                    <input type="submit" value="Enviar" name="op" /> <br/>
                    <hr/>
                    <%
                        Perfil p = (Perfil) session.getAttribute("perfil");
                        Dao<Sugestao> daoSugestao = new Dao<Sugestao>(Sugestao.class);
                        List<Sugestao> list = daoSugestao.list();

                        if (list != null) {

                            out.println("<table border=\"1\">");
                            out.println("<tr>");
                            out.println("<th> Sugestao </th>");
                            out.println("<th> Data </th>");
                            out.println("<th> Status </th>");
                            out.println("<th> Operaçao </th>");
                            out.println("</tr>");

                            for (Sugestao s : list) {
                                if (s.getPerfil().getId() == p.getId()) {
                                    out.println("<tr>");
                                    out.println("<td> " + s.getDica() + " </td>");
                                    out.println("<td> " + Util.dateToString(s.getDataSug()) + " </td>");
                                    if (s.isLida()) {
                                        out.println("<td> Lida </td>");
                                    } else {
                                        out.println("<td> Não Lida </td>");
                                    }
                                    out.println("<td><a href=\"ServletSugestao?id=" + s.getId() + "\">Remover</a></td>");
                                    out.println("</tr>");
                                }
                            }
                            out.println("</table>");
                        }
                    %></div>
            </div>

        </form>
    </body>
</html>
