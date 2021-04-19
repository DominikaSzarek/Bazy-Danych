-- 1. Utw�rz pust� baz� danych 

CREATE DATABASE firma;
USE firma;
GO

-- 2. Utw�rz schemat

CREATE SCHEMA ksiegowosc;
GO

-- 3. Utw�rz tabel�

CREATE TABLE ksiegowosc.pracownicy(ID_pracownika INTEGER NOT NULL PRIMARY KEY, imie VARCHAR(20) NOT NULL, nazwisko VARCHAR(20) NOT NULL, adres VARCHAR(40), telefon INTEGER);
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
EXEC sp_addextendedproperty 'Pracownicy', 'Tabela zawieraj�ca informacje o pracownikach firmy', 'SCHEMA', 'ksiegowosc', 'TABLE', 'pracownicy'; 
EXEC sp_addextendedproperty 'Godziny' , 'Tabela zawieraj�ca informacje o przepracowanych godzinach w miesi�cu', 'SCHEMA', 'ksiegowosc', 'TABLE', 'godziny';
EXEC sp_addextendedproperty 'Pensje', 'Tabela zawierajaca informacje dotycz�ce miesi�cznego wynagrodzenia pracownik�w', 'SCHEMA','ksiegowosc', 'TABLE', 'pensje';
EXEC sp_addextendedproperty 'Premie', 'Tabela zawieraj�ca informacje dotycz�ce premii dla pracownik�w','SCHEMA', 'ksiegowosc','TABLE','premie';
EXEC sp_addextendedproperty 'Wynagrodzenie', 'Tabela, w kt�rej wyst�puj� powi�zania pomi�dzy pozosta�ymi tabelami', 'SCHEMA', 'ksiegowosc', 'TABLE', 'wynagrodzenie'; 

-- 4. Dodaj rekordy do tabeli

INSERT INTO ksiegowosc.pracownicy 
VALUES (1, 'Adam','Nowak', 'D�uga 4', 977837372),
	   (2, 'Krzysztof','Kras', 'Mickiewicza 40', 746293748),
	   (3, 'Karol','Paciorek', 'Lekka 3', 859284920),
	   (4, 'Wo�odymir','Markowicz', 'Stronnicza 7', 947284728),
	   (5, 'Artur','Loczek', 'Jarzynowa 10', 792531493),
	   (6, 'Marek','Drab', 'Tarnowska 9', 938472393),
	   (7, 'Jolanta','Kroczek', 'Kleberga 38', 739285730),
	   (8, 'Monika','Las', 'Kr�tka 2', 839453729),
	   (9, 'Adrian','Nasiadka', 'Rad�owska 89', 983765823),
	   (10,'Wiktoria','Przepi�rka', 'Sienkiewicza 43', 633828473);

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
	   ('W2', '2020-07-31', 2, 'G2', 'P2', 2),
	   ('W3', '2020-07-31', 3, 'G3', 'P3', 1),
	   ('W4', '2020-07-31', 4, 'G4','P4',2),
	   ('W5', '2020-07-31', 5, 'G5','P5',1),
	   ('W6', '2020-07-31', 6, 'G6','P6',3),
	   ('W7', '2020-07-31', 7, 'G7','P7',3),
	   ('W8','2020-07-31', 8, 'G8','P8',2),
	   ('W9', '2020-07-31', 9, 'G9','P9',3),
	   ('W10' ,'2020-07-31', 10, 'G10', 'P10',2)

	   SELECT * FROM ksiegowosc.pracownicy;
	   SELECT * FROM ksiegowosc.godziny;
	   SELECT * FROM ksiegowosc.pensje;
	   SELECT * FROM ksiegowosc.premie;
	   SELECT * FROM ksiegowosc.wynagrodzenie;


-- 5. Wykonaj nast�puj�ce zapytania: 
 
 -- a) Wyswietl ID pracownika oraz nazwisko 
SELECT ID_pracownika, nazwisko FROM ksiegowosc.pracownicy;

-- b) Wyswietl ID pracownik�w, kt�rych p�aca jest wi�ksza ni� 1000
SELECT pracownicy.ID_pracownika, pensje.kwota 
FROM ksiegowosc.pracownicy INNER JOIN (ksiegowosc.pensje INNER JOIN ksiegowosc.wynagrodzenie ON pensje.ID_pensji = wynagrodzenie.ID_pensji) ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika 
WHERE pensje.kwota > 1000.00;

