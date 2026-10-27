<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDate" %>

<%
    // Array simples de turmas (numa app real viria do banco)
    // { disciplina, código, carga horária, professor }
    String[][] turmas = {
        { "Programação para Web",   "ENSOF4AN1", "60h", "Reinaldo Vieira" },
        { "Banco de Dados",         "ENSOF4BD1", "80h", "Carlos Souza"    },
        { "Engenharia de Software", "ENSOF4ES1", "80h", "Ana Lima"        }
    };

    // Objeto implícito: session — último aluno cadastrado nesta sessão
    String ultimo = (String) session.getAttribute("ultimoCadastro");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Turmas — 4º Período — UNICEPLAC</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .bg-uniceplac { background-color: #007441 !important; }
        .btn-laranja { background:#FD7708; border-color:#FD7708; color:#fff; font-weight:700; }
        .btn-laranja:hover { background:#d96200; border-color:#d96200; color:#fff; }
        .table-uniceplac th { background:#007441; color:#fff; }
    </style>
</head>
<body class="bg-light d-flex flex-column min-vh-100">

<nav class="navbar navbar-dark bg-uniceplac shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="portal-bootstrap.html">
            <i class="bi bi-mortarboard-fill" style="color:#FD7708" aria-hidden="true"></i> Portal UNICEPLAC
        </a>
        <a class="btn btn-sm btn-laranja" href="portal-bootstrap.html#cadastrar">Cadastrar aluno</a>
    </div>
</nav>

<main class="container py-4 flex-grow-1">
    <h1 class="h3 fw-bold mb-1">Turmas — 4º Período</h1>
    <p class="text-muted"><%= turmas.length %> turmas disponíveis em 2026/2</p>

    <%-- Mostra último aluno cadastrado se houver sessão --%>
    <% if (ultimo != null) { %>
        <div class="alert alert-info d-flex align-items-center gap-2" role="status">
            <i class="bi bi-person-check-fill" aria-hidden="true"></i>
            <span>Último cadastro desta sessão:
                <strong><%= ultimo.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;") %></strong></span>
        </div>
    <% } %>

    <div class="table-responsive shadow-sm rounded">
        <table class="table table-striped table-hover align-middle mb-0 bg-white">
            <caption class="visually-hidden">Lista de turmas do 4º período</caption>
            <thead class="table-uniceplac">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Disciplina</th>
                    <th scope="col">Código</th>
                    <th scope="col">Carga</th>
                    <th scope="col">Professor</th>
                </tr>
            </thead>
            <tbody>

            <%-- Loop Java gerando linhas HTML --%>
            <% for (int i = 0; i < turmas.length; i++) { %>
                <tr>
                    <td><%= (i + 1) %></td>
                    <td class="fw-semibold"><%= turmas[i][0] %></td>
                    <td><span class="badge bg-secondary"><%= turmas[i][1] %></span></td>
                    <td><%= turmas[i][2] %></td>
                    <td><%= turmas[i][3] %></td>
                </tr>
            <% } %> <%-- fim do for --%>

            </tbody>
        </table>
    </div>

    <a href="portal-bootstrap.html" class="btn btn-outline-secondary mt-4">
        <i class="bi bi-arrow-left" aria-hidden="true"></i> Voltar ao portal
    </a>
</main>

<footer class="bg-dark text-white-50 text-center py-3 small" style="border-top:4px solid #FD7708">
    © <%= LocalDate.now().getYear() %> UNICEPLAC — Programação para Web
</footer>

</body>
</html>
