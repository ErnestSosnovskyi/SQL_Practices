-- книги певного жанру, від новіших до старіших
SELECT Title, Genre, PublishYear
FROM books
WHERE Genre = 'Technology'
ORDER BY PublishYear DESC;


-- автори з конкретної країни
SELECT Name, Email
FROM authors
WHERE Country = 'Ukraine'
ORDER BY Name;
