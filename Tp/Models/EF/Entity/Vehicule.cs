using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Tp.Models.EF
{
    public partial class Vehicule
    {
        //Recuperer liste de vehicule par categorie
        public static List<Vehicule> RecupererVehiculeParCategorie(int idCategorie)
        {
            List<Vehicule> vehicule = null;
            using (DbConcessionnaireEntities db = new DbConcessionnaireEntities())
            {
                vehicule = db.Vehicules.Where(i => i.IdCategorie == idCategorie).ToList();   
            }
            return vehicule;
        }

        //Recuperer un vehicule par son id
        public static Vehicule RecupererVehiculeParId(int id, DbConcessionnaireEntities db = null)
        { 
            Boolean dbEstNull = false;
            if (db == null)
            {
                db = new DbConcessionnaireEntities();
                dbEstNull = true;
            }
            
            Vehicule vehicule = db.Vehicules.Where(i => i.IdVehicule == id).FirstOrDefault();

            if (dbEstNull)
            {
                db.Dispose();
            }

            return vehicule;
        }

        //Supprimer un vehicule
        public static void SupprimerVehicule(int id)
        {
            using (DbConcessionnaireEntities db = new DbConcessionnaireEntities())
            {
                Vehicule vehicule = RecupererVehiculeParId(id, db);
               // db.Vehicules.DeleteObject(vehicule);

                db.SaveChanges();
            }
        }

        //Recuperer tous les vehicule
        public static List<Vehicule> Recuperer()
        {
            using (DbConcessionnaireEntities bd = new DbConcessionnaireEntities())
            {
                List<Vehicule> lstVehicule = bd.Vehicules.ToList();
            }
            return null;
        }

        //Ajouter et mise a jour d'un vehicule
        public static void AjoutMiseAJourVehicule(Vehicule vehiculemodeleForm)
        {
            using (DbConcessionnaireEntities db = new DbConcessionnaireEntities())
            {
                if (vehiculemodeleForm.IdVehicule > 0)
                {
                    Vehicule vehiculeMettreAJour = RecupererVehiculeParId(vehiculemodeleForm.IdVehicule, db);
                    vehiculeMettreAJour.Photo = vehiculemodeleForm.Photo;
                    vehiculeMettreAJour.Photo1 = vehiculemodeleForm.Photo1;
                    vehiculeMettreAJour.Photo2 = vehiculemodeleForm.Photo2;
                    vehiculeMettreAJour.Photo3 = vehiculemodeleForm.Photo3;
                    vehiculeMettreAJour.PrixAchat = vehiculemodeleForm.PrixAchat;
                    vehiculeMettreAJour.PrixVente = vehiculemodeleForm.PrixVente;
                    vehiculeMettreAJour.QuantiteInventaire = vehiculemodeleForm.QuantiteInventaire;
                }
                else
                { 
                   // db.Vehicules.AddObject(vehiculemodeleForm);
                }
                db.SaveChanges();
            }
        }
    }
}