-- замовлення за період + статус
SELECT OrderID, OrderDate, ClientName, Status
FROM orders
WHERE OrderDate BETWEEN DATE '2025-05-01' AND DATE '2025-05-31'
  AND Status IN ('New','Completed')   -- фактичні ENUM зі схеми
ORDER BY OrderDate DESC;
