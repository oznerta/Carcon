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
    <title>Home</title>
    <link
      href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
      rel="stylesheet"
    />
    <link
      href="https://unicons.iconscout.com/release/v4.0.0/css/line.css"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="/css/global.css" />
    <link rel="stylesheet" href="/css/shared-component.css" />
    <link rel="stylesheet" href="/css/view-listing.css" />
    <link rel="stylesheet" href="/css/registered-users.css" />
  </head>

  <body>
    <section class="top-bar">
      <div>
        <a href="/home" class="logo">
          <img src="/images/logo.svg" alt="logo" />Carcon
        </a>
      </div>

      <div class="topbar-profile">
        <a href="/profile" class="topbar-profile-link">
          <img src="/images/profile-placeholder.svg" alt="profile" />
        </a>
      </div>
    </section>

    <div class="sidebar">
      <a href="#" class="logo">
        <img src="/images/logo.svg" alt="logo" />Carcon
      </a>

      <div class="profile">
        <img src="/images/profile-placeholder.svg" alt="profile" />
        <div class="profile-data">
          <p class="name">${user.name}</p>
          <p class="username">@${user.userName}</p>
        </div>
      </div>

      <div class="nav-links" id="navLinks">
        <c:if test="${user.hasAdminRole()}">
            <!-- Admin menu -->
            <a href="/home" class="nav-menu">
                <i class="uil uil-estate"></i> Home
            </a>
            
            <a href="/registered-users" class="nav-menu-active">
                <i class="uil uil-users-alt"></i> All Users
            </a>

            <a href="/all-car-listing" class="nav-menu">
                <i class="uil uil-list-ul"></i> All Car Lists
            </a>

            <a href="/notification" class="nav-menu">
              <i class="uil uil-envelope-check"></i> Notification
            </a>

            <a href="/settings" class="nav-menu">
                <i class="uil uil-cog"></i> Settings
            </a>
        </c:if>
    
        <c:if test="${!user.hasAdminRole()}">
            <!-- Regular user menu -->
            <a href="/home" class="nav-menu-active">
                <i class="uil uil-estate"></i> Home
            </a>

            <a href="/sell-a-car" class="nav-menu">
                <i class="uil uil-car"></i> Sell A Car
            </a>

            <a href="/my-car-lists" class="nav-menu">
                <i class="uil uil-list-ol-alt"></i> My Car Lists
            </a>

            <a href="/notification" class="nav-menu">
                <i class="uil uil-envelope-check"></i> Notification
            </a>

            <a href="/settings" class="nav-menu">
                <i class="uil uil-cog"></i> Settings
            </a>
        </c:if>
    </div>
    

      <div class="flex-grow"></div>

      <div class="signout">
        <a href="/signout" class="signout-link">
          <img src="/images/logout.svg" alt="signout" />Logout</a
        >
      </div>
    </div>

    <section class="main-section">
      <div class="main-container">
        <h2>All Users</h2>
        <div class="users-container">
          <div class="table-responsive">
              <table class="users-table">
                  <thead>
                      <tr>
                          <th><input type="checkbox" class="custom-checkbox" id="checkboxFilter"></th>
                          <th>Username</th>
                          <th>Name</th>
                          <th>Role</th>
                      </tr>
                  </thead>
                  <tbody>
                      <!-- Iterate over the list of users -->
                      <c:forEach var="user" items="${users}">
                          <tr>
                              <td>
                                  <input type="checkbox" class="custom-checkbox" data-id="${user.id}">
                              </td>
                              <td>@${user.userName}</td>
                              <td>${user.name}</td>
                              <td>${user.roles.iterator().next().name}</td>
                            
                            
                          </tr>
                      </c:forEach>
                  </tbody>
              </table>
          </div>
      
          <!-- Action bar for desktop view -->
          <div class="action-bar" id="action-bar">
              <span id="selected-count">0 items selected</span>
              <button class="button" id="change-to-admin-button" disabled>Change To Admin</button>
              <button class="button" id="change-to-users-button" disabled>Change To Users</button>
              <button class="button" id="delete-button" disabled>Delete</button>
          </div>
      </div>
      
    </section>

    <section class="bottom-bar">
      <div class="bottombar-signout">
        <a href="/signout" class="bottombar-signout-link">
          <img src="/images/logout.svg" alt="signout" />Logout
        </a>
      </div>

      <div class="bottombar-menu-icon">
        <i class="uil uil-apps" id="menu-icon"></i>
      </div>

      <!-- Slide-up bottom bar -->
      <div class="slide-up-bar">
        <c:if test="${user.hasAdminRole()}">
            <!-- Admin menu -->
            <a href="/home" class="bottombar-nav-menu-active">
                <i class="uil uil-estate"></i> Home
            </a>

            <a href="/registered-users" class="bottombar-nav-active">
                <i class="uil uil-users-alt"></i> All Users
            </a>

            <a href="/profile" class="bottombar-nav-menu">
              <i class="uil uil-user-circle"></i> Profile
            </a>

            <a href="/notification" class="bottombar-nav-menu">
              <i class="uil uil-envelope-check"></i> Notification
            </a>

            <a href="/all-car-listing" class="bottombar-nav-menu">
                <i class="uil uil-list-ul"></i> Car Lists
            </a>
            <a href="/settings" class="bottombar-nav-menu">
                <i class="uil uil-cog"></i> Settings
            </a>
        </c:if>
        
        <c:if test="${!user.hasAdminRole()}">
            <!-- Regular user menu -->
            <a href="/home" class="bottombar-nav-menu-active">
                <i class="uil uil-estate"></i> Home
            </a>
            <a href="/sell-a-car" class="bottombar-nav-menu">
                <i class="uil uil-car"></i> Sell A Car
            </a>
            <a href="/profile" class="bottombar-nav-menu">
                <i class="uil uil-user-circle"></i> Profile
            </a>
            <a href="/notification" class="bottombar-nav-menu">
                <i class="uil uil-envelope-check"></i> Notification
            </a>
            <a href="/my-car-lists" class="bottombar-nav-menu">
                <i class="uil uil-list-ol-alt"></i> My Car Lists
            </a>
            <a href="/settings" class="bottombar-nav-menu">
                <i class="uil uil-cog"></i> Settings
            </a>
        </c:if>
    </div>
    
    </section>

    <script src="/js/index.js"></script>
    <script src="/js/registered-users.js"></script>
  </body>
</html>
