import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.sql.DataSource;
import pojofiles.customerdetails.Customer;

public class CRUDoperations {

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

	public List<Customer> fetchAllCustomers() throws ServletException, IOException {
		try (Connection conn = getConnection()){
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
	        return customers;
        } catch (SQLException e) {
            e.printStackTrace();
        }
		return null;
	}
	
	public Customer fetchCustomerById(int customerId) throws ServletException, IOException {
		try (Connection conn = getConnection()){	
			try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM CustomerDetails WHERE id = ?")) {
	            ps.setInt(1, customerId);
	            ResultSet rs = ps.executeQuery();
	
	            if (rs.next()) {
	                Customer customer = new Customer(rs.getInt("id"), rs.getString("name"),
	                        rs.getString("gender"), rs.getString("email"), rs.getString("phone"),
	                        rs.getString("dob"), rs.getString("fatherName"), rs.getString("motherName"),
	                        rs.getString("address"), rs.getString("education"), rs.getString("differentlyAbled"));
	                return customer;
	            }
			}
		} catch (SQLException e) {
            e.printStackTrace();
        }
		return null;
	}
	
    public void deleteCustomer(int customerId) {
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
    }
    
    public void updateCustomerData(Customer customer, int customerId) throws CustomException {
    	
    	String name = customer.getName();
        String gender = customer.getGender();
        String email = customer.getEmail();
        String phone = customer.getPhone();
        String dob = customer.getDob();
        String fatherName = customer.getFatherName();
        String motherName = customer.getMotherName();
        String address = customer.getAddress();
        String education = customer.getEducation();
        String differentlyAbled =  customer.getDifferentlyAbled();
        
        try {
	        ServerInputValidations validator = new ServerInputValidations();
	    	validator.nameValidation(name);
	    	validator.genderValidation(gender);
	    	validator.emailValidation(email);
	    	validator.dobValidation(dob);
	    	validator.nameValidation(fatherName);
	    	validator.nameValidation(motherName);
	    	validator.addressValidation(address);
	    	validator.nameValidation(education);
	    	validator.disabledValidation(differentlyAbled);
	
	    	try (Connection conn = getConnection()) {
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
        	throw new CustomException("Error while updation: "+ e.getMessage(), e);
        }	
    }
           
    public void insertNewCustomer(Customer customer) throws CustomException {
    	
    	String name = customer.getName();
        String gender = customer.getGender();
        String email = customer.getEmail();
        String phone = customer.getPhone();
        String dob = customer.getDob();
        String fatherName = customer.getFatherName();
        String motherName = customer.getMotherName();
        String address = customer.getAddress();
        String education = customer.getEducation();
        String differentlyAbled =  customer.getDifferentlyAbled();
        
        try {
	        ServerInputValidations validator = new ServerInputValidations();
	    	validator.nameValidation(name);
	    	validator.genderValidation(gender);
	    	validator.emailValidation(email);
	    	validator.dobValidation(dob);
	    	validator.nameValidation(fatherName);
	    	validator.nameValidation(motherName);
	    	validator.addressValidation(address);
	    	validator.nameValidation(education);
	    	validator.disabledValidation(differentlyAbled);
	    	
	    	try (Connection conn = getConnection()) {
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
	    	} 
        } catch (SQLException e) {
        	throw new CustomException("Error in query execution" + e.getMessage(), e);
        }	
    }
            
            
}
