package br.com.livraria.dao;

import br.com.livraria.model.Livro;
import br.com.livraria.util.Conexao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LivroDAO {

    private Conexao c;

    public LivroDAO() {
        this.c = new Conexao();
    }

    public void salvar(Livro l) {
        String sql = "INSERT INTO livros (nome_livro, isbn, autor, data_publicacao, valor_livro) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = c.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, l.getNomeLivro());
            stmt.setString(2, l.getIsbn());
            stmt.setString(3, l.getAutor());
            stmt.setDate(4, Date.valueOf(l.getDataPublicacao()));
            stmt.setDouble(5, l.getValorLivro());

            stmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void atualizar(Livro l) {
        String sql = "UPDATE livros SET nome_livro = ?, isbn = ?, autor = ?, data_publicacao = ?, valor_livro = ? WHERE id = ?";
        try (Connection conn = c.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, l.getNomeLivro());
            stmt.setString(2, l.getIsbn());
            stmt.setString(3, l.getAutor());
            stmt.setDate(4, Date.valueOf(l.getDataPublicacao()));
            stmt.setDouble(5, l.getValorLivro());
            stmt.setInt(6, l.getId());

            stmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void excluir(int id) {
        String sql = "DELETE FROM livros WHERE id = ?";
        try (Connection conn = c.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Livro> listar() {
        List<Livro> lista = new ArrayList<>();
        String sql = "SELECT * FROM livros ORDER BY id ASC";

        try (Connection conn = c.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Livro l = new Livro();
                l.setId(rs.getInt("id"));
                l.setNomeLivro(rs.getString("nome_livro"));
                l.setIsbn(rs.getString("isbn"));
                l.setAutor(rs.getString("autor"));
                Date dataSql = rs.getDate("data_publicacao");
                if (dataSql != null) {
                    l.setDataPublicacao(dataSql.toLocalDate());
                }
                l.setValorLivro(rs.getDouble("valor_livro"));
                lista.add(l);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Livro getLivro(int id) {
        String sql = "SELECT * FROM livros WHERE id = ?";
        try (Connection conn = c.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Livro l = new Livro();
                    l.setId(rs.getInt("id"));
                    l.setNomeLivro(rs.getString("nome_livro"));
                    l.setIsbn(rs.getString("isbn"));
                    l.setAutor(rs.getString("autor"));
                    Date dataSql = rs.getDate("data_publicacao");
                    if (dataSql != null) {
                        l.setDataPublicacao(dataSql.toLocalDate());
                    }
                    l.setValorLivro(rs.getDouble("valor_livro"));
                    return l;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
