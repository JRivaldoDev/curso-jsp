<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Nova Conta</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">


<style type="text/css">
form {
	position: absolute;
	top: 200%;
	left: 40%;
	rigth: 40%;
	font-family: Cursive;
}

h4 {
	font-family: Cursive;
}

h6 {
	color: red;
	font-family: Cursive;
}
</style>

</head>
<body>


	<div class="card">
		<div class="card-header">
			<h4>Cad. Usuário</h4>
			<!--<span>Add class of <code>.form-control</code> with <code>&lt;input&gt;</code> tag</span>-->
		</div>
		<div class="card-block">
			<form class="form-material"
				action="<%=request.getContextPath()%>/ServletNovaConta"
				method="post">
				
				<div class="form-group form-default">
					<label class="float-label">Nome:</label>
					<input type="text" name="nome" id="nome" class="form-control"
						required="required" value="${modelLogin.nome}"> <span
						class="form-bar"></span> 
				</div>
				
				<div class="form-group form-default">
					<label class="float-label">E-mail:</label>
					<input type="email" name="email" id="email" class="form-control"
						required="required" autocomplete="off" value="${modelLogin.email}">
					<span class="form-bar"></span> 
				</div>
				<div class="form-group form-default">
				 	<label class="float-label">Login:</label>
					<input type="text" name="login" id="login" class="form-control"
						required="required" value="${modelLogin.login}"> <span
						class="form-bar"></span>
				</div>
				<div class="form-group form-default">
					 <label class="float-label">Senha:</label>
					<input type="password" name="senha" id="senha" class="form-control"
						required="required" autocomplete="off" value="${modelLogin.senha}">
					<span class="form-bar"></span>
				</div>
				<div class="form-check">
					<input type="radio" value="MASCULINO" name="sexo" id="sexo"> Masculino 
					<input type="radio" value="FEMININO" name="sexo" id="sexo"> Feminino 
				</div>
				<div>
				<label></label>
				</div>
				<button type="submit"
					class="btn btn-success waves-effect waves-light">Cadastrar</button>
				<button type="reset" class="btn btn-danger waves-effect waves-light">Limpar</button>
				<div>
				<label></label>
				</div>
				<div><h6 style="color:red">${msg}</h6></div>
			</form>
		</div>
	</div>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>




</body>
</html>