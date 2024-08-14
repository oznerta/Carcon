document.addEventListener('DOMContentLoaded', () => {
    const mainImageContainer = document.querySelector('.car-details-img-container img');
    const galleryImages = document.querySelectorAll('.uploaded-image');

    // Function to set the selected image
    function setSelectedImage(clickedImage) {
        // Remove 'selected' class from all images
        galleryImages.forEach(image => image.classList.remove('selected'));
        // Add 'selected' class to the clicked image
        clickedImage.classList.add('selected');
        // Update the main image container's src
        mainImageContainer.src = clickedImage.src;
    }

    // Add event listeners for gallery images
    galleryImages.forEach(image => {
        image.addEventListener('click', event => {
            event.preventDefault();
            setSelectedImage(image);
        });
        image.addEventListener('touchstart', event => {
            event.preventDefault();
            setSelectedImage(image);
        });
    });

    // Initial selected image
    if (galleryImages.length > 0) {
        setSelectedImage(galleryImages[0]);
    }

    // Define drag/swipe functionality
    const imagesWrapper = document.querySelector('.images-wrapper');
    let isDragging = false;
    let startX = 0;
    let scrollLeft = 0;

    function handleInteraction(event) {
        event.preventDefault();
        isDragging = true;
        if (event.type === 'mousedown') {
            startX = event.pageX - imagesWrapper.offsetLeft;
        } else if (event.type === 'touchstart') {
            startX = event.touches[0].pageX - imagesWrapper.offsetLeft;
        }
        scrollLeft = imagesWrapper.scrollLeft;

        // Attach appropriate event listeners
        if (event.type === 'mousedown') {
            document.addEventListener('mousemove', onMouseMove);
            document.addEventListener('mouseup', onInteractionEnd);
        } else if (event.type === 'touchstart') {
            imagesWrapper.addEventListener('touchmove', onTouchMove);
            imagesWrapper.addEventListener('touchend', onInteractionEnd);
        }
    }

    function onMouseMove(event) {
        if (!isDragging) return;
        const x = event.pageX - imagesWrapper.offsetLeft;
        const walk = x - startX;
        imagesWrapper.scrollLeft = scrollLeft - walk;
    }

    function onTouchMove(event) {
        if (!isDragging) return;
        const x = event.touches[0].pageX - imagesWrapper.offsetLeft;
        const walk = x - startX;
        imagesWrapper.scrollLeft = scrollLeft - walk;
    }

    function onInteractionEnd() {
        isDragging = false;
        // Remove event listeners
        document.removeEventListener('mousemove', onMouseMove);
        document.removeEventListener('mouseup', onInteractionEnd);
        imagesWrapper.removeEventListener('touchmove', onTouchMove);
        imagesWrapper.removeEventListener('touchend', onInteractionEnd);
    }

    // Attach mousedown and touchstart event listeners to imagesWrapper
    imagesWrapper.addEventListener('mousedown', handleInteraction);
    imagesWrapper.addEventListener('touchstart', handleInteraction);
});








