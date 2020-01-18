

--DW
create database Turisticka_Agencija_DW
go
use Turisticka_Agencija_DW

CREATE TABLE DimVrijeme
(
	VrijemeKey NVARCHAR(8) NOT NULL CONSTRAINT PK_DimVrijeme PRIMARY KEY(VrijemeKey),
	VrijemeAltKey DATE NOT NULL,
	Dan INT NOT NULL,
	Mjesec INT NOT NULL,
	Godina INT NOT NULL,
	NazivMjeseca NVARCHAR(10) NOT NULL,
	NazivDana NVARCHAR(12) NOT NULL,
	Kvartal INT NOT NULL
)
GO

CREATE TABLE DimAranzman
(
	AranzmanKey INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_DimAranzman PRIMARY KEY(AranzmanKey),
	AranzmanAltKey INT NOT NULL,
	NazivAranzmana NVARCHAR(50) NOT NULL,
	Smjestaj NVARCHAR(50) NOT NULL,
	Prevoz NVARCHAR (50) NOT NULL
)
GO



CREATE TABLE DimLokacija
(
	LokacijaKey INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_DimLokacija PRIMARY KEY(LokacijaKey),
	LokacijaAltKey INT NOT NULL,
	Drzava NVARCHAR(30) NOT NULL,
	Grad NVARCHAR(30) NOT NULL,
)
GO


drop table DimPutnici
CREATE TABLE DimPutnici
(
	PutnikKey INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_DimPutnici PRIMARY KEY(PutnikKey),
	PutnikAltKey INT NOT NULL,
	ImePrezime NVARCHAR(70) NOT NULL,
	Spol NVARCHAR(7) NOT NULL,
	Godine NVARCHAR(20) NOT NULL
)
GO



drop table FactRezervacija
CREATE TABLE FactRezervacija
(
	RezervacijaKey INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_FactRezervacija PRIMARY KEY(RezervacijaKey),
	VrijemeKey NVARCHAR(8) NOT NULL CONSTRAINT FK_FactRecenzije_DimVrijeme FOREIGN KEY(VrijemeKey) REFERENCES DimVrijeme(VrijemeKey),
	AranzmanKey INT NOT NULL CONSTRAINT FK_FactRecenzije_DimPutovanja FOREIGN KEY(AranzmanKey) REFERENCES DimAranzman(AranzmanKey),
	LokacijaKey INT NOT NULL CONSTRAINT FK_FactRecenzije_DimTuristi FOREIGN KEY(LokacijaKey) REFERENCES DimLokacija(LokacijaKey),
	PutnikKey INT NOT NULL CONSTRAINT FK_FactRecenzije_DimZaposlenici FOREIGN KEY(PutnikKey) REFERENCES DimPutnici(PutnikKey),
	CijenaAranzmana DECIMAL(12,2) NOT NULL,

)
GO