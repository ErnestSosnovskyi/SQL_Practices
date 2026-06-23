-- хто і що робив по книгах (Task)
SELECT e.Name  AS Employee,
       b.Title AS Book,
       eb.Task
FROM employeebook eb
JOIN employees e ON e.EmployeeID = eb.EmployeeID
JOIN books     b ON b.BookID     = eb.BookID
ORDER BY e.Name, b.Title;
