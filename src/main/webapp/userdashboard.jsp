<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.bank.Customer.customer" %>
<%@ page import="com.bank.Customer.CustomerDAO" %>
<%@ page import="javax.servlet.http.HttpSession" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f3f4f6;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image:url('images/bgpic.jpg');
            background-size: cover;
            background-position: center;
        }
        .navbar {
            background-color: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            padding: 10px 0;
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-around;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .navbar a {
            color: MediumSlateBlue;
            text-decoration: none;
            font-weight: bold;
            padding: 10px 20px;
            transition: color 0.3s background-color 0.3s;
        }
        .navbar a:hover {
            color: white;
            background-color: #CCCCFF;
        }
        .container {
            width: 100%;
            max-width: 600px;
            margin-top: 80px; /* Adjust based on navbar height */
            padding: 30px;
            background-color: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            text-align: center;
            box-sizing: border-box;
        }
        .header {
            color: MediumSlateBlue;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
        }
        .card {
            background-color: white;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .card h3 {
            color: MediumSlateBlue;
            margin-bottom: 10px;
            font-size: 20px;
            font-weight: bold;
        }
        .card p {
            margin-bottom: 10px;
        }
        .card button {
            padding: 10px 20px;
            background-color: MediumSlateBlue;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            text-transform: uppercase;
            transition: background-color 0.3s, transform 0.3s ease-out;
            margin-top: 10px;
        }
        .card button:hover {
            background-color: #7b68ee;
            transform: translateY(-3px);
        }
        .card button:focus {
            background-color: #7b68ee;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .view-transactions {
            text-align: center;
            margin-top: 20px;
        }
        .dialog-container {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
            text-align: center;
        }
        .dialog-box {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 300px;
            text-align: center;
            display: inline-block;
        }
        .dialog-box input {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .dialog-box button {
            padding: 10px 20px;
            background-color: MediumSlateBlue;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            text-transform: uppercase;
            transition: background-color 0.3s, transform 0.3s ease-out;
            margin-top: 10px;
        }
        .dialog-box button:hover {
            background-color: #7b68ee;
            transform: translateY(-3px);
        }
        .dialog-box button:focus {
            background-color: #7b68ee;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .dialog-box a.dialog-button {
    padding: 10px 20px;
    background-color: MediumSlateBlue;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
    text-transform: uppercase;
    transition: background-color 0.3s, transform 0.3s ease-out;
    margin-top: 10px;
    display: inline-block;
    text-decoration: none; /* Remove underline */
    text-align: center; /* Center text */
}

.dialog-box a.dialog-button:hover {
    background-color: #7b68ee;
    transform: translateY(-3px);
}

.dialog-box a.dialog-button:focus {
    background-color: #7b68ee;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
        .navbar a:hover {
            color: #7b68ee !important;
        }
        h1 {
            color:MediumSlateBlue;
        }
    </style>
</head>
<body>

<div class="navbar">
    <a href="UserDashboardServlet">Home</a>
    <a href="userprofile.jsp">Profile</a>
    <a href="ministatement.jsp">Mini Statement</a>
    <a href="#" onclick="showCloseAccountDialog()">Close Account</a>
    <a href="LogoutServlet">Logout</a>
</div>

<div class="container">
    <div class="header">
        <h1>Welcome, ${fullName}</h1>
    </div>
    <div class="card">
        <h3>Account Overview</h3>
        <p>Account Balance: ${balance}</p>
        <p>Last Login: ${lastLogin}</p>
        <div class="a">
            <button onclick="showDepositDialog()">Deposit</button>
            <button onclick="showWithdrawDialog()">Withdraw</button>
        </div>
    </div>
    <div class="card">
        <div class="view-transactions">
            <a href="ViewTransactionsServlet"><button type="submit" name="submit">View Transactions</button></a>
        </div>
    </div>
</div>

<!-- Deposit Dialog Box -->
<div id="depositDialog" class="dialog-container">
    <div class="dialog-box">
        <h2>Deposit Amount</h2>
        <input type="number" id="depositAmount" placeholder="Enter amount">
        <button onclick="submitDeposit()">Submit</button>
        <button onclick="hideDepositDialog()">Cancel</button>
    </div>
</div>

<!-- Withdraw Dialog Box -->
<div id="withdrawDialog" class="dialog-container">
    <div class="dialog-box">
        <h2>Withdraw Amount</h2>
        <input type="number" id="withdrawAmount" placeholder="Enter amount">
        <button onclick="submitWithdraw()">Submit</button>
        <button onclick="hideWithdrawDialog()">Cancel</button>
    </div>
</div>

<!-- Close Account Dialog Box -->
 <!-- Close Account Dialog Box -->
<!-- Close Account Dialog Box -->
<div id="closeAccountDialog" class="dialog-container">
    <div class="dialog-box">
        <h2>Close Account</h2>
        <p>Are you sure you want to close your account?</p>
        <input type="hidden" id="accountNumber" value="${accountNumber}">
        <a href="#" id="confirmCloseAccount" onclick="submitCloseAccount()" class="dialog-button">Confirm</a>
        <button onclick="hideCloseAccountDialog()">Cancel</button>
    </div>
</div>


<script>
    function showDepositDialog() {
        document.getElementById('depositDialog').style.display = 'flex';
    }

    function hideDepositDialog() {
        document.getElementById('depositDialog').style.display = 'none';
    }

    function submitDeposit() {
        var amount = document.getElementById('depositAmount').value;
        if (amount === '') {
            alert('Please enter an amount.');
            return;
        }

        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'DepositServlet', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    alert('Deposit successful!');
                    window.location.reload(); // Refresh page or update UI
                } else {
                    console.error('Deposit failed:', xhr.status, xhr.statusText);
                    alert('Deposit failed. Please try again.');
                }
            }
        };
        xhr.send('amount=' + encodeURIComponent(amount));
    }

    function showWithdrawDialog() {
        document.getElementById('withdrawDialog').style.display = 'flex';
    }

    function hideWithdrawDialog() {
        document.getElementById('withdrawDialog').style.display = 'none';
    }

    function submitWithdraw() {
        var amount = document.getElementById('withdrawAmount').value;
        if (amount === '') {
            alert('Please enter an amount.');
            return;
        }

        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'WithdrawServlet', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    alert('Withdrawal successful!');
                    window.location.reload(); // Refresh page or update UI
                } else {
                    console.error('Withdrawal failed:', xhr.status, xhr.statusText);
                    alert('Withdrawal failed. Please try again.');
                }
            }
        };
        xhr.send('amount=' + encodeURIComponent(amount));
    }
    function showCloseAccountDialog() {
        document.getElementById('closeAccountDialog').style.display = 'flex';
    }

    function hideCloseAccountDialog() {
        document.getElementById('closeAccountDialog').style.display = 'none';
    }

    function submitCloseAccount() {
        var accountNumber = document.getElementById('accountNumber').value;

        if (confirm("Are you sure you want to close your account?")) {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'CloseAccountServlet', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        var response = JSON.parse(xhr.responseText);
                        if (response.success) {
                            alert('Account closed successfully.');
                            window.location.href = 'accountDeleted.jsp'; // Redirect to account deleted confirmation page
                        } else {
                            alert(response.message); // Show the message returned from the servlet
                        }
                    } else {
                        console.error('Close account failed:', xhr.status, xhr.statusText);
                        alert('Unable to close account. Please try again.');
                    }
                }
            };
            xhr.send('accountNumber=' + encodeURIComponent(accountNumber));
        }
    }

</script>

</body>
</html>