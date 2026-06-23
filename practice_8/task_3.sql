-- Поточна дата
SELECT CURDATE() AS Today;


-- Замовлення, які зроблено більше ніж 100 днів тому
SELECT OrderID, OrderDate, DATEDIFF(CURDATE(), OrderDate) AS DaysAgo
FROM Orders
WHERE DATEDIFF(CURDATE(), OrderDate) > 100;


-- Рік і місяць створення контракту
SELECT ContractID, YEAR(StartDate) AS YearStart, MONTH(StartDate) AS MonthStart
FROM Contracts;
