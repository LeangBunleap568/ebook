package com.ebook.dao;

import java.util.List;
import com.ebook.entity.Book_Order;

public interface BookOrderDAO {
    public boolean saveOrder(List<Book_Order> blist);
    public List<Book_Order> getBookOrder(String email);
    public List<Book_Order> getAllOrder();
}
