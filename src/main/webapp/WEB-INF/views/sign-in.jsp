<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%> <%@ taglib uri="http://www.springframework.org/tags/form"
prefix="form"%> <%@ taglib uri="http://www.springframework.org/security/tags"
prefix="sec"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Portal</title>
    <link
      rel="stylesheet"
      href="https://unicons.iconscout.com/release/v4.0.8/css/line.css"
    />
    <link rel="stylesheet" href="/css/global.css" />
    <link rel="stylesheet" href="/css/shared-component.css" />
    <link rel="stylesheet" href="/css/login.css" />
  </head>

  <body>
    <div class="login-page">
      <div class="login-form-column">
        <div class="back">
          <a href="/" class="back">
            <i class="uil uil-backspace"></i>
            <span class="back-text">Back</span>
          </a>
        </div>
        <div class="login-form-container">
          <a href="/" class="logo"
            ><img src="/images/logo.svg" alt="logo" />Carcon</a
          >

          <!-- Notification Container -->
          <c:if test="${!empty notificationMessage}">
            <div
              id="notification-container"
              class="notification-container ${notificationType}"
            >
              <div class="notification-message">
                <p id="notification-text">${notificationMessage}</p>
                <button
                  class="close-notification"
                  onclick="closeNotification()"
                >
                  <i class="uil uil-times"></i>
                </button>
              </div>
            </div>
          </c:if>

          <!-- Sign In Form -->
          <div id="signInForm">
            <h2 class="login-title">Log in to your account</h2>
            <h1 class="login-subtitle">
              Welcome back! Please enter your details
            </h1>

            <form action="/signin" method="post">
              <input
                type="hidden"
                name="${_csrf.parameterName}"
                value="${_csrf.token}"
              />
              <label class="label" for="username">Username</label>
              <input type="text" id="username" name="username" required />

              <label class="label" for="password">Password</label>
              <input type="password" id="password" name="password" required />

              <button class="button" type="submit">Sign in</button>

              <p class="signup">
                Don't have an account?
                <a class="signup-text" onclick="showForm('signUpForm')"
                  >Sign up</a
                >
              </p>
            </form>
          </div>

          <!-- Sign Up Form -->
          <div id="signUpForm">
            <h2 class="login-title">Create a new account</h2>
            <h1 class="login-subtitle">
              To use Carcon, please enter your details
            </h1>
            <form action="/signup" method="post">
              <input
                type="hidden"
                name="${_csrf.parameterName}"
                value="${_csrf.token}"
              />
              <label class="label" for="name">Name</label>
              <input type="text" id="name" name="name" required />

              <label for="username">Username</label>
              <input type="text" id="user_name" name="userName" required />

              <label class="label" for="email">Email</label>
              <input type="email" id="email" name="email" required />

              <label class="label" for="password">Password</label>
              <input type="password" id="password" name="password" required />

              <button class="button" type="submit">Sign up</button>

              <p class="signup">
                Already have an account?
                <a class="signup-text" onclick="showForm('signInForm')"
                  >Sign in</a
                >
              </p>
            </form>
          </div>
        </div>
      </div>

      <div class="image-column">
        <img src="/images/login-img.png" alt="Login Image" />
      </div>
    </div>
    <script src="/js/index.js"></script>
    <script src="/js/sign-in.js"></script>
  </body>
</html>
