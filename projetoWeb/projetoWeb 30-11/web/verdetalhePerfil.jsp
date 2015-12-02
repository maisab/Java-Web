<%-- 
    Document   : verdetalhePerfil
    Created on : 16/11/2011, 21:32:13
    Author     : Andressa
--%>

<%@page import="classes.Util"%>
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
        <form action="LoginServlet" method="POST"
              id="formSendFile" 
              name="formSendFile" 
              enctype="multipart/form-data"     
              >
            <%
                Perfil p = (Perfil) session.getAttribute("perfildetalhe");
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
                    <h2><%out.println(p.getNome());%></h2>
                    <br/>
                    <br/>
                    <h4>Email:</h4>
                    <p><%out.println(p.getEmail());%></p>
                    <h4>Data de nascimento:</h4>
                    <p><%out.println(Util.dateToString(p.getDataNasc()));%></p>
                    <h4>Cidade:</h4>
                    <p><%out.println(p.getCidade());%></p>
                    <h4>Estado</h4>
                    <p><%out.println(p.getEstado().getNome());%></p>
                    <%String pagina = (String) session.getAttribute("voltar");%>
                    <p class="center"> <a href="<%out.println(pagina);%>">Voltar</a></p>
                </div>

            </div>

        </form>
    </body>
</html>
