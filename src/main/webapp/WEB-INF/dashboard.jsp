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
  <title>Tasty Creations - Recipe Search</title>
  <link rel="stylesheet" href="/webjars/bootstrap/5.3.3/css/bootstrap.min.css"/>
</head>
<body>
<main class="container">
  <h1 class="display-4 mb-3">Find Recipes by Ingredients</h1>

  <!-- Recipe Search Form -->
  <form action="/recipes/search" method="get">
    <div class="mb-3">
      <label for="ingredients" class="form-label">Enter ingredients (comma-separated):</label>
      <input type="text" class="form-control" id="ingredients" name="ingredients" placeholder="e.g., tomato, cheese, onion" required>
    </div>
    <button type="submit" class="btn btn-primary">Search Recipes</button>
  </form>

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

<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>



