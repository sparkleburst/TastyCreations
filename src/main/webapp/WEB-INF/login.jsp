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
</head>
<main class="container">
    <h1 class="display-4 mb-3">Login or Register for Our Site</h1>
    <div class="row">
        <div class="col">
            <h2 class="display-6 mb-3">Register</h2>
            <div class="card shadow mb-3">
                <div class="card-body">
                    <form:form action="/register" method="post" modelAttribute="newUser">
                        <div class="mb-3">
                            <form:label class="form-label" path="firstName">First Name:</form:label>
                            <form:input cssClass="form-control" path="firstName"/>
                            <span class="form-text text-warning">
                                    <form:errors path="firstName"/>
                                </span>
                        </div>
                        <div class="mb-3">
                            <form:label class="form-label" path="lastName">Last Name:</form:label>
                            <form:input cssClass="form-control" path="lastName"/>
                            <span class="form-text text-warning">
                                    <form:errors path="lastName"/>
                                </span>
                        </div>
                        <div class="mb-3">
                            <form:label class="form-label" path="email">Email:</form:label>
                            <form:input cssClass="form-control" path="email"/>
                            <span class="form-text text-warning">
                                    <form:errors path="email"/>
                                </span>
                        </div>
                        <div class="mb-3">
                            <form:label class="form-label" path="birthDate">Date of Birth:</form:label>
                            <form:input type="date" cssClass="form-control" path="birthDate" value="${savedDate}"/>
                            <span class="form-text text-warning">
                                    <form:errors path="birthDate"/>
                                </span>
                        </div>
                        <div class="mb-3">
                            <form:label class="form-label" path="password">Password:</form:label>
                            <form:input type="password" cssClass="form-control" path="password"/>
                            <span class="form-text text-warning">
                                    <form:errors path="password"/>
                                </span>
                        </div>
                        <div class="mb-3">
                            <form:label class="form-label" path="confirmPassword">Confirm Password:</form:label>
                            <form:input type="password" cssClass="form-control" path="confirmPassword"/>
                            <span class="form-text text-warning">
                                    <form:errors path="confirmPassword"/>
                                </span>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Register</button>
                    </form:form>
                </div>
            </div>
        </div>
        <div class="col">
            <h2 class="display-6 mb-3">Login</h2>
            <div class="card shadow mb-3">
                <div class="card-body">
                    <form:form action="/login" method="post" modelAttribute="loginUser">
                        <div class="mb-3">
                            <form:label class="form-label" path="loginEmail">Email:</form:label>
                            <form:input cssClass="form-control" path="loginEmail"/>
                            <span class="form-text text-warning">
                                    <form:errors path="loginEmail"/>
                                </span>
                        </div>
                        <div class="mb-3">
                            <form:label class="form-label" path="loginPassword">Password:</form:label>
                            <form:input type="password" cssClass="form-control" path="loginPassword"/>
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
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>


