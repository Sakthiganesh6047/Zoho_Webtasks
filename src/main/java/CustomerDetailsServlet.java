import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import pojofiles.customerdetails.Customer;
import javax.servlet.annotation.WebServlet;


@WebServlet("/submitDetails")
public class CustomerDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
	private static final String URL = "jdbc:mysql://localhost:3306/CustomerDB";
    private static final String USER = "root";
    private static final String PASSWORD = "Asg@$^*6047007";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerIdParam = request.getParameter("id");

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            if (customerIdParam == null) {
                // Fetch ALL customers (for ViewCustomers.jsp)
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

            } else {
                // Fetch SINGLE customer (for editing in Form.html)
                int customerId = Integer.parseInt(customerIdParam);
                response.setContentType("application/json");

                try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM CustomerDetails WHERE id = ?")) {
                    ps.setInt(1, customerId);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        JSONObject json = new JSONObject();
                        json.put("id", rs.getInt("id"));
                        json.put("name", rs.getString("name"));
                        json.put("gender", rs.getString("gender"));
                        json.put("email", rs.getString("email"));
                        json.put("phone", rs.getString("phone"));
                        json.put("dob", rs.getString("dob"));
                        json.put("fatherName", rs.getString("fatherName"));
                        json.put("motherName", rs.getString("motherName"));
                        json.put("address", rs.getString("address"));
                        json.put("education", rs.getString("education"));
                        json.put("differentlyAbled", rs.getString("differentlyAbled"));

                        response.getWriter().write(json.toString());
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        String idStr = request.getParameter("customerId");
        int customerId = (idStr == null || idStr.isEmpty()) ? -1 : Integer.parseInt(idStr);

        if ("delete".equals(action)) {
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
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

        System.out.println("Received: " + name + ", " + gender + ", " + email + ", " + phone);

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            if (customerId == -1) {
                // INSERT New Customer
                try (PreparedStatement ps = conn.prepareStatement(
                        "INSERT INTO CustomerDetails (name, gender, email, phone, dob, fatherName, motherName, address, education, differentlyAbled) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")) {
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
                // UPDATE Existing Customer
                try (PreparedStatement ps = conn.prepareStatement(
                        "UPDATE CustomerDetails SET name=?, gender=?, email=?, phone=?, dob=?, fatherName=?, motherName=?, address=?, education=?, differentlyAbled=? WHERE id=?")) {
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
            e.printStackTrace();
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
}
