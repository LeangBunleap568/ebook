package com.DAO;

import java.util.List;
import com.entity.BookDtls;

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
}
