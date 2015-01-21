using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Tp.Models.EF
{
    public partial class Favori
    {
        //Recuperer les favoris par idClient
        public static List<Favori> RecupererFavoriParIdClient(int idClient)
        {
            List<Favori> favori = null;
            using (DbConcessionnaireEntities1 db = new DbConcessionnaireEntities1())
            {
                favori = db.Favoris.Where(i => i.IdClient == idClient).ToList();
            }
            return favori;
        }   
    }
}