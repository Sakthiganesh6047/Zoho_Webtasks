<%@ page import="java.util.List" %>
<%@ page import="pojofiles.customerdetails.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Audiowide">
    <title>Customer Data</title>
    <style>
    
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            text-align: center;
            margin: 0;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            flex-wrap: wrap;
    		align-items: center;
            flex-wrap: wrap;
        }
		
		h2{
			margin-top: 130px;
		}
		
		.table-container{
			width: 95%;
		}

        /* Table Styling */
        table {
        	width: 100%;
			border-collapse: collapse;
            background: #fff;
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
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
		
		tr:hover {
		    background-color: #f5f5f5;
		    transform: scale(1.02);
		    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
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
		    display: inline-block;
		}
		
		/* Hover effects */
		.delete-btn:hover {
		    transform: scale(1.1);
		}
		
		.edit-btn img:hover {
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
    <% request.setAttribute("pageName", "home"); %>
	<jsp:include page="header.jsp" />

    <h2>Customers</h2>

	<div class=table-container>
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
	</div>

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
	<jsp:include page="footer.jsp" />
</body>
</html>
