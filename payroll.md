# AccessForAll

## Banco de dados Payroll

Nosso banco de dados em SQL Server foi desenvolvido para adptar a mudanças rapidas e um gerenciamento flexivel de todos os registros.
Cada tabela possui uma coluna em boolean com o dado **BIT** chamada `isActive` que ativa e inativa registros.

## Definições de tabelas

**BENEFITS**
* A tabela benefits representa os beneficios para os funcionários 

**COMPANY**
* A tabela company representa a empresa, com ela podemos registrar os dados da empresa e vincula o funcionário a empresa

**DEPARTMENTS**
* Na tabela departments é onde registramos os departamentos

**DIGITAL_DOT**
* Esta tabela digital dot armazena as horas trabalhadas pelo funcionário e fornece com precisão data, hora minuto e segundo além de informar a ação resgatada pelo horário (entrada, saída, retorno do pausa, etc...),
seus dados serão coletados a partir de uma API de um equipamento em loco para registrar essas informações ou pelo aplicativo.

**EMPLOYEES**
* A tabela employees armazena as informações de um empregado.

**OFFICE**
* A tabela office é onde registramos os tipos de funções que os empregados possuem.

**REGISTRATION**
* Nessa tabela registration contém informações pessoais de um funcionário.

**SALARY**
*  Essa tabela salary tem como objetivo armazenar os valores de salários e é atribuída ao funcionário.

**SYSTEM_USERS**
* A tabela system_users guarda as informações de login do sistema.


