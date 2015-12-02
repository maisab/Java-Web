<%-- 
    Document   : leitores
    Created on : 16/11/2011, 21:09:49
    Author     : Andressa
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="classes.Livro"%>
<%@page import="classes.Perfil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Leitores</title>
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
                Livro l = (Livro) session.getAttribute("livro");
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
                    <button type="submit" value="leitores.jsp" name="op">Pesquisar</button>
                    <hr/>
                    <h4>Leitores:</h4>
                    <%
                        String busca = (String) session.getAttribute("BuscaLivroNome");
                        List<Perfil> lista = new ArrayList<Perfil>();
                        List<Perfil> list = new ArrayList<Perfil>();
                        lista = l.getPerfil();


                        if (!busca.equals("")) {
                            for (Perfil perfil : lista) {
                                if (perfil.getNome().contains(busca)) {
                                    list.add(perfil);
                                }
                            }
                        } else {
                            list = lista;
                        }
                        list.remove(p);
                        int pagina = (Integer) session.getAttribute("paginaatual");
                        int paginaA = (Integer) session.getAttribute("paginaAnterior");

                        int quantidade = (Integer) session.getAttribute("quantidadepaginas");

                        if (!list.isEmpty()) {
                            int cont = 0;
                            if ((pagina + 1) * 2 > list.size()) {
                                for (int i = (pagina * 2 - 2); i < list.size(); i++) {
                                    Perfil perfil = list.get(i);

                                    ++cont;
                                    if (cont == 3) {
                                        break;
                                    }
                                    out.println("<div id=\"blocolivro\">");

                                    //64px a imagem
                                    out.println("<p class=\"p\">" + perfil.getNome() + " </p> ");
                                    out.println("<p class=\"img\"><img width=\"64px\" height=\"64px\" src=\"files/" + perfil.getFoto() + "\"></p> ");

                                    out.println("<p class=\"al1 \"><a href=\"ServletVerPerfil?pagina=leitores.jsp&op=detalhes&id=" + perfil.getId() + "\">Ver detalhes</a></p>");
                                    out.println("</div>");
                                }
                            } else {
                                for (int i = (pagina * 2 - 2); i < pagina * 2; i++) {
                                    Perfil perfil = list.get(i);

                                    out.println("<div id=\"blocolivro\">");

                                    //64px a imagem
                                    out.println("<p class=\"p\">" + perfil.getNome() + " </p> ");
                                    out.println("<p class=\"img\"><img width=\"64px\" height=\"64px\" src=\"files/" + perfil.getFoto() + "\"></p> ");

                                    out.println("<p class=\"al1 \"><a href=\"ServletVerPerfil?pagina=leitores.jsp&op=detalhes&id=" + perfil.getId() + "\">Ver detalhes</a></p>");
                                    out.println("</div>");
                                }
                            }
                        }

                    %>
                    <div id="blocopaginacao">
                        <%

                            int pA = paginaA;
                            int pag = pagina;
                            if (pagina == 1) {
                                if (list.size() <= 2) {
                                    return;
                                }
                                out.println("<a href=\"ServletBusca?op=leitores.jsp&paginaAnterior=1&paginas=" + (++pagina) + " \"> > </a>");
                            } else {

                                if (pagina == quantidade) {
                                    out.println("<a href=\"ServletBusca?op=leitores.jsp&paginaAnterior=" + --paginaA + "&paginas=" + --pagina + " \"> < </a>");

                                } else {
                                    out.print("<a href=\"ServletBusca?op=leitores.jsp&paginaAnterior=" + (--paginaA) + "&paginas=" + (--pagina) + " \"> < </a> "
                                            + "<a href=\"ServletBusca?op=leitores.jsp&paginaAnterior=" + (++pA) + "&paginas=" + (++pag) + " \"> > </a>");

                                }
                            }


                        %>
                    </div>
                </div>
            </div>

        </form>
    </body>
</html>
