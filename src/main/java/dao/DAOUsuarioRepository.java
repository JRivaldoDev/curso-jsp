package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import beandto.BeanDtoSalarioUser;
import connection.SingleConnectionBanco;
import model.ModelEndereco;
import model.ModelLogin;
import model.ModelTelefone;

public class DAOUsuarioRepository {

	Connection connection;

	public DAOUsuarioRepository() {
		connection = SingleConnectionBanco.getConnection();
	}

	public BeanDtoSalarioUser mediaRendaMensal() {
		BeanDtoSalarioUser salarioUser = new BeanDtoSalarioUser();

		try {
			String sql = "select avg(rendamensal) as media_salarial, perfil from model_login where useradmin is false group by perfil;";
			PreparedStatement statement = connection.prepareStatement(sql);

			ResultSet resultSet = statement.executeQuery();

			List<Double> medias = new ArrayList<Double>();
			List<String> perfis = new ArrayList<String>();

			while (resultSet.next()) {

				double media = resultSet.getDouble("media_salarial");
				String perfil = resultSet.getString("perfil");

				medias.add(media);
				perfis.add(perfil);

			}
			salarioUser.setMedias(medias);
			salarioUser.setPerfis(perfis);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return salarioUser;

	}

	public BeanDtoSalarioUser mediaRendaMensal(Date dataInicial, Date dataFinal) {
		BeanDtoSalarioUser salarioUser = new BeanDtoSalarioUser();

		try {
			String sql = "select avg(rendamensal) as media_salarial, perfil from model_login where useradmin is false and datanascimento >= ? and datanascimento <= ? group by perfil;";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setDate(1, dataInicial);
			statement.setDate(2, dataFinal);

			ResultSet resultSet = statement.executeQuery();

			List<Double> medias = new ArrayList<Double>();
			List<String> perfis = new ArrayList<String>();

			while (resultSet.next()) {

				double media = resultSet.getDouble("media_salarial");
				String perfil = resultSet.getString("perfil");

				medias.add(media);
				perfis.add(perfil);

			}
			salarioUser.setMedias(medias);
			salarioUser.setPerfis(perfis);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return salarioUser;

	}

	public void gravarUsuario(ModelLogin modelLogin) {

		try {

			String sql = "INSERT INTO model_login(login, senha, nome, email, sexo, perfil) VALUES (?, ?, ?, ?, ?, ?);";
			PreparedStatement statement = connection.prepareStatement(sql);

			statement.setString(1, modelLogin.getLogin());
			statement.setString(2, modelLogin.getSenha());
			statement.setString(3, modelLogin.getNome());
			statement.setString(4, modelLogin.getEmail());
			statement.setString(5, modelLogin.getSexo());
			statement.setString(6, modelLogin.getPerfil());

			statement.execute();
			connection.commit();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void editarUsuario(ModelLogin modelLogin) {

		try {
			if (existeUsuario(modelLogin.getLogin())) {
				String sql = "UPDATE model_login SET senha=?, nome=?, email=?, perfil=?, sexo=?, fotouser=?, extensaofotouser=?, datanascimento=?, rendamensal=? WHERE id= "
						+ modelLogin.getId();
				PreparedStatement statement = connection.prepareStatement(sql);

				statement.setString(1, modelLogin.getSenha());
				statement.setString(2, modelLogin.getNome());
				statement.setString(3, modelLogin.getEmail());
				statement.setString(4, modelLogin.getPerfil());
				statement.setString(5, modelLogin.getSexo());

				if (modelLogin.getFotoUser() != null && !modelLogin.getFotoUser().isEmpty()) {
					statement.setString(6, modelLogin.getFotoUser());
					statement.setString(7, modelLogin.getExtensaoFotoUser());
				} else {
					statement.setString(6, "");
					statement.setString(7, "");
				}
				if (modelLogin.getDataNascimento() != null) {
					statement.setDate(8, modelLogin.getDataNascimento());
				}

				if (modelLogin.getRendaMensal() != null) {
					statement.setDouble(9, modelLogin.getRendaMensal());
				}

				statement.executeUpdate();
				connection.commit();

				if (modelLogin.getEndereco().getCep() != null && !modelLogin.getEndereco().getCep().isEmpty()
						&& temEndereco(modelLogin.getId())) {
					sql = "UPDATE model_endereco SET cep=?, uf=?, cidade=?, rua=?, bairro=?, numero=? WHERE id_usuario="
							+ modelLogin.getId();
					statement = connection.prepareStatement(sql);
					statement.setString(1, modelLogin.getEndereco().getCep());
					statement.setString(2, modelLogin.getEndereco().getUf());
					statement.setString(3, modelLogin.getEndereco().getCidade());
					statement.setString(4, modelLogin.getEndereco().getRua());
					statement.setString(5, modelLogin.getEndereco().getBairro());
					statement.setString(6, modelLogin.getEndereco().getNumero());

					statement.executeUpdate();
					connection.commit();
				} else {
					String sql2 = "INSERT INTO model_endereco(cep, uf, cidade, rua, bairro, numero, id_usuario) VALUES (?, ?, ?, ?, ?, ?, ?);";
					PreparedStatement statement2 = connection.prepareStatement(sql2);
					statement2.setString(1, modelLogin.getEndereco().getCep());
					statement2.setString(2, modelLogin.getEndereco().getUf());
					statement2.setString(3, modelLogin.getEndereco().getCidade());
					statement2.setString(4, modelLogin.getEndereco().getRua());
					statement2.setString(5, modelLogin.getEndereco().getBairro());
					statement2.setString(6, modelLogin.getEndereco().getNumero());
					statement2.setLong(7, modelLogin.getId());

					statement2.execute();
					connection.commit();
				}
			}

		} catch (Exception e) {
			try {
				connection.rollback();
			} catch (SQLException e1) {

				e1.printStackTrace();
			}
			e.printStackTrace();
		}
	}

	public List<ModelLogin> buscarListUsuarios(String nome) {
		try {
			List<ModelLogin> usuarios = new ArrayList<ModelLogin>();
			String sql = "select * from model_login where lower(nome) like lower(?) and useradmin is false";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, "%" + nome + "%");

			ResultSet resultSet = statement.executeQuery();

			while (resultSet.next()) {
				ModelLogin modelLogin = new ModelLogin();

				modelLogin.setId(Long.parseLong(resultSet.getString("id")));
				modelLogin.setNome(resultSet.getString("nome"));
				modelLogin.setEmail(resultSet.getString("email"));
				modelLogin.setLogin(resultSet.getString("login"));
				modelLogin.setSenha(resultSet.getString("senha"));
				modelLogin.setPerfil(resultSet.getString("perfil"));
				modelLogin.setSexo(resultSet.getString("sexo"));
				modelLogin.setFotoUser(resultSet.getString("fotouser"));
				modelLogin.setExtensaoFotoUser(resultSet.getString("extensaofotouser"));
				modelLogin.setEndereco(buscarEndereco(Long.parseLong(resultSet.getString("id"))));
				modelLogin.setDataNascimento(resultSet.getDate("datanascimento"));
				modelLogin.setRendaMensal(resultSet.getDouble("rendamensal"));

				usuarios.add(modelLogin);
			}

			return usuarios;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<ModelLogin> buscarListUsuariosPaginada(String nome, int offset) {
		try {
			List<ModelLogin> usuarios = new ArrayList<ModelLogin>();
			String sql = "select * from model_login where lower(nome) like lower(?) and useradmin is false order by nome offset "
					+ offset + " limit 5";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, "%" + nome + "%");

			ResultSet resultSet = statement.executeQuery();

			while (resultSet.next()) {
				ModelLogin modelLogin = new ModelLogin();

				modelLogin.setId(Long.parseLong(resultSet.getString("id")));
				modelLogin.setNome(resultSet.getString("nome"));
				modelLogin.setEmail(resultSet.getString("email"));
				modelLogin.setLogin(resultSet.getString("login"));
				modelLogin.setSenha(resultSet.getString("senha"));
				modelLogin.setPerfil(resultSet.getString("perfil"));
				modelLogin.setSexo(resultSet.getString("sexo"));
				modelLogin.setFotoUser(resultSet.getString("fotouser"));
				modelLogin.setExtensaoFotoUser(resultSet.getString("extensaofotouser"));
				modelLogin.setEndereco(buscarEndereco(Long.parseLong(resultSet.getString("id"))));
				modelLogin.setDataNascimento(resultSet.getDate("datanascimento"));
				modelLogin.setRendaMensal(resultSet.getDouble("rendamensal"));

				usuarios.add(modelLogin);
			}

			return usuarios;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public ModelLogin buscarUsuario(String login) {
		try {
			String sql = "select * from model_login where lower(login) = lower(?)";
			PreparedStatement statement = connection.prepareStatement(sql);

			statement.setString(1, login);

			ResultSet resultSet = statement.executeQuery();

			if (resultSet.next()) {
				ModelLogin modelLogin = new ModelLogin();
				modelLogin.setId(Long.parseLong(resultSet.getString("id")));
				modelLogin.setNome(resultSet.getString("nome"));
				modelLogin.setEmail(resultSet.getString("email"));
				modelLogin.setLogin(resultSet.getString("login"));
				modelLogin.setSenha(resultSet.getString("senha"));
				modelLogin.setPerfil(resultSet.getString("perfil"));
				modelLogin.setSexo(resultSet.getString("sexo"));
				modelLogin.setFotoUser(resultSet.getString("fotouser"));
				modelLogin.setExtensaoFotoUser(resultSet.getString("extensaofotouser"));
				modelLogin.setEndereco(buscarEndereco(Long.parseLong(resultSet.getString("id"))));
				modelLogin.setDataNascimento(resultSet.getDate("datanascimento"));
				modelLogin.setRendaMensal(resultSet.getDouble("rendamensal"));

				return modelLogin;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public ModelLogin buscarUsuarioID(String id) {
		try {
			String sql = "select * from model_login where id = ? and useradmin is false";
			PreparedStatement statement = connection.prepareStatement(sql);

			statement.setLong(1, Long.parseLong(id));

			ResultSet resultSet = statement.executeQuery();

			if (resultSet.next()) {
				ModelLogin modelLogin = new ModelLogin();
				modelLogin.setId(Long.parseLong(resultSet.getString("id")));
				modelLogin.setNome(resultSet.getString("nome"));
				modelLogin.setEmail(resultSet.getString("email"));
				modelLogin.setLogin(resultSet.getString("login"));
				modelLogin.setSenha(resultSet.getString("senha"));
				modelLogin.setPerfil(resultSet.getString("perfil"));
				modelLogin.setSexo(resultSet.getString("sexo"));
				modelLogin.setFotoUser(resultSet.getString("fotouser"));
				modelLogin.setExtensaoFotoUser(resultSet.getString("extensaofotouser"));
				modelLogin.setEndereco(buscarEndereco(Long.parseLong(resultSet.getString("id"))));
				modelLogin.setDataNascimento(resultSet.getDate("datanascimento"));
				modelLogin.setRendaMensal(resultSet.getDouble("rendamensal"));

				return modelLogin;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public List<ModelLogin> listarUsuarios() {
		try {
			List<ModelLogin> usuarios = new ArrayList<ModelLogin>();
			String sql = "select * from model_login where useradmin is false order by nome limit 5;";

			PreparedStatement statement = connection.prepareStatement(sql);

			ResultSet resultSet = statement.executeQuery();

			while (resultSet.next()) {
				ModelLogin modelLogin = new ModelLogin();

				modelLogin.setId(Long.parseLong(resultSet.getString("id")));
				modelLogin.setNome(resultSet.getString("nome"));
				modelLogin.setEmail(resultSet.getString("email"));
				modelLogin.setLogin(resultSet.getString("login"));
				modelLogin.setSenha(resultSet.getString("senha"));
				modelLogin.setPerfil(resultSet.getString("perfil"));
				modelLogin.setSexo(resultSet.getString("sexo"));
				modelLogin.setFotoUser(resultSet.getString("fotouser"));
				modelLogin.setExtensaoFotoUser(resultSet.getString("extensaofotouser"));
				modelLogin.setEndereco(buscarEndereco(Long.parseLong(resultSet.getString("id"))));
				modelLogin.setDataNascimento(resultSet.getDate("datanascimento"));
				modelLogin.setRendaMensal(resultSet.getDouble("rendamensal"));

				usuarios.add(modelLogin);
			}

			return usuarios;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<ModelLogin> listarUsuariosRel() {
		try {
			List<ModelLogin> usuarios = new ArrayList<ModelLogin>();
			String sql = "select * from model_login where useradmin is false order by nome;";

			PreparedStatement statement = connection.prepareStatement(sql);

			ResultSet resultSet = statement.executeQuery();

			while (resultSet.next()) {
				ModelLogin modelLogin = new ModelLogin();

				modelLogin.setId(Long.parseLong(resultSet.getString("id")));
				modelLogin.setNome(resultSet.getString("nome"));
				modelLogin.setEmail(resultSet.getString("email"));
				modelLogin.setLogin(resultSet.getString("login"));
				modelLogin.setSenha(resultSet.getString("senha"));
				modelLogin.setPerfil(resultSet.getString("perfil"));
				modelLogin.setSexo(resultSet.getString("sexo"));
				modelLogin.setFotoUser(resultSet.getString("fotouser"));
				modelLogin.setExtensaoFotoUser(resultSet.getString("extensaofotouser"));
				modelLogin.setEndereco(buscarEndereco(Long.parseLong(resultSet.getString("id"))));
				modelLogin.setDataNascimento(resultSet.getDate("datanascimento"));
				modelLogin.setRendaMensal(resultSet.getDouble("rendamensal"));
				modelLogin.setTelefones(this.listarTelefones(Integer.valueOf(resultSet.getString("id"))));

				usuarios.add(modelLogin);
			}

			return usuarios;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<ModelLogin> listarUsuariosRelData(Date dataInicial, Date dataFinal) {
		try {
			List<ModelLogin> usuarios = new ArrayList<ModelLogin>();
			String sql = "select * from model_login where useradmin is false and datanascimento >= ? and datanascimento <= ? order by nome;";

			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setDate(1, dataInicial);
			statement.setDate(2, dataFinal);

			ResultSet resultSet = statement.executeQuery();

			while (resultSet.next()) {
				ModelLogin modelLogin = new ModelLogin();

				modelLogin.setId(Long.parseLong(resultSet.getString("id")));
				modelLogin.setNome(resultSet.getString("nome"));
				modelLogin.setEmail(resultSet.getString("email"));
				modelLogin.setLogin(resultSet.getString("login"));
				modelLogin.setSenha(resultSet.getString("senha"));
				modelLogin.setPerfil(resultSet.getString("perfil"));
				modelLogin.setSexo(resultSet.getString("sexo"));
				modelLogin.setFotoUser(resultSet.getString("fotouser"));
				modelLogin.setExtensaoFotoUser(resultSet.getString("extensaofotouser"));
				modelLogin.setEndereco(buscarEndereco(Long.parseLong(resultSet.getString("id"))));
				modelLogin.setDataNascimento(resultSet.getDate("datanascimento"));
				modelLogin.setRendaMensal(resultSet.getDouble("rendamensal"));
				modelLogin.setTelefones(this.listarTelefones(Integer.valueOf(resultSet.getString("id"))));

				usuarios.add(modelLogin);
			}

			return usuarios;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<ModelLogin> listarUsuariosPaginada(int offset) {
		try {
			List<ModelLogin> usuarios = new ArrayList<ModelLogin>();
			String sql = "select * from model_login where useradmin is false order by nome offset " + offset
					+ " limit 5";

			PreparedStatement statement = connection.prepareStatement(sql);

			ResultSet resultSet = statement.executeQuery();

			while (resultSet.next()) {
				ModelLogin modelLogin = new ModelLogin();

				modelLogin.setId(Long.parseLong(resultSet.getString("id")));
				modelLogin.setNome(resultSet.getString("nome"));
				modelLogin.setEmail(resultSet.getString("email"));
				modelLogin.setLogin(resultSet.getString("login"));
				modelLogin.setSenha(resultSet.getString("senha"));
				modelLogin.setPerfil(resultSet.getString("perfil"));
				modelLogin.setSexo(resultSet.getString("sexo"));
				modelLogin.setFotoUser(resultSet.getString("fotouser"));
				modelLogin.setExtensaoFotoUser(resultSet.getString("extensaofotouser"));
				modelLogin.setEndereco(buscarEndereco(Long.parseLong(resultSet.getString("id"))));
				modelLogin.setDataNascimento(resultSet.getDate("datanascimento"));
				modelLogin.setRendaMensal(resultSet.getDouble("rendamensal"));

				usuarios.add(modelLogin);
			}

			return usuarios;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean existeUsuario(String login) {
		try {
			String sql = "select * from model_login where lower(login) = lower(?)";
			PreparedStatement statement = connection.prepareStatement(sql);

			statement.setString(1, login);

			ResultSet resultSet = statement.executeQuery();

			if (resultSet.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public boolean isAdmin(String login) {
		try {
			String sql = "select * from model_login where lower(login) = lower(?) and useradmin is true;";
			PreparedStatement statement = connection.prepareStatement(sql);

			statement.setString(1, login);

			ResultSet resultSet = statement.executeQuery();

			if (resultSet.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public void deletarUsuario(String id) {

		try {
			if(temEndereco(Long.parseLong(id))) {
				this.deletarEndereco(id);
			}
			if(this.temTelefone(Long.parseLong(id))) {
				this.deletarTelefones(id);
			}
			String sql = "delete from model_login where id= ? and useradmin is false;";
			PreparedStatement statement = connection.prepareStatement(sql);

			statement.setLong(1, Long.parseLong(id));
			statement.executeUpdate();

			connection.commit();

		} catch (SQLException e) {

			e.printStackTrace();
		}
	}

	private void deletarEndereco(String id) {

		try {
			String sql = "delete from model_endereco where id_usuario= ? ;";
			PreparedStatement statement = connection.prepareStatement(sql);

			statement.setLong(1, Long.parseLong(id));
			statement.executeUpdate();

			connection.commit();

		} catch (SQLException e) {

			e.printStackTrace();
		}
	}
	
	private void deletarTelefones(String id) {

		try {
			String sql = "delete from telefone where usuario_id= ? ;";
			PreparedStatement statement = connection.prepareStatement(sql);

			statement.setLong(1, Long.parseLong(id));
			statement.executeUpdate();

			connection.commit();

		} catch (SQLException e) {

			e.printStackTrace();
		}
	}

	public boolean temEndereco(Long id) {
		try {
			String sql = "select * from model_endereco where id_usuario= ?;";
			PreparedStatement statement = connection.prepareStatement(sql);

			statement.setLong(1, id);

			ResultSet resultSet = statement.executeQuery();

			if (resultSet.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public ModelEndereco buscarEndereco(Long id) {
		try {
			String sql = "select * from model_endereco where id_usuario = ?";
			PreparedStatement statement = connection.prepareStatement(sql);

			statement.setLong(1, id);

			ResultSet resultSet = statement.executeQuery();

			if (resultSet.next()) {
				ModelEndereco modelEndereco = new ModelEndereco();
				modelEndereco.setCep(resultSet.getString("cep"));
				modelEndereco.setRua(resultSet.getString("rua"));
				modelEndereco.setCidade(resultSet.getString("cidade"));
				modelEndereco.setBairro(resultSet.getString("bairro"));
				modelEndereco.setUf(resultSet.getString("uf"));
				modelEndereco.setNumero(resultSet.getString("numero"));

				return modelEndereco;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public int totalPaginas() {
		Double totalPaginas = 0.0;

		try {
			String sql = "select count(1) as total from model_login where useradmin is false";
			PreparedStatement statement = connection.prepareStatement(sql);

			ResultSet resultSet = statement.executeQuery();
			resultSet.next();

			Double usuarios = resultSet.getDouble("total");
			Double paginas = 5.0;

			totalPaginas = usuarios / paginas;

			Double resto = totalPaginas % 2;

			if (resto > 0) {

				totalPaginas++;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return totalPaginas.intValue();
	}

	private List<ModelTelefone> listarTelefones(int id) {

		List<ModelTelefone> telefones = new ArrayList<ModelTelefone>();
		String sql = "select * from telefone where usuario_id=" + id;

		try {

			PreparedStatement statement = connection.prepareStatement(sql);

			ResultSet resultSet = statement.executeQuery();

			while (resultSet.next()) {
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
	
	private boolean temTelefone(Long id) {
		try {
			String sql = "select * from telefone where usuario_id= ?;";
			PreparedStatement statement = connection.prepareStatement(sql);

			statement.setLong(1, id);

			ResultSet resultSet = statement.executeQuery();

			if (resultSet.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

}
