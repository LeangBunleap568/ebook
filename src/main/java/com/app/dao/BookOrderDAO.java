package com.app.dao;

import java.util.List;
import com.app.entity.Book_Order;

public interface BookOrderDAO {
    public boolean saveOrder(List<Book_Order> blist);
    public List<Book_Order> getBookOrder(String email);
    public List<Book_Order> getAllOrder();
    public int countOrders();
    public int countActiveTransactions();
    public double getTotalSalesUSD();
    public boolean cancelOrder(String orderNo);
    public boolean deleteOrdersByEmail(String email);
    public boolean deleteOrderByOrderNo(String orderNo);
}

