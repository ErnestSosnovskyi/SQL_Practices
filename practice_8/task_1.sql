-- Повне ім’я автора у верхньому регістрі
SELECT UPPER(Name) AS AuthorNameUpper
FROM Authors;


-- Формування електронного підпису працівника: "Ім’я <email>"
SELECT CONCAT(Name, ' <', Email, '>') AS Signature
FROM Employees;


-- Пошук співробітників, чий email містить домен 'pub.ch'
SELECT Name, Email
FROM Employees
WHERE Email LIKE '%pub.ch%';


-- Визначення довжини назви книги
SELECT Title, LENGTH(Title) AS TitleLength
FROM Books;