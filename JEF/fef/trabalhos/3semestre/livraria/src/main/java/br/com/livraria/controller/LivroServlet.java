package br.com.livraria.controller;

import br.com.livraria.dao.LivroDAO;
import br.com.livraria.model.Livro;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(urlPatterns = {"/livros", "/livros/novo", "/livros/inserir", "/livros/editar", "/livros/atualizar", "/livros/excluir"})
public class LivroServlet extends HttpServlet {

    private LivroDAO dao;

    @Override
    public void init() {
        dao = new LivroDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();

        if (action.equals("/livros/novo")) {
            req.getRequestDispatcher("/livro-form.jsp").forward(req, resp);
        } else if (action.equals("/livros/editar")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Livro l = dao.getLivro(id);
            req.setAttribute("livro", l);
            req.getRequestDispatcher("/livro-form.jsp").forward(req, resp);
        } else if (action.equals("/livros/excluir")) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.excluir(id);
            resp.sendRedirect(req.getContextPath() + "/livros");
        } else {
            List<Livro> lista = dao.listar();
            req.setAttribute("listLivros", lista);
            req.getRequestDispatcher("/livro-list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getServletPath();

        if (action.equals("/livros/inserir")) {
            Livro l = getDados(req);
            dao.salvar(l);
            resp.sendRedirect(req.getContextPath() + "/livros");
        } else if (action.equals("/livros/atualizar")) {
            Livro l = getDados(req);
            l.setId(Integer.parseInt(req.getParameter("id")));
            dao.atualizar(l);
            resp.sendRedirect(req.getContextPath() + "/livros");
        } else {
            resp.sendRedirect(req.getContextPath() + "/livros");
        }
    }

    private Livro getDados(HttpServletRequest req) {
        String nome = req.getParameter("nomeLivro");
        String isbn = req.getParameter("isbn");
        String autor = req.getParameter("autor");
        LocalDate data = LocalDate.parse(req.getParameter("dataPublicacao"));
        double valor = Double.parseDouble(req.getParameter("valorLivro").replace(",", "."));

        return new Livro(0, nome, isbn, autor, data, valor);
    }
}
