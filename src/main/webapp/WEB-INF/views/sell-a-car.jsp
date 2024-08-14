<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sell A Car</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://unicons.iconscout.com/release/v4.0.0/css/line.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/global.css">
    <link rel="stylesheet" href="/css/shared-component.css">
    <link rel="stylesheet" href="/css/sell-a-car.css">
</head>

<body>
    <section class="top-bar">
        <div>
            <a href="/home" class="logo">
                <img src="/images/logo.svg" alt="logo">Carcon
            </a>
        </div>

        <div class="topbar-profile">
            <a href="/profile" class="topbar-profile-link">
                <img src="/images/profile-placeholder.svg" alt="profile">
            </a>
        </div>

    </section>

    <div class="sidebar">
        <a href="/home" class="logo">
            <img src="/images/logo.svg" alt="logo">Carcon
        </a>

        <div class="profile">
            <img src="/images/profile-placeholder.svg" alt="profile">
            <div class="profile-data">
                <p class="name">${user.name}</p>
                <p class="username">@${user.userName}</p>
            </div>
        </div>

        <div class="nav-links" id="navLinks">
                <a href="/home" class="nav-menu">
                    <i class="uil uil-estate"></i> Home
                </a>
        
                <a href="/sell-a-car" class="nav-menu-active">
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
        </div>

        <div class="flex-grow"></div>

        <div class="signout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            <a href="signout" class="signout-link">
                <img src="/images/logout.svg" alt="signout">Logout</a>
        </div>
    </div>

    
    <section class="main-section">
        <div class="main-container">
            
            <div class="car-sale-title">
                <h1><i class="uil uil-car"></i></h1>
                <h1> Sell a car</h1>
            </div>
    
            
                <form id="car-sale-form" enctype="multipart/form-data" action="/upload-car" method="POST">
                    <div class="car-sale-form-items">
                        <label for="make">Make</label>
                        <input class="car-sale-input" type="text" id="make" name="make" required placeholder="Enter (e.g., Ford)">
                    </div>
    
                    <div class="car-sale-form-items">
                        <label for="model">Model</label>
                        <input class="car-sale-input" type="text" id="model" name="model" required placeholder="Enter (e.g., Mustang)">
                    </div>
    
                    <div class="car-sale-form-items">
                        <label for="registration">Registration Year</label>
                        <input class="car-sale-input" type="text" id="registration" name="registration" required placeholder="Enter (e.g., 2010)">
                    </div>
    
                    <div class="car-sale-form-items">
                        <label for="price">Price</label>
                        <input class="car-sale-input" type="number" id="bidding" name="bidding" required placeholder="0.00">
                    </div>
    
                    <div class="car-sale-form-items">
                        <label for="picture">Photos</label>
                        
                        <div class="file-uploader-container">
                            <label for="file-upload" class="file-uploader">
                                <input type="file" name="photos" id="file-upload" class="file-input" multiple accept="image/*,.png,.jpeg,.jpg">
                                <div class="file-uploader-box">
                                    <img src="/images/file-upload.svg" alt="file-upload">
                                    <h3 class="file-uploader-heading">Drag photo here</h3>
                                    <p class="file-uploader-text">SVG, PNG, JPG</p>
                                    <button class="file-uploader-button">Select from computer</button>
                                </div>
                            </label>
                        </div>

                        <div class="uploaded-images-container">
                            <span class="image-count-indicator"></span>
                        </div>
                    </div>
    
                    <div class="submit-button">
                        <button class="button" type="submit">Submit</button>
                    </div>
                </form>
        </div>
    </section>

    <section class="bottom-bar">
        <div class="bottombar-signout">
            <a href="/signout" class="bottombar-signout-link">
                <img src="/images/logout.svg" alt="signout">Logout
            </a>
        </div>
        
        <div class="bottombar-menu-icon">
            <i class="uil uil-apps" id="menu-icon"></i>
        </div>


        <!-- Slide-up bottom bar -->
    <div class="slide-up-bar">
        
        <a href="/home" class="bottombar-nav-menu">
            <i class="uil uil-estate"></i> Home
          </a>
  
          <a href="/sell-a-car" class="bottombar-nav-menu-active">
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
        
    </div>
    </section>

    <script src="/js/index.js"></script>
    <script src="/js/sell-a-car.js"></script>
</body>


</html>
