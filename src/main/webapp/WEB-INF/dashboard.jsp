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

                <div class="d-flex">
                    <a class="nav-link text-dark" style="font-size: .9rem; font-family: 'Playpen Sans', sans-serif;" href="#">My recipes</a> <!-- this link goes to login.jsp -->
                    <a class="nav-link text-dark ms-3" style="font-size: .9rem; font-family: 'Playpen Sans', sans-serif;" href="/logout">Logout</a> <!-- this link goes to login.jsp -->
                </div>
            </a>
        </div>
    </nav>
</div><main class="container mt-4">
    <h1 class="display-5 mb-3 mt-5 text-dark text-center">What would you like to cook today?</h1>
    <div class="card shadow card-blur mx-auto my-4 p-5">
        <h1 class="display-6 mb-3 mt-5 text-dark">Find Recipes by Ingredients</h1>

        <!-- Recipe Search Form -->
        <form action="/recipes/search" method="get">
            <div class="mb-3">
                <label for="ingredients" class="form-label text-dark">Enter ingredients (comma-separated):</label>
                <input type="text" class="form-control bg-white text-dark" id="ingredients" name="ingredients"
                       placeholder="e.g., tomato, cheese, onion" required>
            </div>
            <div class="d-flex justify-content-end">
                <button type="submit" class="btn btn-blur-2 btn-sm">Search Recipes</button>
            </div>

        </form>
    </div>


    <div class="card shadow card-blur mx-auto my-4 p-5">
<%--        <h1 class="display-6 mb-3 mt-5 text-dark">Complex Search</h1>--%>
        <form action="/recipes/complex-search" method="get">
            <div class="d-flex justify-content-between">
                <div class="mb-3">
                    <label for="query" class="form-label text-dark">Enter dish name:</label>
                    <input type="text" class="form-control bg-white text-dark" id="query" name="query" placeholder="e.g., burger">
                </div>

                <div class="mb-3">
                    <label for="cuisine" class="form-label text-dark">Choose cuisine:</label>
                    <select class="form-select bg-white text-dark" id="cuisine" name="cuisine">
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
                    <label for="diet" class="form-label text-dark">Choose diet:</label>
                    <select class="form-select bg-white text-dark" id="diet" name="diet">
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
                    <label for="intolerances" class="form-label text-dark">Choose intolerances:</label>
                    <select class="form-select bg-white text-dark" id="intolerances" name="intolerances">
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
                    <label for="excludeIngredients" class="form-label text-dark">Enter ingredients to exclude
                        (comma-separated):</label>
                    <input type="text" class="form-control bg-white text-dark" id="excludeIngredients" name="excludeIngredients"
                           placeholder="e.g., tomato, cheese, onion">
                </div>
            </div>
            <div class="d-flex justify-content-end">
                <button type="submit" class="btn btn-blur-2 btn-sm">Search Recipes</button>
            </div>
        </form>
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

<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>




