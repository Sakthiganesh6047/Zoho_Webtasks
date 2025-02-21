<%@ page import="java.util.List" %>
<%@ page import="pojofiles.customerdetails.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Data</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            text-align: center;
            padding: 20px;
        }
        table {
            width: 90%;
            margin: auto;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .actions a, .actions button {
            text-decoration: none;
            padding: 5px 10px;
            margin: 2px;
            border: none;
            cursor: pointer;
            color: white;
            border-radius: 5px;
        }
        .edit-btn { background-color: #28a745; }
        .delete-btn { background-color: #dc3545; }
        .add-btn {
            background-color: #007bff;
            padding: 10px 15px;
            display: inline-block;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <h2>Customer Details</h2>

    <a href="Form.html" class="add-btn">Add New Customer</a>

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
                    <a href="Form.html?id=<%= customer.getId() %>" class="edit-btn">Edit</a>
                    <button class="delete-btn" onclick="deleteCustomer(<%= customer.getId() %>)">Delete</button>
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
    <a href="Form.html">Go Back to Form</a>

    <script>
        function deleteCustomer(id) {
            if (confirm("Are you sure you want to delete this customer?")) {
                fetch("submitDetails", {
                    method: "POST",
                    headers: { "Content-Type": "application/x-www-form-urlencoded" },
                    body: `customerId=${id}&action=delete`
                }).then(response => {
                    if (response.ok) {
                        document.getElementById("row-" + id).remove();
                    } else {
                        alert("Failed to delete customer.");
                    }
                }).catch(error => console.error("Error:", error));
            }
        }
    </script>
</body>
</html>
