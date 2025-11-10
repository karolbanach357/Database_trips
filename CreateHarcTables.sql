-- Tabela Rodzic
CREATE TABLE Rodzic (
    id_rodzica INT PRIMARY KEY CHECK (id_rodzica < 5000),
    imiê NVARCHAR(50) NOT NULL,
    nazwisko NVARCHAR(50) NOT NULL,
    telefon CHAR(9) CHECK (telefon LIKE '[0-9]%') UNIQUE
);

-- Tabela Uczestnik
CREATE TABLE Uczestnik (
    id_uczestnika INT PRIMARY KEY CHECK (id_uczestnika < 5000),
    imiê NVARCHAR(50) NOT NULL,
    nazwisko NVARCHAR(50) NOT NULL,
    data_urodzenia DATE NOT NULL,
    stopieñ NVARCHAR(50),
    telefon CHAR(9) CHECK (telefon LIKE '[0-9]%') UNIQUE,
    id_rodzica INT NOT NULL,
    FOREIGN KEY (id_rodzica) REFERENCES Rodzic(id_rodzica) ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE Uczestnik
ADD CONSTRAINT CK_Stopieñ CHECK (stopieñ IN ('brak','m³odzik', 'wywiadowca', 'æwik', 'HO', 'HR'));

-- Tabela Wyjazd
CREATE TABLE Wyjazd (
    id_wyjazdu INT PRIMARY KEY CHECK (id_wyjazdu < 500),
    lokalizacja NVARCHAR(100) NOT NULL,
    data_pocz¹tek DATE NOT NULL,
    data_koniec DATE NOT NULL,
    typ NVARCHAR(50) NOT NULL,
    min_iloœæ_miejsc INT NOT NULL,
    max_iloœæ_miejsc INT NOT NULL
);

-- Tabela Zg³oszenia
CREATE TABLE Zg³oszenia (
    id_zg³oszenia INT PRIMARY KEY CHECK (id_zg³oszenia < 50000),
    id_rodzica INT NOT NULL,
    id_wyjazdu INT NOT NULL,
    status NVARCHAR(20) NOT NULL,
    FOREIGN KEY (id_rodzica) REFERENCES Rodzic(id_rodzica) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_wyjazdu) REFERENCES Wyjazd(id_wyjazdu) ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE Zg³oszenia
ADD CONSTRAINT CK_Status CHECK (status IN ('odrzucone', 'zaakceptowane', 'oczekuje'));

-- Tabela Zg³oszenie_Uczestnika
CREATE TABLE Zg³oszenie_Uczestnika (
    id_zg³oszenia INT NOT NULL,
    id_uczestnika INT NOT NULL,
    PRIMARY KEY (id_zg³oszenia, id_uczestnika),
    FOREIGN KEY (id_zg³oszenia) REFERENCES Zg³oszenia(id_zg³oszenia) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_uczestnika) REFERENCES Uczestnik(id_uczestnika)
);

-- Tabela Opiekun
CREATE TABLE Opiekun (
    id_opiekuna INT PRIMARY KEY CHECK (id_opiekuna < 500),
    imiê NVARCHAR(50) NOT NULL,
    nazwisko NVARCHAR(50) NOT NULL,
    telefon CHAR(9) CHECK (telefon LIKE '[0-9]%') UNIQUE
);

-- Tabela Opiekun_Wyjazdu
CREATE TABLE Opiekun_Wyjazdu (
    id_opiekuna INT NOT NULL,
    id_wyjazdu INT NOT NULL,
    rola NVARCHAR(50) NOT NULL,
    PRIMARY KEY (id_opiekuna, id_wyjazdu),
    FOREIGN KEY (id_opiekuna) REFERENCES Opiekun(id_opiekuna) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_wyjazdu) REFERENCES Wyjazd(id_wyjazdu) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabela Harmonogram
CREATE TABLE Harmonogram (
    id_harmonogram INT PRIMARY KEY CHECK (id_harmonogram < 50000),
    id_wyjazdu INT NOT NULL,
    data DATE NOT NULL,
    FOREIGN KEY (id_wyjazdu) REFERENCES Wyjazd(id_wyjazdu) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabela Aktywnoœæ
CREATE TABLE Aktywnoœæ (
    id_aktywnosc INT PRIMARY KEY CHECK (id_aktywnosc < 100),
    miejsce NVARCHAR(100) NOT NULL,
    opis NVARCHAR(255)
);

-- Tabela Przebieg_Dnia
CREATE TABLE Przebieg_Dnia (
    id_harmonogram INT NOT NULL,
    id_aktywnosc INT NOT NULL,
    godzina_pocz¹tek TIME NOT NULL,
    godzina_koniec TIME NOT NULL,
    PRIMARY KEY (id_harmonogram, id_aktywnosc),
    FOREIGN KEY (id_harmonogram) REFERENCES Harmonogram(id_harmonogram) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_aktywnosc) REFERENCES Aktywnoœæ(id_aktywnosc) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabela Sprzêt
CREATE TABLE Sprzêt (
    id_sprzetu INT PRIMARY KEY CHECK (id_sprzetu < 100),
    nazwa_sprzêtu NVARCHAR(100) NOT NULL,
    iloœæ_sprzêtu INT NOT NULL
);

-- Tabela Potrzebny_Sprzêt
CREATE TABLE Potrzebny_Sprzêt (
    id_aktywnosc INT NOT NULL,
    id_sprzetu INT NOT NULL,
    iloœæ_potrzebnego_sprzetu INT NOT NULL,
    PRIMARY KEY (id_aktywnosc, id_sprzetu),
    FOREIGN KEY (id_aktywnosc) REFERENCES Aktywnoœæ(id_aktywnosc) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_sprzetu) REFERENCES Sprzêt(id_sprzetu) ON DELETE CASCADE ON UPDATE CASCADE
);
