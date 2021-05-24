--1. Przygotuj blok anonimowy, który:
--- znajdzie œredni¹ stawkê wynagrodzenia pracowników, 
--- wyœwietli szczegó³y pracowników, których stawka wynagrodzenia jest ni¿sza ni¿ œrednia. 
USE AdventureWorks2017
GO
SELECT * FROM HumanResources.EmployeePayHistory;

BEGIN 
SELECT AVG(Rate) AS Average FROM HumanResources.EmployeePayHistory; 
END

SELECT * FROM HumanResources.Employee;

BEGIN 
DECLARE @average FLOAT 
SELECT @average = AVG(Rate) FROM HumanResources.EmployeePayHistory
PRINT @average
SELECT HumanResources.Employee.BusinessEntityID, NationalIDNumber, JobTitle,BirthDate, MaritalStatus, Gender, HireDate , Rate
FROM HumanResources.Employee INNER JOIN HumanResources.EmployeePayHistory
ON HumanResources.EmployeePayHistory.BusinessEntityID = HumanResources.Employee.BusinessEntityID
WHERE Rate < @average
END 

--2. Utwórz funkcjê, która zwróci datê wysy³ki okreœlonego zamówienia

SELECT * FROM Purchasing.PurchaseOrderHeader;

CREATE FUNCTION Purchasing.shpdate (@id INTEGER)
RETURNS DateTime
AS
BEGIN
RETURN (SELECT ShipDate
		FROM Purchasing.PurchaseOrderHeader
		WHERE PurchaseOrderID = @id)
END;
SELECT Purchasing.shpdate(9) AS Ship_Date;

--3. Utwórz procedurê sk³adowan¹, która jako parametr przyjmujê nazwê produktu, a jako rezultat wyœwietla jego identyfikator, numer i dostêpnoœæ.

SELECT * FROM Production.Product;
CREATE PROCEDURE Production.ProductAvailability
@product_name VARCHAR(50)
AS 
BEGIN 
	SELECT ProductID, ProductNumber, SafetyStockLevel 
	FROM Production.Product
	WHERE Name = @product_name
END
EXEC Production.ProductAvailability 'Adjustable Race'

--4. Utwórz funkcjê, która zwraca numer karty kredytowej dla konkretnego zamówienia

SELECT * FROM Sales.CreditCard;

CREATE FUNCTION Sales.CreditCardNumber(@id INTEGER)
RETURNS VARCHAR(20)
AS
BEGIN 
RETURN (SELECT CardNumber
		FROM Sales.CreditCard
		WHERE CreditCardID = @id)
END

SELECT Sales.CreditCardNumber(2) 
AS CreditCardNumber;

--5. Utwórz procedurê sk³adowan¹, która jako parametry wejœciowe przyjmuje dwie liczby, num1i num2, a zwraca wynik ich dzielenia. 
--Ponadto wartoœæ num1 powinna zawsze byæ wiêksza ni¿ wartoœæ num2. 
--Je¿eli wartoœæ num1 jest mniejsza ni¿ num2, wygeneruj komunikat o b³êdzie „Niew³aœciwie zdefiniowa³eœ dane wejœciowe”

CREATE PROCEDURE Division(@num1 FLOAT, @num2 FLOAT)
AS 
BEGIN TRY
DECLARE @score FLOAT
IF (@num1>@num2)
	BEGIN
		SET @score = @num1/@num2
		PRINT @score
	END
ELSE
	RAISERROR('Niew³aœciwie zdefiniowa³eœ dane wejœciowe', 16, 1)
END TRY
BEGIN CATCH
	DECLARE @error_message varchar(50)
	SET @error_message = ERROR_MESSAGE()
	RAISERROR(@error_message, 16, 1)
END CATCH

EXEC Division 3,2;

--6. Napisz procedurê, która jako parametr przyjmie NationalIDNumber danej osoby, 
--   a zwróci stanowisko oraz liczbê dni urlopowych i chorobowych.

USE AdventureWorks2017
GO
SELECT * FROM HumanResources.Employee;

CREATE PROCEDURE HumanResources.Vacation_SickLeave_Hours (@ID INTEGER)
AS 
BEGIN 
	SELECT JobTitle,VacationHours,SickLeaveHours 
	FROM HumanResources.Employee
	WHERE NationalIDNumber = @ID
END

EXEC HumanResources.Vacation_SickLeave_Hours 295847284;

--7. Napisz procedurê bêd¹c¹ kalkulatorem walutowym. Wykorzystaj dwie tabele: Sales.Currency 
--   oraz Sales.CurrencyRate. Parametrami wejœciowymi maj¹ byæ: kwota, waluty oraz data 
--   (CurrencyRateDate). Przyjmij, i¿ zawsze jedn¹ ze stron jest dolar amerykañski (USD)

--SELECT * FROM Sales.CurrencyRate;
--SELECT Name FROM Sales.Currency WHERE CurrencyCode  = 'USD';

CREATE PROCEDURE Sales.Currency_Calculator (@amount FLOAT, @from_currency CHAR(3), @to_currency CHAR(3), @date CHAR(30))
AS
BEGIN 
	DECLARE @average_rate FLOAT, @score FLOAT , @name VARCHAR(50), @name2 VARCHAR(50) 
	SET @name2 = (SELECT Name FROM Sales.Currency  WHERE CurrencyCode = @to_currency  )
	IF @from_currency = @to_currency -- lub @from_currency = 'USD' AND  @to_currency = 'USD'
	BEGIN
	SELECT @from_currency AS FromCurrencyCode, @to_currency AS ToCurrencyCode, @name AS Name ,@date AS Date, @amount AS Score
	END
	ELSE
	IF @from_currency = 'USD'
	BEGIN
		SELECT @average_rate = AverageRate 
		FROM Sales.CurrencyRate
		WHERE FromCurrencyCode = @from_currency AND ToCurrencyCode = @to_currency AND CurrencyRateDate = @date;
		SET @score = @amount*@average_rate
		SELECT @from_currency AS FromCurrencyCode,@name AS Name, @to_currency AS ToCurrencyCode, @name2 AS Name ,@date AS Date, @score AS Score 
	END
	ELSE
	IF @to_currency = 'USD'
	BEGIN
		SELECT @average_rate = AverageRate 
		FROM Sales.CurrencyRate 
		WHERE ToCurrencyCode = @from_currency AND FromCurrencyCode = @to_currency AND CurrencyRateDate = @date;
		SET @score = @amount/@average_rate  
		PRINT @score
		SELECT @from_currency AS FromCurrencyCode,@name AS Name, @to_currency AS ToCurrencyCode,@name2 AS Name, @date AS Date, @score AS Score
	END 
END 
EXEC Sales.Currency_Calculator @amount = 20 , @from_currency= 'USD', @to_currency = 'EUR', @date = '2011-05-31 00:00:00.000';
