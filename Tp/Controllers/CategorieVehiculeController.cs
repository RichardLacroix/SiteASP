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


        public ActionResult Admin_Detail(int? id)
        {
            CategorieVehicule catV = null;

            if (id.HasValue)
            {
                catV = CategorieVehicule.GetById((int)id);
            }

            if (catV == null)
            {
                catV = new CategorieVehicule();
            }
            //Retourner un produit vide ou celui a modifier
            return View(catV);
        }

        [HttpPost]
        public ActionResult Admin_Detail(CategorieVehicule pModel)
        {

            if (ModelState.IsValid)
            {
                CategorieVehicule.Save(pModel);
                TempData["FormMessage"] = "Enregistrement reussi!";

                ModelState.Clear();

                //si reussi, retourner a la liste des produits
                return RedirectToAction("Index");
            }
            else
            {
                
                return View(pModel);
            }
        }
    }
}