**Essa é a estrutura da tabela em SQL Server**
```sql
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
	photo				VARBINARY(MAX),
	first_name			VARCHAR(18) NOT NULL,
	last_name			VARCHAR(18) NOT NULL,
	reg_sex				VARCHAR(1),
	phone_number		VARCHAR(15) NOT NULL,
	phone_type			VARCHAR(20) NOT NULL,
	cpf_number			VARCHAR(20),
	cnpj_number			VARCHAR(20),
	hire_date			DATE NOT NULL,
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
	benefit_seq			INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	employee_id			INT,
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
ADD CONSTRAINT fk_employee_id_digital_dot
FOREIGN KEY (employee_id) 
REFERENCES employees(employee_id)

ALTER TABLE benefits
ADD CONSTRAINT fk_employee_id_benefit_seq
FOREIGN KEY (employee_id)
REFERENCES employees(employee_id);

--Inserindo valores nas tabelas

INSERT INTO system_users (user_name, email, password, permission_level, isActive)
VALUES	('admin', 'admin@payroll.com', 'mudar123', 'admin', 1),
		('operador', 'operador@payroll.com', 'mudar123', 'operador', 1);

INSERT INTO company (company_title, company_address, phone_number, email, fundation_DATE, isActive)
VALUES	('Acces For All', 'Av. Paulista, 900', '(11) 1234-5678', 'contato@accessforall.com', '2023-05-12', 1);

INSERT INTO salary (gross_salary, isActive)
VALUES	(50000.00, 1),
		(2800.00, 1),
		(4800.00, 1);

INSERT INTO office (office_title, isActive)
VALUES	('CTO', 1),
		('CEO', 1),
		('Segurança da informação', 1),
		('Analista de testes', 1),
		('Analista de Recursos Humanos', 1);


INSERT INTO registration (photo, first_name, last_name, reg_sex, phone_number, phone_type, cpf_number, cnpj_number, hire_DATE, cep_number, reg_address, address_number, state_name, city_name, neighborhood_name, dependents, isActive)
VALUES	(null, 'Caio', 'Vieira', 'M', '(11) 96078-6755', 'Celular', '123.456.789-01', null, '1999-07-05', '01311-000', 'Av. Paulista', 900, 'SP', 'São Paulo', 'Bela Vista', null, 1),
		(null, 'Matheus', 'Forstners', 'M', '(11) 96078-6755', 'Celular', '223.456.789-01', null, '2001-07-05', '01311-000', 'Av. Paulista', 900, 'SP', 'São Paulo', 'Bela Vista', null, 1),
		(null, 'Erasmo', 'Vasconcelos', 'M', '(11) 96078-6755', 'Celular', '323.456.789-01', null, '1990-07-05', '01311-000', 'Av. Paulista', 900, 'SP', 'São Paulo', 'Bela Vista', 2, 1),
		(null, 'Felipe', 'Bilac', 'M', '(11) 96078-6755', 'Celular', '423.456.789-01', null, '2001-07-05', '01311-000', 'Av. Paulista', 900, 'SP', 'São Paulo', 'Bela Vista', null, 1),
		(null, 'Junior', 'Araujo', 'M', '(11) 96078-6755', 'Celular', '453.456.789-01', null, '2000-07-05', '01311-000', 'Av. Paulista', 900, 'SP', 'São Paulo', 'Bela Vista', 6, 1);

INSERT INTO departments (department_name, isActive)
VALUES	('Diretoria', 1),
		('Equipe de segurança', 1),
		('Equipe de QA', 1),
		('RH', 1);

INSERT INTO employees (first_name, last_name, admission_DATE, resignation_date, employee_status, reg_id, salary_id, office_id, company_id, department_id, isActive)
VALUES	('Caio', 'Vieira', '2023-05-12', null, 'Ativo', 1, 1, 1, 1, 1, 1),
		('Matheus', 'Forstners', '2023-05-12', null, 'Ativo', 2, 3, 3, 1, 2, 1),
		('Erasmo', 'Vasconcelos', '2023-05-12', null, 'Ativo', 3, 1, 2, 1, 1, 1),
		('Felipe', 'Bilac', '2023-05-12', null, 'Ativo', 4, 3, 5, 1, 4, 1),
		('Junior', 'Araujo', '2023-05-12', null, 'Ativo', 5, 2, 4, 1, 3, 1);

INSERT INTO benefits (employee_id, benefit_name, benefit_desc, start_date, cost, cost_percentage, isActive)
VALUES	(1, 'Vale-refeição', 'Benefício para alimentação diária', '2023-05-12', null, 5.00, 1),
		(1, 'Plano de saúde', 'cobertura de despesas médicas e hospitalares, exames, consultas, tratamentos, entre outros.', '2023-05-12', 110.00, null, 1),
		(1, 'Seguro de vida', 'garantia financeira para a família em caso de falecimento do empregado.', '2023-05-12', null, 10, 1),
		(1, 'Vale-transporte', 'custeio do transporte do empregado para ir e voltar do trabalho.', '2023-05-12', 100.00, 1, 0),
		(1, 'Previdência privada', 'plano de aposentadoria complementar ao INSS.', '2023-05-12', 500.00, 20, 1),
		(2, 'Vale-refeição', 'Benefício para alimentação diária', '2023-05-12', null, 5.00, 1),
		(2, 'Plano de saúde', 'cobertura de despesas médicas e hospitalares, exames, consultas, tratamentos, entre outros.', '2023-05-12', 110.00, null, 1),
		(2, 'Seguro de vida', 'garantia financeira para a família em caso de falecimento do empregado.', '2023-05-12', null, 10, 1),
		(2, 'Vale-transporte', 'custeio do transporte do empregado para ir e voltar do trabalho.', '2023-05-12', 100.00, 1, 0),
		(2, 'Previdência privada', 'plano de aposentadoria complementar ao INSS.', '2023-05-12', 500.00, 20, 1),
		(3, 'Vale-refeição', 'Benefício para alimentação diária', '2023-05-12', null, 5.00, 1),
		(3, 'Plano de saúde', 'cobertura de despesas médicas e hospitalares, exames, consultas, tratamentos, entre outros.', '2023-05-12', 110.00, null, 1),
		(3, 'Seguro de vida', 'garantia financeira para a família em caso de falecimento do empregado.', '2023-05-12', null, 10, 1),
		(3, 'Vale-transporte', 'custeio do transporte do empregado para ir e voltar do trabalho.', '2023-05-12', 100.00, 1, 0),
		(3, 'Previdência privada', 'plano de aposentadoria complementar ao INSS.', '2023-05-12', 500.00, 20, 1),
		(4, 'Vale-refeição', 'Benefício para alimentação diária', '2023-05-12', null, 5.00, 1),
		(4, 'Plano de saúde', 'cobertura de despesas médicas e hospitalares, exames, consultas, tratamentos, entre outros.', '2023-05-12', 110.00, null, 1),
		(4, 'Seguro de vida', 'garantia financeira para a família em caso de falecimento do empregado.', '2023-05-12', null, 10, 1),
		(4, 'Vale-transporte', 'custeio do transporte do empregado para ir e voltar do trabalho.', '2023-05-12', 100.00, 1, 0),
		(4, 'Previdência privada', 'plano de aposentadoria complementar ao INSS.', '2023-05-12', 500.00, 20, 1),
		(5, 'Vale-refeição', 'Benefício para alimentação diária', '2023-05-12', null, 5.00, 1),
		(5, 'Plano de saúde', 'cobertura de despesas médicas e hospitalares, exames, consultas, tratamentos, entre outros.', '2023-05-12', 110.00, null, 1),
		(5, 'Seguro de vida', 'garantia financeira para a família em caso de falecimento do empregado.', '2023-05-12', null, 10, 1),
		(5, 'Vale-transporte', 'custeio do transporte do empregado para ir e voltar do trabalho.', '2023-05-12', 100.00, 1, 0),
		(5, 'Previdência privada', 'plano de aposentadoria complementar ao INSS.', '2023-05-12', 500.00, 20, 1);

INSERT INTO digital_dot (employee_id, dot_DATE, dot_time, dot_type)
VALUES	(1, '2023-05-12', '08:30:00', 'Entrada'),
		(1, '2023-05-12', '12:30:00', 'Saída para almoço'),
		(1, '2023-05-12', '13:30:00', 'Retorno do almoço'),
		(1, '2023-05-12', '17:30:00', 'Saída'),
		(2, '2023-05-12', '08:30:00', 'Entrada'),
		(2, '2023-05-12', '12:30:00', 'Saída para almoço'),
		(2, '2023-05-12', '13:30:00', 'Retorno do almoço'),
		(2, '2023-05-12', '17:30:00', 'Saída'),
		(3, '2023-05-12', '08:30:00', 'Entrada'),
		(3, '2023-05-12', '12:30:00', 'Saída para almoço'),
		(3, '2023-05-12', '13:30:00', 'Retorno do almoço'),
		(3, '2023-05-12', '17:30:00', 'Saída'),
		(4, '2023-05-12', '08:30:00', 'Entrada'),
		(4, '2023-05-12', '12:30:00', 'Saída para almoço'),
		(4, '2023-05-12', '13:30:00', 'Retorno do almoço'),
		(4, '2023-05-12', '17:30:00', 'Saída'),
		(5, '2023-05-12', '08:30:00', 'Entrada'),
		(5, '2023-05-12', '12:30:00', 'Saída para almoço'),
		(5, '2023-05-12', '13:30:00', 'Retorno do almoço'),
		(5, '2023-05-12', '17:30:00', 'Saída');
```



