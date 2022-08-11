<%@ page language="java" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<jsp:include page="head.jsp"></jsp:include>

<body>
	<%
	request.setAttribute("tituloPagina", "Relatório de Usuários");
	%>
	<jsp:include page="theme-loader.jsp"></jsp:include>

	<div id="pcoded" class="pcoded">
		<div class="pcoded-overlay-box"></div>
		<div class="pcoded-container navbar-wrapper">

			<jsp:include page="navbar.jsp"></jsp:include>

			<div class="pcoded-main-container">
				<div class="pcoded-wrapper">

					<jsp:include page="navbar-mainmenu.jsp"></jsp:include>

					<div class="pcoded-content">
						<!-- Page-header start -->

						<jsp:include page="page-header.jsp"></jsp:include>

						<!-- Page-header end -->

						<div class="pcoded-inner-content">
							<!-- Main-body start -->
							<div class="main-body">
								<div class="page-wrapper">
									<!-- Page-body start -->
									<div class="page-body">

										<div class="card">
											<div class="card-header">
												<h5>Relatório de Usuários</h5>
												<!--<span>Add class of <code>.form-control</code> with <code>&lt;input&gt;</code> tag</span>-->
											</div>
											<div class="card-block">
												<form
													action="<%=request.getContextPath()%>/ServletRelatorioController"
													method="post" id="relUsuarios" class="form-inline">
													
													<input type="hidden" id="acaoImprimirTipoRelatorio" name="acao" value="imprimirHtml">
													
													<div class="form-row align-items-center">
														<div class="col-auto">
														 <label for="dataInicial" >Data Inicial</label>
															<input type="text" class="form-control mb-2"
																id="dataInicial" name="dataInicial" value="${dataInicial}">
														</div>
														<div class="col-auto">
														 <label for="dataFinal" >Data Final</label>
															<input type="text" class="form-control mb-2" 
															id="dataFinal"	name="dataFinal" value="${dataFinal}">
														</div>
														<div class="col-auto">
														<button type="submit" class="btn btn-primary mb-2">Imprimir</button>
														<button type="button" onclick="imprimirPdf()" class="btn btn-primary mb-2">Imprimir PDF</button>
													</div>
													</div>

												</form>
												
												<div style="height: 300px;overflow: scroll;">
													<table class="table" id="tabelaListaUsuarios">
													  <thead>
													    <tr>
													      <th scope="col">ID</th>
													      <th scope="col">Nome</th>
													    </tr>
													  </thead>
													  <tbody>
													    <c:forEach items='${usuariosRel}' var='uR'>
													    	<tr>
														    	<td> <c:out value="${uR.id}"></c:out> </td>
														    	<td> <c:out value="${uR.nome}"></c:out> </td>
													    	</tr>
													    	
													    </c:forEach>
													  </tbody>
													</table>
													</div>
												
											</div>
										</div>

									</div>
									<!-- Page-body end -->
								</div>
								<div id="styleSelector"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<jsp:include page="javascript-file.jsp"></jsp:include>
	
	<script type="text/javascript">
	
	function imprimirPdf(){
		document.getElementById("acaoImprimirTipoRelatorio").value = 'imprimirPdf';
		$("#relUsuarios").submit();
		return false;
	}
	

	$( function() {
		  
		  $("#dataInicial").datepicker({
			    dateFormat: 'dd/mm/yy',
			    dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
			    dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
			    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
			    monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
			    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
			    nextText: 'Próximo',
			    prevText: 'Anterior'
			});
	} );
	
	$( function() {
		  
		  $("#dataFinal").datepicker({
			    dateFormat: 'dd/mm/yy',
			    dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
			    dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
			    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
			    monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
			    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
			    nextText: 'Próximo',
			    prevText: 'Anterior'
			});
	} );
	
	
	</script>
</body>

</html>