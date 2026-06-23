-- Розрахунок загального доходу по кожному замовленню
SELECT OrderID, ROUND(SUM(Quantity * UnitPrice), 2) AS TotalRevenue
FROM OrderItem
GROUP BY OrderID;


-- Оцінка середньої ціни книги у продажах
SELECT ROUND(AVG(UnitPrice), 2) AS AvgBookPrice
FROM OrderItem;


-- Визначення, які позиції замовлень мають непарну кількість
SELECT OrderItemID, Quantity, MOD(Quantity, 2) AS IsOdd
FROM OrderItem;
