-- 1. Zapytanie z sortowaniem: Lista wyjazdów posortowana wed³ug liczby zg³oszeñ w kolejnoœci malej¹cej
/*Poka¿ listê wyjazdów posortowan¹ wed³ug liczby zg³oszeñ, zaczynaj¹c od tych z najwiêksz¹ liczb¹ zg³oszeñ. 
Wyœwietl lokalizacjê wyjazdu, datê rozpoczêcia oraz liczbê zg³oszeñ.*/
SELECT
    Wyjazd.lokalizacja,
    Wyjazd.data_pocz¹tek,
    COUNT(Zg³oszenia.id_zg³oszenia) AS liczba_zg³oszeñ
FROM Wyjazd
JOIN Zg³oszenia ON Wyjazd.id_wyjazdu = Zg³oszenia.id_wyjazdu
GROUP BY Wyjazd.lokalizacja, Wyjazd.data_pocz¹tek
ORDER BY liczba_zg³oszeñ DESC;

-- 2. Zapytanie kompleksowe: Lista aktywnoœci wymagaj¹cych wiêcej ni¿ 10 sztuk sprzêtu dla danego dnia harmonogramu
/*Poka¿ listê aktywnoœci zaplanowanych na dzieñ 15 stycznia 2024 roku, 
które wymagaj¹ wiêcej ni¿ 10 sztuk sprzêtu. Wyœwietl miejsce, opis aktywnoœci, 
nazwê sprzêtu oraz liczbê potrzebnego sprzêtu*/
SELECT 
    Aktywnoœæ.miejsce,
    Aktywnoœæ.opis,
    Sprzêt.nazwa_sprzêtu,
    Potrzebny_Sprzêt.iloœæ_potrzebnego_sprzetu
FROM Aktywnoœæ
JOIN Potrzebny_Sprzêt ON Aktywnoœæ.id_aktywnosc = Potrzebny_Sprzêt.id_aktywnosc
JOIN Sprzêt ON Potrzebny_Sprzêt.id_sprzetu = Sprzêt.id_sprzetu
JOIN Przebieg_Dnia ON Aktywnoœæ.id_aktywnosc = Przebieg_Dnia.id_aktywnosc
JOIN Harmonogram ON Przebieg_Dnia.id_harmonogram = Harmonogram.id_harmonogram
WHERE Harmonogram.data = '2024-01-15' 
  AND Potrzebny_Sprzêt.iloœæ_potrzebnego_sprzetu > 10;

-- 3. Funkcja agreguj¹ca, grupowanie, podzapytanie: Œrednia liczba uczestników zg³oszonych na wyjazdy
/*Wyœwietl listê wyjazdów z ich identyfikatorami, lokalizacj¹ i liczb¹ zg³oszonych uczestników, 
a tak¿e oblicz œredni¹ liczbê uczestników zg³oszonych na wszystkie wyjazdy w celu dowiedzenia siê czy jest potrzeba
tworzenia wiêcej wyjazdów*/
WITH WyjazdUczestnicy AS (
    SELECT 
        Wyjazd.id_wyjazdu,
        Wyjazd.lokalizacja,
        COUNT(Zg³oszenie_Uczestnika.id_uczestnika) AS liczba_uczestników
    FROM Wyjazd
    LEFT JOIN Zg³oszenia ON Wyjazd.id_wyjazdu = Zg³oszenia.id_wyjazdu
    LEFT JOIN Zg³oszenie_Uczestnika ON Zg³oszenia.id_zg³oszenia = Zg³oszenie_Uczestnika.id_zg³oszenia
    GROUP BY Wyjazd.id_wyjazdu, Wyjazd.lokalizacja
)
SELECT 
    id_wyjazdu,
    lokalizacja,
    liczba_uczestników,
    AVG(liczba_uczestników) OVER () AS œrednia_liczba_uczestników
FROM WyjazdUczestnicy;

-- 4. Zapytanie ze z³¹czeniem: Lista uczestników przypisanych do konkretnego wyjazdu
/*Poka¿ listê uczestników zg³oszonych na wyjazd o identyfikatorze 1. Wyœwietl imiê i nazwisko uczestnika, 
lokalizacjê wyjazdu oraz daty jego rozpoczêcia i zakoñczenia.*/
SELECT 
    Uczestnik.imiê,
    Uczestnik.nazwisko,
    Wyjazd.lokalizacja,
    Wyjazd.data_pocz¹tek,
    Wyjazd.data_koniec
