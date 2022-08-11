<%@ page language="java" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<jsp:include page="head.jsp"></jsp:include>

<body>
	<%
	request.setAttribute("tituloPagina", "Relatório - Gráficos");
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
												<h5>Gráfico de Usuários</h5>
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
														<button type="button" onclick="gerarGrafico()" class="btn btn-primary mb-2">Gerar Gráfico</button>
													</div>
													</div>

												</form>
												
												<div>
													<div>
													  <canvas id="myChart"></canvas>
													</div>
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
	
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	
	<script type="text/javascript">
	
	var myChart = new Chart(document.getElementById('myChart'));
	
	function gerarGrafico(){
		
		var urlAction = document.getElementById('relUsuarios').action;
		var dataInicial =  document.getElementById('dataInicial').value;
		var dataFinal =  document.getElementById('dataFinal').value;
		
		$.ajax({
			
			method : "get",
			url : urlAction,
			data : 'dataInicial='+ dataInicial + '&dataFinal=' + dataFinal + '&acao=graficoAjax',
			success : function (response){
				
				var json = JSON.parse(response);
				
				myChart.destroy();
				
				myChart = new Chart(
					    document.getElementById('myChart'),
					    {
					    	  type: 'line',
					    	  data: {
					    		  labels: json.perfis,
					    		  datasets: [{
					    		    label: 'Gráfico de Média Salarial de Usuários',
					    		    backgroundColor: 'rgb(255, 99, 132)',
					    		    borderColor: 'rgb(255, 99, 132)',
					    		    data: json.medias,
					    		  }]
					    		},
					    	  options: {}
					    	}
					  );

			}
			
		}).fail(function(xhr, status, errorThrown){
			alert('Erro ao carregar o gráfico! ' + xhr.responseText);
		});
		 
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