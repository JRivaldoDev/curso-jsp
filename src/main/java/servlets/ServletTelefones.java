package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DAOTelefoneRepository;
import dao.DAOUsuarioRepository;
import model.ModelTelefone;

@WebServlet("/ServletTelefones")
public class ServletTelefones extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
	private DAOTelefoneRepository daoTelefoneRepository = new DAOTelefoneRepository();

	public ServletTelefones() {
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idUser = request.getParameter("idUser");
		String acao = request.getParameter("acao");
		String foneId = request.getParameter("foneId");
		
		try {
			if(idUser != "null" && !idUser.isEmpty() && acao == null) {
				
				List<ModelTelefone> telefones = daoTelefoneRepository.listarTelefones(Integer.parseInt(idUser));
				request.setAttribute("telefones", telefones);
				request.setAttribute("usuarioTelefone", daoUsuarioRepository.buscarUsuarioID(idUser));
				request.getRequestDispatcher("principal/telefones.jsp").forward(request, response);
			}
			if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("excluirFone")) {
				
				daoTelefoneRepository.deletarTelefone(Integer.parseInt(foneId));
				List<ModelTelefone> telefones = daoTelefoneRepository.listarTelefones(Integer.parseInt(idUser));
				request.setAttribute("telefones", telefones);
				request.setAttribute("usuarioTelefone", daoUsuarioRepository.buscarUsuarioID(idUser));
				request.getRequestDispatcher("principal/telefones.jsp").forward(request, response);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ModelTelefone telefone = new ModelTelefone();
		telefone.setUsuarioId(Integer.parseInt(request.getParameter("idUser")));
		telefone.setNumero(request.getParameter("numero"));
		
		daoTelefoneRepository.gravarTelefone(telefone);
		
		List<ModelTelefone> telefones = daoTelefoneRepository.listarTelefones(telefone.getUsuarioId());
		request.setAttribute("telefones", telefones);
		request.setAttribute("usuarioTelefone", daoUsuarioRepository.buscarUsuarioID(request.getParameter("idUser")));
		request.getRequestDispatcher("/principal/telefones.jsp").forward(request, response);
		
		
	}

}