FROM Zg³oszenie_Uczestnika
JOIN Zg³oszenia ON Zg³oszenie_Uczestnika.id_zg³oszenia = Zg³oszenia.id_zg³oszenia
JOIN Uczestnik ON Zg³oszenie_Uczestnika.id_uczestnika = Uczestnik.id_uczestnika
JOIN Wyjazd ON Zg³oszenia.id_wyjazdu = Wyjazd.id_wyjazdu
WHERE Wyjazd.id_wyjazdu = 1;

 -- 5. Zapytanie z podzapytaniem, funkcjami agreguj¹cymi: Liczba uczestników przypadaj¹cych na jednego opiekuna wyjazdu
 /*Poka¿ listê wyjazdów wraz z liczb¹ opiekunów i uczestników przypisanych do ka¿dego wyjazdu.
 Oblicz liczbê uczestników przypadaj¹cych na jednego opiekuna dla ka¿dego wyjazdu. 
 W przypadku braku opiekunów wyœwietl wartoœæ pust¹.*/
SELECT 
    Wyjazd.lokalizacja,
    Wyjazd.data_pocz¹tek,
    Wyjazd.data_koniec,
    -- Liczba opiekunów przypisanych do wyjazdu
    (SELECT COUNT(*) 
     FROM Opiekun_Wyjazdu 
     WHERE Opiekun_Wyjazdu.id_wyjazdu = Wyjazd.id_wyjazdu) AS liczba_opiekunów,
    -- Liczba uczestników przypisanych do wyjazdu
    (SELECT COUNT(*)
     FROM Zg³oszenie_Uczestnika
     JOIN Zg³oszenia ON Zg³oszenie_Uczestnika.id_zg³oszenia = Zg³oszenia.id_zg³oszenia
     WHERE Zg³oszenia.id_wyjazdu = Wyjazd.id_wyjazdu) AS liczba_uczestników,
    -- Obliczenie liczby uczestników na jednego opiekuna
    CASE 
        WHEN (SELECT COUNT(*) 
              FROM Opiekun_Wyjazdu 
              WHERE Opiekun_Wyjazdu.id_wyjazdu = Wyjazd.id_wyjazdu) = 0 THEN NULL
        ELSE 
            CAST(
                (SELECT COUNT(*)
                 FROM Zg³oszenie_Uczestnika
                 JOIN Zg³oszenia ON Zg³oszenie_Uczestnika.id_zg³oszenia = Zg³oszenia.id_zg³oszenia
                 WHERE Zg³oszenia.id_wyjazdu = Wyjazd.id_wyjazdu)
                AS FLOAT
            ) / 
            (SELECT COUNT(*) 
             FROM Opiekun_Wyjazdu 
             WHERE Opiekun_Wyjazdu.id_wyjazdu = Wyjazd.id_wyjazdu)
    END AS uczestnicy_na_opiekuna
FROM Wyjazd;

--6. Zapytanie z grupowaniem - iloœæ Uczestników, którzy maj¹ dane stopnie
/*Poka¿ liczbê uczestników na poszczególnych wyjazdach w zale¿noœci od ich stopnia (æwik, HO, HR) w celu dowiedzenia siê
ile uczestników mo¿e braæ udzia³ w zrzutach. 
Wyœwietl lokalizacjê wyjazdu, stopieñ uczestnika oraz liczbê uczestników dla ka¿dego stopnia.*/
SELECT 
    lokalizacja,
    stopieñ,
    COUNT(Uczestnik.id_uczestnika) AS liczba_uczestników
FROM 
    Wyjazd
    JOIN Zg³oszenia ON Wyjazd.id_wyjazdu = Zg³oszenia.id_wyjazdu
    JOIN Zg³oszenie_Uczestnika ON Zg³oszenia.id_zg³oszenia = Zg³oszenie_Uczestnika.id_zg³oszenia
    JOIN Uczestnik ON Zg³oszenie_Uczestnika.id_uczestnika = Uczestnik.id_uczestnika
WHERE 
    stopieñ IN ('æwik', 'HO', 'HR')
GROUP BY 
    lokalizacja, stopieñ;

-- 7. wykorzystanie widoku
SELECT 
    lokalizacja,
    data_pocz¹tek,
    data_koniec,
    data_harmonogramu
FROM WyjazdHarmonogram
WHERE data_harmonogramu BETWEEN '2024-01-01' AND '2024-05-31'
ORDER BY data_harmonogramu ASC;