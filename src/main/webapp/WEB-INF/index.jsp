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
    <div class="row">
        <!-- Left side content (you can add any content here) -->
        <div class="col-md-5">
            <h2 class="text-dark text-center" style="font-size: 2rem; font-family: 'Playpen Sans', sans-serif;">Your Guide to Creating Delicious Meals!</h2>
            <ul class="text-dark text-center mt-lg-5" style="font-size: 1rem; font-family: 'Playpen Sans', sans-serif; list-style-type: none; padding-left: 0;">
                <li>Find the perfect recipe.</li>
                <li>Breakfast, lunch, or dinner.</li>
                <li>Today, tomorrow, or every day.</li>
            </ul>
            <div class="mt-5 text-center">
                <!-- this button goes to login.jsp -->
                <form action="/login" method="get">
                    <button type="submit" class="btn btn-lg btn-blur">Let's Start</button>
                </form>
            </div>
            <div class="mt-5 text-center">
                <button class="btn  btn-blur-2">The recipe of the day - no login required</button>
            </div>
        </div>

        <!-- Right side: Carousel -->
        <div class="col-md-7">
            <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="true">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                </div>
                <div class="carousel-inner">
                    <div class="carousel-item active h-100">
                        <img src="/images/Egg-White-Oatmeal2.webp" class="d-block w-100 img-fluid rounded-5" alt="Slide 1">
                    </div>
                    <div class="carousel-item h-100">
                        <img src="/images/oatmeal.webp" class="d-block w-100 img-fluid rounded-5" alt="Slide 2">
                    </div>
                    <div class="carousel-item h-100">
                        <img src="/images/Oatmeal-Recipe-4.webp" class="d-block w-100 img-fluid rounded-5" alt="Slide 3">
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
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

</main>
</body>
<script src="/webjars/bootstrap/5.3.3/js/bootstrap.min.js"></script>
</html>


