package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnectionBanco;
import model.ModelTelefone;

public class DAOTelefoneRepository {
	
	private Connection connection;
	
	public DAOTelefoneRepository() {
		connection = SingleConnectionBanco.getConnection();
	}
	
	public void gravarTelefone(ModelTelefone telefone) {
		
		String sql = "INSERT INTO telefone(numero, usuario_id) VALUES (?, ?);";
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			
			statement.setString(1, telefone.getNumero());
			statement.setInt(2, telefone.getUsuarioId());
			
			statement.execute();
			connection.commit();			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public void deletarTelefone(int id) {
		
		String sql = "delete from telefone WHERE id=?;";
		
		try {
			
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setLong(1, id);
			statement.executeUpdate();
			connection.commit();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public List<ModelTelefone> listarTelefones(int id){
		
		List<ModelTelefone> telefones = new ArrayList<ModelTelefone>();
		String sql = "select * from telefone where usuario_id=" + id;
		
		try {
			
			PreparedStatement statement = connection.prepareStatement(sql);
			
			ResultSet resultSet = statement.executeQuery();
			
			while(resultSet.next()) {
				ModelTelefone telefone = new ModelTelefone();
				
				telefone.setId(Integer.parseInt(resultSet.getString("id")));
				telefone.setNumero(resultSet.getString("numero"));
				telefone.setUsuarioId(Integer.parseInt(resultSet.getString("usuario_id")));
				
				telefones.add(telefone);
			}
			
			return telefones;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return telefones;
	}
	
	

}
