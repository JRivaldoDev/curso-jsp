package connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class SingleConnectionBanco {
	
	
	/*
	private static String url = "jdbc:postgresql://localhost:5432/curso-jsp?autoReconnect=true";
	private static String user = "postgres";
	private static String password = "admin";
	private static Connection connection = null;
	*/
	
	
	private static String url = "jdbc:postgresql://ec2-54-85-56-210.compute-1.amazonaws.com:5432/d8heo3ld9hpvou?autoReconnect=true";
	private static String user = "hfriclclqqqdvp";
	private static String password = "a942b53ef99fca6f9c8501a5311b336aa0141798407a343b4853edabbd462cd3";
	private static Connection connection = null;
	
	
	static {
		conectar();
	}
	
	public SingleConnectionBanco() {
		conectar();
	}
	
	private static void conectar() {
		try {
			Class.forName("org.postgresql.Driver");
			connection = DriverManager.getConnection(url, user, password);
			connection.setAutoCommit(false);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public static Connection getConnection() {
		return connection;
	}

}
