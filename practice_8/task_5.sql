-- Заміна NULL значень
SELECT Name, IFNULL(Phone, '— не вказано —') AS PhoneDisplay
FROM Authors;


-- Порівняння даних
SELECT Name, Email,
       IF(Email LIKE '%@%', 'Valid email', 'Invalid email') AS CheckEmail
FROM Employees;
