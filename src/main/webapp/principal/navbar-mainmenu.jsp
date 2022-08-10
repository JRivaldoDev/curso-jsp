<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<nav class="pcoded-navbar">
                      <div class="sidebar_toggle"><a href="#"><i class="icon-close icons"></i></a></div>
                      <div class="pcoded-inner-navbar main-menu">
                          <div class="">
                              <div class="main-menu-header">
                                  <c:choose>
							 <c:when test="${modelLogin.fotoUser != null && modelLogin.fotoUser != ''}">
								<img class="img-80 img-radius" src="${modelLogin.fotoUser}" alt="User Foto" style="width: 60px; border-radius: 50%">
							 </c:when>
							 <c:otherwise>
								<img class="img-80 img-radius" src="<%=request.getContextPath()%>/assets/images/avatar-blank.jpg" alt="User Foto" style="width: 60px; border-radius: 50%">
							 </c:otherwise>
							 </c:choose>
                                  <div class="user-details">
                                      <span id="more-details"><%= session.getAttribute("usuario") %><i class="fa fa-caret-down"></i></span>
                                  </div>
                              </div>
        
                              <div class="main-menu-content">
                                  <ul>
                                      <li class="more-details">
                                          <a href="ServletLogin?acao=logout"><i class="ti-layout-sidebar-left"></i>Sair</a>
                                      </li>
                                  </ul>
                              </div>
                          </div>
                          <ul class="pcoded-item pcoded-left-item">
                              <li class="active">
                                  <a href="<%= request.getContextPath()%>/principal/principal.jsp" class="waves-effect waves-dark" style="margin-top: 10%">
                                      <span class="pcoded-micon"><i class="ti-home"></i><b>D</b></span>
                                      <span class="pcoded-mtext" data-i18n="nav.dash.main">Início</span>
                                      <span class="pcoded-mcaret"></span>
                                  </a>
                              </li>
                              <li class="pcoded-hasmenu">
                                  <a href="javascript:void(0)" class="waves-effect waves-dark">
                                      <span class="pcoded-micon"><i class="ti-layout-grid2-alt"></i></span>
                                      <span class="pcoded-mtext"  data-i18n="nav.basic-components.main">Menu</span>
                                      <span class="pcoded-mcaret"></span>
                                  </a>
                                  <ul class="pcoded-submenu">
                                      <li class=" ">
                                          <a href="<%=request.getContextPath()%>/principal/usuario.jsp" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Usuário</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>
                                      <c:if test="${isAdmin || modelLogin.perfil == 'ADMINISTRADOR' || modelLogin.perfil == 'AUXILIAR'}">
                                      <li class=" ">
                                          <a href="<%=request.getContextPath()%>/ServletBancoDeUsuarios?acao=listarUsers" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Banco de Usuários</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>
                                      </c:if>
                
                                  </ul>
                              </li>
                          </ul>
        
                          <div class="pcoded-navigation-label" data-i18n="nav.category.forms">Relatórios</div>
                          <ul class="pcoded-item pcoded-left-item">
                              <li>
                                  <a href="<%=request.getContextPath()%>/principal/relatorios.jsp" class="waves-effect waves-dark">
                                      <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
                                      <span class="pcoded-mtext" data-i18n="nav.form-components.main">Relatório de Usuários</span>
                                      <span class="pcoded-mcaret"></span>
                                  </a>
                              </li>
                              <li>
                                  <a href="<%=request.getContextPath()%>/principal/relatorios-grafico.jsp" class="waves-effect waves-dark">
                                      <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
                                      <span class="pcoded-mtext" data-i18n="nav.form-components.main">Gráfico de Usuários</span>
                                      <span class="pcoded-mcaret"></span>
                                  </a>
                              </li>
                          </ul>
        
                  </nav>