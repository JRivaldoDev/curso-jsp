<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Curso JSP</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">


<style type="text/css">
form {
	position: absolute;
	top: 30%;
	left: 33%;
	rigth: 33%;
	font-family: Cursive;
}

h3 {
	font-family: Cursive;
}

h6 {
	color: red;
	font-family: Cursive;
}

</style>

</head>
<body>
	

	<form action="ServletLogin" method="post"
		class="row g-3 needs-validation" novalidate>
		<input type="hidden" value=<%=request.getAttribute("url")%> name="url">
		
		<div class="col-12">
			<h3>Bem Vindo ao Curso de JSP!</h3>
		</div>
		
		<div class="col-auto">
			<label for="validationCustom01" class="form-label">Login:</label> <input
				name="login" type="text" class="form-control" required size="40">
			<div class="invalid-feedback">Informe o login!</div>
		</div>

		<div class="col-auto">
			<label for="validationCustom02" class="form-label">Senha:</label> <input
				name="senha" type="password" class="form-control" required size="40">
			<div class="invalid-feedback">Informe a senha!</div>
		</div>

		<div class="col-12">
			<input type="submit" value="Acessar" class="btn btn-primary">
			<a href="<%=request.getContextPath()%>/nova_conta.jsp" >Criar nova conta!</a>
		</div>
		
		<div class="col-12">
			<h6>${msg}</h6>
		</div>

	</form>
	

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>


	<script type="text/javascript">
		(function() {
			'use strict'

			// Fetch all the forms we want to apply custom Bootstrap validation styles to
			var forms = document.querySelectorAll('.needs-validation')

			// Loop over them and prevent submission
			Array.prototype.slice.call(forms).forEach(function(form) {
				form.addEventListener('submit', function(event) {
					if (!form.checkValidity()) {
						event.preventDefault()
						event.stopPropagation()
					}

					form.classList.add('was-validated')
				}, false)
			})
		})()
	</script>

</body>
</html>