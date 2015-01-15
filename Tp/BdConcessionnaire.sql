USE master

--Verifier si la bd existe et si il y a lieu la detruire avant la creation de la nouvelle
IF EXISTS (SELECT * FROM sysdatabases WHERE name = 'DbConcessionnaire')
	DROP DATABASE DbConcessionnaire
	
--**********CREATION DE LA BASE DE DONNEES**********
CREATE DATABASE DbConcessionnaire
 
GO
 
USE DbConcessionnaire

--**********CREATION DES TABLES**********
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Clients]'))
DROP TABLE [dbo].[Clients]


CREATE TABLE Clients
(
	IdClient INT NOT NULL PRIMARY KEY IDENTITY,
	Nom VARCHAR(25) NOT NULL,
	Prenom VARCHAR(25) NOT NULL,
	MotDePasse VARCHAR(25) NOT NULL,
	Courriel VARCHAR(50) NOT NULL,
	Telephone CHAR(12) NOT NULL CHECK (Telephone Like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
	NumeroCivique VARCHAR(10) NOT NULL,
	Rue VARCHAR(50) NOT NULL,
	Ville VARCHAR(50) NOT NULL,
	Province VARCHAR(25) NOT NULL,
	CodePostal CHAR(7) NOT NULL CHECK (CodePostal Like '[a-z][0-9][a-z]-[0-9][a-z][0-9]'),
	NumeroPermis VARCHAR(25) NOT NULL, 
	NumeroCarteCredit VARCHAR(25) NOT NULL,
	DateExpirationCarte DATETIME NOT NULL,
	Sexe BIT NOT NULL,
	Photo VARCHAR(50) NULL
)

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[TypeComptes]'))
DROP TABLE [dbo].[TypeComptes]

CREATE TABLE TypeComptes
(
	IdCompte INT NOT NULL PRIMARY KEY IDENTITY,
	TypeCompte VARCHAR(20) NOT NULL,
	DateCreation DATETIME DEFAULT(GETDATE())
)

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[TypeComptesClients]'))
DROP TABLE [dbo].[TypeComptesClients]

CREATE TABLE TypeComptesClients
(
	IdCompte INT NOT NULL PRIMARY KEY IDENTITY,
	IdClient INT NOT NULL FOREIGN KEY REFERENCES Clients (IdClient),
	CONSTRAINT FK_TypeComptes FOREIGN KEY (IdCompte) REFERENCES TypeComptes (IdCompte)
)

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CategorieVehicules]'))
DROP TABLE [dbo].[CategorieVehicules]

CREATE TABLE CategorieVehicules
(
	IdCategorie INT NOT NULL PRIMARY KEY IDENTITY,
	NomCategorie VARCHAR(50) NOT NULL
)

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Vehicules]'))
DROP TABLE [dbo].[Vehicules]

CREATE TABLE Vehicules
(
	IdVehicule INT NOT NULL PRIMARY KEY IDENTITY,
	Marque VARCHAR(50) NOT NULL,
	VitesseTerre INT NOT NULL,
	VitesseEau INT NOT NULL,
	DescriptionVehicule VARCHAR(MAX) NOT NULL,
	Apparition Char(4) NOT NULL,
	Fabricant VARCHAR(50) NOT NULL,
	Moteur VARCHAR(50) NOT NULL,
	PrixVente DECIMAL (16,2) NOT NULL,
	PrixAchat DECIMAL (16,2) NOT NULL,
	Photo VARCHAR(50) NOT NULL,
	Photo1 VARCHAR(50) NOT NULL,
	Photo2 VARCHAR(50) NOT NULL,
	Photo3 VARCHAR(50) NOT NULL,
	Photo4 VARCHAR(50) NOT NULL,
	QuantiteInventaire INT NOT NULL,
	IdCategorie INT NOT NULL FOREIGN KEY REFERENCES CategorieVehicules (IdCategorie)
)

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Ventes]'))
DROP TABLE [dbo].[Ventes]

