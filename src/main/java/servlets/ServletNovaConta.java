package servlets;

import java.io.IOException;

import dao.DAOUsuarioRepository;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ModelLogin;

@WebServlet("/ServletNovaConta")
public class ServletNovaConta extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();

	public ServletNovaConta() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		RequestDispatcher redirecionar = request.getRequestDispatcher("/nova_conta.jsp");
		redirecionar.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String nome = request.getParameter("nome");
		String email = request.getParameter("email");
		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
		String sexo = request.getParameter("sexo");

		ModelLogin modelLogin = new ModelLogin();

		modelLogin.setNome(nome);
		modelLogin.setEmail(email);
		modelLogin.setLogin(login);
		modelLogin.setSenha(senha);
		modelLogin.setSexo(sexo);
		modelLogin.setPerfil("SECRETARIO");

		try {
			if(!daoUsuarioRepository.existeUsuario(login)) {
				
				daoUsuarioRepository.gravarUsuario(modelLogin);

				request.getSession().setAttribute("login", modelLogin.getLogin());
				request.getSession().setAttribute("usuario", modelLogin.getNome());
				request.getSession().setAttribute("modelLogin", modelLogin);
				request.getSession().setAttribute("tituloPagina", "Principal");
				request.getRequestDispatcher("/principal/principal.jsp").forward(request,response);
			}
			else {
				RequestDispatcher redirecionar = request.getRequestDispatcher("/nova_conta.jsp");
				request.setAttribute("msg", "Já existe um usuário cadastrado com este login!");
				request.setAttribute("modelLogin", modelLogin);
				redirecionar.forward(request, response);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);

		}
	}
}
