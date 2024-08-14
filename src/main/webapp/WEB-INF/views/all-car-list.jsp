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
            
            <a href="/registered-users" class="nav-menu">
                <i class="uil uil-users-alt"></i> All Users
            </a>

            <a href="/all-car-listing" class="nav-menu-active">
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
          <h2>All Car Lists</h2>
          <div class="car-sales-container">
            <table class="car-sales-table">
              <thead>
                <tr>
                  <th>
                    <div class="custom-checkbox-container">
                      <input type="checkbox" class="custom-checkbox" id="checkboxFilter">
                      <label for="checkboxFilter" class="checkbox-custom"></label>
                      <ul class="dropdown-menu">
                        <li>All</li>
                        <li>Open</li>
                        <li>Closed</li>
                      </ul>
                    </div>
                  </th>
                  <th>Car Details</th>
                  <th>Bidding Status</th>
                  <th>Starting Price</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="carSale" items="${carSales}">
                  <tr>
                    <td>
                      <input type="checkbox" class="custom-checkbox" data-status="${carSale.status}">
                    </td>
                    <td><a href="/cars/${carSale.id}" target="_blank">${carSale.registration} ${carSale.make}
                        ${carSale.model}</a></td>
                    <td>
                      <div class="status-container-${carSale.status.name().toLowerCase()}">
                        <div class="status">
                          <p>${carSale.status}</p>
                        </div>
                      </div>
                    </td>
                    <td>$${carSale.bidding}0</td>
                  </tr>
                </c:forEach>

              </tbody>
            </table>
            <div class="action-bar-desktop" id="action-bar-desktop">
              <span id="selected-count-desktop">0 items selected</span>
              <button class="button" id="edit-button-desktop" disabled>Edit</button>
              <button class="button" id="delete-button-desktop" disabled>Delete</button>
            </div>
          </div>


          <div class="car-sales-container-mobile">
            <!-- Filter options -->
            <div class="filter-container-mobile">
              <div class="custom-checkbox-container-mobile">
                <input type="checkbox" class="custom-checkbox" id="checkboxFilterMobile">
                <ul class="carlist-menu-mobile-container">
                  <a class="carlist-menu-mobile-active" href="#">
                    <li>All</li>
                  </a>
                  <a class="carlist-menu-mobile" href="#">
                    <li>Open</li>
                  </a>
                  <a class="carlist-menu-mobile" href="#">
                    <li>Closed</li>
                  </a>
                  <a class="carlist-menu-mobile" href="#">
                    <li>Deleted</li>
                  </a>
                </ul>
              </div>
            </div>

            <c:forEach var="carSale" items="${carSales}">
              <div class="car-sales-item-mobile">
                <!-- Checkbox for each car -->
                <input type="checkbox" class="custom-checkbox" data-status="${carSale.status}">

                <!-- Car details -->
                <div class="car-details-mobile">
                  <a class="car-details-mobile-title" href="/car-details/${carSale.id}">
                    <h4>${carSale.registration} ${carSale.make} ${carSale.model}</h4>
                  </a>
                  <div class="starting-price-mobile">$${carSale.bidding}0</div>
                </div>

                <!-- Status container -->
                <div class="status-container-${carSale.status.name().toLowerCase()}-mobile">
                  <div class="status">
                    <p>${carSale.status}</p>
                  </div>
                </div>
              </div>
            </c:forEach>


            <div class="action-bar-mobile" id="action-bar-mobile" style="display: none;">
              <span id="selected-count-mobile">0 items selected</span>
              <button class="button" id="edit-button-mobile" disabled>Edit</button>
              <button class="button" id="delete-button-mobile" disabled>Delete</button>
            </div>
          </div>
          <div style="border: 1px; margin-top: 80px;">.</div>


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

            <a href="/registered-users" class="bottombar-nav">
                <i class="uil uil-users-alt"></i> All Users
            </a>

            <a href="/profile" class="bottombar-nav-menu">
              <i class="uil uil-user-circle"></i> Profile
            </a>

            <a href="/notification" class="bottombar-nav-menu">
              <i class="uil uil-envelope-check"></i> Notification
            </a>

            <a href="/all-car-listing" class="bottombar-nav-active">
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
    <script src="/js/view-listing.js"></script>
  </body>
</html>
