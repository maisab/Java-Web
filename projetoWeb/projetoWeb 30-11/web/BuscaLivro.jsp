<%-- 
    Document   : BuscaLivro
    Created on : 10/11/2011, 07:50:26
    Author     : a968307
--%>

<%@page import="com.sun.org.apache.bcel.internal.generic.BREAKPOINT"%>
<%@page import="java.util.List"%>
<%@page import="dao.Dao"%>
<%@page import="classes.Livro"%>
<%@page import="classes.Perfil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
                    <h4>Livros:</h4>
                    <%
                        String busca = (String) session.getAttribute("BuscaLivroNome");

                        dao.Dao<Livro> daoc = new Dao<Livro>(Livro.class);
                        List<Livro> list = null;
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
                            if ((pagina + 1) * 2 > list.size()) {
                                int cont = 0;
                                for (int i = (pagina * 2 - 2); i < list.size(); i++) {
                                    ++cont;
                                    if (cont == 3) {
                                        break;
                                    }
                                    Livro l = list.get(i);
                                    out.println("<div id=\"blocolivro\">");
                                    //64px a imagem
                                    out.println("<p class=\"p\">" + l.getNome() + " </p> ");
                                    out.println("<p class=\"img\"><img src=\"files/" + l.getFoto() + "\"></p> ");

                                    out.println("<p class=\"al1 \"><a href=\"ServletDetalhes?voltar=BuscaLivro.jsp&op=detalhes&id=" + l.getId() + "\">Ver detalhes</a></p>");
                                    out.println("</div>");

                                }





                            } else {
                                for (int i = (pagina * 2 - 2); i < pagina * 2; i++) {


                                    Livro l = list.get(i);
                                    out.println("<div id=\"blocolivro\">");
                                    //64px a imagem
                                    out.println("<p class=\"p\">" + l.getNome() + " </p> ");
                                    out.println("<p class=\"img\"><img src=\"files/" + l.getFoto() + "\"></p> ");

                                    out.println("<p class=\"al1 \"><a href=\"ServletDetalhes?voltar=BuscaLivro.jsp&op=detalhes&id=" + l.getId() + "\">Ver detalhes</a></p>");
                                    out.println("</div>");
                                }
                            }
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
                                out.println("<a href=\"ServletBusca?op=BuscaLivro.jsp&paginaAnterior=1&paginas=" + (++pagina) + " \"> > </a>");
                            } else {

                                if (pagina == quantidade) {
                                    out.println("<a href=\"ServletBusca?op=BuscaLivro.jsp&paginaAnterior=" + --paginaA + "&paginas=" + --pagina + " \"> < </a>");

                                } else {
                                    out.print("<a href=\"ServletBusca?op=BuscaLivro.jsp&paginaAnterior=" + (--paginaA) + "&paginas=" + (--pagina) + " \"> < </a> "
                                            + "<a href=\"ServletBusca?op=BuscaLivro.jsp&paginaAnterior=" + (++pA) + "&paginas=" + (++pag) + " \"> > </a>");

                                }
                            }


                        %>
                    </div>
                </div>

            </div>

        </form>
    </body>
</html>
