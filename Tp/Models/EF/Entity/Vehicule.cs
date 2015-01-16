using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Tp.Models.EF
{
    public partial class Vehicule
    {
        public static List<Vehicule> Recuperer()
        {

            using (DbConcessionnaireEntities bd = new DbConcessionnaireEntities())
            {
                List<Vehicule> lstVehicule = bd.Vehicules.ToList();
            }
            return null;
        }

    }
}