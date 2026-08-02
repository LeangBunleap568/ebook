package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.entity.user;

public class UserDAOImpl implements UserDAO{
	private Connection conn;

	public UserDAOImpl(Connection conn) {
		super();
		this.conn = conn;
	}

	@Override
	public boolean userRegistre(user us) {
		boolean f=false;
		try {
			int nextId = 1;
			try (PreparedStatement idPs = conn.prepareStatement("SELECT COALESCE(MAX(id), 0) + 1 FROM user")) {
				try (ResultSet rs = idPs.executeQuery()) {
					if (rs.next()) {
						nextId = rs.getInt(1);
					}
				}
			}

			String sql="insert into user(id,name,email,phone,password) values(?,?,?,?,?)";
			try (PreparedStatement ps = conn.prepareStatement(sql)) {
				ps.setInt(1, nextId);
				ps.setString(2, us.getName());
				ps.setString(3, us.getEmail());
				ps.setString(4, us.getPhone());
				ps.setString(5, us.getPassword());
				int i = ps.executeUpdate();
				if(i == 1) {
					f = true;
				}
			}
		} catch (Exception e) {  
			e.printStackTrace();
		}
		return f;
	}
	
	

}
