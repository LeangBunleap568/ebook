package com.ebook.dao;

import java.util.List;
import com.ebook.entity.BookDtls;

public interface BookDAO {

    public boolean addBooks(BookDtls b);

    public List<BookDtls> getAllBooks();

    public BookDtls getBookById(int id);

    public boolean updateEditBooks(BookDtls b);

    public boolean deleteBooks(int id);

    // get data in admin to display in page user
    public List<BookDtls> getNewBook();

    public List<BookDtls> getRecentBooks();

    public List<BookDtls> getOldBooks();

    public List<BookDtls> getAllRecentBook();

    public List<BookDtls> getAllNewBook();

    public List<BookDtls> getAllOldBook();

    public List<BookDtls> getBookByOld(String email, String cate);

    public boolean oldBookDelete(String email, String cat, int id);

    public List<BookDtls> getBookBySearch(String ch);
}
