package com.app.dao;

import java.util.List;
import com.app.entity.user;

public interface UserDAO {
	public boolean userRegistre(user us);
	public user login(String email, String password);
	public boolean checkPassword(int id, String ps);
	public boolean updateProfile(user us);
	public boolean checkUser(String email);
	public int countUsers();
	public user getUserById(int id);
	public List<user> getAllUsers();
	public boolean deleteUser(int id);
}

