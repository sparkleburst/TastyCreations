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
</head>
<body>
<div class="container mt-5">
  <h1>${recipeInfo.title}</h1>
  <img src="${recipeInfo.image}" alt="${recipeInfo.title}" class="img-fluid">

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

<script src="/webjars/bootstrap/5.3.3/js/bootstrap.min.js"></script>
</body>
</html>
