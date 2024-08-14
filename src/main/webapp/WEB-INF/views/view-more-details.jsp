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
    <title>Navigation Bar</title>
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
    <link rel="stylesheet" href="/css/view-more-details.css" />
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
        <div class="browse-cars-container">
          <div
            class="loading-animation"
            id="loading-animation"
            style="display: none"
          >
            <img src="/images/loader.svg" alt="Loading..." />
          </div>

          <div class="post-details">
            <div class="back-home">
              <a href="/home"> <i class="uil uil-backspace"></i>Back </a>
            </div>

            <h2 class="car-details-title">Car Details</h2>

            <div class="car-details-profile">
              <img src="/images/profile-placeholder.svg" alt="profile" />
              <div class="car-details-profile-data">
                  <p class="name">${seller.name}</p>
                  <p class="username">@${seller.userName}</p>
              </div>
          </div>          
            
            <div class="car-details">
              <div class="car-details-img-container">
                <img src="${car.photos.iterator().next().filePath}" alt="Car image" />
              </div>

              <div class="car-details-data">
                <div class="car-details-desciption">
                  <h1 class="car-details-desciption-title">
                    <i class="uil uil-car"></i>${car.registration} ${car.make}
                    ${car.model}
                  </h1>
                  <p><strong>Make:</strong> ${car.make}</p>
                  <p><strong>Model:</strong> ${car.model}</p>
                  <p><strong>Registration Year:</strong> ${car.registration}</p>
                </div>

                <div class="bidding-form">
                  <form action="/cars/${car.id}/submit-bid" method="POST">
                      <input type="hidden" name="carId" value="${car.id}" />
                      <!-- Input field for the bidding amount -->
                      <div class="place-bid">
                          <label for="bid-amount">Bidding Amount</label>
                          <div class="input-wrapper">
                              <i class="uil uil-dollar-alt"></i>
                              <input
                                  type="number"
                                  id="bid-amount"
                                  name="bidAmount"
                                  min="${car.bidding}"  
                                  step="1"
                                  placeholder="${car.bidding}0"
                                  required
                                  ${isOwner ? 'disabled' : ''}  <!-- Disable input if the user is the owner -->
                              />
                          </div>
                          <p>Minimum Bid: $${car.bidding}0</p>
                          <button class="button" type="submit" ${isOwner ? 'disabled' : ''}>Place Bid</button> <!-- Disable button if the user is the owner -->
                      </div>
                  </form>

              </div>
              

                <h1 class="photos-title">
                  <i class="uil uil-images"></i>Photos
                </h1>
                <div class="uploaded-images-container">
                  <span class="image-count-indicator"></span>
                  <div class="images-wrapper">
                    <c:forEach var="image" items="${car.photos}">
                        <img src="${image.filePath}" alt="Car Image" class="uploaded-image" />
                    </c:forEach>
                  </div>
                </div>
                
              </div>
            </div>

            <div class="bidding-history-container">
                <h2>Bid History</h2>
                <p class="bidding-countdown">
                  Bidding ends in ${remainingDays} days, ${remainingHours} hours, and ${remainingMinutes} minutes.
              </p>
              <table class="bidding-history-table">
                <thead>
                  <tr>
                    <th>Bidding</th>
                    <th>Date</th>
                    <th>From</th>
                  </tr>
                </thead>
                <tbody>
                    <c:forEach var="bid" items="${bidHistory}">
                        <tr>
                            <td><i class="uil uil-dollar-alt"></i>${bid.amount}0</td>
                            <td>${bid.formattedDateTime} </td>
                            <td>${bid.user.name}</td>
                        </tr>
                    </c:forEach>
                </tbody>
              </table>
            </div>
            <div style="height: 1px; margin-bottom: 100px"></div>
          </div>
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
    <script src="/js/view-more-details.js"></script>
  </body>
</html>
