<%-- 
    Document   : perfilUp
    Created on : 17/11/2011, 09:50:59
    Author     : a968552
--%>

<%@page import="java.util.List"%>
<%@page import="dao.Dao"%>
<%@page import="java.util.List"%>
<%@page import="classes.Estado"%>
<%@page import="classes.Util"%>
<%@page import="classes.Perfil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil</title>
        <script type="text/javascript"  language="javascript">
            function barra(objeto){
                if (objeto.value.length == 2 || objeto.value.length == 5 ){
                    objeto.value = objeto.value+"/";
                }

            }

        </script>
        <link href="newstyle.css" rel="stylesheet" type="text/css"/>
    </head>

    <body>
        <form action="ServletPerfilUp" method="POST"
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
                    <p class="acesso">
                        <% if (p.getSexo() == 'F') {
                                out.println("Bem-vinda " + p.getNome() + "<br/>");
                            } else {
                                out.println("Bem-vindo " + p.getNome() + "<br/>");
                            }
                        %>
                    </p>    
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

                    <center>
                        <h1>Editar dados</h1>
                    </center>
                    <b>Nome: </b> 
                    <b style="color: red">*</b>
                    <br/> 
                    <%

                        out.println("<input type=\"text\" name=\"nome\" value=\"" + p.getNome() + "\" size=\"50\"  />");
                    %> 
                    <br/>
                    <br/>

                    <b>Email: </b>

                    <br/>

                    <%
                        out.println("<input type=\"text\" name=\"email\" value=\"" + p.getEmail() + "\" size=\"50\"  disabled=\"disabled\" />");
                    %>
                    <br/>
                    <br/>
                    <b>Senha</b>
                    <b style="color:red">*</b>
                    <br/>
                    <%
                        out.println("<input type = \"password\" name = \"senha\" value = \"" + p.getSenha() + "\" />");
                    %>
                    <br/>
                    <br/>
                    <b>Data de Nascimento:</b>
                    <b style="color: red">*</b>
                    <br/>
                    <%
                        String d;
                        if (p.getDataNasc() == null) {
                            d = "";

                        } else {
                            d = Util.dateToString(p.getDataNasc());
                        }
                        out.println("<input type=\"text\"  name=\"data\" value=\"" + d + "\" size=\"10\" maxlength=\"10\" onkeyup=\"barra(this)\" />");
                    %>


                    <br/>
                    <br/>
                    <b> Sexo:</b>
                    <b style="color: red">*</b>
                    <br/>
                    <%
                        if (p.getSexo() == 'F') {
                            out.println("Feminino:<input type=\"radio\" name=\"sexo\" value=\"F\" checked=\"checked\"/>");

                            out.println("Masculino:<input type=\"radio\" name=\"sexo\" value=\"M\" />");
                        } else {
                            out.println("Feminino:<input type=\"radio\" name=\"sexo\" value=\"F\" />");
                            out.println("Masculino:<input type=\"radio\" name=\"sexo\" value=\"M\" checked=\"checked\"/>");
                        }
                    %>

                    <br/>
                    <br/>

                    <b> Cidade:</b>
                    <b style="color: red">*</b>
                    <br/>
                    <%
                        out.println("<input type=\"text\" name=\"cidade\" value=\"" + p.getCidade() + "\" size=\"30\" />");
                    %>

                    <br/>
                    <br/>

                    <b> Estado:</b>
                    <b style="color: red">*</b>
                    <br/>
                    <select name="estado">
                        <%
                            Dao<Estado> dao = new Dao<Estado>(Estado.class);
                            List<Estado> estados = dao.list();
                            if (p.getEstado() == null) {
                                out.println("<option value=\"-1\">Escolha um estado</option>");

                            } else {
                                out.println("<option value=\"" + p.getEstado().getId() + "\">" + p.getEstado().getNome() + "</option>");

                            }
                            for (Estado e : estados) {
                                out.println("<option value=\"" + e.getId() + "\">" + e.getNome() + "</option>");
                            }

                        %>
                    </select>
                    <br/>
                    <br/>

                    Foto:<br/>
                    <input name="imagem" type="file" id="imagem" maxlength="60" /><br/><br/>

                    <input type="submit" value="editar" name="op" />
                </div>
            </div>
        </form>
    </body>
</html>