-- c) Wy�wietl ID pracownik�w nieposiadaj�cych premii, kt�rych p�aca jest wi�ksza ni� 2000
SELECT pracownicy.ID_pracownika, pensje.kwota, premie.kwota
FROM ksiegowosc.pracownicy  INNER JOIN (ksiegowosc.pensje INNER JOIN (ksiegowosc.premie INNER JOIN ksiegowosc.wynagrodzenie ON premie.ID_premii = wynagrodzenie.ID_premii)  ON pensje.ID_pensji = wynagrodzenie.ID_pensji) ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika 
WHERE (premie.kwota IS NULL) AND (pensje.kwota > 2000.00);

-- d) Wy�wietl ID pracownik�w, kt�rych pierwsza litera imienia zaczyna si� na liter� 'J'
SELECT ID_pracownika, imie, nazwisko 
FROM ksiegowosc.pracownicy 
WHERE imie LIKE 'J%';

-- e) Wy�wietl pracownik�w, kt�rych nazwisko zawiera liter� 'n' oraz imi� ko�czy si� na liter� 'a'
SELECT ID_pracownika, imie, nazwisko 
FROM ksiegowosc.pracownicy 
WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';

-- f) Wy�wietl imi� i nazwisko pracownik�w oraz liczb� ich nadgodzin, przyjmuj�c, i� standardowy czas pracy to 150h miesi�cznie (zmienione na 150, poniewa� w tabeli nie znajduje si� <160)
SELECT pracownicy.imie, pracownicy.nazwisko, godziny.liczba_godzin 
FROM ksiegowosc.pracownicy INNER JOIN ksiegowosc.godziny ON pracownicy.ID_pracownika = godziny.ID_pracownika
WHERE godziny.liczba_godzin > 150;

-- g) Wy�wietl imi� i nazwisko pracownik�w, kt�rych pensja zawiera si� w przedziale 1500-3000 PLN
SELECT pracownicy.imie, pracownicy.nazwisko, pensje.kwota
FROM ksiegowosc.pracownicy INNER JOIN (ksiegowosc.pensje INNER JOIN ksiegowosc.wynagrodzenie ON pensje.ID_pensji = wynagrodzenie.ID_pensji) ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika 
WHERE pensje.kwota BETWEEN 1500 AND 3000;

-- Zmieniono warto�ci, poniewa� w tabeli nie ma pracownik�w spe�niaj�cych wymagania zadania
--SELECT pracownicy.imie, pracownicy.nazwisko, pensje.kwota
--FROM ksiegowosc.pracownicy INNER JOIN (ksiegowosc.pensje INNER JOIN ksiegowosc.wynagrodzenie ON pensje.ID_pensji = wynagrodzenie.ID_pensji) ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika 
--WHERE pensje.kwota BETWEEN 6000 AND 8000;

-- h) Wy�wietl imi� i nazwisko pracownik�w, kt�rzy pracowali w nadgodzinach i nie otrzymali premii

SELECT pracownicy.imie, pracownicy.nazwisko, godziny.liczba_godzin, premie.kwota 
FROM ksiegowosc.pracownicy  INNER JOIN (ksiegowosc.godziny INNER JOIN (ksiegowosc.premie INNER JOIN ksiegowosc.wynagrodzenie ON premie.ID_premii = wynagrodzenie.ID_premii)  ON godziny.ID_godziny = wynagrodzenie.ID_godziny) ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika 
WHERE godziny.liczba_godzin > 160 AND premie.kwota IS NULL;

-- Zmieniono warto�ci, poniewa� nie ma w tabeli pracownik�w spe�niaj�cych wymagania zadania
--SELECT pracownicy.imie, pracownicy.nazwisko, godziny.liczba_godzin, premie.kwota 
--FROM ksiegowosc.pracownicy  INNER JOIN (ksiegowosc.godziny INNER JOIN (ksiegowosc.premie INNER JOIN ksiegowosc.wynagrodzenie ON premie.ID_premii = wynagrodzenie.ID_premii)  ON godziny.ID_godziny = wynagrodzenie.ID_godziny) ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika 
--WHERE godziny.liczba_godzin > 150 AND premie.kwota = 400;

