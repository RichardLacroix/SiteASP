using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Tp.Models.EF
{
    public partial class Vehicule
    {
        public static List<Vehicule> RecupererTousVehicule()
        {
            using (TestMVC4Entities db = new TestMVC4Entities())
            {
                var rValue = db.Produits.ToList();
                return rValue;
            }
        }
    }
}