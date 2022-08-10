package servlets;

import java.io.IOException;

import dao.DAOLoginRepository;
import dao.DAOUsuarioRepository;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ModelLogin;


@WebServlet(urlPatterns = {"/ServletLogin", "/principal/ServletLogin"})
public class ServletLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private DAOLoginRepository daoLoginRepository = new DAOLoginRepository();  
    private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();

    public ServletLogin() {
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String acao = request.getParameter("acao");
		
		if(acao != null && acao.equalsIgnoreCase("logout")) {
			request.getSession().invalidate();
			RequestDispatcher redirecionar = request.getRequestDispatcher("/index.jsp");
			redirecionar.forward(request, response);
			
		}else {
			doPost(request, response);
		}
		
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
		String url = request.getParameter("url");
		
		if((login != null && !login.isEmpty())&& (senha != null && !senha.isEmpty())) {
			
			ModelLogin modelLogin = new ModelLogin();
			modelLogin.setLogin(login);
			modelLogin.setSenha(senha);
			
			if(url == null || url.equals("null")) {
				url = "/principal/principal.jsp";
			}
			
			if(daoLoginRepository.validarAutenticacao(modelLogin)) {
				modelLogin = daoUsuarioRepository.buscarUsuario(login);
				
				request.getSession().setAttribute("login", modelLogin.getLogin());
				request.getSession().setAttribute("usuario", modelLogin.getNome());
				request.getSession().setAttribute("isAdmin", daoUsuarioRepository.isAdmin(login));
				request.getSession().setAttribute("modelLogin", modelLogin);
				request.getSession().setAttribute("totalPaginas", daoUsuarioRepository.totalPaginas());
				request.getSession().setAttribute("tituloPagina", "Principal");
				RequestDispatcher redirecionar = request.getRequestDispatcher(url);
				request.setAttribute("msg", "Bem vindo " + modelLogin.getLogin() + "!!!");
				redirecionar.forward(request, response);
			}
			else {
				RequestDispatcher redirecionar = request.getRequestDispatcher("/index.jsp");
				request.setAttribute("msg", "Login e senha incorretos!");
				redirecionar.forward(request, response);
			}
			
		}else {
			RequestDispatcher redirecionar = request.getRequestDispatcher("/index.jsp");
			request.setAttribute("msg", "Informe o login e a senha!");
			redirecionar.forward(request, response);
		}
	}

}
