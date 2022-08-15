package servlets;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import beandto.BeanDtoSalarioUser;
import dao.DAOUsuarioRepository;
import model.ModelLogin;
import util.ReportUtil;

@WebServlet("/ServletRelatorioController")
public class ServletRelatorioController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();

	public ServletRelatorioController() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String acao = request.getParameter("acao");
		String dataInicial = request.getParameter("dataInicial");
		String dataFinal = request.getParameter("dataFinal");
		Date dataI = null;
		Date dataF = null;

		try {

			if (acao.equalsIgnoreCase("graficoAjax") && dataInicial.isEmpty() && dataFinal.isEmpty()) {

				BeanDtoSalarioUser listaUsuarios = daoUsuarioRepository.mediaRendaMensal();

				ObjectMapper mapper = new ObjectMapper();
				String json = mapper.writeValueAsString(listaUsuarios);

				response.getWriter().write(json);
			}
			else if (acao.equalsIgnoreCase("graficoAjax") && !dataInicial.isEmpty() && !dataFinal.isEmpty()) {
				
				dataI = Date.valueOf(new SimpleDateFormat("yyyy-MM-dd")
						.format(new SimpleDateFormat("dd/MM/yyyy").parse(dataInicial)));
				dataF = Date.valueOf(new SimpleDateFormat("yyyy-MM-dd")
						.format(new SimpleDateFormat("dd/MM/yyyy").parse(dataFinal)));
				
				BeanDtoSalarioUser listaUsuarios = daoUsuarioRepository.mediaRendaMensal(dataI,dataF);

				ObjectMapper mapper = new ObjectMapper();
				String json = mapper.writeValueAsString(listaUsuarios);

				response.getWriter().write(json);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@SuppressWarnings("null")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String dataInicial = request.getParameter("dataInicial");
		String dataFinal = request.getParameter("dataFinal");
		String acao = request.getParameter("acao");
		Date dataI = null;
		Date dataF = null;
		
		try {
			if (acao.equalsIgnoreCase("imprimirHtml")) {

				if (dataInicial.isEmpty() && dataFinal.isEmpty()) {
					request.setAttribute("usuariosRel", daoUsuarioRepository.listarUsuariosRel());

				} 
				else if ((dataInicial.contains("/") && dataFinal.contains("/") )
						&& (!dataInicial.isEmpty() && !dataFinal.isEmpty())) {

					dataI = Date.valueOf(new SimpleDateFormat("yyyy-MM-dd")
							.format(new SimpleDateFormat("dd/MM/yyyy").parse(dataInicial)));
					dataF = Date.valueOf(new SimpleDateFormat("yyyy-MM-dd")
							.format(new SimpleDateFormat("dd/MM/yyyy").parse(dataFinal)));

					request.setAttribute("usuariosRel", daoUsuarioRepository.listarUsuariosRelData(dataI, dataF));
					
					if(daoUsuarioRepository.listarUsuariosRelData(dataI, dataF).size() <= 0) {
						request.setAttribute("msgRel", "Não existe usuários correspondente às datas informadas!");
					}
				}
				else {
					request.setAttribute("msgRel", "Por favor informe duas datas válidas nos respectivos campos ou faça uma consulta sem datas para pesquisar todos os usuários!");
				}
				
				request.setAttribute("dataInicial", dataInicial);
				request.setAttribute("dataFinal", dataFinal);
				request.getRequestDispatcher("/principal/relatorios.jsp").forward(request, response);
				
			} 
			else if (acao.equalsIgnoreCase("imprimirPdf")) {
				List<ModelLogin> logins = null;

				if (dataInicial.isEmpty() && dataFinal.isEmpty()) {
					logins = daoUsuarioRepository.listarUsuariosRel();

				} 
				else if ((dataInicial.contains("/") && dataFinal.contains("/") )
						&& (!dataInicial.isEmpty() && !dataFinal.isEmpty())) {
					
					dataI = Date.valueOf(new SimpleDateFormat("yyyy-MM-dd")
							.format(new SimpleDateFormat("dd/MM/yyyy").parse(dataInicial)));
					dataF = Date.valueOf(new SimpleDateFormat("yyyy-MM-dd")
							.format(new SimpleDateFormat("dd/MM/yyyy").parse(dataFinal)));

					logins = daoUsuarioRepository.listarUsuariosRelData(dataI, dataF);
				} 
				
				if(logins != null && !logins.isEmpty()) {
					byte[] relatorio = null;
					String tipo = "";
					HashMap<String, Object> params = new HashMap<String, Object>();
					params.put("PARAM_SUB_REPORT", request.getServletContext().getRealPath("relatorios") + File.separator);

					if (acao.equalsIgnoreCase("imprimirPdf")) {
						relatorio = new ReportUtil().geraRelatorioPDF(logins, "rel-user", params,
								request.getServletContext());
						tipo = ".pdf";
					}
					
					response.setHeader("Content-Disposition", "attachment;filename=arquivo" + tipo);
					response.getOutputStream().write(relatorio);
				}
				else {
					request.setAttribute("msgRel", "Não existe usuários correspondente às datas informadas!");
					request.getRequestDispatcher("/principal/relatorios.jsp").forward(request, response);
				}
				

			}
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

}
