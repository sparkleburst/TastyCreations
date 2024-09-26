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
            <a class="navbar-brand d-flex align-items-center" href="/">
                <img src="/images/Logo.webp" alt="" width="60" height="60" class="d-inline-block align-text-top">
                <span class="text-dark" style="font-size: .9rem; font-family: 'Playpen Sans', sans-serif;">Tasty Creations</span>

                <div class="d-flex gap-3">
                    <a class="nav-link text-dark" style="font-size: .9rem; font-family: 'Playpen Sans', sans-serif;"
                       href="/recipes/dashboard">Dashboard</a>
                    <a class="nav-link text-dark" style="font-size: .9rem; font-family: 'Playpen Sans', sans-serif;"
                       href="/recipes/${user.id}">My recipes</a>
                    <a class="nav-link text-dark ms-3"
                       style="font-size: .9rem; font-family: 'Playpen Sans', sans-serif;" href="/logout">Logout</a>
                </div>
            </a>
        </div>
    </nav>
</div>
<div class="container mt-5">
    <h1 class="text-dark text-center" style="font-size: 2rem">${recipeInfo.title}</h1>
    <h6 class=" text-center text-muted"><span><strong><a class="text-decoration-none text-muted"
                                                         href="#reviews">${reviews.size()} Reviews | </a></strong></span><strong>Average
        Rating:</strong>
        <c:choose>
            <c:when test="${averageRating > 0}">
                <%--        formatting a double to one decimal place--%>
                <strong>
                    <fmt:formatNumber value="${averageRating}" pattern="#0.0"/>
                </strong>
                <strong> | </strong>
            </c:when>
            <c:otherwise>
                <strong>0 |</strong>
            </c:otherwise>
        </c:choose>

        <!-- Display the total number of likes -->
        <span class="ms-2"><strong>${likeCount} Likes</strong> </span>

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
        <img src="${recipeInfo.image}" alt="${recipeInfo.title}" class="card-img-top img-fluid rounded"
             style="border-radius: 30px; overflow: hidden;">
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

            <div class="d-flex justify-content-between align-items-center mt-2 mt-sm-0">
                <div>
                    <a href="${recipeInfo.sourceUrl}" class="btn btn-blur-2 btn-sm" target="_blank">View Full Recipe</a>
                </div>
                <div class="d-flex align-items-center justify-content-between">
                    <form action="/ratings/recipes/${recipeInfo.id}/rate" method="post" id="ratingForm"
                          class="d-flex align-items-center">
                        <div class="rate mt-3 d-flex mb-3">
                            <div class="rating d-flex">
                                <c:choose>
                                    <c:when test="${hasRated}">
                                        <p class="mt-2 mx-2 star-rating" style="font-size: 1.5rem;">
                                            <c:forEach var="i" begin="1" end="5">
                                                <span class="${i <= userRating.score ? 'filled' : 'empty'}">☆</span>
                                            </c:forEach>
                                        </p>
                                    </c:when>
                                    <c:otherwise>
                                            <input type="radio" name="score" value="5" id="star5" onchange="submitRating()"/><label
                                                for="star5">☆</label>
                                            <input type="radio" name="score" value="4" id="star4" onchange="submitRating()"/><label
                                                for="star4">☆</label>
                                            <input type="radio" name="score" value="3" id="star3" onchange="submitRating()"/><label
                                                for="star3">☆</label>
                                            <input type="radio" name="score" value="2" id="star2" onchange="submitRating()"/><label
                                                for="star2">☆</label>
                                            <input type="radio" name="score" value="1" id="star1" onchange="submitRating()"/><label
                                                for="star1">☆</label>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <input type="hidden" name="raterId" value="${user.id}"/>
                        </div>
                    </form>
                    <form action="/recipes/${recipeInfo.id}/save" method="post" class="d-flex align-items-center">
                        <input type="hidden" name="recipeId" value="${recipeInfo.id}">
                        <input type="hidden" name="userId" value="${user.id}">
                        <button type="submit" class="btn btn-blur-2 btn-sm ms-2">Save to My Recipe</button>
                    </form>
                    <!-- Like/Unlike Button Form -->
                    <c:choose>
                        <c:when test="${hasUserLikedRecipe}">
                            <form action="/likes/recipes/${recipeInfo.id}/unlike" method="post">
                                <input type="hidden" name="likerId" value="${user.id}">
                                <button type="submit" class="btn btn-blur-2 btn-sm ms-2">Unlike 💔</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <form action="/likes/recipes/${recipeInfo.id}/like" method="post">
                                <input type="hidden" name="likerId" value="${user.id}">
                                <button type="submit" class="btn btn-blur-2 btn-sm ms-2">Like ❤️</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    <h3>Reviews (${reviews.size()})</h3>
    <div class="card card-blur shadow mb-5" id="reviews">
        <h5>My Review</h5>
        <c:choose>
            <c:when test="${hasReviewed}">
                <div class="d-flex justify-content-between">
                    <p id="userReviewContent">${userReview.content}</p>
                    <div class="d-flex justify-content-end">
                        <button class="btn btn-blur-2 btn-sm ms-2" onclick="toggleEditForm(this)">Edit Review</button>
                    </div>
                </div>
                <div id="editReviewForm" style="display:none; margin-top: 10px;">
                    <form:form action="/recipes/${recipeInfo.id}/reviews/${userReview.id}/update" method="post"
                               modelAttribute="userReview">
                        <form:hidden path="reviewer" value="${user.id}"/>
                        <form:hidden path="recipeId" value="${recipeInfo.id}"/>
                        <div class="mb-3">
                            <form:textarea path="content" cssClass="form-control" placeholder="Edit your review"/>
                            <span class="form-text text-warning">
                        <form:errors path="content"/>
                    </span>
                        </div>
                        <div class="text-end">
                            <button type="submit" class="btn btn-blur-2 btn-sm ms-2">Update Review</button>
                        </div>
                    </form:form>
                </div>
            </c:when>
            <c:otherwise>
                <form:form action="/recipes/${recipeInfo.id}/reviews/create" method="post" modelAttribute="review">
                    <form:hidden path="reviewer" value="${user.id}"/>
                    <form:hidden path="recipeId" value="${recipeInfo.id}"/>
                    <div class="mb-3">
                        <form:textarea path="content" cssClass="form-control"
                                       placeholder="What did you think about this recipe? Did you make any changes?"/>
                        <span class="form-text text-warning">
                <form:errors path="content"/>
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
                            <p><fmt:formatDate value="${review.createdAt}" pattern="MMMM dd, yyyy"/></p>
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
<script>
    function toggleEditForm(button) {
        const reviewContent = document.getElementById('userReviewContent');
        if (reviewContent) {
            reviewContent.style.display = 'none';
        }
        const editForm = document.getElementById('editReviewForm');
        if (editForm) {
            editForm.style.display = 'block';
        }
        if (button) {
            button.style.display = 'none';
        }
    }

    function submitRating() {
        document.getElementById("ratingForm").submit();
    }
</script>
</body>
</html>
