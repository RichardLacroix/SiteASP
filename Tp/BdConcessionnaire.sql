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
	NomUtilisateur VARCHAR(25) NOT NULL,
	MotDePasse VARCHAR(25) NOT NULL,
	Courriel VARCHAR(50) NOT NULL,
	Telephone CHAR(12) NOT NULL CHECK (Telephone Like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
	NumeroCivique VARCHAR(10) NOT NULL,
	Rue VARCHAR(50) NOT NULL,
	Ville VARCHAR(50) NOT NULL,
	Province VARCHAR(25) NOT NULL,
	CodePostal CHAR(7) NOT NULL CHECK (CodePostal Like '[a-z][0-9][a-z]-[0-9][a-z][0-9]'),
	NumeroPermis VARCHAR(25) NOT NULL, 
	Sexe BIT NOT NULL,
	Photo VARCHAR(50) NULL
)

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[TypeComptes]'))
DROP TABLE [dbo].[TypeComptes]

CREATE TABLE TypeComptes
(
	IdCompte INT NOT NULL PRIMARY KEY IDENTITY,
	TypeCompte VARCHAR(20) NOT NULL
)

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[TypeComptesClients]'))
DROP TABLE [dbo].[TypeComptesClients]

CREATE TABLE TypeComptesClients
(
	IdCompte INT NOT NULL PRIMARY KEY IDENTITY,
	IdClient INT NOT NULL FOREIGN KEY REFERENCES Clients (IdClient),
	DateCreation DATETIME DEFAULT(GETDATE()),
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

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Paiements]'))
DROP TABLE [dbo].[Paiements]