-- i) Uszereguj pracownik�w wed�ug pensji 
SELECT pracownicy.ID_pracownika, pracownicy.imie, pracownicy.nazwisko, pensje.kwota
FROM ksiegowosc.pracownicy INNER JOIN (ksiegowosc.pensje INNER JOIN ksiegowosc.wynagrodzenie ON pensje.ID_pensji = wynagrodzenie.ID_pensji) ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika
ORDER BY pensje.kwota ASC;

-- j) Uszereguj pracownik�w wed�ug pensji i premii malej�co
SELECT pracownicy.ID_pracownika, pracownicy.imie, pracownicy.nazwisko, pensje.kwota AS pensja, premie.kwota AS premia
FROM ksiegowosc.pracownicy  INNER JOIN (ksiegowosc.pensje INNER JOIN (ksiegowosc.premie INNER JOIN ksiegowosc.wynagrodzenie ON premie.ID_premii = wynagrodzenie.ID_premii)  ON pensje.ID_pensji = wynagrodzenie.ID_pensji) ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika
ORDER BY pensje.kwota DESC, premie.kwota DESC;

-- k) Zlicz i pogrupuj pracownik�w wed�ug pola �stanowisko'
SELECT  COUNT(pensje.stanowisko), pensje.stanowisko
FROM ksiegowosc.pensje
GROUP BY pensje.stanowisko; 

-- l) Policz �redni�, minimaln� i maksymaln� p�ac� dla stanowiska �kierownik� (je�eli takiego nie masz, to przyjmij dowolne inne)
SELECT AVG(pensje.kwota) AS �rednia, MIN(pensje.kwota) AS Minimalna, MAX(pensje.kwota) AS Maksymalna
FROM ksiegowosc.pensje
WHERE pensje.stanowisko LIKE 'Senior Full-Stack Developer' 

-- m) Policz sum� wszystkich wynagrodze�
SELECT SUM(pensje.kwota) AS suma_pensji, SUM(premie.kwota)  AS suma_premii, SUM(pensje.kwota) + SUM(premie.kwota) AS suma_wynagrodze�
FROM ksiegowosc.premie INNER JOIN (ksiegowosc.pensje INNER JOIN ksiegowosc.wynagrodzenie ON pensje.ID_pensji = wynagrodzenie.ID_pensji) ON premie.ID_premii = wynagrodzenie.ID_premii;

-- n) Policz sum� wynagrodze� w ramach danego stanowiska
SELECT SUM(pensje.kwota) AS SumaPensji, SUM(premie.kwota)  AS SumaPremii, SUM(pensje.kwota) + SUM(premie.kwota) AS SumaWynagrodze�, pensje.stanowisko
FROM ksiegowosc.premie INNER JOIN (ksiegowosc.pensje INNER JOIN ksiegowosc.wynagrodzenie ON pensje.ID_pensji = wynagrodzenie.ID_pensji) ON premie.ID_premii = wynagrodzenie.ID_premii 
GROUP BY pensje.stanowisko;

 -- o) Wyznacz liczb� premii przyznanych dla pracownik�w danego stanowiska
SELECT COUNT(premie.kwota) AS LiczbaPremii, pensje.stanowisko
FROM ksiegowosc.premie INNER JOIN (ksiegowosc.pensje INNER JOIN ksiegowosc.wynagrodzenie ON pensje.ID_pensji = wynagrodzenie.ID_pensji) ON premie.ID_premii = wynagrodzenie.ID_premii 
GROUP BY pensje.stanowisko;

-- u)  Usu� wszystkich pracownik�w maj�cych pensj� mniejsz� ni� 1200 z� (zmieniono na 4000)
DELETE ksiegowosc.pracownicy FROM ksiegowosc.premie INNER JOIN (ksiegowosc.pensje INNER JOIN ksiegowosc.wynagrodzenie ON pensje.ID_pensji = wynagrodzenie.ID_pensji) ON premie.ID_premii = wynagrodzenie.ID_premii 
WHERE pensje.kwota <= 4000; 

--DELETE pracownicy FROM ksiegowosc.pracownicy WHERE ID_pracownika = 9; 