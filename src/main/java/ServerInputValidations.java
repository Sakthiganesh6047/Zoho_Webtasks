import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ServerInputValidations {
	
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
    
    private static void isWithinMaxLength(String input, int maxLength) throws CustomException {
        if (input != null) {
        	if(input.length() > maxLength) {
        		throw new CustomException("Maximum length of the entry is exceeded!");
        	}
        }
    }
    
    public void nameValidation(String name) throws CustomException {
    	isNull(name);
    	isWithinMaxLength(name , 100);
    }
    
    public void genderValidation(String gender) throws CustomException {
    	isNull(gender);
    	isWithinMaxLength(gender , 10);
    }
    
    public void emailValidation(String email) throws CustomException {
    	isNull(email);
    	isEmailValid(email);
    	isWithinMaxLength(email , 100);
    }
    
    public void phoneNumValidation_insertions(String phoneNumber) throws CustomException {
    	isNull(phoneNumber);
    	isWithinMaxLength(phoneNumber , 15);
    	isPhoneNumValid(phoneNumber);
    }
    
    public void phoneNumValidation_updations(String phoneNumber) throws CustomException {
    	isNull(phoneNumber);
    	isWithinMaxLength(phoneNumber , 15);
    	isPhoneNumValid(phoneNumber);
    }
    
    public void addressValidation(String address) throws CustomException {
    	isNull(address);
    	isWithinMaxLength(address,400);
    }
    
    public void dobValidation(String dob) throws CustomException {
    	isNull(dob);
    	isDOBValid(dob);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(false);

        try {
            Date date = sdf.parse(dob);

            if (date.after(new Date())) {
                throw new CustomException("Date of birth cannot be in the future!");
            }

            if (!isAboveAge(date, 18)) {
                throw new CustomException("User must be at least 18 years old!");
            }
        } catch (ParseException e) {
            throw new CustomException("Invalid date format. Use YYYY-MM-DD.");
        }
    }

    private static boolean isAboveAge(Date dob, int minAge) {
        long millisPerYear = 1000L * 60 * 60 * 24 * 365;
        long ageInMillis = new Date().getTime() - dob.getTime();
        return (ageInMillis / millisPerYear) >= minAge;
    }
    
    public enum DifferentlyAbled {
        YES, NO;

        public static boolean isValid(String value) {
            for (DifferentlyAbled differentlyabled : values()) {
                if (differentlyabled.name().equalsIgnoreCase(value)) {
                    return true;
                }
            }
            return false;
        }
    }
    
    public void disabledValidation(String userInput) throws CustomException {
    	isNull(userInput);
    	if (!DifferentlyAbled.isValid(userInput)) {
    	    throw new CustomException("Invalid value for differentlyAbled field!");
    	} 
    }
    
//    private static void isPhoneNumUnique_insertion(String phoneNumber) throws CustomException {
// 	 String checkQuery = "SELECT COUNT(*) FROM CustomerDetails WHERE phone = ?";
//
//   try (Connection conn = getConnection();
//        PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
//  	 
//       checkStmt.setString(1, phoneNumber);
//       ResultSet rs = checkStmt.executeQuery();
//       rs.next();
//       if (rs.getInt(1) > 0) {
//           throw new CustomException("Phone number already exists! Please use a different one.");
//       }
//   } catch (SQLException e) {
//          throw new CustomException("Error occured in DataBase while checking phone number" , e);
//      }
//}
//
//private static void isPhoneNumUnique_updation(String phoneNumber , int customerId) throws CustomException {
//	 String checkQuery = "SELECT COUNT(*) FROM CustomerDetails WHERE phone = ? AND id <> ?";
//
//  try (Connection conn = getConnection();
//       PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
// 	 
//      checkStmt.setString(1, phoneNumber);
//      checkStmt.setInt(2, customerId);
//      ResultSet rs = checkStmt.executeQuery();
//      rs.next();
//      if (rs.getInt(1) > 0) {
//          throw new CustomException("Phone number already exists! Please use a different one.");
//      }
//  } catch (SQLException e) {
//          throw new CustomException("Error occured in DataBase while checking phone number" , e);
//      }
//}
}
