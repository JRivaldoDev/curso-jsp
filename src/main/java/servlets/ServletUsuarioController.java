package servlets;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.compress.utils.IOUtils;
import org.apache.tomcat.util.codec.binary.Base64;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import dao.DAOUsuarioRepository;
import model.ModelEndereco;
import model.ModelLogin;

@MultipartConfig
@WebServlet("/ServletUsuarioController")
public class ServletUsuarioController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DAOUsuarioRepository daoUsuarioRepository =  new DAOUsuarioRepository();
       
    public ServletUsuarioController() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String nome = request.getParameter("nome");
		String email = request.getParameter("email");
		String login = (String) request.getSession().getAttribute("login");
		String senha = request.getParameter("senha");
		String sexo = request.getParameter("sexo");
		String[] data = {};
		String renda = "";
		
		if(request.getParameter("dataNascimento") != null) {
			data = request.getParameter("dataNascimento").split("/");
		}
		if(request.getParameter("rendaMensal") != null) {
			renda = request.getParameter("rendaMensal").replace("R$", "").replace(" ","").replace(".", "").replace(",", ".");
		}
		
		String cep = request.getParameter("cep");
		String uf = request.getParameter("uf");
		String cidade = request.getParameter("cidade");
		String rua = request.getParameter("rua");
		String bairro = request.getParameter("bairro");
		String numero = request.getParameter("numero");

		ModelLogin modelLogin = new ModelLogin();
		ModelEndereco endereco = new ModelEndereco();
		
		modelLogin.setId(daoUsuarioRepository.buscarUsuario(login).getId());
		modelLogin.setNome(nome);
		modelLogin.setEmail(email);
		modelLogin.setLogin(login);
		modelLogin.setSenha(senha);
		modelLogin.setPerfil(daoUsuarioRepository.buscarUsuario(login).getPerfil());
		modelLogin.setSexo(sexo);
		
		if(data.length > 1) {
			String dataNascimento = data[2]+"-"+data[1]+"-"+data[0];
			modelLogin.setDataNascimento(Date.valueOf(LocalDate.parse(dataNascimento)));
		}
		else if(daoUsuarioRepository.buscarUsuario(login).getDataNascimento() != null) {
			modelLogin.setDataNascimento(daoUsuarioRepository.buscarUsuario(login).getDataNascimento());
		}
		if (!renda.isEmpty()) {
			modelLogin.setRendaMensal(Double.parseDouble(renda));
		}
		
		endereco.setCep(cep);
		endereco.setUf(uf);
		endereco.setCidade(cidade);
		endereco.setRua(rua);
		endereco.setBairro(bairro);
		endereco.setNumero(numero);
		
		modelLogin.setEndereco(endereco);
		
		if(request.getPart("fileFoto") != null) {
			
			Part part = request.getPart("fileFoto");
			byte[] foto = IOUtils.toByteArray(part.getInputStream());
			String contentType = part.getContentType();
			
			if(!contentType.equalsIgnoreCase("application/octet-stream")) {
				String imagemBase64 ="data:" + contentType + ";base64," + new Base64().encodeBase64String(foto);
				
				modelLogin.setFotoUser(imagemBase64);
				modelLogin.setExtensaoFotoUser(contentType.split("\\/")[1]);
			}
			else {
				modelLogin.setFotoUser(daoUsuarioRepository.buscarUsuario(login).getFotoUser());
				modelLogin.setExtensaoFotoUser(daoUsuarioRepository.buscarUsuario(login).getExtensaoFotoUser());
			}
		}
		
		daoUsuarioRepository.editarUsuario(modelLogin);
		
		request.getSession().setAttribute("usuario", modelLogin.getNome());
		request.setAttribute("msg", "Operação realizada com sucesso!");
		request.getSession().setAttribute("modelLogin", modelLogin);
		request.getSession().setAttribute("tituloPagina", "Usuário");
		request.getRequestDispatcher("principal/usuario.jsp").forward(request, response);
				
	}

}
