-- 1. Utwórz pust¹ bazê danych 

CREATE DATABASE firma;
USE firma;
GO

-- 2. Utwórz schemat

CREATE SCHEMA rozliczenia;
GO

-- 3. Utwórz tabelê

CREATE TABLE rozliczenia.pracownicy(ID_pracownika INTEGER NOT NULL PRIMARY KEY, imie VARCHAR(20) NOT NULL, nazwisko VARCHAR(20) NOT NULL, adres VARCHAR(40), telefon INTEGER);
CREATE TABLE rozliczenia.godziny(ID_godziny INTEGER NOT NULL PRIMARY KEY, data DATE, liczba_godzin FLOAT, ID_pracownika INTEGER NOT NULL);
CREATE TABLE rozliczenia.pensje(ID_pensji INTEGER NOT NULL, stanowisko VARCHAR(50), kwota MONEY NOT NULL, ID_premii INTEGER NOT NULL);
CREATE TABLE rozliczenia.premie(ID_premii INTEGER NOT NULL PRIMARY KEY, rodzaj VARCHAR(20), kwota MONEY NOT NULL);

ALTER TABLE rozliczenia.godziny ADD FOREIGN KEY (ID_pracownika) REFERENCES  rozliczenia.pracownicy(ID_pracownika);
ALTER TABLE rozliczenia.pensje ADD FOREIGN KEY (ID_premii) REFERENCES  rozliczenia.premie(ID_premii);

-- 4. Dodaj rekordy do tabeli

INSERT INTO rozliczenia.pracownicy 
VALUES (1, 'Adam','Nowak', 'D³uga 4', 977837372),
	   (2, 'Krzysztof','Kras', 'Mickiewicza 40', 746293748),
	   (3, 'Karol','Paciorek', 'Lekka 3', 859284920),
	   (4, 'Wo³odymir','Markowicz', 'Stronnicza 7', 947284728),
	   (5, 'Artur','Loczek', 'Jarzynowa 10', 792531493),
	   (6, 'Marek','Drab', 'Tarnowska 9', 938472393),
	   (7, 'Jolanta','Kroczek', 'Kleberga 38', 739285730),
	   (8, 'Monika','Las', 'Krótka 2', 839453729),
	   (9, 'Adrian','Nasiadka', 'Rad³owska 89', 983765823),
	   (10,'Wiktoria','Przepiórka', 'Sienkiewicza 43', 633828473);

INSERT INTO rozliczenia.godziny
VALUES (1,'2020-06-01', 160, 1),
	   (2,'2020-06-01', 160, 2),
	   (3,'2020-06-01', 160, 3),
	   (4,'2020-06-01', 160, 4),
	   (5,'2020-06-01', 160, 5),
	   (6,'2020-06-01', 120, 6),
	   (7,'2020-06-01', 120, 7),
	   (8,'2020-06-01', 160, 8),
	   (9,'2020-06-01', 70, 9),
	   (10,'2020-06-01', 160, 10)

INSERT INTO rozliczenia.pensje
VALUES (1,'Front-end Developer', 7000, 2),
       (2,'Junior Full-Stack Developer', 7000, 2),
	   (3,'Senior Full-Stack Developer', 13000, 1),
	   (4,'Back-end Developer', 8000, 2),
	   (3,'Senior Full-Stack Developer', 13000, 1),
	   (6,'Accountant', 5000, 3),
	   (7,'Data Base Administrator', 6000,3),
	   (4,'Back-end Developer', 8000, 2),
	   (9,'IT Consultant', 4000, 3),
	   (1,'Front-end Developer', 7000, 2)

INSERT INTO rozliczenia.premie
VALUES (1, 'uznaniowa', 400),
	   (2, 'zadaniowa', 300),
	   (3, 'regulaminowa', 200)

-- 5. Wyœwietl adresy i nazwiska

SELECT nazwisko, adres FROM rozliczenia.pracownicy;

-- 6. Przekonwertuj datê z tabeli godziny, aby by³a wyœwietlana informacja jaki to dzieñ tygodnia oraz miesi¹c

SELECT DATEPART (day, data) FROM rozliczenia.godziny as theDay;
SELECT DATEPART (month, data) FROM rozliczenia.godziny as theMonth;

--DECLARE @date datetime2 = '2020-06-01';
--SELECT FORMAT(@date, 'dddd') AS Result;

-- 7. Zmieñ nazwê kolumny kwota na kwota_brutto i dodaj now¹ o nazwie kwota_netto oraz zaaktualizuj wartoœci

EXEC sp_RENAME 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';
ALTER TABLE rozliczenia.pensje ADD kwota_netto MONEY;

SELECT kwota_brutto*0.81 AS kwota_netto FROM rozliczenia.pensje;
UPDATE rozliczenia.pensje SET kwota_netto = kwota_brutto * 0.81;
SELECT kwota_netto FROM rozliczenia.pensje;