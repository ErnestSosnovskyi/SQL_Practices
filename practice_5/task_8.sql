WITH sales AS (
    SELECT b.Title, b.Genre,
           SUM(oi.Quantity * oi.UnitPrice) AS Revenue
    FROM orderitem oi
    JOIN books b ON b.BookID = oi.BookID
    GROUP BY b.Title, b.Genre
)
SELECT *,
       RANK() OVER (PARTITION BY Genre ORDER BY Revenue DESC) AS GenreRank
FROM sales;
