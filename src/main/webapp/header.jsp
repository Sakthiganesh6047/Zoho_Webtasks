<%
    String pageName = (String) request.getAttribute("pageName");
%>

<style>
	.header {
	    display: flex;
	    align-items: center;
	    justify-content: space-between;
	    color: white;
	    background-color: white;
		border-bottom: 2px solid black;
		position: fixed;
	    top: 0;
	    width: 100%;
	    z-index: 1000;        
	}
	
	.header-right {
	    display: flex;
	    align-items: center;
	    gap: 15px; /* Adds space between buttons */
	    padding-left: 20px;
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
		
	.home-btn {
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
	
	.home-btn a {
	    position: relative;
	    display: inline-block;
	}
	
	.logout-btn a {
	    position: relative;
	    display: inline-block;
	}
	
	.home-btn img {
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
	.home-btn a::after {
	    content: "Home"; /* Tooltip text */
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
	
	.home-btn a:hover::after {
	    opacity: 1;
	}
	
	.logout-btn a:hover::after {
	    opacity: 1;
	}
	
	h1 {
	    margin-bottom: 20px;
	    color: #333;
	    text-transform: uppercase;
	    letter-spacing: 1px;
	    font-size: 1.5rem;
	    text-align: center;
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
	
	.add-btn a:hover::after {
	    opacity: 1;
	}
	
	.logout-btn a:hover::after {
	    opacity: 1;
	}
     
</style>

<!-- Header Section -->
<div class="header">
    <div class="header-right">
    	<img src="buildings.png" alt="Company Logo" class="logo"> <!-- Logo -->
    	<h1>Proventus Metrics</h1>
    </div>
    <div class="header-left">
    	 <% if ("addcustomer".equals(pageName)) { %>
        <div class=home-btn>
		    <a href="submitDetails">
		    	<img src="home.png" alt="View Submitted Data">
		    </a>
		</div>
	<% } else if ("home".equals(pageName)) { %>
		<div class=add-btn>
		    <a href="customerForm.jsp">
		    	<img src="add.png" alt="Add New Customer">
		    </a>
		</div>
	<% } %>	
      <div class="logout-btn">
          <a href="logout.jsp">
              <img src="power.png" alt="Logout"> <!-- Logout Icon -->
          </a>
      </div>
  </div>
</div>
