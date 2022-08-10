<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<jsp:include page="head.jsp"></jsp:include>

<title>Usuário</title>

<body>
<% request.setAttribute("tituloPagina", "Usuário");%>
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
												<h5>Cad. Usuário</h5>
												<!--<span>Add class of <code>.form-control</code> with <code>&lt;input&gt;</code> tag</span>-->
											</div>
											<div class="card-block">
												<form class="form-material" enctype="multipart/form-data"
													action="<%=request.getContextPath()%>/ServletUsuarioController"
													method="post" id="formUser">
													
													<div class="form-group form-default form-static-label">
													<div class="media">
														<c:choose>
														<c:when test="${modelLogin.fotoUser != null && modelLogin.fotoUser != ''}">
															<img class="w3-circle" id="fotoembase64" src="${modelLogin.fotoUser}" alt="User Foto" style="width: 70px; border-radius: 50%">
														</c:when>
														<c:otherwise>
															<img class="w3-circle" id="fotoembase64" src="<%=request.getContextPath()%>/assets/images/avatar-blank.jpg" alt="User Foto" style="width: 70px; border-radius: 50%">
														</c:otherwise>
														</c:choose>
													</div>
													<div>
													    <input type="file" id="fileFoto" name="fileFoto" onchange="vizualizarImg('fotoembase64', 'fileFoto');" class="form-control-file" style="font-size: 10px;">
													</div>
													</div>
													
													<div class="form-group form-default">
														<input type="text" name="nome" id="nome"
															class="form-control" required="required"
															value="${modelLogin.nome}"> <span
															class="form-bar"></span> <label class="float-label">Nome</label>
													</div>
													<div class="form-group form-default form-static-label">
														<input type="text" name="dataNascimento" id="dataNascimento"
															class="form-control" required="required"
															value="${modelLogin.dataNascimento}"> <span
															class="form-bar"></span> <label class="float-label">Dat. Nascimento</label>
													</div>
													<div class="form-group form-default form-static-label">
														<input type="text" name="rendaMensal" id="rendaMensal"
															class="form-control" required="required"
															value="${modelLogin.rendaMensal}"> <span
															class="form-bar"></span> <label class="float-label">Renda Mensal</label>
													</div>
													<div class="form-group form-default form-static-label">
														<input onblur="pesquisaCep()" type="text" name="cep" id="cep"
															class="form-control" required="required"
															value="${modelLogin.endereco.cep}"> <span
															class="form-bar"></span> <label class="float-label">CEP</label>
													</div>
													
													<div class="form-group form-default form-static-label">
														<input type="text" name="uf" id="uf"
															class="form-control" required="required"
															value="${modelLogin.endereco.uf}"> <span
															class="form-bar"></span> <label class="float-label">UF</label>
													</div>
													
													<div class="form-group form-default form-static-label">
														<input type="text" name="cidade" id="cidade"
															class="form-control" required="required"
															value="${modelLogin.endereco.cidade}"> <span
															class="form-bar"></span> <label class="float-label">Cidade</label>
													</div>
													
													<div class="form-group form-default form-static-label">
														<input type="text" name="bairro" id="bairro"
															class="form-control" required="required"
															value="${modelLogin.endereco.bairro}"> <span
															class="form-bar"></span> <label class="float-label">Bairro</label>
													</div>
													
													<div class="form-group form-default form-static-label">
														<input type="text" name="rua" id="rua"
															class="form-control" required="required"
															value="${modelLogin.endereco.rua}"> <span
															class="form-bar"></span> <label class="float-label">Rua</label>
													</div>
													
													<div class="form-group form-default form-static-label">
														<input type="text" name="numero" id="numero"
															class="form-control" required="required"
															value="${modelLogin.endereco.numero}"> <span
															class="form-bar"></span> <label class="float-label">Numero</label>
													</div>
													
													<div class="form-group form-default">
														<input type="email" name="email" id="email"
															class="form-control" required="required"
															autocomplete="off" value="${modelLogin.email}"> <span
															class="form-bar"></span> <label class="float-label">E-mail
														</label>
													</div>
													<div class="form-group form-default">
														<input type="password" name="senha" id="senha"
															class="form-control" required="required"
															autocomplete="off" value="${modelLogin.senha}"> <span
															class="form-bar"></span> <label class="float-label">Senha</label>
													</div>
													<div class="form-check">
														<c:choose>
															<c:when test="${modelLogin.sexo == 'MASCULINO' }"> 
																<c:set var="sexoM" value="checked=\"checked\""/>
															</c:when>
															<c:when test="${modelLogin.sexo == 'FEMININO' }"> 
																<c:set var="sexoF" value="checked=\"checked\""/>
															</c:when>
															</c:choose>
														<input type="radio" value="MASCULINO" name="sexo" ${sexoM}> MASCULINO </> 
														<input type="radio" value="FEMININO" name="sexo" ${sexoF}> FEMININO </>
													</div>
													<div>
													<button type="submit"
														class="btn btn-success waves-effect waves-light">Salvar</button>
													<a href="<%=request.getContextPath()%>/ServletTelefones?idUser=${modelLogin.id}" class="btn btn-dark">Telefones</a>
													<button type="button"
														class="btn btn-danger waves-effect waves-light" onclick="limparForm()">Limpar</button>
													</div>
													
													<div><label></label></div>
													<div><h6 style="color:green">${msg}</h6></div>
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
	
	var dataNascimento = document.getElementById("#dataNascimento").value;
	
	if(dataNascimento != null && dataNascimento != ''){
		var dateFormat = new Date($("#dataNascimento").val());
		$("#dataNascimento").val(dateFormat.toLocaleDateString('pt-BR', {timeZone: 'UTC'}));
	}
	
	
	$( function() {
		  
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
	
	$("#cep").keypress(function (event){
		return /\d/.test(String.fromCharCode(event.keyCode));
	});
	
	$("#numero").keypress(function (event){
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
	
	function limparForm(){
		
		var elementos = document.getElementById("formUser").elements;
		
		for(p = 0; p < elementos.length; p++){
			elementos[p].value = '';
		}
		
	}
	
	</script>
	
</body>

</html>