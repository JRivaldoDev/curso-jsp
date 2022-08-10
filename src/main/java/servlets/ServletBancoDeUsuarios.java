package servlets;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import org.apache.commons.compress.utils.IOUtils;
import org.apache.tomcat.util.codec.binary.Base64;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.DAOUsuarioRepository;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.ModelEndereco;
import model.ModelLogin;

@MultipartConfig
@WebServlet(urlPatterns = { "/ServletBancoDeUsuarios"})
public class ServletBancoDeUsuarios extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();

	public ServletBancoDeUsuarios() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {

			String acao = request.getParameter("acao");

			if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletar")) {
				String idUser = request.getParameter("id");
								
				daoUsuarioRepository.deletarUsuario(idUser);
				
				List<ModelLogin> lista = daoUsuarioRepository.listarUsuarios();
				request.getSession().setAttribute("listaModelLogin", lista);
				request.getSession().setAttribute("totalPaginas", daoUsuarioRepository.totalPaginas());
				request.setAttribute("msg", "Operação realizada com sucesso!");
				request.setAttribute("modelLogin2", new ModelLogin());
				request.getRequestDispatcher("/principal/banco_de_usuarios.jsp").forward(request, response);
			}

			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletarAjax")) {

				String idUser = request.getParameter("iduser");

				daoUsuarioRepository.deletarUsuario(idUser);

				response.getWriter().write("Operação concluída com sucesso!");

			} 
			
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscarAjax")) {

				String nomeBusca = request.getParameter("nomeBusca");
				
				List<ModelLogin> listaUsuarios = daoUsuarioRepository.buscarListUsuarios(nomeBusca);
				
				ObjectMapper mapper = new ObjectMapper();
				String json = mapper.writeValueAsString(listaUsuarios);
				
				response.getWriter().write(json);

			} 
			
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("verEditar")) {

				String verId = request.getParameter("verId");
				
				ModelLogin modelLogin = daoUsuarioRepository.buscarUsuarioID(verId);
				
				request.setAttribute("modelLogin2", modelLogin);
				request.getRequestDispatcher("/principal/banco_de_usuarios.jsp").forward(request, response);

			} 
			
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("listarUsers")) {

				List<ModelLogin> lista = daoUsuarioRepository.listarUsuarios();
				request.getSession().setAttribute("listaModelLogin", lista);
				request.getSession().setAttribute("totalPaginas", daoUsuarioRepository.totalPaginas());
				request.setAttribute("msg", "Usuários carregados!");
				request.getRequestDispatcher("/principal/banco_de_usuarios.jsp").forward(request, response);

			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("paginar")) {
				
				int offset = Integer.parseInt(request.getParameter("offset"));
				List<ModelLogin> lista = daoUsuarioRepository.listarUsuariosPaginada(offset);
				request.getSession().setAttribute("listaModelLogin", lista);
				request.getSession().setAttribute("totalPaginas", daoUsuarioRepository.totalPaginas());
				request.setAttribute("msg", "Usuários carregados!");
				request.getRequestDispatcher("/principal/banco_de_usuarios.jsp").forward(request, response);
			}
			
			else {
				request.getRequestDispatcher("/principal/banco_de_usuarios.jsp").forward(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("/erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String id = request.getParameter("id");
		String nome = request.getParameter("nome");
		String email = request.getParameter("email");
		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
		String perfil = request.getParameter("perfil");
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

		modelLogin.setId(Long.parseLong(id));
		modelLogin.setNome(nome);
		modelLogin.setEmail(email);
		modelLogin.setLogin(login);
		modelLogin.setSenha(senha);
		modelLogin.setPerfil(perfil);
		modelLogin.setSexo(sexo);
		
		if(data.length > 1) {
			String dataNascimento = data[2]+"-"+data[1]+"-"+data[0];
			modelLogin.setDataNascimento(Date.valueOf(LocalDate.parse(dataNascimento)));
		}
		else if(daoUsuarioRepository.buscarUsuarioID(id).getDataNascimento() != null) {
			modelLogin.setDataNascimento(daoUsuarioRepository.buscarUsuarioID(id).getDataNascimento());
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
		
		List<ModelLogin> lista = daoUsuarioRepository.listarUsuarios();
		request.getSession().setAttribute("listaModelLogin", lista);
		request.setAttribute("modelLogin2", modelLogin);
		request.getSession().setAttribute("totalPaginas", daoUsuarioRepository.totalPaginas());
		request.setAttribute("msg", "Operação realizada com sucesso!");
		request.getRequestDispatcher("/principal/banco_de_usuarios.jsp").forward(request, response);

	}

}
