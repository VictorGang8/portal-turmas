<%-- Diretiva de página: define encoding e tipo de conteúdo --%>
<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%-- Declaração JSP (<%! %>): método reutilizável da página --%>
<%!
    // Escapa caracteres especiais do HTML — previne ataques XSS (Questão 5)
    private static String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }

    // Traduz o código do select para o nome da turma
    private static String nomeTurma(String codigo) {
        if ("web".equals(codigo)) return "Programação para Web";
        if ("bd".equals(codigo))  return "Banco de Dados";
        if ("es".equals(codigo))  return "Engenharia de Software";
        return null;
    }
%>

<%
    // Scriptlet — código Java executado no servidor

    // 1. Define encoding ANTES de ler parâmetros (aceita acentos)
    request.setCharacterEncoding("UTF-8");

    // 2. Só aceita POST (acesso direto pela URL volta ao formulário)
    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.sendRedirect("portal-bootstrap.html#cadastrar");
        return;
    }

    // 3. Lê parâmetros do formulário (objeto implícito: request)
    String nome  = request.getParameter("nome");
    String email = request.getParameter("email");
    String turma = request.getParameter("turma");

    nome  = (nome  == null) ? "" : nome.trim();
    email = (email == null) ? "" : email.trim();

    // 4. Validação
    String turmaNome = nomeTurma(turma);
    boolean valido = nome.length() >= 3
                  && email.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")
                  && turmaNome != null;

    // 5. Armazena na sessão (objeto implícito: session)
    if (valido) {
        session.setAttribute("ultimoCadastro", nome);
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultado do Cadastro — UNICEPLAC</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .bg-uniceplac { background-color: #007441 !important; }
        .btn-laranja { background:#FD7708; border-color:#FD7708; color:#fff; font-weight:700; }
        .btn-laranja:hover { background:#d96200; border-color:#d96200; color:#fff; }
    </style>
</head>
<body class="bg-light d-flex flex-column min-vh-100">

<nav class="navbar navbar-dark bg-uniceplac shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="portal-bootstrap.html">
            <i class="bi bi-mortarboard-fill" style="color:#FD7708" aria-hidden="true"></i> Portal UNICEPLAC
        </a>
    </div>
</nav>

<main class="container py-5 flex-grow-1">
    <div class="row justify-content-center">
        <div class="col-lg-7">

<% if (valido) { %>

            <div class="card border-0 shadow">
                <div class="card-header bg-success text-white">
                    <h1 class="h4 mb-0"><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Cadastro realizado com sucesso!</h1>
                </div>
                <div class="card-body">
                    <%-- Expressão JSP: imprime valor na página (sempre escapado) --%>
                    <dl class="row mb-0">
                        <dt class="col-sm-3">Nome</dt>   <dd class="col-sm-9"><%= esc(nome) %></dd>
                        <dt class="col-sm-3">E-mail</dt> <dd class="col-sm-9"><%= esc(email) %></dd>
                        <dt class="col-sm-3">Turma</dt>  <dd class="col-sm-9"><%= esc(turmaNome) %></dd>
                    </dl>
                </div>
                <div class="card-footer bg-white border-0 pb-3 d-flex gap-2 flex-wrap">
                    <a href="turmas.jsp" class="btn btn-laranja">Ver turmas</a>
                    <a href="portal-bootstrap.html#cadastrar" class="btn btn-outline-secondary">Cadastrar outro aluno</a>
                </div>
            </div>

<% } else { %>

            <div class="card border-0 shadow">
                <div class="card-header bg-danger text-white">
                    <h1 class="h4 mb-0"><i class="bi bi-x-circle-fill" aria-hidden="true"></i> Erro no cadastro</h1>
                </div>
                <div class="card-body">
                    <p>Verifique os campos abaixo e tente novamente:</p>
                    <ul class="mb-0">
                        <% if (nome.length() < 3) { %><li>Nome com pelo menos 3 caracteres.</li><% } %>
                        <% if (!email.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) { %><li>E-mail em formato válido.</li><% } %>
                        <% if (turmaNome == null) { %><li>Turma selecionada.</li><% } %>
                    </ul>
                </div>
                <div class="card-footer bg-white border-0 pb-3">
                    <a href="portal-bootstrap.html#cadastrar" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-left" aria-hidden="true"></i> Voltar ao formulário
                    </a>
                </div>
            </div>

<% } %>

        </div>
    </div>
</main>

<footer class="bg-dark text-white-50 text-center py-3 small" style="border-top:4px solid #FD7708">
    © 2026 UNICEPLAC — Programação para Web
</footer>

</body>
</html>
