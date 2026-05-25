package br.com.livraria.controller;

import br.com.livraria.dao.EstadoDAO;
import br.com.livraria.model.Estado;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/estados", "/estados/novo", "/estados/inserir", "/estados/editar", "/estados/atualizar", "/estados/excluir"})
public class EstadoServlet extends HttpServlet {

    private EstadoDAO dao;

    @Override
    public void init() {
        dao = new EstadoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();

        if (action.equals("/estados/novo")) {
            prepararFormulario(req, null);
            req.getRequestDispatcher("/estado-form.jsp").forward(req, resp);
        } else if (action.equals("/estados/editar")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Estado e = dao.getEstado(id);
            prepararFormulario(req, e);
            req.getRequestDispatcher("/estado-form.jsp").forward(req, resp);
        } else if (action.equals("/estados/excluir")) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.excluir(id);
            resp.sendRedirect(req.getContextPath() + "/estados");
        } else {
            List<Estado> lista = dao.listar();
            req.setAttribute("listEstados", lista);
            req.getRequestDispatcher("/estado-list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getServletPath();

        if (action.equals("/estados/inserir")) {
            Estado e = getDados(req);
            if (dao.existeSiglaEstado(e.getSiglaEstado(), 0)) {
                req.setAttribute("erro", "A sigla \"" + e.getSiglaEstado() + "\" já está cadastrada.");
                prepararFormulario(req, e);
                req.getRequestDispatcher("/estado-form.jsp").forward(req, resp);
                return;
            }
            dao.salvar(e);
            resp.sendRedirect(req.getContextPath() + "/estados");
        } else if (action.equals("/estados/atualizar")) {
            Estado e = getDados(req);
            e.setId(Integer.parseInt(req.getParameter("id")));
            if (dao.existeSiglaEstado(e.getSiglaEstado(), e.getId())) {
                req.setAttribute("erro", "A sigla \"" + e.getSiglaEstado() + "\" já está cadastrada.");
                prepararFormulario(req, e);
                req.getRequestDispatcher("/estado-form.jsp").forward(req, resp);
                return;
            }
            dao.atualizar(e);
            resp.sendRedirect(req.getContextPath() + "/estados");
        } else {
            resp.sendRedirect(req.getContextPath() + "/estados");
        }
    }

    private void prepararFormulario(HttpServletRequest req, Estado e) {
        if (e != null) {
            req.setAttribute("estado", e);
        }
        req.setAttribute("siglasCadastradas", dao.listarSiglas());
    }

    private Estado getDados(HttpServletRequest req) {
        String nome = req.getParameter("nomeEstado");
        String sigla = req.getParameter("siglaEstado").trim().toUpperCase();
        return new Estado(0, nome, sigla);
    }
}
