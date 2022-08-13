<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-BR">

<jsp:include page="head.jsp"></jsp:include>

<body>
	<% request.setAttribute("tituloPagina", "Telefones");%>
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
												<h5>Banco de Usuários</h5>
												<!--<span>Add class of <code>.form-control</code> with <code>&lt;input&gt;</code> tag</span>-->
											</div>
											<div class="card-block">
												<form class="form-material" action="<%=request.getContextPath()%>/ServletTelefones"	method="post" id="formFones">
												
													
													<input type="hidden" name="acao" id="acao" value="">
																										
													<div class="form-group form-default form-static-label">
														<input type="text" name="idUser" id="idUser"
															class="form-control" required="required"
															value="${usuarioTelefone.id}" readonly="readonly"> <span
															class="form-bar"></span> <label class="float-label">ID</label>
													</div>
													<div class="form-group form-default form-static-label">
														<input type="text" name="nome" id="nome"
															class="form-control" required="required"
															value="${usuarioTelefone.nome}" readonly="readonly"> <span
															class="form-bar"></span> <label class="float-label">Nome</label>
													</div>
													
													<div class="form-group form-default form-static-label">
														<input type="text" name="numero" id="numero"
															class="form-control" required="required"> 
															<span class="form-bar"></span> <label class="float-label">Numero</label>
													</div>

													<button type="submit"
														class="btn btn-success waves-effect waves-light">Salvar</button>
													
													</form>
													
													</div>
													
													<div><label></label></div>
													<div><h6 style="color:green">${msg}</h6></div>
													
													<span></span>
													<div><h4>Telefones de ${usuarioTelefone.nome}!</h4></div>
													
													<div style="height: 300px;overflow: scroll;">
													<table class="table" id="tabelaListaUsuarios">
													  <thead>
													    <tr>
													      <th scope="col">ID</th>
													      <th scope="col">Nome</th>
													      <th scope="col">Excluir</th>
													    </tr>
													  </thead>
													  <tbody>
													    <c:forEach items='${telefones}' var='f'>
													    	<tr>
														    	<td> <c:out value="${f.id}"></c:out> </td>
														    	<td> <c:out value="${f.numero}"></c:out> </td>
														    	<td> <a class="btn btn-danger waves-effect waves-light" href="<%=request.getContextPath()%>/ServletTelefones?acao=excluirFone&foneId=${f.id}&idUser=${f.usuarioId}">Excluir</a> </td>
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


	<jsp:include page="javascript-file.jsp"></jsp:include>
	
	<script type="text/javascript">

	
	$("#numero").keypress(function (event){
		
		return /\d/.test(String.fromCharCode(event.keyCode));
		
	});
	
	
	</script>
	
</body>

</html>