Aqui está um exemplo de SELECT com JOIN para ver quais beneficios um empregado possui.

```sql
SELECT e.first_name, b.benefit_name
FROM employees e
inner join benefits b ON e.employee_id = b.employee_id
WHERE e.employee_id = 1
```

Esse UPDATE irá definir uma data de demissão para o funcionário Felipe com a data e a hora atual.

```sql
UPDATE employees
SET resignation_date = CURRENT_TIMESTAMP
WHERE employee_id = 4;
```

Nessa sequencia temos um comando DELETE para remover do banco um beneficio mas para não perder registro. 

```sql
DELETE FROM benefits
WHERE benefit_name = 'Plano de saúde' 
```

Ou dados nós podemos inativar pela tabela "isActive"

```sql
UPDATE benefits
SET isActive = 0
WHERE benefit_name = 'Vale-refeição'
```
# LGPD

Para tratarmos da segurança de nossos dados, nós utilizamos o conceito de hash ao invés da criptografia tradicional fornecida pelo próprio SQL Server. Pois a criptografia ela pode ser descriptografada já o hash altera o valor e sua alteração é irreversível mas isso não impede o usuário de fazer o seu login com a senha original, iremos mostrar como.

Em nossa tabela ‘system_users’ para realizar o login do sistema o usuário insere a senha e com isso o sistema libera o acesso, seguindo a ideia tradicional mas por trás dos panos o banco trabalha de forma diferente.

```sql
INSERT INTO system_users (user_name, email, password, permission_level, isActive)
VALUES	('Gerente', 'gerente@payroll.com', HASHBYTES ('sha2_512', 'senha_gerente'), 'admin', 1);
```

Aqui nós adicionamos um novo usuário do sistema e já usamos a função HASHBYTES para alterar o valor da senha.
Fizemos esse teste de acesso para mostrar como o sistema entenderá a senha digitada pelo usuário.

```sql
-- Teste de acesso
use payroll


declare @usr varchar(100) = 'Gerente'
declare @pwd varchar(300) = 'Senha_errada'
if hashbytes('sha2_512', @pwd) = (select password from system_users where user_name = @usr)
    print 'Acesso OK'
else
    print 'Acesso NEGADO'

```

Quando o usuário digitar a sua senha o sistema irá pegar essa senha e converter como hash ao invés de compararmos as senhas originais de cada usuário nós iremos transformar a senha digitada pelo usuário em hashbytes e comparar com o valor tipo hashbytes para ver se ambas correspondem.

Após a verificação da senha convertida em hashbytes o sistema autoriza o acesso e assim permite o login.
