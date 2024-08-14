document.addEventListener("DOMContentLoaded", function () {
    // Get desktop checkboxes and action bar elements
    const desktopCheckboxes = document.querySelectorAll(".car-sales-container tbody .custom-checkbox");
    const mainCheckbox = document.querySelector("#checkboxFilter");
    const dropdownMenu = document.querySelector(".dropdown-menu");
    const desktopSelectedCountElement = document.getElementById("selected-count-desktop");
    const desktopActionBar = document.getElementById("action-bar-desktop");
    const desktopEditButton = document.getElementById("edit-button-desktop");
    const desktopDeleteButton = document.getElementById("delete-button-desktop");

    // Get mobile checkboxes and action bar elements
    const mobileCheckboxes = document.querySelectorAll(".car-sales-container-mobile .custom-checkbox");
    const mobileSelectedCountElement = document.getElementById("selected-count-mobile");
    const mobileActionBar = document.getElementById("action-bar-mobile");
    const mobileEditButton = document.getElementById("edit-button-mobile");
    const mobileDeleteButton = document.getElementById("delete-button-mobile");

    function updateActionBar(checkboxes, selectedCountElement, actionBar, editButton, deleteButton) {
        const selectedCount = Array.from(checkboxes).filter(checkbox => checkbox.checked).length;
        selectedCountElement.textContent = `${selectedCount} item${selectedCount !== 1 ? "s" : ""} selected`;

        if (selectedCount > 0) {
            actionBar.style.display = "block";
            deleteButton.disabled = false;
            editButton.disabled = selectedCount !== 1;
        } else {
            actionBar.style.display = "none";
            deleteButton.disabled = true;
            editButton.disabled = true;
        }
    }

    function filterCheckboxes(status) {
    // Convert the selected status to uppercase to match the data-status attribute
    const upperCaseStatus = status.toUpperCase();

    desktopCheckboxes.forEach(checkbox => {
        // Get the row status from the data-status attribute
        const rowStatus = checkbox.getAttribute("data-status").toUpperCase();

        // Check the checkbox if it matches the selected status or "All" is selected
        checkbox.checked = (status === "All") || (rowStatus === upperCaseStatus);
    });
    
    // Update the action bar
    updateActionBar(desktopCheckboxes, desktopSelectedCountElement, desktopActionBar, desktopEditButton, desktopDeleteButton);
}


    // Add event listener for main checkbox (in the table header) to show dropdown menu
    mainCheckbox.addEventListener("click", function() {
        dropdownMenu.style.display = "block";
    });

    // Add event listener for dropdown menu options
    dropdownMenu.addEventListener("click", function(event) {
        const selectedStatus = event.target.textContent.trim();
        if (["All", "Open", "Closed"].includes(selectedStatus)) {
            // Filter checkboxes based on the selected status
            filterCheckboxes(selectedStatus);
        }
        // Hide the dropdown menu and uncheck the main checkbox
        dropdownMenu.style.display = "none";
        mainCheckbox.checked = false;
    });

    // Add event listeners for desktop and mobile checkboxes
    desktopCheckboxes.forEach(checkbox => {
        checkbox.addEventListener("change", () => updateActionBar(desktopCheckboxes, desktopSelectedCountElement, desktopActionBar, desktopEditButton, desktopDeleteButton));
    });

    mobileCheckboxes.forEach(checkbox => {
        checkbox.addEventListener("change", () => updateActionBar(mobileCheckboxes, mobileSelectedCountElement, mobileActionBar, mobileEditButton, mobileDeleteButton));
    });

    // Hide the dropdown menu and uncheck the main checkbox when clicking outside the menu
    document.addEventListener("click", function(event) {
        const isOutsideMenu = !dropdownMenu.contains(event.target);
        const isNotMainCheckbox = event.target !== mainCheckbox;

        if (isOutsideMenu && isNotMainCheckbox) {
            dropdownMenu.style.display = "none";
            mainCheckbox.checked = false;
        }
    });

    // Initial update on page load for desktop and mobile
    updateActionBar(desktopCheckboxes, desktopSelectedCountElement, desktopActionBar, desktopEditButton, desktopDeleteButton);
    updateActionBar(mobileCheckboxes, mobileSelectedCountElement, mobileActionBar, mobileEditButton, mobileDeleteButton);
});




document.addEventListener("DOMContentLoaded", function() {
    // Get desktop checkboxes and action bar elements
    const desktopCheckboxes = document.querySelectorAll(".car-sales-container .custom-checkbox");
    const desktopSelectedCountElement = document.getElementById("selected-count-desktop");
    const desktopActionBar = document.getElementById("action-bar-desktop");
    const desktopEditButton = document.getElementById("edit-button-desktop");
    const desktopDeleteButton = document.getElementById("delete-button-desktop");
    
    // Update action bar when checkboxes change
    function updateActionBar() {
        const selectedCount = Array.from(desktopCheckboxes).filter(checkbox => checkbox.checked).length;
        desktopSelectedCountElement.textContent = `${selectedCount} item${selectedCount !== 1 ? "s" : ""} selected`;
        
        if (selectedCount > 0) {
            desktopActionBar.style.display = "block";
            desktopDeleteButton.disabled = false;
            desktopEditButton.disabled = selectedCount !== 1;
        } else {
            desktopActionBar.style.display = "none";
            desktopDeleteButton.disabled = true;
            desktopEditButton.disabled = true;
        }
    }

    // Add event listener for desktop checkboxes
    desktopCheckboxes.forEach(checkbox => {
        checkbox.addEventListener("change", updateActionBar);
    });

    // Add event listener for the "Delete" button
    desktopDeleteButton.addEventListener("click", function() {
        // Gather the IDs of the selected car sales
        const selectedIds = [];
        desktopCheckboxes.forEach((checkbox, index) => {
            if (checkbox.checked) {
                // Get the ID from the row
                const row = checkbox.closest("tr");
                const carId = row.querySelector("a").href.split("/").pop();
                selectedIds.push(carId);
            }
        });

        // Send a POST request to the server to delete the selected car sales
        fetch("/cars/delete", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(selectedIds)
        })
        .then(response => {
            if (response.ok) {
                // Refresh the page after successful deletion
                location.reload();
            } else {
                // Handle error response (optional)
                alert("Failed to delete car sales.");
            }
        })
        .catch(error => {
            // Handle network error (optional)
            console.error("Error deleting car sales:", error);
        });
    });

    // Initial update on page load
    updateActionBar();
});
