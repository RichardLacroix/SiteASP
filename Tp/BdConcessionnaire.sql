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
INSERT INTO CategorieVehicules (NomCategorie) VALUES ('Vehicule r�cr�atif amphibie')
INSERT INTO CategorieVehicules (NomCategorie) VALUES ('V�hicule tout-terrain amphibie')

GO

INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('Aquada',160,50,'Contrairement � la plupart de ses devanci�res qui n�gligeaient quelque peu l�aspect esth�tique,l�Aquada se distingue par un style particuli�rement sportif.Malgr� cela, on distingue clairement deux influences : au-dessus de la ligne de flottaison, les lignes ne sont pas sans rappeler l�allure de la Mazda MX-5.Surtout vue de l�avant.Tandis que les bas de caisse et les pare-chocs s�apparentant � une coque de navire.Cette impression est renforc�e par la d�coupe de peinture bi-ton.Au del� de son physique plut�t aguicheur, l�Aquada se signale surtout par ses performances in�dites pour le genre.Dot�e du six cylindres 2.5 de 175 ch des Rover 45, MG, et Land Rover Freelander, (un bloc baptis� KV6, fourni par Powertrain Ltd, filiale de MG Rover Group), la Gibbs amphibie peut atteindre 160 km/h sur route et abattre le 0 � 100 km/h en 10 s et surtout franchir la barre des 50 km/h en mode "nautique" gr�ce � un syst�me de propulsion � jet.Un rythme soutenu (correspondant � 27 n�uds) d�autant plus impressionnant que les pr�c�dents mod�les n�avaient jusqu�alors jamais d�pass� les 10 km/h (5,3 noeuds).
','2003','Gibbs Sports Amphibian','V6 2.5litres, 175 chevaux-vapeur',275000.00,200000.00,'GibbsAquada.jpg','GibbsAquada1.jpg','GibbsAquada2.jpg','GibbsAquada3.jpg','GibbsAquada4.jpg',30,1)
 
INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('Panther',130,70,'Le Panther de WaterCar, la compagnie dit s��tre inspir�e de l�embl�matique Jeep CJ-8 pour dessiner le Panther, mais la forme est d�finitivement plus fluide et actuelle.Avec un poids de 3000 livres, la voiture-amphibie est consid�r�e plut�t l�g�re gr�ce � un ch�ssis tubulaire fabriqu� en acier l�ger et une carrosserie en fibre de carbone remplie de mousse de polystyr�ne � cellules ferm�es afin d�am�liorer la flottabilit� du Panther sur l�eau.Pouvant accueillir jusqu�� 4 passagers � son bord, le Panther dispose d�un ameublement haut de gamme avec un large �ventail d�instruments analogiques int�gr�s dans la console centrale.La majorit� des morceaux de finition de l�int�rieur sont r�alis�s en acier inoxydable afin d�aider � pr�venir la corrosion.Sous le capot se un moteur V6 Honda de 3,7 litres qui offre une puissance de 305 chevaux et un couple de 274 lb-pi.Cela permet de propulser le Panther � une vitesse maximale de 130 km/h sur le sol et jusqu�� 70 km/h sur l�eau.Cela fait de la voiture-amphibie la plus rapide au monde.Pour le penchant terrestre, on retrouve une transmission � 4 vitesse de Volkswagen et pour l�eau, une unit� con�ue par le constructeur.
','2014','WaterCar','V6 3.7 litres, 305 chevaux-vapeur par Honda',126000.00,100000.00,'WaterCar_Panther.jpg','WaterCar_Panther1.jpg','WaterCar_Panther2.jpg','WaterCar_Panther3.jpg','WaterCar_Panther4.jpg',100,1)
 
INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('Lotus Elise',150,80,'Voil� donc le r�ve de Rinspeed r�alis� puisque, pour 2008, il nous pr�sente la sQuaba, une voiture pouvant se d�placer sur terre, sur l�eau et sous l�eau.Ce roadster, sans toit, livre des performances int�ressantes puisqu�il peu boucler le  0 � 80 km/h en 7,1 secondes et atteindre une vitesse maximale de 150 km/h sur la route et de 3 km/h sous l�eau.La sQuba peut atteindre une profondeur de 10 m�tres et se d�placer sous l�eau telle un poisson avec la gr�ce d�une voiture sport.Cette voiture z�ro �mission, dispose de trois moteurs �lectriques dont un pour animer les roues arri�re sur terre et les deux autres afin d�alimenter les deux h�lices situ�es � l�arri�re. Afin de favoriser le contr�le � la verticale sous l�eau, deux turbines � jet situ�es sur les c�t�s de la voiture assurent une maniabilit� accrue.Puisqu�il s�agit d�un roadster qui, donc, ne poss�de pas de toit, il ne faut pas avoir peur de se mouiller car seule la carrosserie est �tanche. L�alimentation en oxyg�ne des occupants est confi�e � un syst�me autonome int�gr� � l�habitacle lorsque le v�hicule est sous l�eau.
','2008','Rinspeed','210 chevaux-vapeur par Lotus',230000.00,200000.00,'lotus-elise.jpg','lotus-elise1.jpg','lotus-elise2.jpg','lotus-elise3.jpg','lotus-elise4.jpg',50,1)
  
INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('Quadski',72,72,'Voici ce qui se passe quand un jet ski et un quad se rencontrent, le Quadski, un concept tr�s �tonnant mis au point par la soci�t� Gibbs Technologies, bas�e en Grande-Bretagne.D�j� connus pour leur Aquada, voiture amphibie high tech, ceux-ci n��voluaient pas en terrain inconnu.On connaissait le quad et le jet ski mais les deux r�unis en un m�me v�hicule l� par contre c�est nouveau. En apparence il s�agit d�un quad tout � fait normal mais en fait le Quadski peut se transformer en cinq secondes en jet ski par la simple pression d�un bouton sur le tableau de bord.�quip� d�un moteur de 140 chevaux, le Quadski peut atteindre la vitesse de 72 km/h, que ce soit en mode quad ou en mode jet ski.
','2014','Gibbs Sports Amphibian','4 cylindres, 140 chevaux-vapeur par BMW',40000.00,25000.00,'quadski.jpg','quadski1.jpg','quadski2.jpg','quadski3.jpg','quadski4.jpg',100,3)
 
INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('Terra wind',130,13,'Terra Wind est un camping-car grand luxe aussi � l�aise sur un lac que sur route.Il peut se d�placer � pr�s de 130 Km/H sur le bitume et � environ 7 noeuds (13 Km/H environ) sur l�eau.Ce camping-car est construit en partie en fibre de verre renforc�e contre-plaqu� et coque fabriqu�e � partir d��l�ments de charpente de qualit� marine.Pour aller dans l�eau, il a besoin d�un quai de mise � l�eau (bande b�tonn�e en pente douce).A peine entr� dans l�eau, deux �normes boudins gonflables le stabilisent.A l�arri�re, il y a un ponton relevable �lectrique, pour faire accoster un jet-ski ou servant de plongeoir pour ses occupants.C�t� am�nagement int�rieur, il est �quip� d�un canap� cuir pleine fleur, un �cran plat plasma de 42", un syst�me de r�ception Tv par satellite In Motion (r�ception en roulant), une laveuse/s�cheuse, etc�
','2014','Cool Amphibious Manufacturing International','Diesel, 330 chevaux-vapeur par Caterpillar',1000000.00,950000.00,'terraWind.jpg','terraWind1.jpg','terraWind2.jpg','terraWind3.jpg','terraWind4.jpg',20,2)

INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('Scamander',200,13,'De son vivant, Peter Wheeler aimait faire des courses en voiture sur circuit, faire de la chasse et �galement du hors piste.Avant de rendre l��me, l�ex-g�rant de la soci�t� anglaise TVR a imagin� un prototype de voiture lui permettant de combiner ses trois passions.Ainsi est n�e la Scamander RRV (Rapid Response Vehicle).C�est une voiture tout terrain prenant l�apparence d�une voiture de sport. Gr�ce � ses capacit�s, elle peut s�adapter � n�importe quelle surface.Ce n�est pas tout, c�est � la fois une voiture amphibie capable de se d�placer � la surface de l�eau comme sur la terre ferme.Le regrett� Peter Wheeler est d�c�d� en 2009 alors que Scamander RRV �tait encore au stade de concept, il n�a donc pas vu na�tre son projet.Reprenant le flambeau, sa femme et une �quipe d�ing�nieurs ont fait l�effort de r�aliser le v�hicule.Scamander RRV poss�de un moteur V6 de 300 chevaux.R�alis�e avec de la mousse, du plastique et de l�aluminium, elle p�se uniquement 1200 kg.L�engin peut atteindre une vitesse maximale de 200Km/h et passe de 0 � 100 Km/h en huit secondes.
','2005','TVR','V6 3 litres, 275 chevaux-vapeur par Ford',280000.00,255000.00,'scamander.jpg','scamander1.jpg','scamander2.jpg','scamander3.jpg','scamander3.jpg',20,3)
  
INSERT INTO Vehicules (Marque,VitesseTerre,VitesseEau,DescriptionVehicule,Apparition,Fabricant,Moteur,PrixVente,PrixAchat,Photo,Photo1,Photo2,Photo3,Photo4,QuantiteInventaire,IdCategorie)
VALUES ('HydroCar',201,100,'Con�u et construit par Rick Dobbertin, le Hydrocar est une voiture amphibie qui se transforme pour �tre utilis� dans l�eau ou le sol avec un simple interrupteur.Le Hydrocar fait sa premi�re apparition en Janvier 2004 qui sera pr�sent� dans une �dition de la revue Popular Mechanics "Pratiquement presque toutes les pi�ces ont �t� fabriqu�es � la main.Rick Dobbertin a pass� neuf longues ann�es et 18.800 heures pour terminer le Hydrocar.Il est aliment� par une Chevrolet 572-pouces cubes, qui produit 762 chevaux � 5800 tr / min et 712 livres de couple � 4200 tr / min pour une longueur de 22 pieds 4,5 pouces, une largeur sans les flotteurs auxiliaires de 8 pieds et de 10 pieds et 4 pouces avec flotteurs auxiliaires et une hauteur de 5 pieds et 3,5 pouces.
','1985','Dobbertin','9.37 litres, 762 chevaux-vapeur par Chevrolet',777000.00,750000.00,'HydroCar.jpg','scamander1.jpg','HydroCar2.jpg','HydroCar3.jpg','HydroCar4.jpg',20,1)

GO

INSERT INTO TypeComptes (TypeCompte) VALUES ('Entreprise')
INSERT INTO TypeComptes (TypeCompte) VALUES ('Personnel')
INSERT INTO TypeComptes (TypeCompte) VALUES ('EntreprisePlus')