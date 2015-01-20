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
            using (DbConcessionnaireEntities db = new DbConcessionnaireEntities())
            {
                favori = db.Favoris.Where(i => i.IdClient == idClient).ToList();
            }
            return favori;
        }   
    }
}