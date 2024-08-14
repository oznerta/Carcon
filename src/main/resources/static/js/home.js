document.addEventListener('DOMContentLoaded', function() {
    // Get the list of list items
    const sortOptionsList = document.getElementById('sort-options');
    const listItems = sortOptionsList.querySelectorAll('li');

    // Function to handle click event on list items
    function handleClick(event) {
        // Remove active class from all list items
        listItems.forEach(item => {
            item.classList.remove('active');
        });

        // Add active class to the clicked list item
        event.target.classList.add('active');
    }

    // Add click event listener to each list item
    listItems.forEach(item => {
        item.addEventListener('click', handleClick);
    });

    // Set default active state to "Recent" list item
    const defaultActiveItem = sortOptionsList.querySelector('li[data-value="recent"]');
    if (defaultActiveItem) {
        defaultActiveItem.classList.add('active');
    }
});



document.addEventListener('DOMContentLoaded', function() {
    // Get references to the filter title, desktop list, and mobile dropdown
    const filterTitle = document.querySelector('.filter-title');
    const sortOptionsList = document.querySelector('#sort-options');
    const mobileSortOptions = document.querySelector('#mobile-sort-options');

    // Function to update the filter title
    function updateFilterTitle(value) {
        filterTitle.textContent = value.charAt(0).toUpperCase() + value.slice(1);
    }

    // Add click event listeners to desktop list items
    if (sortOptionsList) {
        const listItems = sortOptionsList.querySelectorAll('li');
        listItems.forEach(item => {
            item.addEventListener('click', function() {
                // Update the filter title based on the clicked list item
                updateFilterTitle(item.getAttribute('data-value'));
            });
        });
    }

    // Add change event listener to mobile dropdown
    if (mobileSortOptions) {
        mobileSortOptions.addEventListener('change', function() {
            // Update the filter title based on the selected option in the dropdown
            updateFilterTitle(mobileSortOptions.value);
        });
    }

    // Set the default filter title when the page loads
    updateFilterTitle('recent');
});


function fetchCars() {
    fetch('/api/cars')
        .then(response => response.json()) // Parse the JSON response
        .then(data => {
            // Update the car listings on the page
            updateCarListings(data);
        })
        .catch(error => {
            console.error('Error fetching car listings:', error);
        });
}


function updateCarListings(data) {
    const gridContainer = document.querySelector('.grid-container');
    gridContainer.innerHTML = ''; // Clear the existing content

    // Loop through the data and create car card elements
    data.forEach(car => {
        // Create a car card element
        const carCard = document.createElement('div');
        carCard.classList.add('car-card');

        // Set up the content of the car card
        carCard.innerHTML = `
            <a href="/cars/${car.id}">
                <div class="img-wrapper">
                    <img src="${car.photos.length > 0 ? car.photos[0].url : 'images/car-placeholder.jpg'}" alt="${car.make} ${car.model}" class="car-image" />
                </div>
            </a>
            <h1 class="car-title">${car.make} ${car.model} (${car.registration})</h1>
            <p class="car-info">Price: $${car.bidding}</p>
            <a class="car-price" href="/cars/${car.id}">View More Details</a>
        `;

        // Append the car card to the grid container
        gridContainer.appendChild(carCard);
    });
}





//========================== Loading Effect ==========================
document.addEventListener('DOMContentLoaded', () => {
    const loadingAnimation = document.getElementById('loading-animation');
    const gridContainer = document.querySelector('.grid-container');

    // Retrieve the initial count from local storage
    let initialCarCardCount = parseInt(localStorage.getItem('initialCarCardCount'), 10);
    if (isNaN(initialCarCardCount)) {
        // If there's no initial count in local storage, set it now
        initialCarCardCount = document.querySelectorAll('.car-card').length;
        localStorage.setItem('initialCarCardCount', initialCarCardCount);
    }

    // Log the initial count for your reference
    console.log(`Initial number of car-card elements: ${initialCarCardCount}`);

    // Function to show the loading animation
    function showLoading() {
        loadingAnimation.style.display = 'flex';
        gridContainer.style.display = 'none';
    }

    // Function to refresh the grid container by reloading the page
    function refreshPage() {
        location.reload();
    }

    // Function to check the current count of car-card elements
    function checkCarCardCount() {
        // Get the current count of car-card elements
        const currentCarCardCount = document.querySelectorAll('.car-card').length;

        // Calculate the change in the count of car-card elements
        const countChange = currentCarCardCount - initialCarCardCount;

        if (countChange > 0) {
            // Log the increase in count for your reference
            console.log(`Increase in car-card elements: ${countChange}`);

            // Update initialCarCardCount to the current count
            localStorage.setItem('initialCarCardCount', currentCarCardCount);
            
            // Show loading animation and refresh the page after a delay
            showLoading();
            setTimeout(refreshPage, 2000);
        } else if (countChange < 0) {
            // Log the decrease in count for your reference
            console.log(`Decrease in car-card elements: ${Math.abs(countChange)}`);

            // Update initialCarCardCount to the current count
            localStorage.setItem('initialCarCardCount', currentCarCardCount);

            // Show loading animation and refresh the page after a delay
            showLoading();
            setTimeout(refreshPage, 2000);
        }
    }

    // Check the car-card count 1 second after the page loads
    setTimeout(checkCarCardCount, 1000);
});












