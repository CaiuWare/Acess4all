CREATE DATABASE payroll; --comando para criar o banco de dados

use payroll --acesso ao database
GO;

--Departments: criação da tabela de departamentos.

CREATE TABLE departments (
department_id   INT identity(1,1) PRIMARY KEY NOT NULL,
department_name VARCHAR(30) NOT NULL,
manager_id      INT,
isActive        BIT
);

--Jobs: criação da tablea de empregos.

CREATE TABLE jobs (
  job_id         INT identity(1,1) PRIMARY KEY NOT NULL,
  job_title      VARCHAR(35) NOT NULL,
  salary         DECIMAL(8),
  isActive       BIT
);

--Employees: criação da tabela de empregados.

CREATE TABLE employees (
  employee_id    INT identity(1,1) PRIMARY KEY NOT NULL,
  first_name     VARCHAR(20),
  last_name      VARCHAR(25) NOT NULL,
  cpf_number     VARCHAR(12) NOT NULL,
  email          VARCHAR(25) NOT NULL,
  phone_number   VARCHAR(20),
  hire_date      DATE NOT NULL,
  job_id         INT NOT NULL,
  manager_id     INT,
  department_id  INT,
  isActive       BIT
);

--Bonus: criação da tabela de vales (bonificação) para os empregados.

CREATE TABLE bonus (
  bonus_id      INT identity(1,1) PRIMARY KEY NOT NULL,
  employee_id   INT NOT NULL,
  amount        DECIMAL(10,2) NOT NULL,
  discount      DECIMAL(10,2),
  bonus_date    DATE NOT NULL,
  description   VARCHAR(100),
  isActive      BIT
);

--Criação das chaves estrangeiras das tabelas.

ALTER TABLE employees
ADD CONSTRAINT employees_departments_fk
  FOREIGN KEY (department_id) REFERENCES departments (department_id);

ALTER TABLE employees
ADD CONSTRAINT employees_jobs_fk
  FOREIGN KEY (job_id) REFERENCES jobs (job_id);

ALTER TABLE employees
ADD CONSTRAINT employees_manager_fk
  FOREIGN KEY (manager_id) REFERENCES employees (employee_id);

ALTER TABLE bonus
ADD CONSTRAINT bonus_employee_fk FOREIGN KEY (employee_id) REFERENCES employees (employee_id);

-- Inserindo dados na tabela Departments
INSERT INTO departments (department_name, manager_id, isActive)
VALUES 
	('Vendas', 1, 1),
	('Marketing', 2, 1),
	('Recursos Humanos', 3, 1),
	('Financeiro', 4, 1),
	('Departamento de TI', 5, 1);

-- Inserindo dados na tabela Jobs
INSERT INTO jobs (job_title, salary, isActive)
VALUES 
	('Sales Associate', 5000.00, 1),
	('Cordenador de marketing', 6000.00, 1),
	('Gerente de Recursos humanos', 8000.00, 1),
	('Analista financeiro', 9000.00, 1),
	('Gerente de TI', 1200.00, 1);

-- Inserindo dados na tabela Employees
INSERT INTO employees (first_name, last_name, cpf_number, email, phone_number, hire_date, job_id, manager_id, department_id, isActive)
VALUES 
	('Matheus', 'Forstner', '12345678901', 'matheus.forstner@acessfall.com', '(11) 99999-1234', '2001-01-01', 1, NULL, 1, 1),
	('Caio', 'Vieira', '23456789012', 'caio.vieira@acessfall.com', '(11) 99999-5678', '1999-02-01', 2, 1, 2, 1),
	('Felipe', 'Bilac', '34567890123', 'felipe.bilac@acessfall.com', '(11) 99999-9101', '2005-03-01', 3, 2, 3, 1),
	('Erasmo', 'Vasconcelos', '45678901234', 'erasmo.vasconcelos@acessfall.com', '(11) 99999-6789', '1991-04-01', 4, 3, 4, 1),
	('Junior', 'Araujo', '45678901234', 'junior.araujo@acessfall.com', '(11) 99999-6789', '1999-05-01', 5, 4, 5, 1);

-- Inserindo dados na tabela Bonus
INSERT INTO bonus (employee_id, amount, discount, bonus_date, description, isActive)
VALUES
  (1, 1000.00, 50.00, '2023-04-30', 'Bônus de desempenho', 1),
  (2, 750.00, 0, '2023-05-01', 'Bônus de reconhecimento', 1),
  (3, 1500.00, 100.00, '2023-05-02', 'Bônus de aniversário', 1);