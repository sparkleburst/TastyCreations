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
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tasty Creations</title>
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
            <a class="navbar-brand d-flex align-items-center" href="/recipes/dashboard">
                <img src="/images/Logo.webp" alt="" width="60" height="60" class="d-inline-block align-text-top">
                <span class="text-dark" style="font-size: .9rem; font-family: 'Playpen Sans', sans-serif;">Tasty Creations</span>

                <div class="d-flex gap-3">
                    <a class="nav-link text-dark" style="font-size: .9rem; font-family: 'Playpen Sans', sans-serif;" href="/recipes/dashboard">Dashboard</a>
                    <a class="nav-link text-dark" style="font-size: .9rem; font-family: 'Playpen Sans', sans-serif;" href="/recipes/${user.id}">My recipes</a> <!-- this link goes to login.jsp -->
                    <a class="nav-link text-dark ms-3" style="font-size: .9rem; font-family: 'Playpen Sans', sans-serif;" href="/logout">Logout</a> <!-- this link goes to login.jsp -->
                </div>
            </a>
        </div>
    </nav>
</div>

<main class="container mt-5">
    <h1 class="text-dark text-center" style="font-size: 2rem">Recipe Search Results:</h1>
    <c:if test="${not empty response}">
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 mt-4">
            <c:forEach var="recipe" items="${response}">
                <div class="col">
                    <div class="card shadow card-blur h-100" style="border: none;">
                        <img src="https://img.spoonacular.com/recipes/${recipe.image}" class="card-img-top h-50" alt="${recipe.title}">
                        <div class="card-body  d-flex flex-column">
                            <h5 class="card-title text-center mb-3">${recipe.title}</h5>
                            <p class="card-text text-black">Ready in: <fmt:formatNumber value="${recipe.readyInMinutes}" pattern="#"/> minutes</p>
                            <p class="card-text text-black">Servings: <fmt:formatNumber value="${recipe.servings}" pattern="#"/></p>
                            <div class="mt-auto d-flex justify-content-center">
                                <a href="/recipes/${recipe.id}/information" class="btn btn-blur-2 btn-sm" target="_self">View Recipe Details</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
</main>

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
