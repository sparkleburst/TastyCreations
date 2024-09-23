<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- c:out ; c:forEach etc. --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- Formatting (dates) --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%-- form:form --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- for rendering errors on PUT routes --%>

<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Recipe Details</title>
  <link rel="stylesheet" href="/webjars/bootstrap/5.3.3/css/bootstrap.min.css"/>
  <link rel="stylesheet" href="/css/style.css"/>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Playpen+Sans:wght@100..800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<div class="container">
  <nav class="navbar navbar-light navbar-blur py-0">
    <div class="container-fluid">
      <a class="navbar-brand d-flex align-items-center" href="">
        <img src="/images/Logo.webp" alt="" width="60" height="60" class="d-inline-block align-text-top">
        <span class="text-dark" style="font-size: .9rem; font-family: 'Playpen Sans', sans-serif;">Tasty Creations</span>

        <div class="d-flex">
          <a class="nav-link text-dark" style="font-size: .9rem; font-family: 'Playpen Sans', sans-serif;" href="/login">My recipes</a> <!-- this link goes to login.jsp -->
          <a class="nav-link text-dark ms-3" style="font-size: .9rem; font-family: 'Playpen Sans', sans-serif;" href="/login">Logout</a> <!-- this link goes to login.jsp -->
        </div>
      </a>
    </div>
  </nav>
</div>
<div class="container mt-5">
  <h1 class="text-dark text-center" style="font-size: 2rem">${recipeInfo.title}</h1>
  <div class="card shadow mx-auto my-4" style="max-width: 500px; border: none;">
    <img src="${recipeInfo.image}" alt="${recipeInfo.title}" class="card-img-top img-fluid rounded" style="border-radius: 30px; overflow: hidden;">
  </div>
  <div class="col-sm-4">
    <div class="card card-blur shadow mb-3" style="padding: 8px; max-height: 500px;">

      <div class="card-body p-3">
        <h2 class="mb-2 text-dark">Register</h2>
        <form:form action="/register" method="post" modelAttribute="newUser">
          <div class="mb-0">
            <form:label class="form-label text-dark" path="firstName" style="font-size: 0.9rem;">First Name:</form:label>
            <form:input cssClass="form-control form-control-sm bg-white text-dark" path="firstName" style="height: 30px;"/>
            <span class="form-text text-warning">
                                    <form:errors path="firstName"/>
                                </span>
          </div>
          <div class="mb-0">
            <form:label class="form-label text-dark" path="lastName" style="font-size: 0.9rem;">Last Name:</form:label>
            <form:input cssClass="form-control form-control-sm bg-white text-dark" path="lastName" style="height: 30px;"/>
            <span class="form-text text-warning">
                                    <form:errors path="lastName"/>
                                </span>
          </div>
          <div class="mb-0">
            <form:label class="form-label text-dark" path="email" style="font-size: 0.9rem;">Email:</form:label>
            <form:input cssClass="form-control form-control-sm bg-white text-dark" path="email" style="height: 30px;"/>
            <span class="form-text text-warning">
                                    <form:errors path="email"/>
                                </span>
          </div>
          <div class="mb-0">
            <form:label class="form-label text-dark" path="birthDate" style="font-size: 0.9rem;">Date of Birth:</form:label>
            <form:input type="date" cssClass="form-control form-control-sm bg-white text-dark" path="birthDate" value="${savedDate}" style="height: 30px;"/>
            <span class="form-text text-warning">
                                    <form:errors path="birthDate"/>
                                </span>
          </div>
          <div class="mb-0">
            <form:label class="form-label text-dark" path="password" style="font-size: 0.9rem;">Password:</form:label>
            <form:input type="password" cssClass="form-control form-control-sm bg-white text-dark" path="password" style="height: 30px;"/>
            <span class="form-text text-warning">
                                    <form:errors path="password"/>
                                </span>
          </div>
          <div class="mb-1">
            <form:label class="form-label text-dark" path="confirmPassword" style="font-size: 0.9rem;">Confirm Password:</form:label>
            <form:input type="password" cssClass="form-control form-control-sm bg-white text-dark" path="confirmPassword" style="height: 30px;"/>
            <span class="form-text text-warning">
                                    <form:errors path="confirmPassword"/>
                                </span>
          </div>
          <button type="submit" class="btn btn-blur-2 btn-sm w-100">Register</button>
        </form:form>
      </div>
    </div>
  </div>










  <h3>Ingredients</h3>
  <ul>
    <c:forEach var="ingredient" items="${recipeInfo.extendedIngredients}">
      <li>${ingredient.original}</li>
    </c:forEach>
  </ul>

  <h3>Instructions</h3>
  <p>${recipeInfo.instructions}</p>

  <a href="${recipeInfo.sourceUrl}" class="btn btn-primary" target="_blank">View Full Recipe</a>
</div>
<div class="container">
  <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
    <div class="col-md-4 d-flex align-items-center">
      <a href="/" class="mb-3 me-2 mb-md-0 text-dark text-decoration-none lh-1">
        <svg class="bi" width="30" height="24" style="fill: black;"><use xlink:href="#bootstrap"></use></svg>
      </a>
      <span class="mb-3 mb-md-0 text-dark">© 2024 TastyCreations, Inc</span>
    </div>

    <ul class="nav col-md-4 justify-content-end list-unstyled d-flex footer-icons">
      <li class="ms-3"><a class="text-body-secondary" href="#"><i class="bi bi-twitter text-dark"></i></a></li>
      <li class="ms-3"><a class="text-body-secondary" href="#"><i class="bi bi-instagram text-dark"></i></a></li>
      <li class="ms-3"><a class="text-body-secondary" href="#"><i class="bi bi-facebook text-dark"></i></a></li>
    </ul>
  </footer>
</div>
<script src="/webjars/bootstrap/5.3.3/js/bootstrap.min.js"></script>
</body>
</html>
