<%@ page import="pojofiles.customerdetails.Customer" %>
<%
    Customer customer = (Customer) request.getAttribute("customer");
    boolean isEditMode = (customer != null);
%>
<!DOCTYPE html>
<html lang="en">
<html>
<head>
    <meta charset="UTF-8">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Audiowide">
	<title><%= isEditMode ? "Edit Customer Details" : "Customer Details Form" %></title>
    
    <style>
		
		body {
			font-family: Arial, sans-serif;
			background-color: #f8f9fa;
			margin: 0;
		}
		
		.form-body {
		    margin: 0;
		    padding: 0;
		    min-height: 100vh;
		    display: flex;
		    flex-direction: column;
		    justify-content: flex-start;
		    align-items: center;
		    padding-top: 100px;
		    padding-bottom: 30px; /* Added space to avoid cutoff */
		    box-sizing: border-box;
		}
		
		form {
		    background-color: #ffffff;
		    padding: 30px;
		    border-radius: 15px;
		    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
		    max-width: 650px;
		    width: 100%;
		    border: 1px solid #ddd;
		    margin-top: 20px;
		}
		
		label {
		    font-weight: 600;
		    color: #555;
		    margin-bottom: 5px;
		    display: block;
		}
		
		label span.required {
		    color: red !important;
		}
		
		
		label .required {
		    color: red !important;
		    font-size: 1.2rem;
		    margin-left: 5px;
		    font-weight: bold;
		}
		
		input[type="text"], 
		input[type="email"], 
		input[type="tel"], 
		input[type="date"], 
		textarea {
		    width: 100%;
		    padding: 12px;
		    margin-bottom: 15px;
		    border: 1px solid #bbb;
		    border-radius: 8px;
		    font-size: 1rem;
		    box-sizing: border-box;
		}
		
		input:focus, textarea:focus {
		    border-color: #007BFF;
		    outline: none;
		}
		
		#address {
		    resize: none;
		}
		
		.gender-container, .checkbox-container {
		    display: flex;
		    align-items: center;
		    gap: 15px;
		    margin-bottom: 15px;
		}
		
		.gender-container label, .checkbox-container label {
		    margin: 0;
		}
		
		button {
		    background: linear-gradient(135deg, #2EC9FF, #2267E9);
		    color: #fff;
		    border: none;
		    padding: 14px;
		    border-radius: 8px;
		    cursor: pointer;
		    width: 100%;
		    font-size: 1rem;
		    transition: transform 0.2s;
		    text-align: center;
		    display: inline-block;
		    text-decoration: none;
		    text-transform: uppercase;
		    font-weight: bold;
		}
		
		button:hover {
		    transform: translateY(-3px);
		}
		
		.view-button {
		    display: inline-block;
		    background: linear-gradient(135deg, #007BFF, #0056b3);
		    color: white !important; /* Override inherited styles */
		    padding: 12px 20px;
		    border-radius: 8px;
		    text-align: center;
		    font-size: 1rem;
		    font-weight: bold;
		    text-decoration: none; /* Removes underline */
		    transition: transform 0.2s, background 0.3s;
		}
		
		.view-button:hover {
		    transform: translateY(-3px);
		    background: linear-gradient(135deg, #0056b3, #004494);
		}
		
		.error-message{
			padding: 20px;
		}
		
    </style>
    
</head>
<body>

	<% request.setAttribute("pageName", "addcustomer"); %>
	<jsp:include page="header.jsp" />
    
	<div class="form-body">
    	<h1 id="form-title"><%= isEditMode ? "Edit Customer Details" : "Customer Details Form" %></h1>
    	<%-- Display error message if exists --%>
	    <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
	    <% if (errorMessage != null) { %>
	        <div class=error-message style="color: red; font-weight: bold;"><%= errorMessage %></div>
	    <% } %>
		    <form action="submitDetails" method="post">
	        <input type="hidden" name="customerId" value="<%= isEditMode ? customer.getId() : "" %>">
	
	        <label for="name">Full Name:<span class="required">*</span></label>
	        <input type="text" id="name" name="name" value="<%= isEditMode ? customer.getName() : "" %>" maxlength="50" autofocus required><br><br>
			
			<div class="gender-container">
		        <label>Gender:<span class="required">*</span></label>
		        <input type="radio" id="male" name="gender" value="Male" <%= isEditMode && "Male".equals(customer.getGender()) ? "checked" : "" %> >
		        <label for="male">Male</label>
		        
		        <input type="radio" id="female" name="gender" value="Female" <%= isEditMode && "Female".equals(customer.getGender()) ? "checked" : "" %> >
		        <label for="female">Female</label>
		
		        <input type="radio" id="other" name="gender" value="Others" <%= isEditMode && "Others".equals(customer.getGender()) ? "checked" : "" %> >
		        <label for="other">Others</label><br><br>
		    </div>
		    
		   	<div class="checkbox-container">
			    <label for="differentlyAbled">Check if: <span class="required">*</span></label>
			    <input type="checkbox" id="differentlyAbled" name="differentlyAbled" value="Yes" 
			        <%= isEditMode && "Yes".equals(customer.getDifferentlyAbled()) ? "checked" : "" %> >
			    <label for="differentlyAbled">Differently Abled</label>
			</div><br>
	
	        <label for="dob">Date of Birth:<span class="required">*</span></label>
	        <input type="date" id="dob" name="dob" value="<%= isEditMode ? customer.getDob() : "" %>" required><br><br>
	
	        <label for="email">Email:<span class="required">*</span></label>
	        <input type="email" id="email" name="email" value="<%= isEditMode ? customer.getEmail() : "" %>" maxlength="50" required><br><br>
	
	        <label for="phone">Phone Number:<span class="required">*</span></label>
	        <input type="tel" id="phone" name="phone" value="<%= isEditMode ? customer.getPhone() : "" %>" pattern="[0-9]{10}" inputmode="numeric" maxlength="10" required><br><br>
	
	        <label for="address">Address:<span class="required">*</span></label><br>
	        <textarea id="address" name="address" rows="4" maxlength="50" required><%= isEditMode ? customer.getAddress() : "" %></textarea><br><br>
	
	        <label for="father_name">Father's Name:<span class="required">*</span></label>
	        <input type="text" id="father_name" name="fatherName" value="<%= isEditMode ? customer.getFatherName() : "" %>" maxlength="50" required><br><br>
	
	        <label for="mother_name">Mother's Name:<span class="required">*</span></label>
	        <input type="text" id="mother_name" name="motherName" value="<%= isEditMode ? customer.getMotherName() : "" %>" maxlength="50" required><br><br>
	
	        <label for="education">Educational Qualifications:<span class="required">*</span></label>
	        <input type="text" id="education" name="education" value="<%= isEditMode ? customer.getEducation() : "" %>" maxlength="50" ><br><br>
	
	        <button type="submit"><%= isEditMode ? "Update" : "Submit" %></button>
    	</form>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>
