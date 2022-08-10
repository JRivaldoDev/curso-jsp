package model;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class ModelLogin implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String nome;
	private String email;
	private String login;
	private String senha;
	private String perfil;
	private String sexo;
	private Date dataNascimento;
	
	private String fotoUser;
	private String extensaoFotoUser;
	private Double rendaMensal;
		
	private ModelEndereco endereco = new ModelEndereco();
	private List<ModelTelefone> telefones = new ArrayList<ModelTelefone>();
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getLogin() {
		return login;
	}
	public void setLogin(String login) {
		this.login = login;
	}
	public String getSenha() {
		return senha;
	}
	public void setSenha(String senha) {
		this.senha = senha;
	}
	public String getPerfil() {
		return perfil;
	}
	public void setPerfil(String perfil) {
		this.perfil = perfil;
	}
	public String getSexo() {
		return sexo;
	}
	public void setSexo(String sexo) {
		this.sexo = sexo;
	}

	public String getFotoUser() {
		return fotoUser;
	}
	public void setFotoUser(String fotoUser) {
		this.fotoUser = fotoUser;
	}
	public String getExtensaoFotoUser() {
		return extensaoFotoUser;
	}
	public void setExtensaoFotoUser(String extensaoFotoUser) {
		this.extensaoFotoUser = extensaoFotoUser;
	}
	public ModelEndereco getEndereco() {
		return endereco;
	}
	public void setEndereco(ModelEndereco endereco) {
		this.endereco = endereco;
	}
	
	public Date getDataNascimento() {
		return dataNascimento;
	}
	public void setDataNascimento(Date dataNascimento) {
		this.dataNascimento = dataNascimento;
	}
	public void setRendaMensal(Double rendaMensal) {
		this.rendaMensal = rendaMensal;
	}
	public Double getRendaMensal() {
		return rendaMensal;
	}
	
	public void setTelefones(List<ModelTelefone> telefones) {
		this.telefones = telefones;
	}
	public List<ModelTelefone> getTelefones() {
		return telefones;
	}
	
	public String telefonesToString() {
		String telefones = "";
		
		for (ModelTelefone modelTelefone : this.telefones) {
			telefones += modelTelefone.getNumero() + "; ";
		}
		
		return telefones;
	}
	
	@Override
	public String toString() {
		return "ModelLogin [id=" + id + ", nome=" + nome + ", email=" + email + ", login=" + login + ", senha=" + senha
				+ "]";
	}
	
	

}
