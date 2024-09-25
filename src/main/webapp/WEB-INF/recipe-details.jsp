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
<div class="container mt-5">
  <h1 class="text-dark text-center" style="font-size: 2rem">${recipeInfo.title}</h1>
  <h6  class=" text-center text-muted"><span><strong><a class="text-decoration-none text-muted" href="#reviews">${reviews.size()} Reviews | </a></strong></span><strong>Average Rating:</strong>
    <c:choose>
      <c:when test="${averageRating > 0}">
        <%--        formatting a double to one decimal place--%>
        <fmt:formatNumber value="${averageRating}" pattern="#0.0" />
      </c:when>
      <c:otherwise>
        No ratings yet
      </c:otherwise>
    </c:choose>
  </h6>
  <c:if test="${not empty param.error}">
    <div class="alert alert-warning text-center mt-3">
      <c:choose>
        <c:when test="${param.error == 'alreadyRated'}">
          You have already rated this recipe.
        </c:when>
        <c:when test="${param.error == 'userNotFound'}">
          User not found.
        </c:when>
      </c:choose>
    </div>
  </c:if>
  <div class="card shadow mx-auto my-4" style="max-width: 500px; border: none;">
    <img src="${recipeInfo.image}" alt="${recipeInfo.title}" class="card-img-top img-fluid rounded" style="border-radius: 30px; overflow: hidden;">
  </div>

  <div class="card card-blur shadow mb-3" style="padding: 8px;">

      <div class="card-body p-3">
        <h3>Ingredients</h3>
        <ul>
          <c:forEach var="ingredient" items="${recipeInfo.extendedIngredients}">
            <li>${ingredient.original}</li>
          </c:forEach>
        </ul>

        <h3>Instructions</h3>
        <p>${recipeInfo.instructions}</p>
        <div class="text-start">
          <a href="${recipeInfo.sourceUrl}" class="btn btn-blur-2 btn-sm" target="_blank">View Full Recipe</a>
        </div>
        <div class="d-flex justify-content-end align-items-center mt-2 mt-sm-0">
          <form action="/ratings/recipes/${recipeInfo.id}/rate" method="post"  class="d-flex align-items-center">
            <div class="rate mt-3">
              <div class="rating d-flex">
                <input type="radio" name="score" value="5" id="star5" /><label for="star5">☆</label>
                <input type="radio" name="score" value="4" id="star4" /><label for="star4">☆</label>
                <input type="radio" name="score" value="3" id="star3" /><label for="star3">☆</label>
                <input type="radio" name="score" value="2" id="star2" /><label for="star2">☆</label>
                <input type="radio" name="score" value="1" id="star1" /><label for="star1">☆</label>
              </div>
              <input type="hidden" name="raterId" value="${user.id}"/>
              <div class="buttons px-4 mt-0">
                <button type="submit" class="btn btn-warning btn-block rating-submit">Submit</button>
              </div>
            </div>
          </form>

        <%--          <form action="/ratings/recipes/${recipeInfo.id}/rate" method="post" class="d-flex align-items-center">--%>
<%--            <label for="ratingDropdown" class="me-2 mb-0">Rate:</label>--%>
<%--            <select name="score" id="ratingDropdown" class="form-select form-select-sm" style="width: auto;">--%>
<%--              <option value="" disabled selected>Select</option>--%>
<%--              <option value="1">1</option>--%>
<%--              <option value="2">2</option>--%>
<%--              <option value="3">3</option>--%>
<%--              <option value="4">4</option>--%>
<%--              <option value="5">5</option>--%>
<%--            </select>--%>
<%--            <input type="hidden" name="raterId" value="${user.id}">--%>
<%--            <button type="submit" class="btn btn-blur-2 btn-sm ms-2">Submit</button>--%>
<%--          </form>--%>
          <form action="/recipes/${recipeInfo.id}/save" method="post" class="d-flex align-items-center">
            <input type="hidden" name="recipeId" value="${recipeInfo.id}">
            <input type="hidden" name="userId" value="${userId}">
            <button type="submit" class="btn btn-blur-2 btn-sm ms-2">Save to My Recipe</button>
          </form>
        </div>

      </div>
      </div>
  <h3>Reviews (${reviews.size()})</h3>
  <div class="card card-blur shadow mb-5" id="reviews">
    <h5>My Review</h5>
    <c:choose>
        <c:when test="${hasReviewed}">
            <p>${userReview.content}</p>
        </c:when>
        <c:otherwise>
          <form:form action="/recipes/${recipeInfo.id}/reviews/create" method="post" modelAttribute="review">
            <form:hidden path="reviewer" value="${user.id}"/>
            <form:hidden path="recipeId" value="${recipeInfo.id}"/>
            <div class="mb-3">
              <form:textarea path="content" cssClass="form-control" placeholder="What did you think about this recipe? Did you make any changes?"/>
              <span class="form-text text-warning">
                <form:errors path="content" />
            </span>
            </div>
            <div class="text-end">
              <button type="submit" class="btn btn-blur-2 btn-sm ms-2">Submit</button>
            </div>
          </form:form>
        </c:otherwise>
    </c:choose>
    <c:choose>
        <c:when test="${reviews == null or reviews.size() == 0}">
          <p>No reviews yet</p>
        </c:when>
        <c:otherwise>
          <div class="card card-blur shadow mb-3 mt-3">
            <c:forEach var="review" items="${reviews}">
              <div class="mb-3">
                <p><strong>${review.reviewer.firstName}</strong></p>
                <p><fmt:formatDate value="${review.createdAt}" pattern="MMMM dd, yyyy" /></p>
                <p>${review.content}</p>
              </div>
            </c:forEach>
          </div>
        </c:otherwise>
    </c:choose>
  </div>
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
