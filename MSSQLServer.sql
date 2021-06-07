CREATE DATABASE test;
USE test 

--SELECT * FROM Milion ORDER BY liczba asc;
--SELECT * FROM Dziesiec

CREATE TABLE GeoEon(ID_Eon INTEGER PRIMARY KEY, nazwa_eon VARCHAR(30));
CREATE TABLE GeoEra(ID_Era INTEGER PRIMARY KEY,ID_Eon INTEGER, Nazwa_Era VARCHAR(30));
CREATE TABLE GeoOkres(ID_Okres INTEGER PRIMARY KEY,ID_Era INTEGER, Nazwa_Okres VARCHAR(30));
CREATE TABLE GeoEpoka(ID_Epoka INTEGER PRIMARY KEY,ID_Okres INTEGER, Nazwa_Epoka VARCHAR(30));
CREATE TABLE GeoPietro(ID_Pietro INTEGER PRIMARY KEY,ID_Epoka INTEGER, Nazwa_Pietro VARCHAR(30));
CREATE TABLE Dziesiec(cyfra int, bit int);
CREATE TABLE Milion(liczba int NOT NULL PRIMARY KEY,cyfra int, bit int);

SELECT ID_Pietro, ep.ID_Epoka, Nazwa_Pietro, okr.ID_Okres, Nazwa_Epoka, er.ID_Era, Nazwa_Okres, eo.ID_Eon, Nazwa_Era, nazwa_eon
INTO GeoTabela 
FROM GeoPietro p 
INNER JOIN GeoEpoka ep ON p.ID_Epoka = ep.ID_Epoka 										 
INNER JOIN GeoOkres okr ON ep.ID_Okres = okr.ID_Okres												 
INNER JOIN GeoEra er ON okr.ID_Era = er.ID_Era 
INNER JOIN GeoEon eo ON er.ID_Eon = eo.ID_Eon;

-- adding primary key (index) 

ALTER TABLE GeoTabela
ADD PRIMARY KEY (ID_Pietro)

ALTER TABLE GeoOkres
ADD PRIMARY KEY (ID_Okres)

ALTER TABLE GeoEra
ADD PRIMARY KEY (ID_Era)

ALTER TABLE GeoEpoka
ADD PRIMARY KEY (ID_Epoka)

ALTER TABLE GeoEon
ADD PRIMARY KEY (ID_Eon)

ALTER TABLE GeoPietro
ADD PRIMARY KEY (ID_Pietro)

ALTER TABLE Milion
ADD PRIMARY KEY (liczba)


-- adding foreign key

ALTER TABLE GeoEra
ADD FOREIGN KEY (ID_Eon)
REFERENCES GeoEon(ID_Eon)

ALTER TABLE GeoOkres
ADD FOREIGN KEY (ID_Era)
REFERENCES GeoEra(ID_Era)

ALTER TABLE GeoEpoka
ADD FOREIGN KEY (ID_Okres)
REFERENCES GeoOkres(ID_Okres)

ALTER TABLE GeoPietro
ADD FOREIGN KEY (ID_Epoka)
REFERENCES GeoEpoka(ID_Epoka)


-- adding records to the table 

SELECT * FROM GeoTabela;
INSERT INTO GeoEon
VALUES (1, 'Fanerozoik')

INSERT INTO GeoEra
VALUES (1, 1, 'Kenozoik'),
	   (2, 1, 'Mezozoik'),
	   (3, 1, 'Paleozoik')

INSERT INTO GeoOkres
VALUES (1, 1, 'Czwartorzêd'), 
	   (2, 1, 'Neogen'),
	   (3, 1, 'Paleogen'),
	   (4, 2, 'Kreda'),
	   (5, 2, 'Jura'),
	   (6, 2, 'Trias'),
	   (7, 3, 'Perm'),
	   (8, 3, 'Karbon'),
	   (9, 3, 'Dewon')

INSERT INTO GeoEpoka 
VALUES (1, 1, 'Holocen'),
	   (2, 1, 'Plejstocen'),
	   (3, 2, 'Pliocen'),
	   (4, 2, 'Miocen'),
	   (5, 3, 'Oligocen'),
	   (6, 3, 'Eocen'),
	   (7, 3, 'Paleocen'),
	   (8, 4, 'Górna'),
	   (9, 4, 'Dolna'),
	   (10, 5, 'Górna'),
	   (11, 5, 'Œrodkowa'),
	   (12, 5, 'Dolna'),
	   (13, 6, 'Górny'),
	   (14, 6, 'Œrodkowy'),
	   (15, 6, 'Dolny'),
	   (16, 7, 'Górny'),
	   (17, 7, 'Dolny'),
	   (18, 8, 'Górny'),
	   (19, 8, 'Dolny'),
	   (20, 9, 'Górny'),
	   (21, 9, 'Œrodkowy'),
	   (22, 9, 'Dolny')

