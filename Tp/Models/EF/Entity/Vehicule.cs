using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace Tp.Models.EF
{
    [MetadataType(typeof(VehiculeMetaData))]
    public partial class Vehicule
    {
        //Recuperer tous les vehicules
        public static List<Vehicule> RecupererTousVehicule()
        {
            List<Vehicule> listeVehicule;

            using (DbConcessionnaireEntities1 db = new DbConcessionnaireEntities1())
            {
                listeVehicule = db.Vehicules.OrderBy(m => m.PrixVente).ToList();
            }

            if (listeVehicule == null)
            {
                listeVehicule = new List<Vehicule>();
            }

            return listeVehicule;
        }

        //Recuperer les vehicules selon une categorie donnée
        public static List<Vehicule> RecupererVehiculeParCategorie(int? pIdCategorie, DbConcessionnaireEntities1 pCurrentContext = null)
        {
            Boolean dbEstNull = false;

            if (pCurrentContext == null)
            {
                pCurrentContext = new DbConcessionnaireEntities1();
                dbEstNull = true;
            }

            List<Vehicule> listeVehicule = pCurrentContext.Vehicules.Where(i => i.IdCategorie == pIdCategorie).ToList();

            if (dbEstNull)
            {
                pCurrentContext.Dispose();
            }

            return listeVehicule;
        }

        //Recuperer un vehicule par son id
        public static Vehicule RecupererVehiculeParId(int? pIdVehicule, DbConcessionnaireEntities1 pDb = null)
        {
            Boolean dbEstNull = false;
            if (pDb == null)
            {
                pDb = new DbConcessionnaireEntities1();
                dbEstNull = true;
            }

            Vehicule vehicule = pDb.Vehicules.Where(i => i.IdVehicule == pIdVehicule).FirstOrDefault();

            if (dbEstNull)
            {
                pDb.Dispose();
            }

            return vehicule;
        }

        //Ajouter ou mettre a jour un vehicule
        public static void Sauvegarder(Vehicule pModelVehicule)
        {
            using (DbConcessionnaireEntities1 db = new DbConcessionnaireEntities1())
            {
                if (pModelVehicule.IdVehicule > 0)
                {
                    Vehicule vehiculeASauvegarder = RecupererVehiculeParId(pModelVehicule.IdVehicule, db);

                    vehiculeASauvegarder.Photo = pModelVehicule.Photo;
                    vehiculeASauvegarder.Photo1 = pModelVehicule.Photo1;
                    vehiculeASauvegarder.Photo2 = pModelVehicule.Photo2;
                    vehiculeASauvegarder.Photo3 = pModelVehicule.Photo3;
                    vehiculeASauvegarder.Photo4 = pModelVehicule.Photo4;
                    vehiculeASauvegarder.DescriptionVehicule = pModelVehicule.DescriptionVehicule;
                    vehiculeASauvegarder.PrixAchat = pModelVehicule.PrixAchat;
                    vehiculeASauvegarder.PrixVente = pModelVehicule.PrixVente;
                    vehiculeASauvegarder.QuantiteInventaire = pModelVehicule.QuantiteInventaire;
                }
                else
                {
                    db.Vehicules.Attach(pModelVehicule);
                    db.Vehicules.Add(pModelVehicule);
                }

                db.SaveChanges();
            }
        }

        //Suppimer un vehicule
        public static void Supprimer(int idVehicule)
        {
            using (DbConcessionnaireEntities1 db = new DbConcessionnaireEntities1())
            {
                Vehicule vehiculeASupprimer = RecupererVehiculeParId(idVehicule, db);

                db.Vehicules.Attach(vehiculeASupprimer);
                db.Vehicules.Remove(vehiculeASupprimer);

                db.SaveChanges();
            }
        }
    }

    public class VehiculeMetaData
    {

        [Required(ErrorMessage = "La marque est obligatoire")]
        [StringLength(50, MinimumLength = 3, ErrorMessage = "La marque doit contenir de 3 a 50 cartacteres")]
        public string Marque { get; set; }

        [Required(ErrorMessage = "La vitesse sur terre est obligatoire")]
        [Range(1, 500, ErrorMessage = "La vitesse sur terre doit etre comprise entre 1 et 500")]
        public int VitesseTerre { get; set; }

        [Required(ErrorMessage = "La vitesse sur l'eau est obligatoire")]
        [Range(1, 500, ErrorMessage = "La vitesse sur l'eau doit etre comprise entre 1 et 500")]
        public int VitesseEau { get; set; }

        [Required(ErrorMessage = "La description du vehicule est obligatoire")]
        public string DescriptionVehicule { get; set; }

        [Required(ErrorMessage = "L'année est obligatoire")]
        [Range(1950, 2100, ErrorMessage = "L'année doit etre comprises entre 1950 et cette année")]
        public string Apparition { get; set; }

        [Required(ErrorMessage = "Le fabricant est obligatoire")]
        [StringLength(50, MinimumLength = 3, ErrorMessage = "Le fabricant doit contenir de 3 a 50 cartacteres")]
        public string Fabricant { get; set; }

        [Required(ErrorMessage = "Le moteur est obligatoire")]
        [StringLength(50, MinimumLength = 3, ErrorMessage = "Le moteur doit contenir de 3 a 50 cartacteres")]
        public string Moteur { get; set; }

        [Required(ErrorMessage = "Le prix d'achat est obligatoire")]
        [Range(1.0, 5000000.0, ErrorMessage = "Le pris d'achat doit etre compris entre 1 et 5000000")]
        public decimal PrixAchat { get; set; }

        [Required(ErrorMessage = "Le prix de vente est obligatoire")]
        [Range(1.0, 6000000.0, ErrorMessage = "Le pris de vente doit etre compris entre 1 et 6000000")]
        public decimal PrixVente { get; set; }

        [Required(ErrorMessage = "La photo est obligatoire")]
        [StringLength(50, MinimumLength = 5, ErrorMessage = "La photo doit contenir de 5 a 50 cartacteres")]
        public string Photo { get; set; }

        [Required(ErrorMessage = "La photo est obligatoire")]
        [StringLength(50, MinimumLength = 5, ErrorMessage = "La photo doit contenir de 5 a 50 cartacteres")]
        public string Photo1 { get; set; }

        [Required(ErrorMessage = "La photo est obligatoire")]
        [StringLength(50, MinimumLength = 5, ErrorMessage = "La photo doit contenir de 5 a 50 cartacteres")]
        public string Photo2 { get; set; }

        [Required(ErrorMessage = "La photo est obligatoire")]
        [StringLength(50, MinimumLength = 5, ErrorMessage = "La photo doit contenir de 5 a 50 cartacteres")]
        public string Photo3 { get; set; }

        [Required(ErrorMessage = "La photo est obligatoire")]
        [StringLength(50, MinimumLength = 5, ErrorMessage = "La photo doit contenir de 5 a 50 cartacteres")]
        public string Photo4 { get; set; }

        [Required(ErrorMessage = "La quantité est obligatoire")]
        [Range(0, 100, ErrorMessage = "Le quantité doit etre comprise entre 0 et 100")]
        public string QuantiteInventaire { get; set; }

    }
}