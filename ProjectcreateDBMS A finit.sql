CREATE DATABASE LinjeFluturimi;
DROP DATABASE LinjeFluturimi

CREATE TABLE Pasagjer(
Id_P INT NOT NULL PRIMARY KEY IDENTITY,
IDRregjistrimi VARCHAR (50) NOT NULL UNIQUE,
Emer VARCHAR (50) NOT NULL ,
Mbiemri VARCHAR (50) NOT NULL ,
Email VARCHAR (50) NOT NULL UNIQUE,
NrCel INT  NOT NULL CONSTRAINT chk_phone CHECK (NrCel not like '%[^0-9]%')
);

CREATE TABLE Veprime(
Id_VP INT NOT NULL PRIMARY KEY IDENTITY , 
Veprimi VARCHAR (50) NOT NULL ,
Pagesa Float  NOT NULL 
);

CREATE TABLE PasVeprime(
Id_VP INT NOT NULL,
Id_P INT NOT NULL,
CONSTRAINT PK_PasVeprime PRIMARY KEY (Id_VP,Id_P),
CONSTRAINT FK_VP FOREIGN KEY(Id_VP) REFERENCES Veprime(Id_VP),
CONSTRAINT FK_P FOREIGN KEY(Id_P) REFERENCES Pasagjer(Id_P)
);

CREATE TABLE LinjeFluturimi(
Id_L INT NOT NULL PRIMARY KEY IDENTITY , 
Emer VARCHAR (50) NOT NULL 
);

CREATE TABLE Aeroport(
Id_Ae INT NOT NULL PRIMARY KEY IDENTITY , 
Emer VARCHAR (50) NOT NULL ,
Shtet VARCHAR (50) NOT NULL ,
Qytet VARCHAR (50) NOT NULL 
);

CREATE TABLE Avion(
Id_A INT NOT NULL PRIMARY KEY IDENTITY , 
Emer VARCHAR (50) NOT NULL ,
Lloji varchar (50)  NOT NULL ,
NrMotorrve INT  NOT NULL ,
Harxhimper100KM INT  NOT NULL ,
PeshaMax INT  NOT NULL ,
NrMaxVendesh INT  NOT NULL ,
Id_Ae INT FOREIGN KEY REFERENCES Aeroport (Id_Ae),
Id_L INT FOREIGN KEY REFERENCES LinjeFluturimi (Id_L)
);

CREATE TABLE [Status](
Id_S INT NOT NULL PRIMARY KEY IDENTITY , 
[Status] VARCHAR (50)  NOT NULL 
);

CREATE TABLE Fluturim(
Id_F INT NOT NULL PRIMARY KEY IDENTITY , 
VendNisje VARCHAR (50) NOT NULL ,
VendMberritje VARCHAR (50) NOT NULL ,
Id_S INT FOREIGN KEY REFERENCES Status (Id_S),
Id_A INT FOREIGN KEY REFERENCES Avion (Id_A)
); 

CREATE TABLE Bilete(
Id_B INT NOT NULL PRIMARY KEY IDENTITY , 
NrSerial INT  NOT NULL,
LlojiBagazhit VARCHAR (50) NOT NULL ,
LlojiBiletes VARCHAR (50) NOT NULL ,
DataNisjes DATE NOT NULL,
OrariNisjes TIME  NOT NULL ,
DataMberritjes Date NOT NULL,
OrariMberritjes TIME  NOT NULL ,
Id_P INT FOREIGN KEY REFERENCES Pasagjer (Id_P),
Id_F INT FOREIGN KEY REFERENCES Fluturim (Id_F)
);

CREATE TABLE Aeroport_LinjeFluturimi(
Id_Ae INT NOT NULL,
Id_L INT NOT NULL,
CONSTRAINT PK_Aeroport_LinjeFluturimi PRIMARY KEY (Id_Ae,Id_L),
CONSTRAINT FK_Ae FOREIGN KEY(Id_Ae) REFERENCES Aeroport(Id_Ae),
CONSTRAINT FK_L FOREIGN KEY(Id_L) REFERENCES LinjeFluturimi(Id_L)
);

CREATE TABLE Ad_Fizike(
Id_AF INT NOT NULL PRIMARY KEY IDENTITY , 
Shtet VARCHAR (50) NOT NULL ,
Qytet VARCHAR (50) NOT NULL 
);


CREATE TABLE Pilot(
Id_Pi INT NOT NULL PRIMARY KEY IDENTITY , 
NrIdentifikues VARCHAR (50) NOT NULL Unique   ,
Emer VARCHAR (50) NOT NULL ,
Mbiemer VARCHAR (50) NOT NULL ,
Gjini VARCHAR (50)  NOT NULL ,
Datelindje DATE  NOT NULL ,
Email VARCHAR (50)  NOT NULL UNIQUE ,
NrCEL INT  NOT NULL  CONSTRAINT chk_phone1 CHECK (NrCEL not like '%[^0-9]%'),
AdresaFizike varchar (50)  NOT NULL ,
Id_L INT FOREIGN KEY REFERENCES LinjeFluturimi (Id_L),
Id_AF INT FOREIGN KEY REFERENCES Ad_Fizike (Id_AF)
);




DROP TABLE PasVeprime
DROP TABLE Bilete
DROP TABLE Aeroport_LinjeFluturimi
DROP TABLE Pilot
DROP TABLE Pasagjer
DROP TABLE Veprime
DROP TABLE Fluturim
DROP TABLE Ad_Fizike
DROP TABLE Avion
DROP TABLE [Status]
DROP TABLE LinjeFluturimi
DROP TABLE Aeroport





