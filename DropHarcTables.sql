-- Usuwanie tabel w odpowiedniej kolejnoœci
IF OBJECT_ID('dbo.Potrzebny_Sprzêt', 'U') IS NOT NULL
    DROP TABLE dbo.Potrzebny_Sprzêt;

IF OBJECT_ID('dbo.Przebieg_Dnia', 'U') IS NOT NULL
    DROP TABLE dbo.Przebieg_Dnia;

IF OBJECT_ID('dbo.Sprzêt', 'U') IS NOT NULL
    DROP TABLE dbo.Sprzêt;

IF OBJECT_ID('dbo.Aktywnoœæ', 'U') IS NOT NULL
    DROP TABLE dbo.Aktywnoœæ;

IF OBJECT_ID('dbo.Harmonogram', 'U') IS NOT NULL
    DROP TABLE dbo.Harmonogram;

IF OBJECT_ID('dbo.Opiekun_Wyjazdu', 'U') IS NOT NULL
    DROP TABLE dbo.Opiekun_Wyjazdu;

IF OBJECT_ID('dbo.Opiekun', 'U') IS NOT NULL
    DROP TABLE dbo.Opiekun;

IF OBJECT_ID('dbo.Zg³oszenie_Uczestnika', 'U') IS NOT NULL
    DROP TABLE dbo.Zg³oszenie_Uczestnika;

IF OBJECT_ID('dbo.Zg³oszenia', 'U') IS NOT NULL
    DROP TABLE dbo.Zg³oszenia;

IF OBJECT_ID('dbo.Wyjazd', 'U') IS NOT NULL
    DROP TABLE dbo.Wyjazd;

IF OBJECT_ID('dbo.Uczestnik', 'U') IS NOT NULL
    DROP TABLE dbo.Uczestnik;

IF OBJECT_ID('dbo.Rodzic', 'U') IS NOT NULL
    DROP TABLE dbo.Rodzic;