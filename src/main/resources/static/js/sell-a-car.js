//===================== File Uploader JS ====================
// Define variables
const imagesContainer = document.querySelector('.uploaded-images-container');
const fileUploadInput = document.getElementById('file-upload');
const fileUploaderButton = document.querySelector('.file-uploader-button');
const fileUploaderContainer = document.querySelector('.file-uploader-container');
const fileUploaderBox = document.querySelector('.file-uploader-box');
let isDragging = false;
let startX = 0;
let scrollLeft = 0;

let uploadedFiles = [];

// Function to handle file input change
function handleFileChange(event) {
    const files = Array.from(event.target.files);

    // Add the new files to the uploadedFiles array
    uploadedFiles.push(...files);

    // Clear the file input
    event.target.value = '';

    // Display the uploaded images
    displayUploadedImages();
}

// Handle mouse down event
function handleMouseDown(event) {
    isDragging = true;
    startX = event.pageX - imagesContainer.offsetLeft;
    scrollLeft = imagesContainer.scrollLeft;
    imagesContainer.style.cursor = 'grabbing';
}

// Handle mouse move event
function handleMouseMove(event) {
    if (!isDragging) return;
    event.preventDefault();
    const x = event.pageX - imagesContainer.offsetLeft;
    const walk = (x - startX) * 1.5; // Adjust walk speed as needed
    imagesContainer.scrollLeft = scrollLeft - walk;
}

// Handle mouse up event
function handleMouseUp() {
    isDragging = false;
    imagesContainer.style.cursor = 'grab';
}

// Attach event listeners
if (imagesContainer) {
    imagesContainer.addEventListener('mousedown', handleMouseDown);
    document.addEventListener('mousemove', handleMouseMove);
    document.addEventListener('mouseup', handleMouseUp);
    imagesContainer.addEventListener('mouseleave', handleMouseUp);
}

// Function to display uploaded images
function displayUploadedImages() {
    // Clear existing images
    imagesContainer.innerHTML = '';

    // Display each file in the uploadedFiles array
    uploadedFiles.forEach((file, index) => {
        const reader = new FileReader();

        reader.onload = function(e) {
            const img = document.createElement('img');
            img.src = e.target.result;
            img.alt = file.name;

            // Append the image to the images container
            imagesContainer.appendChild(img);

            // Set the background image of the fileUploaderContainer for the first image
            if (index === 0) {
                fileUploaderContainer.style.backgroundImage = `url(${e.target.result})`;
                fileUploaderContainer.style.backgroundSize = 'cover';
                fileUploaderContainer.style.backgroundPosition = 'center';
            }
        };

        reader.readAsDataURL(file);
    });

    // Update the file uploader button
    fileUploaderButton.textContent = '+';
    fileUploaderButton.style.marginBottom = '100%';
    fileUploaderButton.style.marginTop = '100%';

    // Hide elements within the file-uploader-box div except the button
    const fileUploaderElements = fileUploaderBox.children;
    for (const element of fileUploaderElements) {
        if (element !== fileUploaderButton) {
            element.style.display = 'none';
        }
    }
}

// Attach file input change event listener
fileUploadInput.addEventListener('change', handleFileChange);

// Handle form submission
const form = document.getElementById('car-sale-form');
form.addEventListener('submit', (event) => {
    // Create a new DataTransfer object
    const dataTransfer = new DataTransfer();

    // Add each file in uploadedFiles to dataTransfer
    uploadedFiles.forEach((file) => {
        dataTransfer.items.add(file);
    });

    // Set the files property of the file input
    fileUploadInput.files = dataTransfer.files;
});
