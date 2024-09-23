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
    <title>Tasty Creations Login Registration</title>
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
    <div class="row justify-content-between form-container">
        <!-- Register Form -->
        <div class="col-md-6 form-card">
            <h2 class="display-6 mb-3">Register</h2>
            <div class="card card-sm shadow mb-3">
                <div class="card-body">
                    <form:form action="/register" method="post" modelAttribute="newUser">
                        <!-- Form fields for Register -->
                        <div class="mb-3">
                            <form:label class="form-label" path="firstName">First Name:</form:label>
                            <form:input cssClass="form-control form-control-sm" path="firstName"/>
                            <span class="form-text text-warning">
                                <form:errors path="firstName"/>
                            </span>
                        </div>
                        <div class="mb-3">
                            <form:label class="form-label" path="lastName">Last Name:</form:label>
                            <form:input cssClass="form-control form-control-sm" path="lastName"/>
                            <span class="form-text text-warning">
                                <form:errors path="lastName"/>
                            </span>
                        </div>
                        <div class="mb-3">
                            <form:label class="form-label" path="email">Email:</form:label>
                            <form:input cssClass="form-control form-control-sm" path="email"/>
                            <span class="form-text text-warning">
                                <form:errors path="email"/>
                            </span>
                        </div>
                        <div class="mb-3">
                            <form:label class="form-label" path="birthDate">Date of Birth:</form:label>
                            <form:input type="date" cssClass="form-control form-control-sm" path="birthDate" value="${savedDate}"/>
                            <span class="form-text text-warning">
                                <form:errors path="birthDate"/>
                            </span>
                        </div>
                        <div class="mb-3">
                            <form:label class="form-label" path="password">Password:</form:label>
                            <form:input type="password" cssClass="form-control form-control-sm" path="password"/>
                            <span class="form-text text-warning">
                                <form:errors path="password"/>
                            </span>
                        </div>
                        <div class="mb-3">
                            <form:label class="form-label" path="confirmPassword">Confirm Password:</form:label>
                            <form:input type="password" cssClass="form-control form-control-sm" path="confirmPassword"/>
                            <span class="form-text text-warning">
                                <form:errors path="confirmPassword"/>
                            </span>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Register</button>
                    </form:form>
                </div>
            </div>
        </div>

        <!-- Login Form -->
        <div class="col-md-6 form-card">
            <h2 class="display-6 mb-3">Login</h2>
            <div class="card card-sm shadow mb-3">
                <div class="card-body">
                    <form:form action="/login" method="post" modelAttribute="loginUser">
                        <!-- Form fields for Login -->
                        <div class="mb-3">
                            <form:label class="form-label" path="loginEmail">Email:</form:label>
                            <form:input cssClass="form-control form-control-sm" path="loginEmail"/>
                            <span class="form-text text-warning">
                                <form:errors path="loginEmail"/>
                            </span>
                        </div>
                        <div class="mb-3">
                            <form:label class="form-label" path="loginPassword">Password:</form:label>
                            <form:input type="password" cssClass="form-control form-control-sm" path="loginPassword"/>
                            <span class="form-text text-warning">
                                <form:errors path="loginPassword"/>
                            </span>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Login</button>
                    </form:form>
                </div>
            </div>
        </div>
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

<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>

</html>
