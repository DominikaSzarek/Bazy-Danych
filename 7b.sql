-- 1. Napisz procedurê wypisuj¹c¹ do konsoli ci¹g Fibonacciego. Procedura musi przyjmowaæ jako argument wejœciowy liczbê n. Generowanie ci¹gu Fibonacciego musi zostaæ zaimplementowane jako osobna funkcja, wywo³ywana przez procedurê.

CREATE PROCEDURE Fibonacci(@ilosc INTEGER)
AS
BEGIN
	DECLARE @liczby TABLE(fib INTEGER)
	DECLARE @n INTEGER, @i INTEGER = 0 
	INSERT INTO @liczby 
	VALUES(0),
		  (1)
	WHILE (@i < @ilosc) 
	BEGIN
		SELECT @n = SUM(fib) 
		FROM (SELECT TOP 2 fib FROM @liczby ORDER BY fib DESC) AS ci¹g_fib		
		INSERT INTO @liczby VALUES (@n)
		SELECT @i = COUNT(*) FROM @liczby
	END
	SELECT * FROM @liczby
END
EXEC Fibonacci 30;

-- 2.  Napisz trigger DML, który po wprowadzeniu danych do tabeli Persons zmodyfikuje nazwisko tak, aby by³o napisane du¿ymi literami.
USE AdventureWorks2017; 
GO

CREATE TRIGGER up_lastname
ON Person.Person
AFTER INSERT
AS 
BEGIN 
DECLARE @lastname VARCHAR(50), @id INTEGER
SELECT @lastname = inserted.LastName, @id = inserted.BusinessEntityID
FROM inserted
	UPDATE Person.Person
SET LastName = upper(LastName)
WHERE LastName = @lastname AND BusinessEntityID = @id
END

--SELECT * FROM Person.Person;

--UPDATE Person.Person 
--SET LastName = 'Duffy' 
--WHERE BusinessEntityID = 2;


-- 3. Przygotuj trigger ‘taxRateMonitoring’, który wyœwietli komunikat o b³êdzie, je¿eli nast¹pi zmiana wartoœci w polu ‘TaxRate’ o wiêcej ni¿ 30%

CREATE TRIGGER taxRateMonitoring 
ON Sales.SalesTaxRate
AFTER UPDATE 
AS 
BEGIN 
DECLARE @taxrate FLOAT, @newTaxRate FLOAT 
SELECT @taxrate = deleted.TaxRate FROM deleted 
SELECT @newTaxRate = inserted.TaxRate FROM inserted
	IF @newTaxRate > 1.3*@taxrate 
		PRINT 'Error'
END

--UPDATE Sales.SalesTaxRate
--SET TaxRate = 20
--WHERE SalesTaxRateID = 1;
--SELECT * FROM Sales.SalesTaxRate;