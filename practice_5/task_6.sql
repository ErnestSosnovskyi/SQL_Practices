SELECT b.Title
FROM books b
WHERE b.BookID IN (
    SELECT BookID
    FROM orderitem
);
