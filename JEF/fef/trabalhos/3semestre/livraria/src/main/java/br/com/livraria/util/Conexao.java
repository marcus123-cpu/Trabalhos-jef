package br.com.livraria.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Conexao {
    
    private String url = "jdbc:postgresql://localhost:5432/";
    private String db = "livraria";
    private String user = "postgres";
    private String pass = "postdba"; 

    public Connection getConexao() {
        try {
            Class.forName("org.postgresql.Driver");
            validar();
            Connection c = DriverManager.getConnection(url + db, user, pass);
            criar(c);
            return c;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private void validar() {
        try (Connection c = DriverManager.getConnection(url + "postgres", user, pass);
             Statement s = c.createStatement()) {
            
            ResultSet rs = c.getMetaData().getCatalogs();
            boolean ok = false;
            while (rs.next()) {
                if (db.equals(rs.getString(1))) {
                    ok = true;
                    break;
                }
            }
            
            if (!ok) {
                s.executeUpdate("CREATE DATABASE " + db);
            }
        } catch (SQLException e) {
        }
    }

    private void criar(Connection c) {
        String sqlLivros = "CREATE TABLE IF NOT EXISTS livros ("
                + "id SERIAL PRIMARY KEY,"
                + "nome_livro VARCHAR(255) NOT NULL,"
                + "isbn VARCHAR(50),"
                + "autor VARCHAR(255),"
                + "data_publicacao DATE,"
                + "valor_livro DECIMAL(10,2)"
                + ");";

        String sqlEstados = "CREATE TABLE IF NOT EXISTS estados ("
                + "id SERIAL PRIMARY KEY,"
                + "nome_estado VARCHAR(100) NOT NULL,"
                + "sigla_estado VARCHAR(2) NOT NULL UNIQUE"
                + ");";

        try (Statement s = c.createStatement()) {
            s.execute(sqlLivros);
            s.execute(sqlEstados);
        } catch (SQLException e) {
        }
    }
}
