document.addEventListener('DOMContentLoaded', function() {
    // Select the elements
    const selectAllCheckbox = document.querySelector('#checkboxFilter');
    const checkboxes = document.querySelectorAll('.users-table input[type="checkbox"]');
    const actionBar = document.querySelector('#action-bar');
    const changeToAdminButton = document.querySelector('#change-to-admin-button');
    const changeToUsersButton = document.querySelector('#change-to-users-button');
    const deleteButton = document.querySelector('#delete-button');

    // Function to update button states
    function updateButtonStates() {
        const selectedCheckboxes = Array.from(checkboxes).filter(checkbox => checkbox.checked && checkbox !== selectAllCheckbox);
        const selectedUserRoles = selectedCheckboxes.map(checkbox => {
            const tr = checkbox.closest('tr');
            return tr.querySelector('td:nth-child(4)').innerText;
        });

        // Determine if there are any selected checkboxes
        const hasSelected = selectedCheckboxes.length > 0;

        // Show or hide the action bar based on the selection state
        actionBar.style.display = hasSelected ? 'block' : 'none';

        // Determine which buttons should be enabled or disabled
        const allUsers = selectedUserRoles.every(role => role === 'User');
        const allAdmins = selectedUserRoles.every(role => role === 'Admin');

        changeToAdminButton.disabled = !allUsers;
        changeToUsersButton.disabled = !allAdmins;
        deleteButton.disabled = !hasSelected;
    }

    // Function to handle the "Select All" checkbox
    function handleSelectAll() {
        const isChecked = selectAllCheckbox.checked;
        checkboxes.forEach(checkbox => {
            checkbox.checked = isChecked;
        });
        updateButtonStates();
    }

    // Add event listeners
    selectAllCheckbox.addEventListener('change', handleSelectAll);
    checkboxes.forEach(checkbox => {
        checkbox.addEventListener('change', updateButtonStates);
    });

    changeToAdminButton.addEventListener('click', () => {
        const selectedCheckboxes = Array.from(checkboxes).filter(checkbox => checkbox.checked && checkbox !== selectAllCheckbox);
        selectedCheckboxes.forEach(async checkbox => {
            const userId = checkbox.dataset.id;
            await changeUserRole(userId, 'Admin');
        });
        // Refresh the UI
        location.reload();
    });

    changeToUsersButton.addEventListener('click', () => {
        const selectedCheckboxes = Array.from(checkboxes).filter(checkbox => checkbox.checked && checkbox !== selectAllCheckbox);
        selectedCheckboxes.forEach(async checkbox => {
            const userId = checkbox.dataset.id;
            await changeUserRole(userId, 'User');
        });
        // Refresh the UI
        location.reload();
    });

    // Event listener for delete button
    deleteButton.addEventListener('click', () => {
        const selectedCheckboxes = Array.from(checkboxes).filter(checkbox => checkbox.checked && checkbox !== selectAllCheckbox);
        selectedCheckboxes.forEach(async checkbox => {
            const userId = checkbox.dataset.id;
            const response = await deleteUser(userId);
            if (response) {
                // Remove the row for the deleted user from the table
                const row = checkbox.closest('tr');
                row.parentNode.removeChild(row);
            }
            location.reload();
        });
        // Update the button states after deletions
        updateButtonStates();
    });

    // Initially update button states
    updateButtonStates();
});

async function changeUserRole(userId, newRole) {
    try {
        const response = await fetch(`/api/users/${userId}/role?newRole=${newRole}`, {
            method: 'PUT',
        });

        if (response.ok) {
            console.log('User role updated successfully');
        } else {
            console.error('Failed to update user role');
        }
    } catch (error) {
        console.error('Error:', error);
    }
}

// Function to delete a user
async function deleteUser(userId) {
    try {
        const response = await fetch(`/api/users/${userId}`, {
            method: 'DELETE',
        });

        if (response.ok) {
            console.log('User deleted successfully');
            // Return true to indicate successful deletion
            return true;
        } else {
            console.error('Failed to delete user');
            return false;
        }
    } catch (error) {
        console.error('Error:', error);
        return false;
    }
}
