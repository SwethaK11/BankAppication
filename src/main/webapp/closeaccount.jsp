<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Close Account</title>
    <script>
        function closeAccount(event) {
            event.preventDefault(); // Prevent form submission

            var accountNumber = document.getElementById('accountNumber').value;

            fetch('CloseAccountServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'accountNumber=' + accountNumber
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message); // Show success message
                    window.location.href = 'accountdeleted.jsp';
                } else {
                    alert(data.message); // Show warning message
                    window.location.href = 'accountnotdeleted.jsp';
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred. Please try again later.');
            });
        }
    </script>
</head>
<body>
    <h1>Close Account</h1>
    <form onsubmit="closeAccount(event)">
        <label for="accountNumber">Account Number:</label>
        <input type="text" id="accountNumber" name="accountNumber" required>
        <button type="submit">Close Account</button>
    </form>
</body>
</html>
