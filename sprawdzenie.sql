SELECT * FROM Opiekun;
UPDATE Opiekun
SET telefon = '300000000'
WHERE telefon = '653000221'
SELECT * FROM Opiekun;

SELECT * FROM Uczestnik WHERE id_uczestnika=11;
UPDATE Uczestnik
SET stopieñ = 'HO'
WHERE id_uczestnika = 11
SELECT * FROM Uczestnik WHERE id_uczestnika=11;

SELECT * FROM Sprzêt WHERE nazwa_sprzêtu = 'Rower';
UPDATE Sprzêt
SET iloœæ_sprzêtu = 21
WHERE nazwa_sprzêtu = 'Rower'
SELECT * FROM Sprzêt WHERE nazwa_sprzêtu = 'Rower';

SELECT * FROM Sprzêt;
UPDATE Sprzêt
SET id_sprzetu = 35
WHERE id_sprzetu = 3
SELECT * FROM Sprzêt

SELECT * FROM Uczestnik
WHERE id_uczestnika = 1;
SELECT * FROM Zg³oszenie_Uczestnika;

DELETE FROM Zg³oszenie_Uczestnika
WHERE id_uczestnika = 1;
DELETE FROM Uczestnik
WHERE id_uczestnika = 1;

SELECT * FROM Uczestnik
WHERE id_uczestnika = 1;
SELECT * FROM Zg³oszenie_Uczestnika;

SELECT * FROM Opiekun

DELETE FROM Opiekun_Wyjazdu
WHERE id_opiekuna = 2

DELETE FROM Opiekun
WHERE id_opiekuna = 2

SELECT * FROM Opiekun

SELECT * FROM Sprzêt
SELECT * FROM Potrzebny_Sprzêt

DELETE FROM Sprzêt
WHERE id_sprzetu = 4

SELECT * FROM Sprzêt
SELECT * FROM Potrzebny_Sprzêt