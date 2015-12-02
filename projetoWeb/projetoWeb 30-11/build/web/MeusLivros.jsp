<%-- 
    Document   : MuesLivros
    Created on : 16/11/2011, 20:36:11
    Author     : Andressa
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="classes.Perfil"%>
<%@page import="dao.Dao"%>
<%@page import="java.util.List"%>
<%@page import="classes.Livro"%>
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
                    <button type="submit" value="MeusLivros.jsp" name="op">Pesquisar</button>
                    <hr/>
                    <h4>Meus Livros:</h4>
                    <%
                        String busca = (String) session.getAttribute("BuscaLivroNome");

                        dao.Dao<Livro> daoc = new Dao<Livro>(Livro.class);
                        List<Livro> list = new ArrayList<Livro>();
                        List<Livro> lista = null;

                        lista = p.getLivros();
                        if (!busca.equals("")) {
                            for (Livro l : lista) {
                                if (l.getNome().contains(busca)) {
                                    list.add(l);
                                }
                            }
                        } else {
                            list = p.getLivros();
                        }

                        int paginas = (Integer) session.getAttribute("paginaatual");
                        int paginaA = (Integer) session.getAttribute("paginaAnterior");
                        int quantidade = (Integer) session.getAttribute("quantidadepaginas");
                        //Paginação aqui 13 por pagina
                        if (!list.isEmpty()) {
                            if ((paginas + 1) * 2 > list.size()) {
                                int cont = 0;
                                for (int i = (paginas * 2 - 2); i < list.size(); i++) {
                                    ++cont;
                                    if (cont == 3) {
                                        break;
                                    }
                                    Livro l = list.get(i);

                                    out.println("<div id=\"blocolivro\">");

                                    //64px a imagem
                                    out.println("<p class=\"p\">" + l.getNome() + " </p> ");
                                    out.println("<p class=\"img\"><img src=\"files/" + l.getFoto() + "\"></p> ");

                                    out.println("<p class=\"al1 \"><a href=\"ServletDetalhes?voltar=MeusLivros.jsp&op=detalhes&id=" + l.getId() + "\">Ver detalhes</a></p>");
                                    out.println("</div>");
                                }
                            } else {
                                for (int i = (paginas * 2 - 2); i < paginas * 2; i++) {


                                    Livro l = list.get(i);
                                    out.println("<div id=\"blocolivro\">");
                                    //64px a imagem
                                    out.println("<p class=\"p\">" + l.getNome() + " </p> ");
                                    out.println("<p class=\"img\"><img src=\"files/" + l.getFoto() + "\"></p> ");

                                    out.println("<p class=\"al1 \"><a href=\"ServletDetalhes?voltar=MeusLivros.jsp&op=detalhes&id=" + l.getId() + "\">Ver detalhes</a></p>");
                                    out.println("</div>");
                                }
                            }



                        }
                    %>
                    <div id="blocopaginacao">
                        <%
                            int pA = paginaA;
                            int pag = paginas;
                            if (paginas == 1) {
                                if (list.size() <= 2) {
                                    return;
                                }
                                out.println("<a href=\"ServletBusca?op=MeusLivros.jsp&paginaAnterior=1&paginas=" + (++paginas) + " \"> > </a>");
                            } else {

                                if (paginas == quantidade) {
                                    out.println("<a href=\"ServletBusca?op=MeusLivros.jsp&paginaAnterior=" + --paginaA + "&paginas=" + --paginas + " \"> < </a>");

                                } else {
                                    out.print("<a href=\"ServletBusca?op=MeusLivros.jsp&paginaAnterior=" + (--paginaA) + "&paginas=" + (--paginas) + " \"> < </a> "
                                            + "<a href=\"ServletBusca?op=MeusLivros.jsp&paginaAnterior=" + (++pA) + "&paginas=" + (++pag) + " \"> > </a>");

                                }
                            }
                        %>
                    </div> 
                </div>
            </div>

        </form>
    </body>
</html>