CREATE TABLE Ventes
(
	IdVente INT NOT NULL PRIMARY KEY IDENTITY,
	IdVehicule INT NOT NULL FOREIGN KEY REFERENCES Vehicules (IdVehicule),
	IdClient INT NOT NULL FOREIGN KEY REFERENCES Clients (IdClient),
	DateVente DATETIME DEFAULT(GETDATE()),
	PrixVente DECIMAL (16,2) NOT NULL,
	Quantite INT NOT NULL
)

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Commentaires]'))
DROP TABLE [dbo].[Commentaires]

CREATE TABLE Commentaires
(
	IdCommentaire INT NOT NULL PRIMARY KEY IDENTITY,
	IdVehicule INT NOT NULL FOREIGN KEY REFERENCES Vehicules (IdVehicule),
	IdClient INT NOT NULL FOREIGN KEY REFERENCES Clients (IdClient),
	DateCommentaire DATETIME DEFAULT(GETDATE()),
	Cote INT NULL CHECK (Cote > 0 AND Cote <= 5),
	Commentaire VARCHAR(Max) NULL
)

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Favoris]'))
DROP TABLE [dbo].[Favoris]

CREATE TABLE Favoris
(
	IdFavoris INT PRIMARY KEY IDENTITY,
	IdVehicule INT NOT NULL FOREIGN KEY REFERENCES Vehicules (IdVehicule),
	IdClient INT NOT NULL FOREIGN KEY REFERENCES Clients (IdClient)
)

GO

INSERT INTO CategorieVehicules (NomCategorie) VALUES ('Voiture amphibie')
INSERT INTO CategorieVehicules (NomCategorie) VALUES ('Vehicule récréatif amphibie')
INSERT INTO CategorieVehicules (NomCategorie) VALUES ('Véhicule tout-terrain amphibie')

GO

INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('Aquada',160,50,'Vehicule1','2003','Gibbs Sports Amphibian','V6, 175 chevaux-vapeur',275000.00,200000.00,'GibbsAquada.jpg','GibbsAquada1.jpg','GibbsAquada2.jpg','GibbsAquada3.jpg','GibbsAquada4.jpg',30,1)
INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('Panther',130,70,'Vehicule2','2014','WaterCar','V6 3.7 litres,250 chevaux-vapeur par Honda',126000.00,100000.00,'WaterCar_Panther.jpg','WaterCar_Panther1.jpg','WaterCar_Panther2.jpg','WaterCar_Panther3.jpg','WaterCar_Panther4.jpg',100,1)
INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('Lotus Elise',150,80,'Vehicule3','2006','Lotus','210 chevaux-vapeur par Lotus',230000.00,200000.00,'lotus-elise.jpg','lotus-elise1.jpg','lotus-elise2.jpg','lotus-elise3.jpg','lotus-elise4.jpg',50,1)
INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('Quadski',72,72,'Vehicule4','2014','Gibbs Sports Amphibian','4 cylindres, 140 chevaux-vapeur par BMW',40000.00,25000.00,'quadski.jpg','quadski1.jpg','quadski2.jpg','quadski3.jpg','quadski4.jpg',100,3)
INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('Terra wind',130,13,'Vehicule5','2014','Cool Amphibious Manufacturing International','Diesel, 330 chevaux-vapeur par Caterpillar',1000000.00,950000.00,'terraWind.jpg','terraWind1.jpg','terraWind2.jpg','terraWind3.jpg','terraWind4.jpg',20,2)
INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('Scamander',191,13,'Vehicule6','2005','TVR','V6 3 litres, 275 chevaux-vapeur par Ford',280000.00,255000.00,'scamander.jpg','scamander1.jpg','scamander2.jpg','scamander3.jpg','scamander3.jpg',20,3)
INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('HydroCar',201,100,'Vehicule7','1985','Dobbertin','9.37 litres, 762 chevaux-vapeur par Chevrolet',777000.00,750000.00,'HydroCar.jpg','scamander1.jpg','HydroCar2.jpg','HydroCar3.jpg','HydroCar4.jpg',20,1)