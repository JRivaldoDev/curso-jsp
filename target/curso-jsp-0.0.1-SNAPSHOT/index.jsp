<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<!DOCTYPE html>
<html lang="en">

<jsp:include page="principal/head.jsp"></jsp:include>

<title>Projeto - Curso JSP</title>

<style type="text/css">
form {
	
	font-family: Cursive;
}

h1 {
	font-family: Cursive;
}

h6 {
	color: red;
	font-family: Cursive;
}

</style>


	
<body themebg-pattern="theme1">
  <!-- Pre-loader start -->
  <div class="theme-loader">
      <div class="loader-track">
          <div class="preloader-wrapper">
              <div class="spinner-layer spinner-blue">
                  <div class="circle-clipper left">
                      <div class="circle"></div>
                  </div>
                  <div class="gap-patch">
                      <div class="circle"></div>
                  </div>
                  <div class="circle-clipper right">
                      <div class="circle"></div>
                  </div>
              </div>
              <div class="spinner-layer spinner-red">
                  <div class="circle-clipper left">
                      <div class="circle"></div>
                  </div>
                  <div class="gap-patch">
                      <div class="circle"></div>
                  </div>
                  <div class="circle-clipper right">
                      <div class="circle"></div>
                  </div>
              </div>
            
              <div class="spinner-layer spinner-yellow">
                  <div class="circle-clipper left">
                      <div class="circle"></div>
                  </div>
                  <div class="gap-patch">
                      <div class="circle"></div>
                  </div>
                  <div class="circle-clipper right">
                      <div class="circle"></div>
                  </div>
              </div>
            
              <div class="spinner-layer spinner-green">
                  <div class="circle-clipper left">
                      <div class="circle"></div>
                  </div>
                  <div class="gap-patch">
                      <div class="circle"></div>
                  </div>
                  <div class="circle-clipper right">
                      <div class="circle"></div>
                  </div>
              </div>
          </div>
      </div>
  </div>
  <!-- Pre-loader end -->

    <section class="login-block">
        <!-- Container-fluid starts -->
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <!-- Authentication card start -->
                    
                        <form class="md-float-material form-material" action="ServletLogin" method="post">
                        <input type="hidden" value=<%=request.getAttribute("url")%> name="url">
                            <div class="text-center">
                                <h1>PROJETO - CURSO JSP</h1>
                            </div>
                            <div class="auth-box card">
                                <div class="card-block">
                                    <div class="row m-b-20">
                                        <div class="col-md-12">
                                            <h3 class="text-center">Bem Vindo!!!</h3>
                                        </div>
                                    </div>
                                    <div class="form-group form-primary">
                                        <input name="login" type="text" class="form-control" required="">
                                        <span class="form-bar"></span>
                                        <label class="float-label">Login</label>
                                        <div class="invalid-feedback">Informe o login!</div>
                                    </div>
                                    <div class="form-group form-primary">
                                        <input name="senha" type="password" class="form-control" required="">
                                        <span class="form-bar"></span>
                                        <label class="float-label">Senha</label>
                                        <div class="invalid-feedback">Informe a senha!</div>
                                    </div>
                                    <div class="row m-t-25 text-left">
                                        <div class="col-12">
                                            
                                            <div class="forgot-phone text-right f-right">
                                                <a href="<%=request.getContextPath()%>/nova_conta.jsp" class="text-right f-w-600"> Criar nova conta!</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row m-t-30">
                                        <div class="col-md-12">
                                            <button type="submit" value="Acessar" class="btn btn-primary btn-md btn-block waves-effect waves-light text-center m-b-20">Acessar</button>
                                        </div>
                                    </div>
                                    <hr/>
                                    <div class="row">
                                        <div class="col-md-10">
                                            <p class="text-inverse text-left m-b-0"> <h6> ${msg}</h6>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <!-- end of form -->
                </div>
                <!-- end of col-sm-12 -->
            </div>
            <!-- end of row -->
        </div>
        <!-- end of container-fluid -->
    </section>


	<jsp:include page="/principal/javascript-file.jsp"></jsp:include>


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