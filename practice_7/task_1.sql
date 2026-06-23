INSERT INTO Authors (Name, Email, Phone, Country)
VALUES ('Василь Стус', 'stus@example.com', '+380501111111', 'Україна');

-- Додаємо книгу для цього автора (дізнаємось її ID)
INSERT INTO Books (Title, Genre, ISBN, PublishYear)
VALUES ('Палімпсести', 'Поезія', '978-0-100000-999', 2026);

-- Пов'язуємо автора з цією книгою (припустимо, що ID автора та книги = 11, або використовуйте LAST_INSERT_ID())
INSERT INTO AuthorBook (AuthorID, BookID, AuthorOrder)
VALUES (LAST_INSERT_ID(), LAST_INSERT_ID(), 1);

SELECT a.AuthorID, a.Name
FROM Authors a
WHERE NOT EXISTS (
  SELECT 1
  FROM AuthorBook ab
  JOIN OrderItem oi ON oi.BookID = ab.BookID
  WHERE ab.AuthorID = a.AuthorID
);