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
    <link rel="stylesheet" href="/css/global.css" />
    <link rel="stylesheet" href="/css/index.css" />
  </head>

  <body>
    <!-- Navigation Bar -->
    <nav>
      <a href="#" class="logo"
        ><img src="/images/logo.svg" alt="logo" />Carcon</a
      >

      <ul class="nav-links" id="navLinks">
        <li><a href="#">Home</a></li>
        <li><a href="#">Why Carcon?</a></li>
        <li><a href="#">How does it work?</a></li>
        <li><a href="#">Contact</a></li>
      </ul>

      <div class="nav-right">
        <a href="/portal" class="button">Sign in</a>
        <div class="bx bx-menu" id="menu-icon"></div>
      </div>
    </nav>

    <!-- Section with two columns -->
    <section class="hero-section section">
      <div class="hero-section-description column">
        <h1 class="hero-title">
          Your Trusted <span class="highlight">Car Connection</span>
        </h1>
        <p class="hero-text">
          <span class="highlight">Carcon</span> is your ultimate destination for
          buying and selling used cars. Whether you're in the market for a
          specific make and model or simply exploring your options,
          <span class="highlight">Carcon</span> offers a seamless and secure
          platform to connect you with your dream car.
        </p>

        <!-- Buttons -->
        <div class="hero-buttons">
          <a href="#" class="button prim-button">How does it work?</a>
          <a href="#" class="button button-2">Browse Cars</a>
        </div>
      </div>
      <div class="hero-section-img column">
        <img src="/images/hero-img.png" alt="Car" />
      </div>
    </section>

    <script type="text/javascript">
      let menu = document.querySelector("#menu-icon");
      let navlinks = document.querySelector(".nav-links");

      menu.onclick = () => {
        menu.classList.toggle("bx-x");
        navlinks.classList.toggle("open");
      };

      // Select the buttons you want to manipulate
      const button2 = document.querySelector(".button-2");
      const button = document.querySelector(".prim-button");

      // Define event handlers for hover in and out
      function handleButton2HoverIn() {
        // Apply styles to button when hovering over button-2
        button.style.background = "var(--light-secondary)";
        button.style.color = "var(--light-text)";
        button.style.transform = "scale(1.1)";

        button2.style.background = "var(--secondary)";
        button2.style.color = "var(--text)";
        button2.style.transform = "none";
      }

      function handleButtonHoverIn() {
        // Apply styles to button when hovering over button-2
        button.style.background = "var(--secondary)";
        button.style.color = "var(--text)";
        button.style.transform = "none";

        button2.style.background = "var(--light-secondary)";
        button2.style.color = "var(--light-text)";
        button2.style.transform = "scale(1.1)";
      }

      function handleButton2HoverOut() {
        // Reset styles to original state when not hovering over button-2
      }

      // Add event listeners for hover events on button-2
      button2.addEventListener("mouseover", handleButton2HoverIn);
      button.addEventListener("mouseover", handleButtonHoverIn);
    </script>
  </body>
</html>
