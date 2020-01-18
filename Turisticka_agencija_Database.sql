--relaciona
CREATE DATABASE Turisticka_Agencija
GO

USE Turisticka_Agencija
GO

CREATE TABLE Menadzer
(

MenadzerID INT PRIMARY KEY IDENTITY(1,1) CONSTRAINT PK_MenadzerID not null,
Ime  nvarchar(50) not null,
Prezime  nvarchar(50) not null,
DatumRodjenja date not null,
Spol nvarchar(7) not null,
Email nvarchar(50) not null,
JMBG NVARCHAR(13) CONSTRAINT UQ_JMBG UNIQUE NOT NULL,
BrojTelefona nvarchar(30) not null,
Licenca nvarchar(30) not null,
Fakultet nvarchar(50) not null
)


CREATE TABLE Vodic
(
VodicID INT PRIMARY KEY IDENTITY(1,1) CONSTRAINT PK_VodicID not null,
Ime  nvarchar(50) not null,
Prezime  nvarchar(50) not null,
DatumRodjenja date not null,
Spol nvarchar(7) not null,
Email nvarchar(50) not null,
JMBG NVARCHAR(13) CONSTRAINT UQ_JMBGVodic UNIQUE NOT NULL,
BrojTelefona nvarchar(30) not null
)


CREATE TABLE Vozac
(
VozacID INT PRIMARY KEY IDENTITY(1,1) CONSTRAINT PK_VozacID not null,
Ime  nvarchar(50) not null,
Prezime  nvarchar(50) not null,
DatumRodjenja date not null,
Spol nvarchar(7) not null,
Email nvarchar(50) not null,
JMBG NVARCHAR(13) CONSTRAINT UQ_JMBGVOzac UNIQUE NOT NULL,
BrojTelefona nvarchar(30) not null,
)

CREATE TABLE TipVozila
(
	TipID  INT PRIMARY KEY IDENTITY(1,1) CONSTRAINT PK_VoziloID not null,
	Naziv  nvarchar(50) not null,
)

CREATE TABLE Vozilo
(
 VoziloID INT PRIMARY KEY IDENTITY(1,1) CONSTRAINT PK_VoziloID not null,
TipID INT CONSTRAINT FK_TipID FOREIGN KEY REFERENCES TipVozila(TipID),
Registracija  nvarchar(50) not null,
Marka nvarchar(20) not null
)

Create table Mjesto
(
MjestoID INT PRIMARY KEY IDENTITY(1,1) CONSTRAINT PK_MjestoID not null,
Drzava nvarchar(30) not null,
Grad nvarchar(30) not null
)

Create table Smjestaj 
(
SmjestajID INT PRIMARY KEY IDENTITY(1,1) CONSTRAINT PK_SmjestajID not null,
MjestoID INT CONSTRAINT FK_MjestoID FOREIGN KEY REFERENCES Mjesto(MjestoID),
Naziv nvarchar(50) not null,
VrstaSmjestaja nvarchar(30) not null,
Cijena decimal(12,2) not null,
Adresa nvarchar(50) not null,
Webstranica nvarchar(60),
wi_fi bit 
)

CREATE TABLE Putnik 
(
PutnikID INT PRIMARY KEY IDENTITY(1,1) CONSTRAINT PK_PutnikID not null,
BrojPasosa nvarchar(30) not null,
BrojTelefona nvarchar(20) not null,
Ime nvarchar(50) not null,
Prezime nvarchar(50) not null,
Adresa nvarchar(30),
Email nvarchar(40) not null,
Spol nvarchar(7) not null,
Starost int not null
)
create table Aranzman
(
AranzmanID INT PRIMARY KEY IDENTITY(1,1) CONSTRAINT PK_AranzmanID not null,
SmjestajID INT CONSTRAINT FK_SmjestajID FOREIGN KEY REFERENCES Smjestaj(SmjestajID),
MenadzerID INT CONSTRAINT FK_MenadzerID FOREIGN KEY REFERENCES Menadzer(MenadzerID),
NazivAranzmana nvarchar(50) not null,
Cijena decimal(12,2) not null,
DatumOD date not null,
DatumDO date not null,
Aktivnost bit not null,
Viza bit not null,
)


CREATE TABLE Aranzman_Organizacija
(
OrganizacijaID INT PRIMARY KEY IDENTITY(1,1) CONSTRAINT PK_OrganizacijaID NOT NULL,
AranzmanID INT CONSTRAINT FK_AranzmanID FOREIGN KEY REFERENCES Aranzman(AranzmanID),
VodicID INT CONSTRAINT FK_VodicID FOREIGN KEY REFERENCES Vodic(VodicID),
VozacID INT CONSTRAINT FK_VozacID FOREIGN KEY REFERENCES Vozac(VozacID),
VoziloID INT CONSTRAINT FK_VoziloID  FOREIGN KEY REFERENCES Vozilo(VoziloID),
DatumZaduzenja DATE not null
)

CREATE TABLE Rezervacija
(
  RezervacijaID INT PRIMARY KEY IDENTITY(1,1) CONSTRAINT PK_RezervacijaID not null,
AranzmanID INT CONSTRAINT FK_AranzmanRezervacijaID FOREIGN KEY REFERENCES Aranzman(AranzmanID),
PutnikID INT CONSTRAINT FK_PutnikRezervacijaID FOREIGN KEY REFERENCES Putnik(PutnikID),
DatumRezervacija date not null,
TipSobe nvarchar(50) not null,

)

CREATE TABLE Recenzije
(
	RecenzijaID INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_Recenzije PRIMARY KEY(RecenzijaID),
	PutnikID INT NOT NULL CONSTRAINT FK_TuristiVodiciKomentari_Turisti FOREIGN KEY REFERENCES Putnik(PutnikID),
	AranzmanID INT NULL CONSTRAINT FK_Recenzije_AranzmanID FOREIGN KEY REFERENCES Aranzman(AranzmanID),
	VodicID INT NULL CONSTRAINT FK_Recenzije_VodicID FOREIGN KEY REFERENCES Vodic(VodicID),
	Komentar NVARCHAR(MAX) NULL,
	Ocjena INT NULL,
	DatumKomentara DATETIME NOT NULL DEFAULT SYSDATETIME()
)

