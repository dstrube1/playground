package com.dstrube.dbTest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Student {

	private int SID;
	private String firstName, lastName, address, city, state, email;
	private int zip;
	private float gpa;

	public Student() {
		setSID(0);
		setFirstName("");
		setLastName("");
		setAddress("");
		setCity("");
		setState("");
		setZip(0);
		setEmail("");
		setGpa(0.0f);
	}

	public Student(int SID, String firstName, String lastName, String address,
			String city, String state, int zip, String email, float gpa) {
		setSID(SID);
		setFirstName(firstName);
		setLastName(lastName);
		setAddress(address);
		setCity(city);
		setState(state);
		setZip(zip);
		setEmail(email);
		setGpa(gpa);
	}

	public int getSID() {
		return SID;
	}

	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public String getAddress() {
		return address;
	}

	public String getCity() {
		return city;
	}

	// can't just call this getState; that name is already taken
	public String getStudentState() {
		return state;
	}

	public int getZip() {
		return zip;
	}

	public String getEmail() {
		return email;
	}

	public float getGpa() {
		return gpa;
	}

	public void setSID(int SID) {
		this.SID = SID;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public void setState(String state) {
		this.state = state;
	}

	public void setZip(int zip) {
		this.zip = zip;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setGpa(float gpa) {
		this.gpa = gpa;
	}

	public void display() {
		System.out.println(SID + ", " + firstName + ", " + lastName + ", "
				+ address + ", " + city + ", " + state + ", " + zip + ", "
				+ email + ", " + gpa + "\n");
	}

	public void selectStudent(int ID) {
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");

			// System.out.println("Driver loaded");

			Connection c1 = DriverManager
					.getConnection("jdbc:odbc:RegistrationDB");

			// System.out.println("Database connected");

			Statement statement = c1.createStatement();

			String sql = "Select * from Students where ID=" + ID;

			// System.out.println(sql);

			ResultSet rs = statement.executeQuery(sql);
			rs.next();
			// while (rs.next()) {
			//
			// StringBuilder sb = new StringBuilder();
			//
			// for (int i = 1; i <= 9; i++) {
			//
			// sb.append(rs.getString(i) + "\t");
			//
			// }
			//
			// System.out.println(sb.toString());
			//
			// }

			setSID(Integer.parseInt(rs.getString(1)));
			setFirstName(rs.getString(2));
			setLastName(rs.getString(3));
			setAddress(rs.getString(4));
			setCity(rs.getString(5));
			setState(rs.getString(6));
			setZip(Integer.parseInt(rs.getString(7)));
			setEmail(rs.getString(8));
			setGpa(Float.parseFloat(rs.getString(9)));

			c1.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void insertStudent(int SID, String firstName, String lastName,
			String address, String city, String state, int zip, String email,
			float gpa) {
		// 1 Insert into the db
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			Connection c1 = DriverManager
					.getConnection("jdbc:odbc:RegistrationDB");
			Statement statement = c1.createStatement();
			String sql = "Insert into Students (ID,FirstName,LastName,Street,City,State,Zip,EMail,GPA) values("
					+ SID+ ",'"
					+ firstName+ "','"
					+ lastName+ "','"
					+ address+ "','"
					+ city+ "','"
					+ state+ "',"
					+ zip+ ",'"
					+email+ "'," 
					+ gpa + ")";

//			System.out.println(sql);
			int rowsInserted = statement.executeUpdate(sql);

			System.out.println(rowsInserted + " row(s) inserted.");
			
			c1.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 2 set object values
		setSID(SID);
		setFirstName(firstName);
		setLastName(lastName);
		setAddress(address);
		setCity(city);
		setState(state);
		setZip(zip);
		setEmail(email);
		setGpa(gpa);
	}

	public void updateStudent(){
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			Connection c1 = DriverManager
					.getConnection("jdbc:odbc:RegistrationDB");
			Statement statement = c1.createStatement();
			String sql = "update students set "
					+"FirstName = '"+firstName
					+"', LastName = '"+lastName
					+"', Street = '"+address
					+"', City = '"+city
					+"', State = '"+state
					+"', Zip = "+zip
					+" , EMail = '"+email
					+"', GPA = "+gpa
					+" where ID="+SID;
			
//			System.out.println(sql);
			
			int rowsUpdated = statement.executeUpdate(sql);
			
			System.out.println(rowsUpdated + " row(s) updated.");
			
			c1.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void deleteStudent(){
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			Connection c1 = DriverManager
					.getConnection("jdbc:odbc:RegistrationDB");
			Statement statement = c1.createStatement();
			
			String sql = "delete from students where id="+SID;
			
//			System.out.println(sql);
			
			int rowsDeleted = statement.executeUpdate(sql);
			
			System.out.println(rowsDeleted + " row(s) deleted.");
			
			c1.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		System.out.println("Student with empty constructor: ");
		Student s = new Student();
		s.display();

		System.out.println("Student with parameterized constructor: ");
		s = new Student(4, "Frank", "Jones", "123 Main", "Atlanta", "GA",
				30133, "fj@yahoo.com", 3.2f);
		s.display();

		System.out.println("Student selected from database: ");
		s.selectStudent(4);
		s.display();

		System.out.println("Inserting student into database: ");
		s.insertStudent(33, "Frank", "Mayes", "123 Main street", "Atlanta", "GA",
				30100, "fmayes@yahoo.com", 3.3f);
		s.display();
		
		System.out.println("Updating student in database (altered zip code): ");
		s.setZip(30303);
		s.updateStudent();
		s.display();
		
		System.out.println("Deleting student from database: ");
		s.deleteStudent();
	}

}
