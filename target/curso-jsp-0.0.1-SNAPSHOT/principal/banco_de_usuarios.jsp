<%@ page language="java" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="pt-BR">

<jsp:include page="head.jsp"></jsp:include>


<body>
 	<% request.setAttribute("tituloPagina", "Banco de Usuário");%>
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
												<form class="form-material" enctype="multipart/form-data"
													action="<%=request.getContextPath()%>/ServletBancoDeUsuarios"
													method="post" id="formUsuarios">
													
													<input type="hidden" name="acao" id="acao" value="">
																										
													<div class="form-group form-default form-static-label">
													<div class="media">
														<c:choose>
														<c:when test="${modelLogin2.fotoUser != null && modelLogin2.fotoUser != ''}">
															<img class="w3-circle" id="fotoembase64" src="${modelLogin2.fotoUser}" alt="User Foto" style="width: 90px">
														</c:when>
														<c:otherwise>
															<img class="w3-circle" id="fotoembase64" src="<%=request.getContextPath()%>/assets/images/avatar-blank.jpg" alt="User Foto" style="width: 90px">
														</c:otherwise>
														</c:choose>
													</div>
													<div>
													    <input type="file" id="fileFoto" name="fileFoto" onchange="vizualizarImg('fotoembase64', 'fileFoto');" class="form-control-file" style="font-size: 10px;">
													</div>
													</div>
													<div class="form-group form-default form-static-label">
														<input type="text" name="id" id="id"
															class="form-control" required="required"
															value="${modelLogin2.id}" readonly="readonly"> <span
															class="form-bar"></span> <label class="float-label">ID</label>
													</div>
													<div class="form-group form-default form-static-label">
														<input type="text" name="nome" id="nome"
															class="form-control" required="required"
															value="${modelLogin2.nome}"> <span
															class="form-bar"></span> <label class="float-label">Nome</label>
													</div>
													
													<div class="form-group form-default form-static-label">
														<input type="text" name="dataNascimento" id="dataNascimento"
															class="form-control" required="required"
															value="${modelLogin2.dataNascimento}"> <span
															class="form-bar"></span> <label class="float-label">Dat. Nascimento</label>
													</div>
													<div class="form-group form-default form-static-label">
														<input type="text" name="rendaMensal" id="rendaMensal"
															class="form-control" required="required"
															value="${modelLogin2.rendaMensal}"> <span
															class="form-bar"></span> <label class="float-label">Renda Mensal</label>
													</div>
													<div class="form-group form-default form-static-label">
														<input onblur="pesquisaCep()" type="text" name="cep" id="cep"
															class="form-control" required="required"
															value="${modelLogin2.endereco.cep}"> <span
															class="form-bar"></span> <label class="float-label">CEP</label>
													</div>
													
													<div class="form-group form-default form-static-label">
														<input type="text" name="uf" id="uf"
															class="form-control" required="required"
															value="${modelLogin2.endereco.uf}"> <span
															class="form-bar"></span> <label class="float-label">UF</label>
													</div>
													
													<div class="form-group form-default form-static-label">
														<input type="text" name="cidade" id="cidade"
															class="form-control" required="required"
															value="${modelLogin2.endereco.cidade}"> <span
															class="form-bar"></span> <label class="float-label">Cidade</label>
													</div>
													
													<div class="form-group form-default form-static-label">
														<input type="text" name="bairro" id="bairro"
															class="form-control" required="required"
															value="${modelLogin2.endereco.bairro}"> <span
															class="form-bar"></span> <label class="float-label">Bairro</label>
													</div>
													
													<div class="form-group form-default form-static-label">
														<input type="text" name="rua" id="rua"
															class="form-control" required="required"
															value="${modelLogin2.endereco.rua}"> <span
															class="form-bar"></span> <label class="float-label">Rua</label>
													</div>
													
													<div class="form-group form-default form-static-label">
														<input type="text" name="numero" id="numero"
															class="form-control" required="required"
															value="${modelLogin2.endereco.numero}"> <span
															class="form-bar"></span> <label class="float-label">Numero</label>
													</div>
													
													<div class="form-group form-default form-static-label">
														<input type="email" name="email" id="email"
															class="form-control" required="required"
															autocomplete="off" value="${modelLogin2.email}"> <span
															class="form-bar"></span> <label class="float-label">E-mail
														</label>
													</div>
													<div class="form-group form-default form-static-label">
														<input type="text" name="login" id="login"
															class="form-control" required="required"
															value="${modelLogin2.login}" readonly="readonly"> <span
															class="form-bar"></span> <label class="float-label">Login</label>
													</div>
													<div class="form-group form-default form-static-label">
														<input type="password" name="senha" id="senha"
															class="form-control" required="required"
															autocomplete="off" value="${modelLogin2.senha}"> <span
															class="form-bar"></span> <label class="float-label">Senha</label>
													</div>
													<div class="form-group form-default form-static-label">
														<select class="form-control" name="perfil" id="perfil">
														<c:choose>
															<c:when test="${modelLogin2.perfil == 'ADMINISTRADOR' }"> 
																<c:set var="perf" value="ADMINISTRADOR"/>
															</c:when>
															<c:when test="${modelLogin2.perfil == 'AUXILIAR' }"> 
																<c:set var="perf" value="AUXILIAR"/>
															</c:when>
															<c:when test="${modelLogin2.perfil == 'SECRETARIO' }"> 
																<c:set var="perf" value="SECRETARIO"/>
															</c:when>
															<c:otherwise>
																<c:set var="perf" value="[Selecione um perfil]"/>
															</c:otherwise>
															</c:choose>
															<option selected="selected">${perf}</option>
															<option value="ADMINISTRADOR">ADMINISTRADOR</option>
															<option value="AUXILIAR">AUXILIAR</option>
															<option value="SECRETARIO">SECRETARIO</option>
														</select>
														<label class="float-label">Perfil</label>
													</div>
													<div class="form-check">
														<c:choose>
															<c:when test="${modelLogin2.sexo == 'MASCULINO' }"> 
																<c:set var="sexoM" value="checked=\"checked\""/>
															</c:when>
															<c:when test="${modelLogin2.sexo == 'FEMININO' }"> 
																<c:set var="sexoF" value="checked=\"checked\""/>
															</c:when>
															</c:choose>
														<input type="radio" value="MASCULINO" name="sexo" ${sexoM}> MASCULINO </> 
														<input type="radio" value="FEMININO" name="sexo" ${sexoF}>FEMININO </>
													</div>
													<div>
													<button type="submit"
														class="btn btn-success waves-effect waves-light">Salvar</button>
													<button type="button"
														class="btn btn-danger waves-effect waves-light" onclick="deletarUsuarioAjax();">Deletar</button>
													<c:if test="${modelLogin2.id > 0}">
													<a href="<%=request.getContextPath()%>/ServletTelefones?idUser=${modelLogin2.id}" class="btn btn-dark">Telefones</a>
													</c:if>
													<button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#pesquisaModal"> Pesquisar</button>
													</div>
													
													<div><label></label></div>
													<div>
													<h6 style="color:green">${msg}</h6>
													<h6 style="color:red">${msgErro}</h6>
													</div>
													<span></span>
													<div><h4>Lista de Usuários</h4></div>
													
													<div style="height: 300px;overflow: scroll;">
													<table class="table" id="tabelaListaUsuarios">
													  <thead>
													    <tr>
													      <th scope="col">ID</th>
													      <th scope="col">Nome</th>
													      <th scope="col">Ver</th>
													    </tr>
													  </thead>
													  <tbody>
													    <c:forEach items='${listaModelLogin}' var='mL'>
													    	<tr>
														    	<td> <c:out value="${mL.id}"></c:out> </td>
														    	<td> <c:out value="${mL.nome}"></c:out> </td>
														    	<td> <a class="btn btn-outline-success" href="<%=request.getContextPath()%>/ServletBancoDeUsuarios?acao=verEditar&verId=${mL.id}">Ver</a> </td>
													    	</tr>
													    	
													    </c:forEach>
													  </tbody>
													</table>
													</div>
													
													<nav aria-label="Page navigation example">
													  <ul class="pagination">
													   <c:forEach begin="1" end="${totalPaginas}" step="1" varStatus="loop">
													    <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/ServletBancoDeUsuarios?acao=paginar&offset=${(loop.count - 1) * 5}">${loop.count}</a></li>
													    </c:forEach>
													  </ul>
													</nav>
													
												</form>
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
	
	<div class="modal fade" id="pesquisaModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Pesquisar Usuários</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <div class="input-group mb-3">
			  <input type="text" class="form-control" placeholder="Nome do usuário" aria-label="nome" id="nomeBusca" aria-describedby="basic-addon2">
			  <div class="input-group-append">
			    <button class="btn btn-outline-success" type="button" onclick="buscarUsuario();">Buscar</button>
			  </div>
			</div>
			
			<div style="height: 300px;overflow: scroll;">
			<table class="table" id="tabelaResultados">
			  <thead>
			    <tr>
			      <th scope="col">ID</th>
			      <th scope="col">Nome</th>
			      <th scope="col">Ver</th>
			    </tr>
			  </thead>
			  <tbody>
			     <c:forEach items='${listaModelLogin2}' var='mL'>
			    	<tr>
			    	<td> <c:out value="${mL.id}"></c:out> </td>
			    	<td> <c:out value="${mL.nome}"></c:out> </td>
			    	<td> <a class="btn btn-outline-success" href="<%=request.getContextPath()%>/ServletBancoDeUsuarios?acao=verEditar&verId=${mL.id}">Ver</a> </td>
			    	</tr>
													    	
			    </c:forEach>
			  </tbody>
			</table>
			</div>
			
	      </div>
	      <span id="totalResultados"></span>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
	      </div>
	    </div>
	  </div>
	</div>
	
		
	<jsp:include page="javascript-file.jsp"></jsp:include>
			
	<script type="text/javascript">
		
		$("#rendaMensal").maskMoney({prefix:"R$ ", decimal:",", thousands:"."});
		
		const formatter = new Intl.NumberFormat('pt-BR',{
			currency: 'BRL',
			minimunFractionDigits: 2
		});
		
		$("#rendaMensal").val(formatter.format($("#rendaMensal").val()));
		
		$("#rendaMensal").focus();
		
		$('#nome').focus();
		
		
		$(function() {
			  
			  $("#dataNascimento").datepicker({
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
		
		$("#numero").keypress(function(event){
			return /\d/.test(String.fromCharCode(event.keyCode));			
		});
		
		$("#cep").keypress( function(event){
			return /\d/.test(String.fromCharCode(event.keyCode));			
		});
	
		function pesquisaCep(){
			
			var cep = document.getElementById("cep").value;
			
			$.getJSON("https://viacep.com.br/ws/"+ cep +"/json/?callback=?", function(dados) {

                if (!("erro" in dados)) {
                    //Atualiza os campos com os valores da consulta.
                    $("#rua").val(dados.logradouro);
                    $("#bairro").val(dados.bairro);
                    $("#cidade").val(dados.localidade);
                    $("#uf").val(dados.uf);
                } //end if.
                
            });
			
		}
		
		
		function vizualizarImg(fotoembase64, fileFoto){
			
			var preview = document.getElementById(fotoembase64);
			var fileUser = document.getElementById(fileFoto).files[0];
			var reader = new FileReader();
			
			reader.onloadend = function(){
				preview.src = reader.result;				
			};
			
			if(fileUser){
				reader.readAsDataURL(fileUser);
			}else{
				preview.src = '';
			}
			
		}
		
	
		function verEditar(id){
			var urlAction = document.getElementById('formUsuarios').action;
			
			window.location.href = urlAction + '?acao=verEditar&verId=' + id;
		}
	
		function buscarUsuario(){
			
			var nomeBusca =  document.getElementById("nomeBusca").value;
			
			if(nomeBusca != null && nomeBusca != '' && nomeBusca.trim() != ''){
				var urlAction = document.getElementById('formUsuarios').action;
								
				$.ajax({
					
					method : "get",
					url : urlAction,
					data : "nomeBusca="+ nomeBusca + "&acao=buscarAjax",
					success : function (response){
						
						var json = JSON.parse(response);
						
						$('#tabelaResultados > tbody > tr').remove();
						
						for(var p = 0; p < json.length; p++ ){
							$('#tabelaResultados > tbody').append('<tr><td>' + json[p].id + '</td><td>' + json[p].nome + '</td><td><button type="button" onclick="verEditar('+json[p].id+')" class="btn btn-info">Ver</button></td></tr>');
						}
						document.getElementById("totalResultados").textContent = "Resultados: " + json.length;

					}
					
				}).fail(function(xhr, status, errorThrown){
					alert('Erro ao buscar usuário! ' + xhr.responseText);
				});
				
			}
			
		}
	
	
		function deletarUsuario(){
			if (confirm("Deseja excluir o usuário?")){
				document.getElementById("formUsuarios").method = "get";
				document.getElementById("acao").value = "deletar";
				document.getElementById("formUsuarios").submit();
			}
		}
	
		function deletarUsuarioAjax(){
			if(confirm('Deseja excluir o usuário?')){
				
				var urlAction = document.getElementById('formUsuarios').action;
				var id =  document.getElementById("id").value;
				
				$.ajax({
					
					method : "get",
					url : urlAction,
					data : "iduser="+ id + "&acao=deletarAjax",
					success : function (response){
						
						limparForm();
						alert(response);

					}
					
				}).fail(function(xhr, status, errorThrown){
					alert('Erro ao deletar usuário! ' + xhr.responseText);
				});


			}
		}
		
		function limparForm(){
			
			var elementos = document.getElementById("formUsuarios").elements;
			
			for(p = 0; p < elementos.length; p++){
				elementos[p].value = '';
			}
			
		}
	
		
		
	</script>
	
	
</body>

</html>