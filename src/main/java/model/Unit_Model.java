package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import db_connection.DB;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.simple.JSONObject;

public class Unit_Model {

	private String res;
	
	public String getRes() {
		return res;
	}

	public void setRes(String res) {
		this.res = res;
	}

	public String getUnit() {
		PreparedStatement ps;
		String data="";
		
		try {
			
			Connection conn = DB.getConn();
			ps = conn.prepareStatement("SELECT * FROM unit");
			
			ResultSet res_Set = ps.executeQuery();
			
			data = "<table style='border: 1px solid black;'>"
		            +"<tr>"
		            +"<th style='border-style: dotted;'>ID</th>"
	                +"<th style='border-style: dotted;'>Account ID</th>"
	                +"<th style='border-style: dotted;'>Number Of Units</th>"
	                +"<th style='border-style: dotted;'>From Date</th>"
	                +"<th style='border-style: dotted;'>To date</th>"
	                +"<th style='border-style: dotted;'>Bill Amount</th>"
	                +"<th style='border-style: dotted;'>Edit/Delete</th>"
	                +"</tr>";
			
			while (res_Set.next()) {
				
				String button = "<button onclick='edit("+res_Set.getString(1)+")' >Edit</button><button onclick='deletes("+res_Set.getString(1)+")'>Delete</button>";
				
				data = data+"<tr><td style='border-style: dotted;'>"+res_Set.getString(1)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(2)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(3)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(4)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(5)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(6)+"</td>"
						+ "<td style='border-style: dotted;'>"+button+"</td>"
					  + "</tr>";
				
			}
			
			ps.close();
			conn.close();
			
		}catch (ClassNotFoundException | SQLException  e) {

			System.out.println(e.getMessage());
		}
		
		return data+"</table>";
	}
	
	public void addUnit(String account_number,int units,String f_date,String t_date,double amount) {
		PreparedStatement ps;
		
		try {
			Connection conn = DB.getConn();
			
			ps = conn.prepareStatement("insert into unit (account_number,units,f_date,t_date,amount) values (?,?,?,?,?)");
			ps.setString(1, account_number);
			ps.setInt(2, units);
			ps.setString(3, f_date);
			ps.setString(4, t_date);
			ps.setDouble(5, amount);
			ps.execute();
			ps.close();
			conn.close();
			setRes("Done");
		
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("Error");
		}
	}

	public void editUnit(int id,String account_number,int units,String f_date,String t_date,double amount) {
		PreparedStatement ps;
		
		try {
			Connection conn = DB.getConn();
			
				ps = conn.prepareStatement("UPDATE unit SET account_number=?,units=?,f_date=?,t_date=?,amount=? where id=?");
				ps.setString(1, account_number);
				ps.setInt(2, units);
				ps.setString(3, f_date);
				ps.setString(4, t_date);
				ps.setDouble(5, amount);
				ps.setInt(6,id);
				ps.execute();
				ps.close();
				conn.close();
				setRes("Done");
				
		
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("Error");
		}
	}

	public void deleteUnit(int id) {
		PreparedStatement ps;
		
		try {
			Connection conn = DB.getConn();
			
			ps = conn.prepareStatement("DELETE FROM unit WHERE id=?");
			ps.setInt(1, id);
			ps.execute();
			setRes("Done");
		
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("Error");
		}
	}
	
	public JSONObject getOneUnits(int id) {
		Connection connection;
		PreparedStatement preparedStatement;
		JSONObject json = new JSONObject();
		
		try {
			connection = DB.getConn();
			
			preparedStatement = connection.prepareStatement("SELECT * FROM unit where id=?");
			preparedStatement.setInt(1, id);
			ResultSet rs = preparedStatement.executeQuery();

			while(rs.next())
			{
				json.put("id", rs.getInt(1));
				json.put("account_number", rs.getString(2));
				json.put("units", rs.getString(3));
				json.put("f_date", rs.getString(4));
				json.put("t_date", rs.getString(5));
				json.put("amount", rs.getString(6));
			}
			
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("Error");
		}
		return json;
	}

}