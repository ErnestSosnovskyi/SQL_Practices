-- ===============================
-- Schema: publishing
-- MySQL 8.0+ (Workbench)
-- ===============================


DROP DATABASE IF EXISTS publishing;
CREATE DATABASE publishing
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;
USE publishing;


-- ===============================
-- Base tables
-- ===============================


CREATE TABLE Authors (
  AuthorID     INT AUTO_INCREMENT PRIMARY KEY,
  Name         VARCHAR(200) NOT NULL,
  Email        VARCHAR(255) UNIQUE,
  Phone        VARCHAR(50),
  Country      VARCHAR(100)
) ENGINE=InnoDB;


CREATE TABLE Employees (
  EmployeeID   INT AUTO_INCREMENT PRIMARY KEY,
  Name         VARCHAR(200) NOT NULL,
  Role         ENUM('Editor','Proofreader','Translator','Designer') NOT NULL,
  Email        VARCHAR(255) UNIQUE
) ENGINE=InnoDB;


CREATE TABLE Books (
  BookID       INT AUTO_INCREMENT PRIMARY KEY,
  Title        VARCHAR(300) NOT NULL,
  Genre        VARCHAR(100),
  ISBN         VARCHAR(32) NOT NULL,
  PublishYear  YEAR,
  CONSTRAINT uq_books_isbn UNIQUE (ISBN)
) ENGINE=InnoDB;


CREATE TABLE Orders (
  OrderID      INT AUTO_INCREMENT PRIMARY KEY,
  OrderDate    DATE NOT NULL,
  ClientName   VARCHAR(200) NOT NULL,
  Status       ENUM('New','InProgress','Completed','Canceled') NOT NULL DEFAULT 'New'
) ENGINE=InnoDB;


-- Контракти можуть належати автору АБО співробітнику (рівно одне).
CREATE TABLE Contracts (
  ContractID   INT AUTO_INCREMENT PRIMARY KEY,
  AuthorID     INT NULL,
  EmployeeID   INT NULL,
  ContractType ENUM('Author','Employee') NOT NULL,
  StartDate    DATE NOT NULL,
  EndDate      DATE NULL,
  CONSTRAINT fk_contract_author   FOREIGN KEY (AuthorID)  REFERENCES Authors(AuthorID)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_contract_employee FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  INDEX ix_contract_author (AuthorID),
  INDEX ix_contract_employee (EmployeeID)
) ENGINE=InnoDB;


-- ===============================
-- Associative (M:N) tables
-- ===============================


CREATE TABLE AuthorBook (
  AuthorID     INT NOT NULL,
  BookID       INT NOT NULL,
  AuthorOrder  INT NULL,
  PRIMARY KEY (AuthorID, BookID),
  CONSTRAINT fk_ab_author FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ab_book   FOREIGN KEY (BookID)   REFERENCES Books(BookID)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE EmployeeBook (
  EmployeeID   INT NOT NULL,
  BookID       INT NOT NULL,
  Task         ENUM('Edit','Proofread','Translate','Design') NOT NULL,
  PRIMARY KEY (EmployeeID, BookID),
  CONSTRAINT fk_eb_employee FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_eb_book     FOREIGN KEY (BookID)    REFERENCES Books(BookID)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE OrderItem (
  OrderItemID  INT AUTO_INCREMENT PRIMARY KEY,
  OrderID      INT NOT NULL,
  BookID       INT NOT NULL,
  Quantity     INT NOT NULL,
  UnitPrice    DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_oi_order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_oi_book  FOREIGN KEY (BookID)  REFERENCES Books(BookID)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  INDEX ix_oi_order (OrderID),
  INDEX ix_oi_book  (BookID),
  CONSTRAINT chk_oi_qty  CHECK (Quantity >= 1),
  CONSTRAINT chk_oi_price CHECK (UnitPrice >= 0)
) ENGINE=InnoDB;
