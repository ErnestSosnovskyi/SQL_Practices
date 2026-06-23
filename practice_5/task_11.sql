-- книги з першим автором (AuthorOrder = 1)
SELECT b.BookID, b.Title, a.AuthorID, a.Name AS Author
FROM authorbook ab
JOIN authors a ON a.AuthorID = ab.AuthorID
JOIN books   b ON b.BookID   = ab.BookID
WHERE ab.AuthorOrder = 1
ORDER BY b.Title;
