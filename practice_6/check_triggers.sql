-- коректна вставка
INSERT INTO Contracts (AuthorID, ContractType, StartDate, EndDate)
VALUES (1, 'Author', '2025-06-01', '2025-12-31');


-- помилка 1: два власники
INSERT INTO Contracts (AuthorID, EmployeeID, ContractType, StartDate)
VALUES (1, 1, 'Author', '2025-06-01');


-- помилка 2: неправильний тип
INSERT INTO Contracts (A;uthorID, ContractType, StartDate)
VALUES (1, 'Employee', '2025-06-01');


-- помилка 3: неправильні дати
INSERT INTO Contracts (AuthorID, ContractType, StartDate, EndDate)
VALUES (1, 'Author', '2025-12-01', '2025-01-01')