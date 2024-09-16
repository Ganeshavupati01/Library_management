public class User {
    private String role;
    private String name;
    private String pin;
    private long phone;
    private String email;
    private String password;
    
    
    
    
    public User() {
		super();
	}



	public User(String role, String name, String pin, long phone, String email, String password) {
		super();
		this.role = role;
		this.name = name;
		this.pin = pin;
		this.phone = phone;
		this.email = email;
		this.password = password;
	}
    
    

    // Getters and Setters
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    public String getPin() {
        return pin;
    }

    public void setPin(String pin) {
        this.pin = pin;
    }

    public long getPhone() {
        return phone;
    }

    public void setPhone(long phone) {
        this.phone = phone;
    }

   

	public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
