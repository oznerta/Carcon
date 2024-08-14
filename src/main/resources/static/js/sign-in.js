function showForm(formId) {
            // Hide both forms initially
            document.getElementById('signInForm').style.display = 'none';
            document.getElementById('signUpForm').style.display = 'none';

            // Show the requested form
            document.getElementById(formId).style.display = 'block';
        }

        // Set the default form to be the sign-in form
        window.onload = function() {
            showForm('signInForm');
        };