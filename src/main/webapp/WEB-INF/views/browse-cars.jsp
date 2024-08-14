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
    <link rel="stylesheet" href="/css/browse-cars.css" />
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
        <img src="/images/profile-placeholder.svg" alt="profile">
        <div class="profile-data">
            <p class="name">${user.name}</p>
            <p class="username">@${user.userName}</p>
        </div>
    </div>
    

      <div class="nav-links" id="navLinks">
        <c:if test="${user.hasAdminRole()}">
            <!-- Admin menu -->
            <a href="/home" class="nav-menu-active">
                <i class="uil uil-estate"></i> Home
            </a>

            <a href="/registered-users" class="nav-menu">
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
        <div class="main-inner-container">
          <h1 class="search">Search Cars</h1>

          <form class="search-container">
            <img src="images/search.svg" alt="search icon" class="search-icon" />
            <input type="text" class="search-input" placeholder="Search for cars (e.g., name, model, year)" aria-label="Search for cars" />
          </form>

        </div>

        <div class="browse-cars-container">
          <!-- Sort and filter container -->
          <div class="sort-filter">
            <!-- Label and list for sorting -->
            <div class="sort-options">
              <ul id="sort-options" class="sort-options-list">
                <li data-value="recent">Recent</li>
                <li data-value="popular">Popular</li>
                <li data-value="most bidding">Most Bidding</li>
              </ul>
            </div>

            <!-- Icon for additional filtering or options -->
            <i class="uil uil-filter"></i>
          </div>

          <!-- Sort and filter container -->
          <div class="mobile-sort-filter">
            <!-- Label and select box for sorting -->
            <div class="mobile-sort-options">
              <select id="mobile-sort-options">
                <option value="recent">Recent</option>
                <option value="popular">Popular</option>
                <option value="most bidding">Most Bidding</option>
              </select>
            </div>

            <!-- Icon for additional filtering or options -->
            <i class="mobile-icon uil uil-filter"></i>
          </div>

          <h1 class="filter-title">Recent</h1>

          <!-- Loading animation (hidden initially) -->
          <div
            class="loading-animation"
            id="loading-animation"
            style="display: none"
          >
            <img src="/images/loader.svg" alt="Loading..." />
          </div>

          <!-- Placeholder for the grid -->
          <div class="grid-container">
            <!-- Iterate over the list of cars provided by the controller -->
            <c:forEach var="car" items="${cars}">
              <div class="car-card">
                <a href="/cars/${car.id}">
                  <div class="img-wrapper">
                    <img
                      src="${car.photos.iterator().next().filePath}"
                      alt="Car image"
                      class="car-image"
                    />
                  </div>
                </a>
                <h1 class="car-title">
                  ${car.registration} ${car.make} ${car.model}
                </h1>
                <p class="car-info">Latest Bid: $${car.highestBidAmount}0</p>
                <a class="car-price" href="/cars/${car.id}"
                  >View More Details</a
                >
              </div>
            </c:forEach>
          </div>
        </div>
        <div class="margin-bottom" style="height: 1px;"></div>

        <div class="no-result-container" style="display: none;">
          <div class="back-home">
            <a href=""> <i class="uil uil-backspace"></i>Back </a>
          </div>
          <div class="no-result">
            <img src="images/no-result.png" alt="" />
            <h5 class="no-result-title">No Result Found</h5>
            <p class="no-result-description">
              We can't find any item matching your search
            </p>
          </div>
        </div>

        <!-- Pagination -->
        <div class="pagination-container" style="display: none">
          <ul class="pagination">
            <li class="pagination-item">
              <a href="#" class="pagination-link">1</a>
            </li>
            <li class="pagination-item">
              <a href="#" class="pagination-link">2</a>
            </li>
            <li class="pagination-item">
              <a href="#" class="pagination-link">3</a>
            </li>
            <!-- Add more pagination links as needed -->
            <li class="pagination-item">
              <a href="#" class="pagination-link">Next</a>
            </li>
          </ul>
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

            <a href="/registered-users" class="bottombar-nav-menu">
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
    <script src="/js/home.js"></script>
  </body>
</html>
