<%-- 
    Document   : buscaAutores
    Created on : 30/11/2011, 20:19:30
    Author     : Andressa
--%>

<%@page import="classes.Perfil"%>
<%@page import="dao.Dao"%>
<%@page import="java.util.List"%>
<%@page import="classes.Autor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Busca de Autores</title>
        <link href="newstyle.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <form action="ServletBusca" method="POST"
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
                    <input type="text" name="nome" value="" size="50"/>
                    <button type="submit" value="BuscaLivro.jsp" name="op">Pesquisar</button>

                    <hr/>

                    <%
                        String busca = (String) session.getAttribute("BuscaLivroNome");

                        dao.Dao<Autor> daoc = new Dao<Autor>(Autor.class);
                        List<Autor> list = null;
                        if (!busca.equals("")) {
                            list = daoc.listbyNome(busca);
                        } else {
                            list = daoc.list();

                        }
                        int pagina = (Integer) session.getAttribute("paginaatual");
                        int paginaA = (Integer) session.getAttribute("paginaAnterior");

                        int quantidade = (Integer) session.getAttribute("quantidadepaginas");

                        //Paginação aqui 13 por pagina
                        if (!list.isEmpty()) {
                            out.println("<table style=\"font-size:medium\">");
                            out.println("<tr>");
                            out.println("<th>Id</th>");
                            out.println("<th></th>");
                            out.println("<th>Editora</th>");
                            out.println("</tr");
                            if ((pagina + 1) * 2 > list.size()) {
                                int cont = 0;
                                for (int i = (pagina * 2 - 2); i < list.size(); i++) {
                                    ++cont;
                                    if (cont == 3) {
                                        break;
                                    }

                                    Autor ed = list.get(i);

                                    out.println("<tr>");
                                    out.println("<td>" + ed.getId() + "</td>");
                                    out.println("<th></th>");
                                    out.println("<td>" + ed.getNome() + "</td>");
                                    out.println("</tr>");
                                }





                            } else {
                                for (int i = (pagina * 2 - 2); i < pagina * 2; i++) {


                                    Autor ed = list.get(i);

                                    out.println("<tr>");
                                    out.println("<td>" + ed.getId() + "</td>");
                                    out.println("<th></th>");
                                    out.println("<td>" + ed.getNome() + "</td>");
                                    out.println("</tr>");
                                }
                            }
                            out.println("</table>");
                        }
                    %>
                    <br/>
                    <div id="blocopaginacao">
                        <%

                            int pA = paginaA;
                            int pag = pagina;
                            if (pagina == 1) {
                                if (list.size() <= 2) {
                                    return;
                                }
                                out.println("<a href=\"ServletBusca?op=buscaAutores.jsp&paginaAnterior=1&paginas=" + (++pagina) + " \"> > </a>");
                            } else {

                                if (pagina == quantidade) {
                                    out.println("<a href=\"ServletBusca?op=buscaAutores.jsp&paginaAnterior=" + --paginaA + "&paginas=" + --pagina + " \"> < </a>");

                                } else {
                                    out.print("<a href=\"ServletBusca?op=buscaAutores.jsp&paginaAnterior=" + (--paginaA) + "&paginas=" + (--pagina) + " \"> < </a> "
                                            + "<a href=\"ServletBusca?op=buscaAutores.jsp&paginaAnterior=" + (++pA) + "&paginas=" + (++pag) + " \"> > </a>");

                                }
                            }


                        %>
                    </div>
                </div>

            </div>

        </form>
    </body>
</html>
