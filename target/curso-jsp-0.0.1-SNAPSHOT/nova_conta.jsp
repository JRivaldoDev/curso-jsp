<%@ page language="java" pageEncoding="ISO-8859-1"%>


<!DOCTYPE html>
<html lang="en">

<jsp:include page="principal/head.jsp"></jsp:include>

<title>Nova Conta</title>

<style type="text/css">

h6 {
	color: red;
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
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <form class="md-float-material form-material" 
                   		 action="<%=request.getContextPath()%>/ServletNovaConta"	method="post">
                        <div class="text-center">
                          <h1>PROJETO - CURSO JSP</h1>
                        </div>
                        <div class="auth-box card">
                            <div class="card-block">
                                <div class="row m-b-20">
                                    <div class="col-md-12">
                                        <h3 class="text-center txt-primary">Cadastro</h3>
                                    </div>
                                </div>
                                <div class="form-group form-primary">
                                    <input type="text" name="nome" id="nome" class="form-control"
									required="required" value="${modelLogin.nome}">
                                    <span class="form-bar"></span>
                                    <label class="float-label">Nome</label>
                                    <div class="invalid-feedback">Informe o nome!</div>
                                </div>
                                
                                <div class="form-group form-primary">
                                    <input type="email" name="email" id="email" class="form-control"
										required="required" autocomplete="off" value="${modelLogin.email}">
                                    <span class="form-bar"></span>
                                    <label class="float-label">E-mail</label>
                                    <div class="invalid-feedback">Informe o e-mail!</div>
                                </div>
                                <div class="form-group form-primary">
                                    <input type="text" name="login" id="login" class="form-control"
										required="required" value="${modelLogin.login}"> 
                                    <span class="form-bar"></span>
                                    <label class="float-label">Login</label>
                                    <div class="invalid-feedback">Informe o login!</div>
                                </div>
                               
                                 <div class="form-group form-primary">
                                     <input type="password" name="senha" id="senha" class="form-control" 
                                         required="required" autocomplete="off" value="${modelLogin.senha}">
                                     <span class="form-bar"></span>
                                     <label class="float-label">Senha</label>
                                     <div class="invalid-feedback">Informe a senha!</div>
                                </div>
                                <div class="row m-t-25 text-left">
                                    <div class="col-md-12">
                                      	<div class="form-check">
										<input type="radio" value="MASCULINO" name="sexo" id="sexo" required="required"> Masculino 
										<input type="radio" value="FEMININO" name="sexo" id="sexo" required="required"> Feminino 
										<div class="invalid-feedback">Informe o sexo!</div>
										</div>
                                    </div>
                                </div>
                                <div class="row m-t-30">
                                    <div class="col-md-12">
                                        <button type="submit" class="btn btn-primary btn-md btn-block waves-effect text-center m-b-20">Cadastrar</button>
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
                </div>
                <!-- end of col-sm-12 -->
            </div>
            <!-- end of row -->
        </div>
        <!-- end of container-fluid -->
    </section>

	<jsp:include page="/principal/javascript-file.jsp"></jsp:include>



</body>
</html>