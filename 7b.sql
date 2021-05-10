-- 1. Napisz procedur� wypisuj�c� do konsoli ci�g Fibonacciego. Procedura musi przyjmowa� jako argument wej�ciowy liczb� n. Generowanie ci�gu Fibonacciego musi zosta� zaimplementowane jako osobna funkcja, wywo�ywana przez procedur�.

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
		FROM (SELECT TOP 2 fib FROM @liczby ORDER BY fib DESC) AS ci�g_fib		
		INSERT INTO @liczby VALUES (@n)
		SELECT @i = COUNT(*) FROM @liczby
	END
	SELECT * FROM @liczby
END
EXEC Fibonacci 30;

-- 2.  Napisz trigger DML, kt�ry po wprowadzeniu danych do tabeli Persons zmodyfikuje nazwisko tak, aby by�o napisane du�ymi literami.
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


-- 3. Przygotuj trigger �taxRateMonitoring�, kt�ry wy�wietli komunikat o b��dzie, je�eli nast�pi zmiana warto�ci w polu �TaxRate� o wi�cej ni� 30%

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