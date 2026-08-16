package com.ebook.dao;

import com.ebook.entity.user;

public interface UserDAO {
	public boolean userRegistre(user us);
	public user login(String email, String password);
	public boolean checkPassword(int id, String ps);
	public boolean updateProfile(user us);
	public boolean checkUser(String email);
	public int countUsers();
}

