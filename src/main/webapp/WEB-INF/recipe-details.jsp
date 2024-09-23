<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tasty Creations Home</title>
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
    <div class="container mt-5">
        <h1>${recipeInfo.title}</h1>
        <img src="${recipeInfo.image}" alt="${recipeInfo.title}" class="img-fluid">

        <!-- Like, Save, and Rate Buttons -->
        <div>
    <span>
        <a href="${recipeInfo.sourceUrl}" class="btn btn-primary" target="_blank">Save</a>
        <a href="${recipeInfo.sourceUrl}" class="btn btn-primary" target="_blank">Rate</a>

        <!-- Like/Unlike button -->
        <form action="/recipes/${recipeInfo.id}/like" method="POST" style="display:inline;">
            <!-- Display the Recipe ID -->
            <p>Recipe ID: ${recipeInfo.id}</p>

            <!-- Check if the user is logged in and if the user has liked the recipe -->
            <!-- Ensure we're checking against the correct list -->
            <!-- If the user has liked the recipe, show the 'Unlike' button and like count -->
            <!-- If the user hasn't liked the recipe, show the 'Like' button and like count -->
            <c:choose>
                <c:when test="${sessionScope.loggedInUser != null && fn:contains(likedByUsers, sessionScope.loggedInUser)}">
                    <button type="submit" class="btn btn-danger">Unlike (${likeCount})</button>
                </c:when>
                <c:otherwise>
                    <button type="submit" class="btn btn-primary">Like (${likeCount})</button>
                </c:otherwise>
            </c:choose>
        </form>
    </span>
        </div>

        <h3>Ingredients</h3>
        <ul>
            <c:forEach var="ingredient" items="${recipeInfo.extendedIngredients}">
                <li>${ingredient.original}</li>
            </c:forEach>
        </ul>

        <h3>Instructions</h3>
        <p>${recipeInfo.instructions}</p>

        <a href="${recipeInfo.sourceUrl}" class="btn btn-primary" target="_blank">See Recipe on External Website</a>
    </div>
</main>

<div class="container">
    <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
        <div class="col-md-4 d-flex align-items-center">
            <a href="/" class="mb-3 me-2 mb-md-0 text-dark text-decoration-none lh-1">
                <svg class="bi" width="30" height="24" style="fill: black;">
                    <use xlink:href="#bootstrap"></use>
                </svg>
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
