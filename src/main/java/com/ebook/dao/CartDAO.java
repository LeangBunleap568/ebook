package com.ebook.dao;

import com.entity.Cart;

public interface CartDAO {
    public boolean addCart(Cart c);
    public java.util.List<Cart> getCartByUser(int uid);
    public boolean removeBook(int cid, int uid);
    public int countCart(int uid);
    public boolean deleteCartByUid(int uid);
}
