-- 1. Знайти книги, які мають продажі вище середніх по всіх книгах
-- (Використовуємо підзапит у HAVING для розрахунку середньої виручки)
SELECT b.BookID, b.Title, SUM(oi.Quantity * oi.UnitPrice) AS BookRevenue
FROM orderitem oi
JOIN books b ON b.BookID = oi.BookID
GROUP BY b.BookID, b.Title
HAVING BookRevenue > (
    -- Підзапит: знаходимо середню виручку на одну книгу серед усіх проданих
    SELECT AVG(total_book_sales)
    FROM (
        SELECT SUM(Quantity * UnitPrice) AS total_book_sales
        FROM orderitem
        GROUP BY BookID
    ) AS average_sales
)
ORDER BY BookRevenue DESC;