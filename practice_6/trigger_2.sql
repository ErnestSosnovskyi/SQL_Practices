USE publishing;

-- Видаляємо старий тригер, якщо він вже є в базі, щоб уникнути помилки 1359
DROP TRIGGER IF EXISTS trg_contracts_bi;

-- Змінюємо роздільник команд
DELIMITER $$

CREATE TRIGGER trg_contracts_bi
BEFORE INSERT ON Contracts
FOR EACH ROW
BEGIN
  
  -- 1. Перевірка власника контракту
  IF (NEW.AuthorID IS NULL AND NEW.EmployeeID IS NULL)
     OR (NEW.AuthorID IS NOT NULL AND NEW.EmployeeID IS NOT NULL) THEN

    -- Штучна помилка, яка зупиняє виконання INSERT
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Exactly one of AuthorID or EmployeeID must be set';
  END IF;

  -- 2. Перевірка правильності типу контракту
  IF (NEW.AuthorID IS NOT NULL AND NEW.ContractType <> 'Author')
     OR (NEW.EmployeeID IS NOT NULL AND NEW.ContractType <> 'Employee') THEN

    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'ContractType must match owner (Author/Employee)';
  END IF;

  -- 3. Перевірка послідовності дат
  IF NEW.EndDate IS NOT NULL AND NEW.EndDate < NEW.StartDate THEN

    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'EndDate must be >= StartDate';
  END IF;

END$$

-- Повертаємо стандартний роздільник команд
DELIMITER ;