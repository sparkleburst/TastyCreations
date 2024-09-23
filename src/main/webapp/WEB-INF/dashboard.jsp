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
  <title>Game Workshop Dashboard</title>
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
      <a class="navbar-brand d-flex align-items-center" href="#">
        <img src="/images/Logo.webp" alt="" width="60" height="60" class="d-inline-block align-text-top">
        <span class="text-dark" style="font-size: .9rem; font-family: 'Playpen Sans', sans-serif;">Tasty Creations</span>
        <div class="d-flex">
          <a class="nav-link text-dark" style="font-size: .9rem; font-family: 'Playpen Sans', sans-serif;" href="/login">Login</a> <!-- this link goes to login.jsp -->
        </div>
      </a>
    </div>
  </nav>
</div>
<main class="container mt-4">
  <h1 class="display-4 mb-3">Find Recipes by Ingredients</h1>

  <!-- Recipe Search Form -->
  <form action="/recipes/search" method="get">
    <div class="mb-3">
      <label for="ingredients" class="form-label">Enter ingredients (comma-separated):</label>
      <input type="text" class="form-control" id="ingredients" name="ingredients" placeholder="e.g., tomato, cheese, onion" required>
    </div>
    <button type="submit" class="btn btn-primary">Search Recipes</button>
  </form>

  <div class="mt-3 mb-3">
    <h1 class="display-4 mb-3">Complex Search</h1>
    <form action="/recipes/complex-search" method="get">
      <div class="mb-3">
        <label for="query" class="form-label">Enter dish name:</label>
        <input type="text" class="form-control" id="query" name="query" placeholder="e.g., burger">
      </div>

      <div class="mb-3">
        <label for="cuisine" class="form-label">Choose cuisine:</label>
        <select class="form-select" id="cuisine" name="cuisine">
          <option value="" selected disabled>Select cuisine</option>
          <option value="african">African</option>
          <option value="asian">Asian</option>
          <option value="american">American</option>
          <option value="british">British</option>
          <option value="cajun">Cajun</option>
          <option value="caribbean">Caribbean</option>
          <option value="chinese">Chinese</option>
          <option value="eastern European">Eastern European</option>
          <option value="european">European</option>
          <option value="french">French</option>
          <option value="german">German</option>
          <option value="greek">Greek</option>
          <option value="indian">Indian</option>
          <option value="irish">Irish</option>
          <option value="italian">Italian</option>
          <option value="japanese">Japanese</option>
          <option value="jewish">Jewish</option>
          <option value="korean">Korean</option>
          <option value="latin american">Latin American</option>
          <option value="mediterranean">Mediterranean</option>
          <option value="mexican">Mexican</option>
          <option value="middle Eastern">Middle Eastern</option>
          <option value="nordic">Nordic</option>
          <option value="southern">Southern</option>
          <option value="spanish">Spanish</option>
          <option value="thai">Thai</option>
          <option value="vietnamese">Vietnamese</option>
        </select>
      </div>
      <div class="mb-3">
        <label for="diet" class="form-label">Choose diet:</label>
        <select class="form-select" id="diet" name="diet">
          <option value="" selected disabled>Select diet</option>
          <option value="ketogenic">Ketogenic</option>
          <option value="gluten free">Gluten Free</option>
          <option value="vegetarian">Vegetarian</option>
          <option value="vegan">Vegan</option>
          <option value="pescetarian">Pescetarian</option>
          <option value="paleo">Paleo</option>
          <option value="primal">Primal</option>
        </select>
      </div>
      <div class="mb-3">
        <label for="intolerances" class="form-label">Choose intolerances:</label>
        <select class="form-select" id="intolerances" name="intolerances">
          <option value="" selected disabled>Select intolerances</option>
          <option value="dairy">Dairy</option>
          <option value="egg">Egg</option>
          <option value="gluten">Gluten</option>
          <option value="grain">Grain</option>
          <option value="peanut">Peanut</option>
          <option value="seafood">Seafood</option>
          <option value="sesame">Sesame</option>
          <option value="soy">Soy</option>
          <option value="sulfite">Sulfite</option>
          <option value="tree nut">Tree Nut</option>
          <option value="wheat">Wheat</option>
        </select>
      </div>
      <div class="mb-3">
        <label for="excludeIngredients" class="form-label">Enter ingredients to exclude (comma-separated):</label>
        <input type="text" class="form-control" id="excludeIngredients" name="excludeIngredients" placeholder="e.g., tomato, cheese, onion">
      </div>
      <button type="submit" class="btn btn-primary">Search Recipes</button>
    </form>
  </div>
<%--Here's and example how to display complex-search.--%>
  <div class="mt-5">
    <h2>Recipe Complex Search Results:</h2>

    <c:if test="${not empty response}">
      <c:forEach var="recipe" items="${response}">
        <p>==============================</p>
        <p>Title: ${recipe.title}</p>
        <p>Image: <img src="${recipe.image}" alt="${recipe.title}"/></p>
        <p>Ready in: ${recipe.readyInMinutes} minutes</p>
        <p>Servings: ${recipe.servings}</p>
      </c:forEach>
    </c:if>
  </div>

<%--  I needed to comment out the code below, because of the complex search--%>

  <!-- Display the API Response (formatted) -->
<%--  <div class="mt-5">--%>
<%--    <h2>Recipe Search Results By Ingredients:</h2>--%>

<%--    <c:if test="${not empty response}">--%>
<%--      <div class="row">--%>
<%--        <c:forEach var="recipe" items="${response}">--%>
<%--          <div class="col-md-4 mb-4">--%>
<%--            <div class="card">--%>
<%--              <img src="${recipe.image}" class="card-img-top" alt="${recipe.title}">--%>
<%--              <div class="card-body">--%>
<%--                <h5 class="card-title">${recipe.title}</h5>--%>
<%--                <p class="card-text">Used ingredients: ${recipe.usedIngredientCount}</p>--%>
<%--                <p class="card-text">Missing ingredients: ${recipe.missedIngredientCount}</p>--%>

<%--                <!-- List the used ingredients -->--%>
<%--                <h6>Used Ingredients:</h6>--%>
<%--                <ul>--%>
<%--                  <c:forEach var="usedIngredient" items="${recipe.usedIngredients}">--%>
<%--                    <li>${usedIngredient.original} <img src="${usedIngredient.image}" alt="${usedIngredient.name}" style="width: 30px; height: 30px;"></li>--%>
<%--                  </c:forEach>--%>
<%--                </ul>--%>

<%--                <!-- List the missed ingredients -->--%>
<%--                <h6>Missing Ingredients:</h6>--%>
<%--                <ul>--%>
<%--                  <c:forEach var="missedIngredient" items="${recipe.missedIngredients}">--%>
<%--                    <li>${missedIngredient.original} <img src="${missedIngredient.image}" alt="${missedIngredient.name}" style="width: 30px; height: 30px;"></li>--%>
<%--                  </c:forEach>--%>
<%--                </ul>--%>

<%--                <!-- Link to the recipe-details page -->--%>
<%--                <a href="/recipes/${recipe.id}/information" class="btn btn-primary" target="_self">View Recipe Details</a>--%>
<%--              </div>--%>
<%--            </div>--%>
<%--          </div>--%>
<%--        </c:forEach>--%>
<%--      </div>--%>
<%--    </c:if>--%>
<%--  </div>--%>
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

<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>



