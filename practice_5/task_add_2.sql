-- 2. Визначити автора з найбільшим сумарним доходом від продажів
-- (Зв'язуємо авторів з їхніми книгами та позиціями замовлень, виводимо ТОП-1)
SELECT a.AuthorID, a.Name AS AuthorName, SUM(oi.Quantity * oi.UnitPrice) AS TotalAuthorRevenue
FROM orderitem oi
JOIN authorbook ab ON oi.BookID = ab.BookID
JOIN authors a ON ab.AuthorID = a.AuthorID
GROUP BY a.AuthorID, a.Name
ORDER BY TotalAuthorRevenue DESC
LIMIT 1;