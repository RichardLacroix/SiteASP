using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Tp.Models.EF
{
    public partial class CategorieVehicule
    {
        public static List<CategorieVehicule> RecupererTouteCategorie()
        {
            List<CategorieVehicule> listeVehicule;

            using (DbConcessionnaireEntities1 db = new DbConcessionnaireEntities1())
            {
                listeVehicule = db.CategorieVehicules.OrderBy(m => m.IdCategorie).ToList();
            }

            if (listeVehicule == null)
            {
                listeVehicule = new List<CategorieVehicule>();
            }

            return listeVehicule;
        }

        public static CategorieVehicule GetById(int pId, DbConcessionnaireEntities1 pDb = null)
        {
            //Option de recevoir le context courant ou pas. 
            //Pour vouloire faire une mise a jour il faut le meme context que celui on fait un db.SaveChanges();
            Boolean dbWasNull = false;
            if (pDb == null)
            {
                pDb = new DbConcessionnaireEntities1();
                dbWasNull = true;
            }
            //Recuperer l'item dans la BD
            CategorieVehicule item = pDb.CategorieVehicules.Where(i => i.IdCategorie == pId).FirstOrDefault();

            if (dbWasNull)
            {
                //On doit faire un dispose car on n'a pas utiliser le using.
                pDb.Dispose();
            }

            return item;

        }

        public static void Delete(int id)
        {
            using (DbConcessionnaireEntities1 db = new DbConcessionnaireEntities1())
            {
                //TODO: delete

                db.SaveChanges();
            }
        }

        public static void Save(CategorieVehicule pModelForm)
        {
            using (DbConcessionnaireEntities1 db = new DbConcessionnaireEntities1())
            {
                //Edit
                if (pModelForm.IdCategorie > 0)
                {
                    CategorieVehicule catToSave = GetById(pModelForm.IdCategorie, db);
                    catToSave.NomCategorie = pModelForm.NomCategorie;

                }
                else
                { //New

                    //Init des navigate properties (si il y a lieu)
                    db.CategorieVehicules.Add(pModelForm);

                }

                db.SaveChanges();
            }
        }

        public class ProduitMetaData
        {
            [Display(Name = "Nom Categorie")]
            [Required(ErrorMessage = "Nom Categorie obligatoire")]
            public string NomCategorie { get; set; }
        }
    }
}