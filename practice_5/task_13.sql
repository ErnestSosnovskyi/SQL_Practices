-- позиції замовлень
SELECT o.OrderID, o.OrderDate, o.ClientName,
       b.Title,
       oi.Quantity, oi.UnitPrice,
       (oi.Quantity * oi.UnitPrice) AS LineTotal
FROM orders o
JOIN orderitem oi ON oi.OrderID = o.OrderID
JOIN books b      ON b.BookID   = oi.BookID
ORDER BY o.OrderDate DESC, o.OrderID;

-- підсумок по замовленню
SELECT o.OrderID, o.OrderDate, o.ClientName,
       SUM(oi.Quantity * oi.UnitPrice) AS OrderTotal
FROM orders o
JOIN orderitem oi ON oi.OrderID = o.OrderID
GROUP BY o.OrderID, o.OrderDate, o.ClientName
ORDER BY o.OrderDate DESC;