// ======================= No Result Found ==================================

document.addEventListener('DOMContentLoaded', () => {
    const searchForm = document.querySelector('.search-container');
    const searchInput = document.querySelector('.search-input');
    const browseCarsContainer = document.querySelector('.browse-cars-container');
    const noResultContainer = document.querySelector('.no-result-container');
    const gridContainer = document.querySelector('.grid-container');

    // Save the original HTML content of the grid container
    const originalGridHTML = gridContainer.innerHTML;

    // Function to handle search results
    function handleSearchResults(html) {
        // Create a temporary div to hold the parsed HTML response
        const tempDiv = document.createElement('div');
        tempDiv.innerHTML = html;

        // Find the new grid content from the parsed HTML
        const newGridContent = tempDiv.querySelector('.grid-container');

        // Clear the existing grid container
        gridContainer.innerHTML = '';

        if (newGridContent && newGridContent.children.length > 0) {
            // Append the new grid content to the existing grid container
            while (newGridContent.firstChild) {
                gridContainer.appendChild(newGridContent.firstChild);
            }
            // Show the browseCarsContainer and hide the noResultContainer
            browseCarsContainer.style.display = 'block';
            noResultContainer.style.display = 'none';
        } else {
            // If there are no results, hide the browseCarsContainer and show the noResultContainer
            browseCarsContainer.style.display = 'none';
            noResultContainer.style.display = 'block';
        }
    }

    // Function to handle the search query
    function handleSearch(query) {
        fetch(`/home/search?query=${encodeURIComponent(query)}`)
            .then(response => response.text())
            .then(handleSearchResults)
            .catch(error => {
                console.error('Failed to fetch search results:', error);
            });
    }

    // Event listener for form submission
    searchForm.addEventListener('submit', event => {
        event.preventDefault(); // Prevent the default form submission behavior

        const query = searchInput.value.trim(); // Get the search query

        if (query) {
            handleSearch(query);
        } else {
            // Restore the original grid content when the input is empty
            gridContainer.innerHTML = originalGridHTML;
            browseCarsContainer.style.display = 'block';
            noResultContainer.style.display = 'none';
        }
    });
});





// ===================================== Search Function ==============================
function updateBrowseCarsContainer(data) {
    // Get the grid container element
    const gridContainer = document.querySelector('.grid-container');
    
    // Clear previous results from the grid container
    gridContainer.innerHTML = '';

    // Iterate over the car data array and create a car card for each car
    data.forEach(car => {
        const carCard = createCarCard(car);
        // Append each created car card to the grid container
        gridContainer.appendChild(carCard);
    });
}

function createCarCard(car) {
    // Create the car card element
    const carCard = document.createElement('div');
    carCard.classList.add('car-card');
    
    // Create anchor element linking to car details page
    const anchor = document.createElement('a');
    anchor.href = `/cars/${car.id}`;
    
    // Create image wrapper and image element
    const imgWrapper = document.createElement('div');
    imgWrapper.classList.add('img-wrapper');
    const img = document.createElement('img');
    img.src = car.photos[0].filePath; // Assuming the first photo is used
    img.alt = 'Car image';
    img.classList.add('car-image');
    
    // Append the image to the image wrapper and the image wrapper to the anchor
    imgWrapper.appendChild(img);
    anchor.appendChild(imgWrapper);
    carCard.appendChild(anchor);
    
    // Add car title, info, and view more link
    const carTitle = document.createElement('h1');
    carTitle.classList.add('car-title');
    carTitle.textContent = `${car.registration} ${car.make} ${car.model}`;
    carCard.appendChild(carTitle);
    
    const carInfo = document.createElement('p');
    carInfo.classList.add('car-info');
    carInfo.textContent = `Bidding: $${car.bidding}`;
    carCard.appendChild(carInfo);
    
    const viewMoreLink = document.createElement('a');
    viewMoreLink.classList.add('car-price');
    viewMoreLink.href = `/cars/${car.id}`;
    viewMoreLink.textContent = 'View More Details';
    carCard.appendChild(viewMoreLink);

    // Return the created car card element
    return carCard;
}






