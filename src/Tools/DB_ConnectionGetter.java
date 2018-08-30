package Tools;

import java.sql.Connection;
import java.sql.DriverManager;


public class DB_ConnectionGetter {
	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL="jdbc:mysql://localhost:3306/bookstoreproject?useUnicode=true&characterEncoding=UTF-8";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "root";
	private static Connection conn = null;
	static{
		try{
			Class.forName(DRIVER);
		}catch(Exception e){
			System.out.println("fail to get an instance of DRIVER");
			e.getMessage();
		}
	}
	
	public static Connection getConnection() {
		try{
			if (conn == null) {
				conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
				return conn;
			}else {
				return conn;
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("Can't get connnetion to database");
			return null;
		}
	}
		
	public static void main (String[] args) {
		try {
			Connection conn = DB_ConnectionGetter.getConnection();
			if (conn == null) {
				System.out.println("faile to get DB connection.");
			} else {
				System.out.println("get DB connection successful.");
			}
		} catch(Exception e){
			System.out.println("error in get DB connection.");
			e.getMessage();
		}
		
	}	
}
	