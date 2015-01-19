using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Tp.Models.EF;

namespace Tp.Controllers
{
    public class CategorieVehiculeController : Controller
    {
        // GET: CategorieVehicule
        public ActionResult Categorie()
        {
            List<CategorieVehicule> listeCategorie = CategorieVehicule.RecupererTouteCategorie();

            return PartialView("_CategorieVehiculePartielle", listeCategorie);
        }
    }
}