-- 3. Порахувати кількість замовлень у кожного клієнта
SELECT ClientName, COUNT(OrderID) AS TotalOrdersCount
FROM orders
GROUP BY ClientName
ORDER BY TotalOrdersCount DESC, ClientName;