SELECT a.Name
FROM authors a
WHERE EXISTS (
    SELECT 1
    FROM authorbook ab
    JOIN orderitem oi ON oi.BookID = ab.BookID
    WHERE ab.AuthorID = a.AuthorID
);
