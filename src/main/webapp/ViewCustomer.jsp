<%@ page import="java.util.List" %>
<%@ page import="pojofiles.customerdetails.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Audiowide">
    <title>Customer Data</title>
    <style>
    
  		* {
			box-sizing: border-box;
		}
		
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            text-align: center;
            padding: 20px;
        }

        /* Header Styling */
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            color: white;
            background-color: white;
			border-bottom: 2px solid black;
		    position: sticky;
		    top: 0;
		    width: 100%;
		    z-index: 1000;
		}
		
		/* Right-side container for Add New Customer & Logout */
		.header-right {
		    display: flex;
		    align-items: center;
		    gap: 15px; /* Adds space between buttons */
		}
		
		.header-right a, .header-right button {
		    text-decoration: none;
		    padding: 8px 12px;
		    border-radius: 5px;
		    font-size: 16px;
		    cursor: pointer;
		}
		
		.header-left {
		    display: flex;
		    align-items: center;
		    gap: 15px; /* Adds space between buttons */
		}
		
		.header h1 {
			color: black;
			font-family: "Audiowide", sans-serif;
			font-weight: normal;
			text-transform: uppercase;
		}

        .logo {
            height: 50px; /* Adjust the logo size */
        }
        
        .add-btn {
		    display: flex;
		    justify-content: flex-end;
		    width: 100%;
		    padding: 10px 30px;
		    position: relative;
		}
		
		.logout-btn {
		    display: flex;
		    justify-content: flex-end;
		    width: 100%;
		    padding: 10px 30px;
		    position: relative;
		}
		
		.add-btn a {
		    position: relative;
		    display: inline-block;
		}
		
		.logout-btn a {
		    position: relative;
		    display: inline-block;
		}
		
		.add-btn img {
		    width: 40px;
		    height: auto;
		    cursor: pointer;
		    transition: transform 0.2s;
		}
		
		.logout-btn img {
		    width: 40px;
		    height: auto;
		    cursor: pointer;
		    transition: transform 0.2s;
		}
		
		/* Tooltip Styling */
		.add-btn a::after {
		    content: "Add Customer"; /* Tooltip text */
		    position: absolute;
		    bottom: -30px; /* Position below the image */
		    left: 50%;
		    transform: translateX(-50%);
		    background-color: #333;
		    color: white;
		    padding: 5px 10px;
		    font-size: 12px;
		    border-radius: 5px;
		    white-space: nowrap;
		    opacity: 0;
		    transition: opacity 0.3s ease-in-out;
		    pointer-events: none;
		}
		
		.logout-btn a::after {
		    content: "Logout"; /* Tooltip text */
		    position: absolute;
		    bottom: -30px; /* Position below the image */
		    left: 50%;
		    transform: translateX(-50%);
		    background-color: #333;
		    color: white;
		    padding: 5px 10px;
		    font-size: 12px;
		    border-radius: 5px;
		    white-space: nowrap;
		    opacity: 0;
		    transition: opacity 0.3s ease-in-out;
		    pointer-events: none;
		}
		
		/* Show tooltip on hover */
		.add-btn a:hover::after {
		    opacity: 1;
		}
		
		.logout-btn a:hover::after {
		    opacity: 1;
		}

        /* Table Styling */
        table {
            width: 90%;
            margin: auto;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 8px;
            border: 1px solid #ddd;
            text-align: left;
        }

       	th {
		    background: linear-gradient(135deg, #2EC9FF, #2267E9);
		    color: white;
		    text-align: center;
		    padding: 12px;
		}
		
		.actions {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    gap: 10px; /* Space between buttons */
		}
		
		.edit-btn, .delete-btn {
		    background: none;
		    border: none;
		    cursor: pointer;
		    padding: 5px;
		    transition: transform 0.2s ease-in-out;
		}
		
		.edit-btn img, .delete-btn img {
		    width: 24px; /* Adjust icon size */
		    height: 24px;
		    display: block;
		}
		
		/* Hover effects */
		.edit-btn:hover, .delete-btn:hover {
		    transform: scale(1.1);
		}
		
		/* Edit button specific styles */
		.edit-btn img {
		    filter: brightness(0) saturate(100%) invert(40%) sepia(93%) saturate(286%) hue-rotate(88deg) brightness(92%) contrast(97%);
		    /* Adjust color if needed */
		}
		
		/* Delete button specific styles */
		.delete-btn img {
		    filter: brightness(0) saturate(100%) invert(16%) sepia(99%) saturate(7483%) hue-rotate(358deg) brightness(100%) contrast(104%);
		    /* Adjust color if needed */
		}
		
        .center-button {
		    display: inline-block;
		    padding: 10px 20px;
		    background: linear-gradient(135deg, #2EC9FF, #2267E9); /* Blue color */
		    color: white;
		    text-decoration: none;
		    font-size: 16px;
		    font-weight: bold;
		    border-radius: 5px;
		    text-align: center;
		    border: none;
		    cursor: pointer;
		    transition: background 0.3s ease;
		}
		
		.center-button:hover {
		    background-color: #0056b3; /* Darker blue on hover */
		}
		
		/* Center the button */
		.button-container {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		}

    </style>
</head>
<body>

    <!-- Header Section -->
    <div class="header">
        
        <div class="header-right">
        	<img src="buildings.png" alt="Company Logo" class="logo"> <!-- Logo -->
        	<h1>Proventus Metrics</h1>
        </div>
        <div class="header-left">
	        <div class=add-btn>
			    <a href="customerForm.jsp">
			    	<img src="add.png" alt="Add New Customer">
			    </a>
			</div>
	        <div class="logout-btn">
	            <a href="logout.jsp">
	                <img src="power.png" alt="Logout"> <!-- Logout Icon -->
	            </a>
	        </div>
	    </div>
    </div>

    <h2>Customers</h2>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Gender</th>
                <th>Email</th>
                <th>Phone</th>
                <th>DOB</th>
                <th>Father's Name</th>
                <th>Mother's Name</th>
                <th>Address</th>
                <th>Education</th>
                <th>Disabled</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% List<Customer> customers = (List<Customer>) request.getAttribute("customerList");
            	if (customers == null){
            		response.sendRedirect("submitDetails");
            	}
            	customers = (List<Customer>) request.getAttribute("customerList");
               	if (customers != null && !customers.isEmpty()) {
                   for (Customer customer : customers) { %>
            <tr id="row-<%= customer.getId() %>">
                <td><%= customer.getId() %></td>
                <td><%= customer.getName() %></td>
                <td><%= customer.getGender() %></td>
                <td><%= customer.getEmail() %></td>
                <td><%= customer.getPhone() %></td>
                <td><%= customer.getDob() %></td>
                <td><%= customer.getFatherName() %></td>
                <td><%= customer.getMotherName() %></td>
                <td><%= customer.getAddress() %></td>
                <td><%= customer.getEducation() %></td>
                <td><%= customer.getDifferentlyAbled() %></td>
                <td class="actions">
                	<div>
                	<a href="submitDetails?id=<%= customer.getId() %>" class="edit-btn">
					    <img alt="Edit" src="pencil.png">
					</a>
                	</div>
                  	<button class="delete-btn" onclick="deleteCustomer('<%= customer.getId() %>')">
					    <img src="delete.png" alt="Delete">
					</button>             
                </td>
            </tr>
            <% } } else { %>
            <tr>
                <td colspan="12">No customer data available.</td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <br>
    <div class="button-container">
	    <a href="customerForm.jsp" class="center-button">Go Back to Form</a>
	</div>

    <script>
	    function deleteCustomer(id) {
	        console.log("Customer ID received in function:", id); // Debugging log
	
	        if (!id || id.trim() === "") {
	            alert("Invalid Customer ID");
	            return;
	        }
	
	        let formData = "customerId=" + encodeURIComponent(id) + "&action=delete";
	        console.log("Sending data:", formData); // Debugging log
	
	        if (confirm("Are you sure you want to delete this customer?")) {
	            fetch("submitDetails", {
	                method: "POST",
	                headers: { "Content-Type": "application/x-www-form-urlencoded" },
	                body: formData
	            })
	            .then(response => response.text())
	            .then(data => {
	                console.log("Server response:", data);
	                let row = document.getElementById("row-" + id);
	                if (row) row.remove();
	            })
	            .catch(error => console.error("Error:", error));
	        }
	    }
    </script>

</body>
</html>
