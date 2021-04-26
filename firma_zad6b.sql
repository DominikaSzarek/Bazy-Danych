-- Baza danych:

CREATE DATABASE firma;
USE firma;
GO

-- Schemat:

CREATE SCHEMA ksiegowosc;
GO

-- Tabele:

CREATE TABLE ksiegowosc.pracownicy(ID_pracownika INTEGER NOT NULL PRIMARY KEY, imie VARCHAR(20) NOT NULL, nazwisko VARCHAR(20) NOT NULL, adres VARCHAR(40), telefon VARCHAR(20));
CREATE TABLE ksiegowosc.godziny(ID_godziny VARCHAR(3) NOT NULL PRIMARY KEY, data DATE, liczba_godzin FLOAT, ID_pracownika INTEGER NOT NULL);
CREATE TABLE ksiegowosc.pensje(ID_pensji VARCHAR(3) NOT NULL PRIMARY KEY, stanowisko VARCHAR(50), kwota MONEY NOT NULL, ID_premii INTEGER NOT NULL);
CREATE TABLE ksiegowosc.premie(ID_premii INTEGER NOT NULL PRIMARY KEY, rodzaj VARCHAR(20), kwota MONEY NOT NULL);
CREATE TABLE ksiegowosc.wynagrodzenie(ID_wynagrodzenia VARCHAR(4) PRIMARY KEY, data DATE NOT NULL, ID_pracownika INTEGER NOT NULL, ID_godziny VARCHAR(3) NOT NULL, ID_pensji VARCHAR(3) NOT NULL, ID_premii INTEGER NOT NULL);

-- Klucze obce
ALTER TABLE ksiegowosc.godziny ADD FOREIGN KEY (ID_pracownika) REFERENCES  ksiegowosc.pracownicy(ID_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (ID_pracownika) REFERENCES ksiegowosc.pracownicy(ID_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (ID_godziny) REFERENCES ksiegowosc.godziny(ID_godziny);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (ID_pensji) REFERENCES ksiegowosc.pensje(ID_pensji);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (ID_premii) REFERENCES ksiegowosc.premie(ID_premii);

-- Komentarze
EXEC sp_addextendedproperty 'Pracownicy', 'Tabela zawieraj¹ca informacje o pracownikach firmy', 'SCHEMA', 'ksiegowosc', 'TABLE', 'pracownicy'; 
EXEC sp_addextendedproperty 'Godziny' , 'Tabela zawieraj¹ca informacje o przepracowanych godzinach w miesi¹cu', 'SCHEMA', 'ksiegowosc', 'TABLE', 'godziny';
EXEC sp_addextendedproperty 'Pensje', 'Tabela zawierajaca informacje dotycz¹ce miesiêcznego wynagrodzenia pracowników', 'SCHEMA','ksiegowosc', 'TABLE', 'pensje';
EXEC sp_addextendedproperty 'Premie', 'Tabela zawieraj¹ca informacje dotycz¹ce premii dla pracowników','SCHEMA', 'ksiegowosc','TABLE','premie';
EXEC sp_addextendedproperty 'Wynagrodzenie', 'Tabela, w której wystêpuj¹ powi¹zania pomiêdzy pozosta³ymi tabelami', 'SCHEMA', 'ksiegowosc', 'TABLE', 'wynagrodzenie'; 

SELECT * FROM sys.extended_properties; 

-- Dodanie rekordów do tabeli:

INSERT INTO ksiegowosc.pracownicy 
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

INSERT INTO ksiegowosc.godziny
VALUES ('G1','2020-06-01', 160, 1),
	   ('G2','2020-06-01', 160, 2),
	   ('G3','2020-06-01', 160, 3),
	   ('G4','2020-06-01', 160, 4),
	   ('G5','2020-06-01', 160, 5),
	   ('G6','2020-06-01', 120, 6),
	   ('G7','2020-06-01', 120, 7),
	   ('G8','2020-06-01', 160, 8),
	   ('G9','2020-06-01', 70, 9),
	   ('G10','2020-06-01', 160, 10)

INSERT INTO ksiegowosc.pensje
VALUES ('P1','Front-end Developer', 7000, 2),
       ('P2','Junior Full-Stack Developer', 7000, 2),
	   ('P3','Senior Full-Stack Developer', 13000, 1),
	   ('P4','Back-end Developer', 8000, 2),
	   ('P5','Senior Full-Stack Developer', 13000, 1),
	   ('P6','Accountant', 5000, 3),
	   ('P7','Data Base Administrator', 6000,3),
	   ('P8','Back-end Developer', 8000, 2),
	   ('P9','IT Consultant', 4000, 3),
	   ('P10','Front-end Developer', 7000, 2)

INSERT INTO ksiegowosc.premie
VALUES (1, 'uznaniowa', 400),
	   (2, 'zadaniowa', 300),
	   (3, 'regulaminowa', 200)

INSERT INTO ksiegowosc.wynagrodzenie 
VALUES ('W1', '2020-07-31', 1, 'G1','P1',2),
	   ('W2', '2020-07-31', 2, 'G2', 'P2',2),
	   ('W3', '2020-07-31', 3, 'G3', 'P3',1),
	   ('W4', '2020-07-31', 4, 'G4','P4',2),
	   ('W5', '2020-07-31', 5, 'G5','P5',1),
	   ('W6', '2020-07-31', 6, 'G6','P6',3),
	   ('W7', '2020-07-31', 7, 'G7','P7',3),
	   ('W8', '2020-07-31', 8, 'G8','P8',2),
	   ('W9', '2020-07-31', 9, 'G9','P9',3),
	   ('W10' ,'2020-07-31', 10, 'G10', 'P10',2)


	   SELECT * FROM ksiegowosc.pracownicy;
	   SELECT * FROM ksiegowosc.godziny;
	   SELECT * FROM ksiegowosc.pensje;
	   SELECT * FROM ksiegowosc.premie;
	   SELECT * FROM ksiegowosc.wynagrodzenie;

-- a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj¹c do niego kierunkowy dla Polski 
-- b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony by³ myœlnikami
	  
	   UPDATE ksiegowosc.pracownicy 
	   SET telefon = CONCAT ('(+48)', FORMAT(CONVERT(int, telefon), '###-###-###'))
	   FROM  ksiegowosc.pracownicy; 
	   --SELECT * FROM ksiegowosc.pracownicy;

	   --SELECT FORMAT (telefon,'###-###-###');,
	   --CONVERT (int, telefon) FROM ksiegowosc.pracownicy;

-- c) Wyœwietl dane pracownika, którego nazwisko jest najd³u¿sze, u¿ywaj¹c du¿ych liter
	   
	   --SELECT MAX(LEN(UPPER(nazwisko)))
	   --FROM ksiegowosc.pracownicy
	
	   SELECT ID_pracownika, UPPER(imie) AS Imie, 
	   UPPER(nazwisko) AS Nazwisko, 
	   UPPER(adres) AS Adres 
	   FROM ksiegowosc.pracownicy 
	   WHERE LEN(nazwisko)= (SELECT MAX(LEN(nazwisko)) FROM ksiegowosc.pracownicy);


-- d) Wyœwietl dane pracowników i ich pensje zakodowane przy pomocy algorytmu md5

	   SELECT pracownicy.ID_pracownika,imie, nazwisko,adres, telefon, HASHBYTES('MD5',CONVERT(varchar(20), kwota)) AS hash_kwota
	   FROM ksiegowosc.pracownicy INNER JOIN ksiegowosc.pensje INNER JOIN ksiegowosc.wynagrodzenie ON pensje.ID_pensji = wynagrodzenie.ID_pensji ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika;