CREATE TABLE Paiements
(
	IdPaiement INT NOT NULL PRIMARY KEY IDENTITY,
	IdVente INT NOT NULL FOREIGN KEY REFERENCES Ventes (IdVente),
	NumeroCarteCredit VARCHAR(25) NOT NULL,
	DateExpirationCarte DATETIME NOT NULL
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

/************************Insertion*****************************************/

INSERT INTO CategorieVehicules (NomCategorie) VALUES ('Voiture amphibie')
INSERT INTO CategorieVehicules (NomCategorie) VALUES ('Vehicule récréatif amphibie')
INSERT INTO CategorieVehicules (NomCategorie) VALUES ('Véhicule tout-terrain amphibie')

GO

INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('Aquada',160,50,'Contrairement à la plupart de ses devancières qui négligeaient quelque peu l’aspect esthétique,l’Aquada se distingue par un style particulièrement sportif.Malgré cela, on distingue clairement deux influences : au-dessus de la ligne de flottaison, les lignes ne sont pas sans rappeler l’allure de la Mazda MX-5.Surtout vue de l’avant.Tandis que les bas de caisse et les pare-chocs s’apparentant à une coque de navire.Cette impression est renforcée par la découpe de peinture bi-ton.Au delà de son physique plutôt aguicheur, l’Aquada se signale surtout par ses performances inédites pour le genre.Dotée du six cylindres 2.5 de 175 ch des Rover 45, MG, et Land Rover Freelander, (un bloc baptisé KV6, fourni par Powertrain Ltd, filiale de MG Rover Group), la Gibbs amphibie peut atteindre 160 km/h sur route et abattre le 0 à 100 km/h en 10 s et surtout franchir la barre des 50 km/h en mode "nautique" grâce à un système de propulsion à jet.Un rythme soutenu (correspondant à 27 nœuds) d’autant plus impressionnant que les précédents modèles n’avaient jusqu’alors jamais dépassé les 10 km/h (5,3 noeuds).
','2003','Gibbs Sports Amphibian','V6 2.5litres, 175 chevaux-vapeur',275000.00,200000.00,'GibbsAquada.jpg','GibbsAquada1.jpg','GibbsAquada2.jpg','GibbsAquada3.jpg','GibbsAquada4.jpg',30,1)
 
INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('Panther',130,70,'Le Panther de WaterCar, la compagnie dit s’être inspirée de l’emblématique Jeep CJ-8 pour dessiner le Panther, mais la forme est définitivement plus fluide et actuelle.Avec un poids de 3000 livres, la voiture-amphibie est considérée plutôt légère grâce à un châssis tubulaire fabriqué en acier léger et une carrosserie en fibre de carbone remplie de mousse de polystyrène à cellules fermées afin d’améliorer la flottabilité du Panther sur l’eau.Pouvant accueillir jusqu’à 4 passagers à son bord, le Panther dispose d’un ameublement haut de gamme avec un large éventail d’instruments analogiques intégrés dans la console centrale.La majorité des morceaux de finition de l’intérieur sont réalisés en acier inoxydable afin d’aider à prévenir la corrosion.Sous le capot se un moteur V6 Honda de 3,7 litres qui offre une puissance de 305 chevaux et un couple de 274 lb-pi.Cela permet de propulser le Panther à une vitesse maximale de 130 km/h sur le sol et jusqu’à 70 km/h sur l’eau.Cela fait de la voiture-amphibie la plus rapide au monde.Pour le penchant terrestre, on retrouve une transmission à 4 vitesse de Volkswagen et pour l’eau, une unité conçue par le constructeur.
','2014','WaterCar','V6 3.7 litres, 305 chevaux-vapeur par Honda',126000.00,100000.00,'WaterCar_Panther.jpg','WaterCar_Panther1.jpg','WaterCar_Panther2.jpg','WaterCar_Panther3.jpg','WaterCar_Panther4.jpg',100,1)
 
INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('Lotus Elise',150,80,'Voilà donc le rêve de Rinspeed réalisé puisque, pour 2008, il nous présente la sQuaba, une voiture pouvant se déplacer sur terre, sur l’eau et sous l’eau.Ce roadster, sans toit, livre des performances intéressantes puisqu’il peu boucler le  0 à 80 km/h en 7,1 secondes et atteindre une vitesse maximale de 150 km/h sur la route et de 3 km/h sous l’eau.La sQuba peut atteindre une profondeur de 10 mètres et se déplacer sous l’eau telle un poisson avec la grâce d’une voiture sport.Cette voiture zéro émission, dispose de trois moteurs électriques dont un pour animer les roues arrière sur terre et les deux autres afin d’alimenter les deux hélices situées à l’arrière. Afin de favoriser le contrôle à la verticale sous l’eau, deux turbines à jet situées sur les côtés de la voiture assurent une maniabilité accrue.Puisqu’il s’agit d’un roadster qui, donc, ne possède pas de toit, il ne faut pas avoir peur de se mouiller car seule la carrosserie est étanche. L’alimentation en oxygène des occupants est confiée à un système autonome intégré à l’habitacle lorsque le véhicule est sous l’eau.
','2008','Rinspeed','210 chevaux-vapeur par Lotus',230000.00,200000.00,'lotus-elise.jpg','lotus-elise1.jpg','lotus-elise2.jpg','lotus-elise3.jpg','lotus-elise4.jpg',50,1)
  
INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('Quadski',72,72,'Voici ce qui se passe quand un jet ski et un quad se rencontrent, le Quadski, un concept très étonnant mis au point par la société Gibbs Technologies, basée en Grande-Bretagne.Déjà connus pour leur Aquada, voiture amphibie high tech, ceux-ci n’évoluaient pas en terrain inconnu.On connaissait le quad et le jet ski mais les deux réunis en un même véhicule là par contre c’est nouveau. En apparence il s’agit d’un quad tout à fait normal mais en fait le Quadski peut se transformer en cinq secondes en jet ski par la simple pression d’un bouton sur le tableau de bord.Équipé d’un moteur de 140 chevaux, le Quadski peut atteindre la vitesse de 72 km/h, que ce soit en mode quad ou en mode jet ski.
','2014','Gibbs Sports Amphibian','4 cylindres, 140 chevaux-vapeur par BMW',40000.00,25000.00,'quadski.jpg','quadski1.jpg','quadski2.jpg','quadski3.jpg','quadski4.jpg',100,3)
 
INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('Terra wind',130,13,'Terra Wind est un camping-car grand luxe aussi à l’aise sur un lac que sur route.Il peut se déplacer à près de 130 Km/H sur le bitume et à environ 7 noeuds (13 Km/H environ) sur l’eau.Ce camping-car est construit en partie en fibre de verre renforcée contre-plaqué et coque fabriquée à partir d’éléments de charpente de qualité marine.Pour aller dans l’eau, il a besoin d’un quai de mise à l’eau (bande bétonnée en pente douce).A peine entré dans l’eau, deux énormes boudins gonflables le stabilisent.A l’arrière, il y a un ponton relevable électrique, pour faire accoster un jet-ski ou servant de plongeoir pour ses occupants.Côté aménagement intérieur, il est équipé d’un canapé cuir pleine fleur, un écran plat plasma de 42", un système de réception Tv par satellite In Motion (réception en roulant), une laveuse/sécheuse, etc…
','2014','Cool Amphibious Manufacturing International','Diesel, 330 chevaux-vapeur par Caterpillar',1000000.00,950000.00,'terraWind.jpg','terraWind1.jpg','terraWind2.jpg','terraWind3.jpg','terraWind4.jpg',20,2)

INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('Scamander',200,13,'De son vivant, Peter Wheeler aimait faire des courses en voiture sur circuit, faire de la chasse et également du hors piste.Avant de rendre l’âme, l’ex-gérant de la société anglaise TVR a imaginé un prototype de voiture lui permettant de combiner ses trois passions.Ainsi est née la Scamander RRV (Rapid Response Vehicle).C’est une voiture tout terrain prenant l’apparence d’une voiture de sport. Grâce à ses capacités, elle peut s’adapter à n’importe quelle surface.Ce n’est pas tout, c’est à la fois une voiture amphibie capable de se déplacer à la surface de l’eau comme sur la terre ferme.Le regretté Peter Wheeler est décédé en 2009 alors que Scamander RRV était encore au stade de concept, il n’a donc pas vu naître son projet.Reprenant le flambeau, sa femme et une équipe d’ingénieurs ont fait l’effort de réaliser le véhicule.Scamander RRV possède un moteur V6 de 300 chevaux.Réalisée avec de la mousse, du plastique et de l’aluminium, elle pèse uniquement 1200 kg.L’engin peut atteindre une vitesse maximale de 200Km/h et passe de 0 à 100 Km/h en huit secondes.
','2005','TVR','V6 3 litres, 275 chevaux-vapeur par Ford',280000.00,255000.00,'scamander.jpg','scamander1.jpg','scamander2.jpg','scamander3.jpg','scamander3.jpg',20,3)
  
INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('HydroCar',201,100,'Conçu et construit par Rick Dobbertin, le Hydrocar est une voiture amphibie qui se transforme pour être utilisé dans l’eau ou le sol avec un simple interrupteur.Le Hydrocar fait sa première apparition en Janvier 2004 qui sera présenté dans une édition de la revue Popular Mechanics "Pratiquement presque toutes les pièces ont été fabriquées à la main.Rick Dobbertin a passé neuf longues années et 18.800 heures pour terminer le Hydrocar.Il est alimenté par une Chevrolet 572-pouces cubes, qui produit 762 chevaux à 5800 tr / min et 712 livres de couple à 4200 tr / min pour une longueur de 22 pieds 4,5 pouces, une largeur sans les flotteurs auxiliaires de 8 pieds et de 10 pieds et 4 pouces avec flotteurs auxiliaires et une hauteur de 5 pieds et 3,5 pouces.
','1985','Dobbertin','9.37 litres, 762 chevaux-vapeur par Chevrolet',777000.00,750000.00,'HydroCar.jpg','scamander1.jpg','HydroCar2.jpg','HydroCar3.jpg','HydroCar4.jpg',20,1)

GO

INSERT INTO TypeComptes (TypeCompte) VALUES ('Entreprise')
INSERT INTO TypeComptes (TypeCompte) VALUES ('Personnel')
INSERT INTO TypeComptes (TypeCompte) VALUES ('EntreprisePlus')