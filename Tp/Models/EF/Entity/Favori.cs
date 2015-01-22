using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;


namespace Tp.Models.EF
{
    public partial class Favori
    {
        //Recuperer les favoris par idClient
        public static List<Vehicule> RecupererFavoriParIdClient(int idClient)
        {
            List<Vehicule> listeFavori;
            if (idClient > 0)
            {
                using (DbConcessionnaireEntities1 db = new DbConcessionnaireEntities1())
                {
                    listeFavori = db.Vehicules.Where(i => i.Favoris.Any(m => m.IdClient == idClient)).ToList();
                }
            }
            else
            {
                listeFavori = new List<Vehicule>();
            }

            return listeFavori;
        }

        public static List<Favori> RecupererTousFavoris()
        {
            List<Favori> listefavori;

            using (DbConcessionnaireEntities1 db = new DbConcessionnaireEntities1())
            {
                listefavori = db.Favoris.OrderBy(m => m.IdClient).ToList();
            }

            if (listefavori == null)
            {
                listefavori = new List<Favori>();
            }

            return listefavori;
        }

        public static Boolean ValideUnFavori(int pIdVehicule)
        {
            List<Favori> listefavori = Favori.RecupererTousFavoris();




            foreach (Favori favori in listefavori)
            {
                if (favori.IdVehicule == pIdVehicule)
                {
                    return true;

                }

            }

            return false;


        }

        public static void Sauvegarder(int pIdVehicule)
        {
            Favori modelFavori = new Favori();

            modelFavori.IdVehicule = pIdVehicule;
            modelFavori.IdClient = pIdVehicule;

            using (DbConcessionnaireEntities1 db = new DbConcessionnaireEntities1())
            {

                db.Favoris.Attach(modelFavori);
                db.Favoris.Add(modelFavori);


                db.SaveChanges();
            }
        }

    }
}