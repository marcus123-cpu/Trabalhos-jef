<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Livraria | Manutenção</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6366f1;
            --primary-hover: #4f46e5;
            --bg-dark: #0f172a;
            --card-bg: rgba(30, 41, 59, 0.8);
            --text-main: #ffffff;
            --text-muted: #94a3b8;
            --border: rgba(51, 65, 85, 0.5);
            --input-bg: #0f172a;
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
            max-width: 800px;
            margin: auto;
            padding: 4rem 2rem;
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .form-card {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border);
            border-radius: 32px;
            padding: 4rem;
            width: 100%;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }

        .form-title {
            font-size: 2.75rem;
            font-weight: 800;
            margin-bottom: 3.5rem;
            text-align: center;
            letter-spacing: -0.05em;
            background: linear-gradient(to right, #fff, var(--text-muted));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .form-group {
            margin-bottom: 2rem;
        }

        .form-label {
            display: block;
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--text-muted);
            margin-bottom: 0.75rem;
            padding-left: 0.5rem;
        }

        .form-control {
            width: 100%;
            padding: 1.125rem 1.5rem;
            font-family: inherit;
            font-size: 1rem;
            color: var(--text-main);
            background: var(--input-bg);
            border: 1px solid var(--border);
            border-radius: 16px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            background: rgba(0, 0, 0, 0.4);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.2);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
        }

        .action-buttons {
            display: flex;
            gap: 1.5rem;
            margin-top: 4rem;
        }

        .btn {
            flex: 1;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 1.125rem;
            font-size: 1rem;
            font-weight: 700;
            text-decoration: none;
            border-radius: 16px;
            transition: all 0.3s ease;
            cursor: pointer;
            border: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: #fff;
            box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            filter: brightness(1.1);
            box-shadow: 0 20px 25px -5px rgba(99, 102, 241, 0.4);
        }

        .btn-outline {
            background: rgba(255, 255, 255, 0.03);
            color: var(--text-main);
            border: 1px solid var(--border);
        }

        .btn-outline:hover {
            background: rgba(255, 255, 255, 0.08);
            transform: translateY(-2px);
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
            .form-row { grid-template-columns: 1fr; gap: 0; }
            .form-card { padding: 3rem 1.5rem; }
            .action-buttons { flex-direction: column-reverse; }
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="form-card">
            <h2 class="form-title">
                <c:choose>
                    <c:when test="${livro != null}">Editar Registro</c:when>
                    <c:otherwise>Novo Cadastro</c:otherwise>
                </c:choose>
            </h2>

            <form action="${pageContext.request.contextPath}/livros/${livro != null ? 'atualizar' : 'inserir'}" method="post" id="livroForm">
                <c:if test="${livro != null}">
                    <input type="hidden" name="id" value="${livro.id}" />
                </c:if>

                <div class="form-group">
                    <label class="form-label">Título da Obra</label>
                    <input type="text" class="form-control" name="nomeLivro" value="${livro.nomeLivro}" required maxlength="255">
                </div>

                <div class="form-group">
                    <label class="form-label">Autor</label>
                    <input type="text" class="form-control" name="autor" value="${livro.autor}" required maxlength="255">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">ISBN</label>
                        <input type="text" class="form-control" name="isbn" value="${livro.isbn}" required maxlength="50">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Data de Lançamento</label>
                        <input type="date" class="form-control" name="dataPublicacao" value="${livro.dataPublicacao}" 
                               id="dataPublicacao" max="9999-12-31" required
                               oninput="validarAno(this)">
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Valor (R$)</label>
                    <input type="number" step="0.01" class="form-control" name="valorLivro" value="${livro.valorLivro}" min="0" required>
                </div>

                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/livros" class="btn btn-outline">Cancelar</a>
                    <button type="submit" class="btn btn-primary">Salvar</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function validarAno(input) {
            if (input.value) {
                const partes = input.value.split('-');
                if (partes[0].length > 4) {
                    input.value = '9999' + '-' + partes[1] + '-' + partes[2];
                }
            }
        }
    </script>

    <footer class="footer">
        <div class="container">
            <p>Trabalho Acadêmico • 3º Semestre</p>
            <span class="footer-names">Marcus Paulo Coleta Caetano</span>
        </div>
    </footer>

</body>
</html>