INSERT INTO GeoPietro 
VALUES (1, 1, NULL),
	   (2, 2, 'Górny/PóŸny'),
	   (3, 2, 'Œrodkowy'),
	   (4, 2, 'Dolny/Wczesny'),
	   (5, 3, 'Gelas'),
	   (6, 3, 'Piacent'),
	   (7, 3, 'Zankl'),
	   (8, 4, 'Messyn'),
	   (9, 4, 'Torton'),
	   (10, 4,'Serrawal'),
	   (11, 4, 'Lang'),
	   (12, 4, 'Burdyga³'),
	   (13, 4, 'Akwitan'),
	   (14, 5, 'Szat'),
	   (15, 5, 'Rupel'),
	   (16, 6, 'Priabon'),
	   (17, 6, 'Barton'),
	   (18, 6, 'Lutet'),
	   (19, 6, 'Ipres'),
	   (20, 7, 'Tanet'),
	   (21, 7, 'Seland'),
	   (22, 7, 'Dan'),
	   (23, 8, 'Mastrycht'),
	   (24, 8, 'Kampan'),
	   (25, 8, 'Santon'),
	   (26, 8, 'Koniak'),
	   (27, 8, 'Turon'),
	   (28, 8, 'Cenoman'), 
	   (29, 9, 'Alb'),
	   (30, 9, 'Apt'),
	   (31, 9, 'Barrem'),
	   (32, 9, 'Hoteryw'),
	   (33, 9, 'Walan¿yn'),
	   (34, 9, 'Berias'),
	   (35, 10, 'Tyton'),
	   (36, 10, 'Kimeryd'), 
	   (37, 10, 'Oksford'),
	   (38, 11, 'Kelowej'),
	   (39, 11, 'Baton'), 
	   (40, 11, 'Bajos'),
	   (41, 11, 'Aalen'),
	   (42, 12, 'Toark'), 
	   (43, 12, 'Pliensbach'), 
	   (44, 12, 'Synemur'),
	   (45, 12, 'Hetang'),
	   (46, 13, 'Retyk'),
	   (47, 13, 'Noryk'),
	   (48, 13, 'Karnik'),
	   (49, 14, 'Ladyn'),
	   (50, 14, 'Anizyk'), 
	   (51, 15, 'Olenek'),
	   (52, 15, 'Ind'),
	   (53, 16, 'Ohre'),
	   (54, 16, 'Aller'),
	   (55, 16, 'Leine'),
	   (56, 16, 'Stassfurt'),
	   (57, 16, 'Werra'), 
	   (58, 17, 'Sakson'),
	   (59, 17, 'Autun'),
	   (60, 18, 'Stefan'),
	   (61, 18, 'Westfal'),
	   (62, 18, 'Namur'),
	   (63, 19, 'Wizen'),
	   (64, 19, 'Turnej'), 
	   (65, 20, 'Famen'),
	   (66, 20, 'Fran'),
	   (67, 21, 'Eifel'),
	   (68, 22, 'Ems'),
	   (69, 22, 'Prag'),
	   (70, 22, 'Lochkow')

INSERT INTO Dziesiec 
VALUES (0, 1), 
	   (1, 1),
	   (2, 1),
	   (3, 1),
	   (4, 1),
	   (5, 1),
	   (6, 1),
	   (7, 1),
	   (8, 1),
	   (9, 1);

INSERT INTO Milion SELECT a1.cyfra + 10*a2.cyfra + 100*a3.cyfra + 1000*a4.cyfra
+ 10000*a5.cyfra + 100000*a6.cyfra AS liczba , a1.cyfra AS cyfra, a1.bit AS bit
FROM dziesiec a1, dziesiec a2, dziesiec a3, dziesiec a4, dziesiec a5, dziesiec a6;


--1 ZL 

SELECT COUNT(*) FROM Milion 
INNER JOIN GeoTabela 
ON (Milion.liczba%68)=(GeoTabela.id_pietro);


--2 ZL

SELECT COUNT(*) FROM Milion INNER JOIN GeoPietro gpi 
ON (Milion.liczba%68)=gpi.ID_Pietro 
INNER JOIN GeoEpoka ep ON gpi.ID_Epoka = ep.ID_Epoka 
INNER JOIN GeoOkres okr ON okr.ID_Okres = ep.ID_Okres INNER JOIN GeoEra er ON er.ID_Era = okr.ID_EraINNER JOIN GeoEon eo ON er.ID_Eon = eo.ID_Eon --3 ZLSELECT COUNT(*) FROM Milion WHERE Milion.liczba%68= 
(SELECT id_pietro FROM GeoTabela WHERE Milion.liczba%68 =(ID_Pietro));--4 ZLSELECT COUNT(*) FROM Milion WHERE (Milion.liczba%68) = 
(SELECT gpi.ID_Pietro FROM GeoPietro gpi 
INNER JOIN GeoEpoka ep ON  gpi.ID_Epoka = ep.ID_Epoka 
INNER JOIN GeoOkres okr ON ep.ID_Okres = okr.ID_OkresINNER JOIN GeoEra er ON okr.ID_Era = er.ID_EraINNER JOIN GeoEon eo ON er.ID_Eon = eo.ID_EonWHERE Milion.liczba%68 =(ID_Pietro))