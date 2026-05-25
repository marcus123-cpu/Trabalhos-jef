<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Livraria | Estado</title>
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
            --danger: #f43f5e;
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
            margin-bottom: 2rem;
            text-align: center;
            letter-spacing: -0.05em;
            background: linear-gradient(to right, #fff, var(--text-muted));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .alert-error {
            background: rgba(244, 63, 94, 0.15);
            border: 1px solid rgba(244, 63, 94, 0.4);
            color: #fecdd3;
            padding: 1rem 1.25rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            font-size: 0.95rem;
        }

        .field-error {
            color: var(--danger);
            font-size: 0.85rem;
            margin-top: 0.5rem;
            padding-left: 0.5rem;
            display: none;
        }

        .form-group { margin-bottom: 2rem; }

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
            text-transform: uppercase;
        }

        .form-control.nome { text-transform: none; }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            background: rgba(0, 0, 0, 0.4);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.2);
        }

        .form-control.invalid { border-color: var(--danger); }

        .form-row {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
        }

        .action-buttons {
            display: flex;
            gap: 1.5rem;
            margin-top: 3rem;
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
        }

        .btn-outline {
            background: rgba(255, 255, 255, 0.03);
            color: var(--text-main);
            border: 1px solid var(--border);
        }

        .btn-outline:hover { background: rgba(255, 255, 255, 0.08); }

        .nav-link {
            display: block;
            text-align: center;
            margin-bottom: 2rem;
            color: var(--text-muted);
            text-decoration: none;
            font-size: 0.9rem;
        }

        .nav-link:hover { color: var(--primary); }

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
            .form-row { grid-template-columns: 1fr; }
            .form-card { padding: 3rem 1.5rem; }
            .action-buttons { flex-direction: column-reverse; }
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="form-card">
            <a href="${pageContext.request.contextPath}/estados" class="nav-link">← Voltar para Estados</a>

            <h2 class="form-title">
                <c:choose>
                    <c:when test="${estado != null}">Editar Estado</c:when>
                    <c:otherwise>Novo Estado</c:otherwise>
                </c:choose>
            </h2>

            <c:if test="${not empty erro}">
                <div class="alert-error"><c:out value="${erro}" /></div>
            </c:if>

            <form action="${pageContext.request.contextPath}/estados/${estado != null ? 'atualizar' : 'inserir'}"
                  method="post" id="estadoForm" novalidate>
                <c:if test="${estado != null}">
                    <input type="hidden" name="id" id="estadoId" value="${estado.id}" />
                </c:if>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Nome do Estado</label>
                        <input type="text" class="form-control nome" name="nomeEstado" id="nomeEstado"
                               value="${estado.nomeEstado}" required maxlength="100">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Sigla (UF)</label>
                        <input type="text" class="form-control" name="siglaEstado" id="siglaEstado"
                               value="${estado.siglaEstado}" required maxlength="2" minlength="2"
                               pattern="[A-Za-z]{2}" title="Informe exatamente 2 letras">
                        <p class="field-error" id="siglaErro">Esta sigla já está cadastrada.</p>
                    </div>
                </div>

                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/estados" class="btn btn-outline">Cancelar</a>
                    <button type="submit" class="btn btn-primary" id="btnSalvar">Salvar</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const siglasCadastradas = [
            <c:forEach var="sigla" items="${siglasCadastradas}" varStatus="st">
            '<c:out value="${sigla}" />'<c:if test="${!st.last}">,</c:if>
            </c:forEach>
        ];

        const siglaOriginal = '<c:out value="${estado.siglaEstado}" default="" />'.toUpperCase();
        const inputSigla = document.getElementById('siglaEstado');
        const siglaErro = document.getElementById('siglaErro');
        const form = document.getElementById('estadoForm');

        function siglaDuplicada(sigla) {
            const normalizada = sigla.trim().toUpperCase();
            if (normalizada.length !== 2) return false;
            if (siglaOriginal && normalizada === siglaOriginal) return false;
            return siglasCadastradas.includes(normalizada);
        }

        function validarSigla() {
            const sigla = inputSigla.value.trim().toUpperCase();
            inputSigla.value = sigla;
            const duplicada = siglaDuplicada(sigla);

            inputSigla.classList.toggle('invalid', duplicada);
            siglaErro.style.display = duplicada ? 'block' : 'none';
            return !duplicada;
        }

        inputSigla.addEventListener('input', function () {
            this.value = this.value.replace(/[^A-Za-z]/g, '').toUpperCase().slice(0, 2);
            validarSigla();
        });

        inputSigla.addEventListener('blur', validarSigla);

        form.addEventListener('submit', function (e) {
            if (!validarSigla()) {
                e.preventDefault();
                inputSigla.focus();
            }
        });
    </script>

    <footer class="footer">
        <div class="container">
            <p>Trabalho Acadêmico • 3º Semestre • Cap 5.4 Desafio 02</p>
            <span class="footer-names">Murilo Rocha Silva, Marcus Paulo Coleta Caetano e Pedro Henrique Rodrigues da Silva</span>
        </div>
    </footer>

</body>
</html>
