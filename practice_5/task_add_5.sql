-- 5. Побудувати запит, що показує 5 найпопулярніших жанрів за кількістю проданих екземплярів
SELECT b.Genre, SUM(oi.Quantity) AS TotalCopiesSold
FROM orderitem oi
JOIN books b ON b.BookID = oi.BookID
WHERE b.Genre IS NOT NULL AND b.Genre != ''
GROUP BY b.Genre
ORDER BY TotalCopiesSold DESC
LIMIT 5;