-- e) Wyœwietl pracowników, ich pensje oraz premie. Wykorzystaj z³¹czenie lewostronne

	   SELECT p.ID_pracownika, imie, nazwisko, pe.kwota AS kwota_pensji, pr.kwota AS kwota_premii
	   FROM ksiegowosc.pracownicy p
	   LEFT JOIN ksiegowosc.wynagrodzenie w ON w.ID_pracownika=p.ID_pracownika 
	   LEFT JOIN ksiegowosc.pensje pe ON pe.ID_pensji=w.ID_pensji
	   LEFT JOIN ksiegowosc.premie pr ON pr.ID_premii=w.ID_premii;
	 
-- f) wygeneruj raport (zapytanie), które zwróci w wyniki treœæ wg szablonu
 
	 SELECT CONCAT('Pracownik ', imie,' ', nazwisko, ', w dniu ', g.data, ' otrzyma³ pensjê ca³kowit¹ na kwotê ', pe.kwota + pr.kwota +
	 CASE WHEN g.liczba_godzin - 150 > 0
		THEN 20*(g.liczba_godzin - 150)
		ELSE 0
	 END,
	 ', gdzie wynagrodzenie zasadnicze wynosi³o ', pe.kwota, ', premia: ', pr.kwota, ', nadgodziny: ',
	 CASE WHEN g.liczba_godzin - 150 > 0 
		THEN 20*(g.liczba_godzin - 150) 
		ELSE 0 
	 END
	 ) 
	 AS RAPORT
	 FROM ksiegowosc.pracownicy p
	 LEFT JOIN ksiegowosc.wynagrodzenie w ON p.ID_pracownika = w.ID_pracownika
	 LEFT JOIN ksiegowosc.pensje pe ON w.ID_pensji=pe.ID_pensji
	 LEFT JOIN ksiegowosc.premie pr ON w.ID_premii=pr.ID_premii
	 LEFT JOIN ksiegowosc.godziny g ON w.ID_pracownika=g.ID_pracownika;
	 



