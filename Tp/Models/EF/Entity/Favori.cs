using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Tp.Models.EF
{
    public partial class Favori
    {
        //Recuperer les favoris par idClient
        public static List<Favori> RecupererFavoriParIdClient(int? idClient)
        {
            List<Vehicule> vehicule = new List<Vehicule>();
            List<Favori> listeFavori;
            if (idClient > 0)
            {
                using (DbConcessionnaireEntities111 db = new DbConcessionnaireEntities111())
                {
                    listeFavori = db.Favoris.Where(i => i.IdClient == idClient).ToList();

                    
                }
            }
            else
            {
                listeFavori = new List<Favori>();  
            }


            return listeFavori;
        }
        
     }
}