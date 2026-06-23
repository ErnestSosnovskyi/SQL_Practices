-- ранжування книжок за виручкою (в межах жанру)
WITH sales AS (
  SELECT b.BookID, b.Title, b.Genre,
         SUM(oi.Quantity * oi.UnitPrice) AS Revenue
  FROM orderitem oi
  JOIN books b ON b.BookID = oi.BookID
  GROUP BY b.BookID, b.Title, b.Genre
)
SELECT *,
       DENSE_RANK() OVER (PARTITION BY Genre ORDER BY Revenue DESC) AS GenreRank
FROM sales
ORDER BY Genre, GenreRank;
