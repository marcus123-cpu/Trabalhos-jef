<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Livraria | Estados</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6366f1;
            --bg-dark: #0f172a;
            --card-bg: rgba(30, 41, 59, 0.7);
            --text-main: #ffffff;
            --text-muted: #94a3b8;
            --border: rgba(51, 65, 85, 0.5);
            --danger: #f43f5e;
            --accent: #8b5cf6;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Outfit', sans-serif;
            background-color: var(--bg-dark);
            background-image: radial-gradient(circle at 50% -20%, #1e1b4b, var(--bg-dark));
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            line-height: 1.6;
        }

        .container {
            width: 100%;
            max-width: 1000px;
            margin: 0 auto;
            padding: 4rem 2rem;
            flex: 1;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 3rem;
            flex-wrap: wrap;
            gap: 1.5rem;
        }

        .header h1 {
            font-size: 3rem;
            font-weight: 800;
            letter-spacing: -0.05em;
            background: linear-gradient(to bottom right, #fff, #94a3b8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .header-actions {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.875rem 1.75rem;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            border-radius: 14px;
            transition: all 0.3s ease;
            cursor: pointer;
            border: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: #fff;
            box-shadow: 0 10px 20px -5px rgba(99, 102, 241, 0.4);
        }

        .btn-primary:hover { transform: translateY(-3px); filter: brightness(1.1); }

        .btn-outline {
            background: rgba(255, 255, 255, 0.03);
            color: var(--text-main);
            border: 1px solid var(--border);
        }

        .btn-outline:hover { background: rgba(255, 255, 255, 0.08); }

        .btn-danger {
            background: rgba(244, 63, 94, 0.08);
            color: var(--danger);
            border: 1px solid rgba(244, 63, 94, 0.2);
        }

        .btn-danger:hover { background: var(--danger); color: #fff; }

        .table-wrap {
            background: var(--card-bg);
            backdrop-filter: blur(12px);
            border: 1px solid var(--border);
            border-radius: 24px;
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 1.25rem 1.5rem;
            text-align: left;
        }

        th {
            background: rgba(15, 23, 42, 0.6);
            color: var(--text-muted);
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.08em;
        }

        tr:not(:last-child) td {
            border-bottom: 1px solid var(--border);
        }

        .sigla-badge {
            display: inline-block;
            background: rgba(99, 102, 241, 0.2);
            color: #a5b4fc;
            font-weight: 800;
            padding: 0.35rem 0.75rem;
            border-radius: 8px;
            letter-spacing: 0.05em;
        }

        .row-actions {
            display: flex;
            gap: 0.75rem;
        }

        .row-actions .btn {
            padding: 0.5rem 1rem;
            font-size: 0.85rem;
        }

        .empty-state {
            text-align: center;
            padding: 5rem;
            background: var(--card-bg);
            border: 2px dashed var(--border);
            border-radius: 28px;
        }

        .footer {
            padding: 5rem 2rem;
            text-align: center;
            border-top: 1px solid var(--border);
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        .footer-names {
            font-weight: 600;
            color: var(--text-main);
            display: block;
            margin-top: 0.5rem;
        }

        @media (max-width: 640px) {
            .header { flex-direction: column; text-align: center; }
            th:nth-child(1), td:nth-child(1) { display: none; }
        }
    </style>
</head>
<body>

    <div class="container">
        <header class="header">
            <h1>Estados</h1>
            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/livros" class="btn btn-outline">Livros</a>
                <a href="${pageContext.request.contextPath}/estados/novo" class="btn btn-primary">+ Novo Estado</a>
            </div>
        </header>

        <c:choose>
            <c:when test="${empty listEstados}">
                <div class="empty-state">
                    <h2 style="margin-bottom: 1rem;">Nenhum estado cadastrado</h2>
                    <p style="color: var(--text-muted);">Clique em "Novo Estado" para começar.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Sigla</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="estado" items="${listEstados}">
                                <tr>
                                    <td><c:out value="${estado.id}" /></td>
                                    <td><c:out value="${estado.nomeEstado}" /></td>
                                    <td><span class="sigla-badge"><c:out value="${estado.siglaEstado}" /></span></td>
                                    <td>
                                        <div class="row-actions">
                                            <a href="${pageContext.request.contextPath}/estados/editar?id=${estado.id}" class="btn btn-outline">Editar</a>
                                            <a href="${pageContext.request.contextPath}/estados/excluir?id=${estado.id}" class="btn btn-danger"
                                               onclick="return confirm('Deseja realmente excluir este estado?');">Excluir</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <footer class="footer">
        <div class="container">
            <p>Trabalho Acadêmico • 3º Semestre • Cap 5.4 Desafio 02</p>
            <span class="footer-names">Marcus Paulo Coleta Caetano</span>
        </div>
    </footer>

</body>
</html>
