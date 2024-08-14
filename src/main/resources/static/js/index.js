document.addEventListener('DOMContentLoaded', () => {
    const menu = document.querySelector('#menu-icon');
    const slideUpBar = document.querySelector('.slide-up-bar');

    // Add a click event listener to the menu icon
    menu.addEventListener('click', () => {
        // Toggle the 'open' class on the slide-up bar
        slideUpBar.classList.toggle('open');
        
        // Check if the slide-up bar is open
        if (slideUpBar.classList.contains('open')) {
            // Change the icon to 'uil-times' (X icon)
            menu.classList.remove('uil-apps');
            menu.classList.add('uil-times');
        } else {
            // Change the icon back to 'uil-apps' (menu icon)
            menu.classList.remove('uil-times');
            menu.classList.add('uil-apps');
        }
    });
});


// ================= Error Component =========================


document.addEventListener('DOMContentLoaded', function () {
    // Function to display the notification
function displayNotification() {
    const notificationContainer = document.getElementById('notification-container');

    // Add the 'show' class to display the notification with smooth transition
    notificationContainer.classList.add('show');

    // Hide the notification after 5 seconds
    setTimeout(() => {
        closeNotification();
    }, 5000);
}

// Function to close the notification
function closeNotification() {
    const notificationContainer = document.getElementById('notification-container');
    
    // Remove the 'show' class to hide the notification with smooth transition
    notificationContainer.classList.remove('show');
}

// Attach event listener to close button
const closeButton = document.querySelector('.close-notification');
if (closeButton) {
    closeButton.addEventListener('click', closeNotification);
}

// Check if the notification container is present
const notificationContainer = document.getElementById('notification-container');
if (notificationContainer) {
    displayNotification();
}

});













