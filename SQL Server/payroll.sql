--Criação do banco de dados Folha de pagamento (payroll)

CREATE DATABASE payroll;

--Acessar o database payroll

USE payroll;

--Criação das tabelas.

CREATE TABLE system_users (
	su_id				INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	user_name			VARCHAR(25) NOT NULL,
	email				VARCHAR(60) NOT NULL,
	password			VARCHAR(255) NOT NULL,
	permission_level	VARCHAR(20) NOT NULL,
	isActive			BIT
);

CREATE TABLE company (
	company_id			INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	company_title		VARCHAR(130) NOT NULL,
	company_address		VARCHAR(90) NOT NULL,
	phone_number		VARCHAR(15) NOT NULL,
	email				VARCHAR(60) NOT NULL,
	fundation_DATE		DATE NOT NULL,
	isActive			BIT
)

CREATE TABLE registration (
	reg_id				INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	photo				IMAGE,
	first_name			VARCHAR(18) NOT NULL,
	last_name			VARCHAR(18) NOT NULL,
	reg_sex				VARCHAR(1),
	phone_number		VARCHAR(15) NOT NULL,
	phone_type			VARCHAR(20) NOT NULL,
	cpf_number			VARCHAR(20),
	cnpj_number			VARCHAR(20),
	hire_DATE			DATE NOT NULL,
	cep_number			VARCHAR(10) NOT NULL,
	reg_address			VARCHAR(90) NOT NULL,
	address_number		INT NOT NULL,
	state_name			VARCHAR(30) NOT NULL,
	city_name			VARCHAR(30) NOT NULL,
	neighborhood_name	VARCHAR(30) NOT NULL,
	dependents			INT,
	isActive			BIT
);

CREATE TABLE employees(
	employee_id			INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	first_name			VARCHAR(18) NOT NULL,
	last_name			VARCHAR(18) NOT NULL,
	admission_DATE		DATE NOT NULL,
	resignation_date	DATE,
	employee_status		VARCHAR(18) NOT NULL,
	reg_id				INT NOT NULL,
	salary_id			INT	NOT NULL,
	benefit_id			INT,
	office_id			INT	NOT NULL,
	company_id			INT NOT NULL,
	department_id		INT NOT NULL,
	isActive			BIT
)

CREATE TABLE departments (
	department_id		INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	department_name		VARCHAR(90),
	isActive			BIT
)

CREATE TABLE office (
	office_id			INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	office_title		VARCHAR(30) NOT NULL,
	isActive			BIT
)

CREATE TABLE salary (
	salary_id			INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	gross_salary		DECIMAL(10,2),
	isActive			BIT
)

CREATE TABLE benefits (
	benefit_id			INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	benefit_name		VARCHAR(60) NOT NULL,
	benefit_desc		VARCHAR(255) NOT NULL,
	start_date			DATE NOT NULL,
	cost				DECIMAL(10,2),
	cost_percentage		DECIMAL(5,2),
	isActive			BIT
)

CREATE TABLE digital_dot (
    dot_id				INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    employee_id			INT NOT NULL,
    dot_DATE			DATE NOT NULL,
    dot_time			TIME(0) NOT NULL,
    dot_type			VARCHAR(55) NOT NULL
);

--Definindo FK na tabela employyes

ALTER TABLE employees
ADD CONSTRAINT fk_employees_reg_id
FOREIGN KEY (reg_id)
REFERENCES registration(reg_id);

ALTER TABLE employees
ADD CONSTRAINT fk_employees_salary_id
FOREIGN KEY (salary_id)
REFERENCES salary(salary_id);

ALTER TABLE employees
ADD CONSTRAINT fk_employees_benefit_id
FOREIGN KEY (benefit_id)
REFERENCES benefits(benefit_id);

ALTER TABLE employees
ADD CONSTRAINT fk_employees_office_id
FOREIGN KEY (office_id)
REFERENCES office(office_id);

ALTER TABLE employees
ADD CONSTRAINT fk_employees_company_id
FOREIGN KEY (company_id)
REFERENCES company(company_id);

ALTER TABLE employees
ADD CONSTRAINT fk_employees_department_id
FOREIGN KEY (department_id)
REFERENCES departments(department_id);

ALTER TABLE digital_dot
ADD CONSTRAINT fk_employee_id 
FOREIGN KEY (employee_id) 
REFERENCES employees(employee_id)

--Inserindo valores nas tabelas

INSERT INTO system_users (user_name, email, password, permission_level, isActive)
VALUES	('admin', 'admin@payroll.com', 'mudar123', 'admin', 1);

INSERT INTO company (company_title, company_address, phone_number, email, fundation_DATE, isActive)
VALUES	('Acces For All', 'Av. Paulista, 900', '(11) 1234-5678', 'contato@accessforall.com', '2023-05-12', 1);

INSERT INTO salary (gross_salary, isActive)
VALUES	(50000.00, 1);

INSERT INTO office (office_title, isActive)
VALUES	('CTO', 1);

INSERT INTO registration (image, first_name, last_name, reg_sex, phone_number, phone_type, cpf_number, cnpj_number, hire_DATE, cep_number, reg_address, address_number, state_name, city_name, neighborhood_name, dependents, isActive)
VALUES	(null, 'Caio', 'Vieira', 'M', '(11) 96078-6755', 'Celular', '123.456.789-01', null, '1999-07-05', '01311-000', 'Av. Paulista', 900, 'SP', 'São Paulo', 'Bela Vista', 2, 1);

INSERT INTO departments (department_name, isActive)
VALUES	 ('Diretoria', 1);

INSERT INTO employees (first_name, last_name, admission_DATE, resignation_date, employee_status, reg_id, salary_id, benefit_id, office_id, company_id, department_id, isActive)
VALUES	 ('Caio', 'Vieira', '2023-05-12', null, 'Ativo', 1, 1, null, 1, 1, 1, 1);

INSERT INTO benefits (benefit_name, benefit_desc, start_date, cost, cost_percentage, isActive)
VALUES	('Vale-refeição', 'Benefício para alimentação diária', '2023-05-12', null, 5.00, 1),
		('Plano de saúde', 'cobertura de despesas médicas e hospitalares, exames, consultas, tratamentos, entre outros.', '2023-05-12', 110.00, null, 1),
		('Seguro de vida', 'garantia financeira para a família em caso de falecimento do empregado.', '2023-05-12', null, 10, 1),
		('Vale-transporte', 'custeio do transporte do empregado para ir e voltar do trabalho.', '2023-05-12', 100.00, 1, 0),
		('Previdência privada', 'plano de aposentadoria complementar ao INSS.', '2023-05-12', 500.00, 20, 1);

INSERT INTO digital_dot (employee_id, dot_DATE, dot_time, dot_type)
VALUES	(1, '2023-05-12', '08:30:00', 'Entrada'),
		(1, '2023-05-12', '12:30:00', 'Saída para almoço'),
		(1, '2023-05-12', '13:30:00', 'Retorno do almoço'),
		(1, '2023-05-12', '17:30:00', 'Saída');
