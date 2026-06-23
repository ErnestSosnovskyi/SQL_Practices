-- Визначити статус контракту
SELECT ContractID,
       IF(EndDate IS NULL, 'Active', 'Closed') AS ContractStatus
FROM Contracts;


-- Категоризація книг за роком видання
SELECT Title, PublishYear,
       CASE
         WHEN PublishYear >= 2025 THEN 'Нові видання'
         WHEN PublishYear BETWEEN 2020 AND 2024 THEN 'Сучасні'
         ELSE 'Архів'
       END AS Category
FROM Books;
