CREATE OR REPLACE VIEW v_book_sales AS
SELECT b.BookID, b.Title, SUM(oi.Quantity * oi.UnitPrice) AS Revenue
FROM Books b
LEFT JOIN OrderItem oi ON oi.BookID = b.BookID
GROUP BY b.BookID, b.Title;

SELECT * FROM v_book_sales ORDER BY Revenue DESC;