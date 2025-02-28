import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pojofiles.customerdetails.Customer;
import javax.servlet.annotation.WebServlet;

@WebServlet("/submitDetails")
public class CustomerDetailsServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	CRUDoperations crudoperations = new CRUDoperations();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerIdParam = request.getParameter("id");
            if (customerIdParam == null) {
            	List<Customer> customers = crudoperations.fetchAllCustomers();
            	request.setAttribute("customerList", customers);
    	        request.getRequestDispatcher("/ViewCustomer.jsp").forward(request, response);
            } else {
                int customerId = Integer.parseInt(customerIdParam);
            	Customer customer = crudoperations.fetchCustomerById(customerId);
	            request.setAttribute("customer", customer);
	            request.getRequestDispatcher("/customerForm.jsp").forward(request, response);
            }
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        String idStr = request.getParameter("customerId");

        int customerId = (idStr == null || idStr.isEmpty()) ? -1 : Integer.parseInt(idStr);

        if ("delete".equals(action)) {
        	crudoperations.deleteCustomer(customerId);
            response.sendRedirect("submitDetails");
        }

        try {
        	
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
            
            Customer customer = new Customer(name, gender, email, phone, dob, fatherName, motherName, 
        			address, education, differentlyAbled);
        	
	        if (customerId == -1) {
	        	crudoperations.insertNewCustomer(customer);
	        } else {
	        	crudoperations.updateCustomerData(customer, customerId);
	        } 
        } catch(CustomException e) {
        	request.setAttribute("errorMessage", e.getMessage());
        	request.getRequestDispatcher("customerForm.jsp").forward(request, response);
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
    

