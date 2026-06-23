SELECT b.Genre, COUNT(*) AS BooksCount
FROM books b
GROUP BY b.Genre
ORDER BY BooksCount DESC;
