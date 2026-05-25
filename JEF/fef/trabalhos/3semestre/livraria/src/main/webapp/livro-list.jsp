<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Livraria | Acervo</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6366f1;
            --primary-hover: #4f46e5;
            --bg-dark: #0f172a;
            --card-bg: rgba(30, 41, 59, 0.7);
            --text-main: #ffffff;
            --text-muted: #94a3b8;
            --border: rgba(51, 65, 85, 0.5);
            --danger: #f43f5e;
            --accent: #8b5cf6;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

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
            max-width: 1200px;
            margin: 0 auto;
            padding: 4rem 2rem;
            flex: 1;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 5rem;
        }

        .header h1 {
            font-size: 3.5rem;
            font-weight: 800;
            letter-spacing: -0.05em;
            background: linear-gradient(to bottom right, #fff, #94a3b8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
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
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            border: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: #fff;
            box-shadow: 0 10px 20px -5px rgba(99, 102, 241, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 20px 30px -5px rgba(99, 102, 241, 0.5);
            filter: brightness(1.1);
        }

        .btn-outline {
            background: rgba(255, 255, 255, 0.03);
            color: var(--text-main);
            border: 1px solid var(--border);
            backdrop-filter: blur(10px);
        }

        .btn-outline:hover {
            background: rgba(255, 255, 255, 0.08);
            border-color: var(--text-muted);
            transform: translateY(-2px);
        }

        .btn-danger {
            background: rgba(244, 63, 94, 0.08);
            color: var(--danger);
            border: 1px solid rgba(244, 63, 94, 0.2);
        }

        .btn-danger:hover {
            background: var(--danger);
            color: #fff;
            transform: translateY(-2px);
        }

        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
            gap: 2.5rem;
        }

        .book-card {
            background: var(--card-bg);
            backdrop-filter: blur(12px);
            border: 1px solid var(--border);
            border-radius: 28px;
            padding: 2.5rem;
            display: flex;
            flex-direction: column;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .book-card:hover {
            transform: translateY(-12px) scale(1.02);
            border-color: var(--primary);
            box-shadow: 0 30px 40px -10px rgba(0, 0, 0, 0.4);
        }

        .book-id {
            font-size: 0.8rem;
            font-weight: 800;
            color: var(--primary);
            text-transform: uppercase;
            margin-bottom: 0.75rem;
            letter-spacing: 0.1em;
        }

        .book-title {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            line-height: 1.2;
        }

        .book-author {
            color: var(--text-muted);
            font-size: 0.9rem;
            margin-bottom: 2rem;
        }

        .book-details {
            margin-bottom: 2.5rem;
            padding: 1.5rem;
            background: rgba(15, 23, 42, 0.4);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.03);
        }

        .detail-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }

        .detail-item:last-child {
            margin-bottom: 0;
        }

        .detail-label {
            color: var(--text-muted);
        }

        .detail-value {
            font-weight: 600;
        }

        .price-tag {
            font-size: 1.75rem;
            font-weight: 800;
            color: #fff;
            margin-bottom: 2.5rem;
            display: block;
        }

        .book-actions {
            display: flex;
            gap: 1rem;
            margin-top: auto;
        }

        .book-actions .btn {
            flex: 1;
            font-size: 0.9rem;
            padding: 0.75rem;
        }

        .footer {
            padding: 5rem 2rem;
            text-align: center;
            border-top: 1px solid var(--border);
            color: var(--text-muted);
            font-size: 0.9rem;
            background: rgba(15, 23, 42, 0.5);
        }

        .footer p {
            margin-bottom: 1.5rem;
        }

        .footer-names {
            font-weight: 600;
            color: var(--text-main);
            display: block;
            margin-top: 0.5rem;
        }

        @media (max-width: 640px) {
            .header { flex-direction: column; text-align: center; gap: 2rem; }
            .header h1 { font-size: 2.5rem; }
            .book-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

    <div class="container">
        <header class="header">
            <h1>Livraria</h1>
            <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                <a href="${pageContext.request.contextPath}/estados" class="btn btn-outline">Estados</a>
                <a href="${pageContext.request.contextPath}/livros/novo" class="btn btn-primary">
                    + Adicionar Livro
                </a>
            </div>
        </header>

        <c:choose>
            <c:when test="${empty listLivros}">
                <div style="text-align: center; padding: 5rem; background: var(--card-bg); border: 2px dashed var(--border); border-radius: 28px;">
                    <h2 style="margin-bottom: 1rem;">Nenhum item encontrado</h2>
                    <p style="color: var(--text-muted);">Sua biblioteca ainda está vazia.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="book-grid">
                    <c:forEach var="livro" items="${listLivros}">
                        <div class="book-card">
                            <span class="book-id">#<c:out value="${livro.id}" /></span>
                            <h2 class="book-title"><c:out value="${livro.nomeLivro}" /></h2>
                            <p class="book-author">por <c:out value="${livro.autor}" /></p>
                            
                            <div class="book-details">
                                <div class="detail-item">
                                    <span class="detail-label">ISBN</span>
                                    <span class="detail-value"><c:out value="${livro.isbn}" /></span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label">Publicação</span>
                                    <span class="detail-value"><c:out value="${livro.formataData}" /></span>
                                </div>
                            </div>

                            <span class="price-tag">
                                R$ <c:out value="${livro.formataPreco}" />
                            </span>

                            <div class="book-actions">
                                <a href="${pageContext.request.contextPath}/livros/editar?id=${livro.id}" class="btn btn-outline">
                                    Editar
                                </a>
                                <a href="${pageContext.request.contextPath}/livros/excluir?id=${livro.id}" class="btn btn-danger" onclick="return confirm('Deseja realmente excluir este registro?');">
                                    Excluir
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <footer class="footer">
        <div class="container">
            <p>Trabalho Acadêmico • 3º Semestre</p>
            <span class="footer-names">Marcus Paulo Coleta Caetano</span>
        </div>
    </footer>

</body>
</html>
