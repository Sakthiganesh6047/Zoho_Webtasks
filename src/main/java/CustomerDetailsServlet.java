import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pojofiles.customerdetails.Customer;
import javax.servlet.annotation.WebServlet;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


@WebServlet("/submitDetails")
public class CustomerDetailsServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	public static Connection getConnection() {
        Connection conn = null;
        try {
            Context ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/MyDB");
            conn = ds.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerIdParam = request.getParameter("id");
        System.out.println(customerIdParam);

        try (Connection conn = getConnection()){
            if (customerIdParam == null) {
            	System.out.println("inside null doget");
                List<Customer> customers = new ArrayList<>();
                try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM CustomerDetails");
                     ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        customers.add(new Customer(rs.getInt("id"), rs.getString("name"),
                                rs.getString("gender"), rs.getString("email"), rs.getString("phone"),
                                rs.getString("dob"), rs.getString("fatherName"), rs.getString("motherName"),
                                rs.getString("address"), rs.getString("education"), rs.getString("differentlyAbled")));
                    }
                }
                request.setAttribute("customerList", customers);
                request.getRequestDispatcher("/ViewCustomer.jsp").forward(request, response);
                return;
            } 

            try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM CustomerDetails WHERE id = ?")) {
                int customerId = Integer.parseInt(customerIdParam);
                System.out.println(customerId);
                ps.setInt(1, customerId);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    Customer customer = new Customer(rs.getInt("id"), rs.getString("name"),
                            rs.getString("gender"), rs.getString("email"), rs.getString("phone"),
                            rs.getString("dob"), rs.getString("fatherName"), rs.getString("motherName"),
                            rs.getString("address"), rs.getString("education"), rs.getString("differentlyAbled"));
                    request.setAttribute("customer", customer);
                }
            }

            request.getRequestDispatcher("/customerForm.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        String idStr = request.getParameter("customerId");
        System.out.println(idStr);
        int customerId = (idStr == null || idStr.isEmpty()) ? -1 : Integer.parseInt(idStr);

        if ("delete".equals(action)) {
            try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement("DELETE FROM CustomerDetails WHERE id = ?")) {
                ps.setInt(1, customerId);
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Customer deleted successfully.");
                } else {
                    System.out.println("No customer found with the given ID.");
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }
            response.sendRedirect("submitDetails");
            return;
        }

        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("dob");
        String fatherName = request.getParameter("fatherName");
        String motherName = request.getParameter("motherName");
        String address = request.getParameter("address");
        String education = request.getParameter("education");
        String differentlyAbled = request.getParameter("differentlyAbled") != null ? "Yes" : "No";

        try {
        	isNull(name);
        	isNull(gender);
        	isEmailValid(email);
        	isPhoneNumValid(phone);
        	isDOBValid(dob);
        	isNull(fatherName);
        	isNull(motherName);
        	isNull(address);
        	isNull(education);
        	isNull(differentlyAbled);
        	System.out.println("Received: " + name + ", " + gender + ", " + email + ", " + phone);

	        try (Connection conn = getConnection()) {
	            if (customerId == -1) {
	                try (PreparedStatement ps = conn.prepareStatement(
	                        "INSERT INTO CustomerDetails (name, gender, email, phone, dob, fatherName,"
	                        + " motherName, address, education, differentlyAbled) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")) {
	                    ps.setString(1, name);
	                    ps.setString(2, gender);
	                    ps.setString(3, email);
	                    ps.setString(4, phone);
	                    ps.setString(5, dob);
	                    ps.setString(6, fatherName);
	                    ps.setString(7, motherName);
	                    ps.setString(8, address);
	                    ps.setString(9, education);
	                    ps.setString(10, differentlyAbled);
	                    ps.executeUpdate();
	                    System.out.println("Customer added successfully!");
	                }
	            } else {
	                try (PreparedStatement ps = conn.prepareStatement(
	                        "UPDATE CustomerDetails SET name=?, gender=?, email=?, phone=?, dob=?, fatherName=?,"
	                        + " motherName=?, address=?, education=?, differentlyAbled=? WHERE id=?")) {
	                    ps.setString(1, name);
	                    ps.setString(2, gender);
	                    ps.setString(3, email);
	                    ps.setString(4, phone);
	                    ps.setString(5, dob);
	                    ps.setString(6, fatherName);
	                    ps.setString(7, motherName);
	                    ps.setString(8, address);
	                    ps.setString(9, education);
	                    ps.setString(10, differentlyAbled);
	                    ps.setInt(11, customerId);
	                    ps.executeUpdate();
	                    System.out.println("Customer updated successfully!");
	                }
	            }
	        } catch (SQLException e) {
	            throw new CustomException("Error occured in DataBase" , e);
	        }
        
        } catch(CustomException e) {
        	request.setAttribute("errorMessage", e.getMessage());
        	System.out.println("Custom attribute is set");
            request.getRequestDispatcher("customerForm.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("submitDetails");
    }
    
    public void init() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    private void isNull(String name) throws CustomException {
    	if (name == null || name.trim().isEmpty()) {
    		System.out.println("null-check");
    		throw new CustomException("Required fields cannot be empty.");
    	}
    }
    
    private void isEmailValid(String email) throws CustomException {
    	if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
    		throw new CustomException("Invalid email format.");
    	}
    }
    
    private void isPhoneNumValid(String phone) throws CustomException {
    	if (!phone.matches("^\\d{10}$")) {
    		throw new CustomException("Phone number must be 10 digits.");
    	}
    }
    
    private void isDOBValid(String dob) throws CustomException {
    	if (!dob.matches("^\\d{4}-\\d{2}-\\d{2}$")) {
    		throw new CustomException("Invalid date format (YYYY-MM-DD).");
    	}
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
