USE publishing;
-- ===============================
-- Triggers to enforce business rules in MySQL
-- (ексклюзивність власника контракту + контроль дат)
-- ===============================


DELIMITER $$


CREATE TRIGGER trg_contracts_bi
BEFORE INSERT ON Contracts
FOR EACH ROW
BEGIN
  -- рівно одне з AuthorID/EmployeeID має бути NOT NULL
  IF (NEW.AuthorID IS NULL AND NEW.EmployeeID IS NULL)
     OR (NEW.AuthorID IS NOT NULL AND NEW.EmployeeID IS NOT NULL) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exactly one of AuthorID or EmployeeID must be set';
  END IF;


-- ContractType має відповідати встановленому FK
  IF (NEW.AuthorID IS NOT NULL AND NEW.ContractType <> 'Author')
     OR (NEW.EmployeeID IS NOT NULL AND NEW.ContractType <> 'Employee') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ContractType must match owner (Author/Employee)';
  END IF;


  -- Перевірка дат
  IF NEW.EndDate IS NOT NULL AND NEW.EndDate < NEW.StartDate THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EndDate must be >= StartDate';
  END IF;
END$$


CREATE TRIGGER trg_contracts_bu
BEFORE UPDATE ON Contracts
FOR EACH ROW
BEGIN
  IF (NEW.AuthorID IS NULL AND NEW.EmployeeID IS NULL)
     OR (NEW.AuthorID IS NOT NULL AND NEW.EmployeeID IS NOT NULL) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exactly one of AuthorID or EmployeeID must be set';
  END IF;


  IF (NEW.AuthorID IS NOT NULL AND NEW.ContractType <> 'Author')
     OR (NEW.EmployeeID IS NOT NULL AND NEW.ContractType <> 'Employee') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ContractType must match owner (Author/Employee)';
  END IF;


  IF NEW.EndDate IS NOT NULL AND NEW.EndDate < NEW.StartDate THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EndDate must be >= StartDate';
  END IF;
END$$


DELIMITER ;