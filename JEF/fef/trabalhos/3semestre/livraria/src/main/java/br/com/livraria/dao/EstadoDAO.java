package br.com.livraria.dao;

import br.com.livraria.model.Estado;
import br.com.livraria.util.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EstadoDAO {

    private Conexao c;

    public EstadoDAO() {
        this.c = new Conexao();
    }

    public void salvar(Estado e) {
        String sql = "INSERT INTO estados (nome_estado, sigla_estado) VALUES (?, ?)";
        try (Connection conn = c.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, e.getNomeEstado());
            stmt.setString(2, e.getSiglaEstado());
            stmt.execute();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void atualizar(Estado e) {
        String sql = "UPDATE estados SET nome_estado = ?, sigla_estado = ? WHERE id = ?";
        try (Connection conn = c.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, e.getNomeEstado());
            stmt.setString(2, e.getSiglaEstado());
            stmt.setInt(3, e.getId());
            stmt.execute();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void excluir(int id) {
        String sql = "DELETE FROM estados WHERE id = ?";
        try (Connection conn = c.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.execute();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public List<Estado> listar() {
        List<Estado> lista = new ArrayList<>();
        String sql = "SELECT * FROM estados ORDER BY id ASC";

        try (Connection conn = c.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                lista.add(mapear(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return lista;
    }

    public Estado getEstado(int id) {
        String sql = "SELECT * FROM estados WHERE id = ?";
        try (Connection conn = c.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapear(rs);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public boolean existeSiglaEstado(String sigla, int idIgnorar) {
        String sql = "SELECT COUNT(*) FROM estados WHERE UPPER(sigla_estado) = UPPER(?) AND id <> ?";
        try (Connection conn = c.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, sigla);
            stmt.setInt(2, idIgnorar);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public List<String> listarSiglas() {
        List<String> siglas = new ArrayList<>();
        String sql = "SELECT sigla_estado FROM estados ORDER BY sigla_estado ASC";

        try (Connection conn = c.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                siglas.add(rs.getString("sigla_estado").toUpperCase());
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return siglas;
    }

    private Estado mapear(ResultSet rs) throws SQLException {
        Estado e = new Estado();
        e.setId(rs.getInt("id"));
        e.setNomeEstado(rs.getString("nome_estado"));
        e.setSiglaEstado(rs.getString("sigla_estado"));
        return e;
    }
}
