package db_connection;

import java.sql.*;

public class DB {
	
	private static Connection db;

	public static Connection getConn() throws ClassNotFoundException, SQLException {

		if (db == null || db.isClosed()) {
			Class.forName("com.mysql.jdbc.Driver");
			db = DriverManager.getConnection("jdbc:mysql://localhost:3306/Electro_Grid_System", "root", "");
		}
		
		return db;
	}

}
