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
<%--comment--%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tasty Creations Search Results</title>
    <link rel="stylesheet" href="/webjars/bootstrap/5.3.3/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/css/style.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playpen+Sans:wght@100..800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>

<!-- Transparent Navbar with logo and login button -->
<div class="container">
    <nav class="navbar navbar-light py-0">
        <div class="container-fluid">
            <!-- Logo inside navbar -->
            <a class="navbar-brand d-flex align-items-center" href="#">
                <img src="/images/Logo.webp" alt="Logo" class="navbar-logo">
            </a>

            <!-- Display logged-in user information if present -->
            <c:if test="${not empty sessionScope.loggedInUser}">
                <span>Logged in as: ${sessionScope.loggedInUser.email}</span>
            </c:if>

            <!-- Login button with blur effect -->
            <form action="/login" method="get">
                <button type="submit" class="btn btn-lg btn-blur">Login</button>
            </form>
        </div>
    </nav>
</div>

<main class="container">

    <!-- Display the API Response (formatted) -->
    <div class="mt-5">
        <h2>Recipe Search Results:</h2>

        <c:if test="${not empty response}">
            <div class="row">
                <c:forEach var="recipe" items="${response}">
                    <div class="col-md-4 mb-4">
                        <div class="card">
                            <img src="${recipe.image}" class="card-img-top" alt="${recipe.title}">
                            <div class="card-body">
                                <h5 class="card-title">${recipe.title}</h5>
                                <p class="card-text">Used ingredients: ${recipe.usedIngredientCount}</p>
                                <p class="card-text">Missing ingredients: ${recipe.missedIngredientCount}</p>

                                <!-- List the used ingredients -->
                                <h6>Used Ingredients:</h6>
                                <ul>
                                    <c:forEach var="usedIngredient" items="${recipe.usedIngredients}">
                                        <li>${usedIngredient.original} <img src="${usedIngredient.image}" alt="${usedIngredient.name}" style="width: 30px; height: 30px;"></li>
                                    </c:forEach>
                                </ul>

                                <!-- List the missed ingredients -->
                                <h6>Missing Ingredients:</h6>
                                <ul>
                                    <c:forEach var="missedIngredient" items="${recipe.missedIngredients}">
                                        <li>${missedIngredient.original} <img src="${missedIngredient.image}" alt="${missedIngredient.name}" style="width: 30px; height: 30px;"></li>
                                    </c:forEach>
                                </ul>

                                <!-- Link to the recipe-details page -->
                                <a href="/recipes/${recipe.id}/information" class="btn btn-primary" target="_self">View Recipe Details</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>

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
