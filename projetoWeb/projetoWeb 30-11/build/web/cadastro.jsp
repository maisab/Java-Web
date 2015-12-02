
<%@page import="classes.Util"%>
<%@page import="classes.Perfil"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%-- 
    Document   : cadastro
    Created on : 25/08/2011, 21:47:00
    Author     : Barreto
--%>  

<%@page import="dao.Dao"%>
<%@page import="classes.Estado"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro</title>
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

        <div id="tudo">
            <div id="header">
                <div id="logo">
                </div>
            </div>    
            <div id="body2">
                <form action="ServletCadastroPerfil" method="POST" 
                      id="formSendFile"
                      action="UploadServlet" 
                      enctype="multipart/form-data">
                    <center>
                        <h1>Cadastro de Usuários</h1>
                    </center>
                    <%
                        Perfil p = (Perfil) session.getAttribute("valida");
                        if (p != null) {
                            String ema = (String) session.getAttribute("email");
                            if (!ema.equals("true")) {
                                out.print("Dados em branco!<br/>");
                            }
                    %>



                    <b>Nome: </b> 
                    <b style="color: red">*</b>
                    <br/> 
                    <%

                        out.println("<input type=\"text\" name=\"nome\" value=\"" + p.getNome() + "\" size=\"50\"  />");
                    %> 
                    <br/>
                    <br/>

                    <b>Email: </b>
                    <b style="color: red">*</b>
                    <br/>
                    <%
                        out.println("<input type=\"text\" name=\"email\" value=\"" + p.getEmail() + "\" size=\"50\"/>");
                    %>

                    <input type="submit" value="Verificar" name="op" />
                    <br/>(Exemplo xxx@livros.com)
                    <br/>
                    <%
                        String em = (String) session.getAttribute("verifica");
                        if ("false".equals(em)) {
                            out.print("<br/><b style=\"color:red\">Verificação: Já existe este email </b><br/><br/>");
                        } else if ("true".equals(em)) {
                            out.print("<br/><b style=\"color:red\">Verificação: Ok!</b><br/><br/>");

                        }
                    %>



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


                    <% } else {%>


                    <b>Nome: </b> 
                    <b style="color: red">*</b>
                    <br/> 
                    <input type="text" name="nome" value="" size="50"/>
                    <br/>
                    <br/>

                    <b>Email: </b>
                    <b style="color: red">*</b>
                    <br/>
                    <%
                        String email = (String) session.getAttribute("email");
                        if (email == null) {
                            email = "";
                        }
                        out.println("<input type=\"text\" name=\"email\" value=\"" + email + "\" size=\"50\"/>");
                    %>

                    <input type="submit" value="Verificar" name="op" />
                    <br/>(Exemplo xxx@livros.com)
                    <br/>
                    <%
                        String em = (String) session.getAttribute("verifica");
                        if ("false".equals(em)) {
                            out.print("<br/><b style=\"color:red\">Verificação: Já existe este email </b><br/><br/>");
                        } else if ("true".equals(em)) {
                            out.print("<br/><b style=\"color:red\">Verificação: Ok!</b><br/><br/>");

                        }
                    %>



                    <b>Senha</b>
                    <b style="color:red">*</b>
                    <br/>
                    <input type="password" name="senha" value="" />
                    <br/>
                    <br/>
                    <b>Data de Nascimento:</b>
                    <b style="color: red">*</b>
                    <br/>

                    <input type="text"  name="data" value="" size="10" maxlength="10" onkeyup="barra(this)" />

                    <br/>
                    <br/>
                    <b> Sexo:</b>
                    <b style="color: red">*</b>
                    <br/>
                    Feminino:<input type="radio" name="sexo" value="F" checked="checked"/>
                    Masculino:<input type="radio" name="sexo" value="M" />
                    <br/>
                    <br/>

                    <b> Cidade:</b>
                    <b style="color: red">*</b>
                    <br/>
                    <input type="text" name="cidade" value="" size="30" />
                    <br/>
                    <br/>

                    <b> Estado:</b>
                    <b style="color: red">*</b>
                    <br/>
                    <select name="estado">
                        <%

                            Dao<Estado> dao = new Dao<Estado>(Estado.class);
                            List<Estado> estados = dao.list();
                            out.println("<option value=\"-1\">Escolha seu estado</option>");
                            for (Estado e : estados) {
                                out.println("<option value=\"" + e.getId() + "\">" + e.getNome() + "</option>");
                            }

                        %>
                    </select>
                    <br/>
                    <br/>

                    Foto:<br/>
                    <input name="imagem" type="file" id="imagem" maxlength="60" /><br/><br/>
                    <%}%>

                    <input type="submit" value="Enviar" name="op" />

                </form> 
            </div>
        </div>


    </div>
</body>
</html>
