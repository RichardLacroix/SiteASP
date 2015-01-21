using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Tp.Models.EF
{
    public partial class Favori
    {
        //Recuperer les favoris par idClient
        public static List<Vehicule> RecupererFavoriParIdClient(int? idClient)
        {
            List<Vehicule> vehicule = new List<Vehicule>();
            List<Favori> listeFavori;
            if (idClient > 0)
            {
                using (DbConcessionnaireEntities db = new DbConcessionnaireEntities())
                {
                    listeFavori = db.Favoris.Where(i => i.IdClient == idClient).ToList();

                    
                }
            }
            else
            {
                listeFavori = new List<Favori>();  
            }


            return vehicule;
        }
        
     }
}