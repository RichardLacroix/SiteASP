using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Tp.Models.EF
{
    public partial class CategorieVehicule
    {
        public static List<CategorieVehicule> RecupererTouteCategorie()
        {
            List<CategorieVehicule> listeVehicule;

            using (DbConcessionnaireEntities db = new DbConcessionnaireEntities())
            {
                listeVehicule = db.CategorieVehicules.OrderBy(m => m.IdCategorie).ToList();
            }

            if (listeVehicule == null)
            {
                listeVehicule = new List<CategorieVehicule>();
            }

            return listeVehicule;
        }
    }
}