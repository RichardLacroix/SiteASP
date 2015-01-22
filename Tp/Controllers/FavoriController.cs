using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Tp.Models.EF;
using Tp.Logic;

namespace Tp.Controllers
{
    public class FavoriController : Controller
    {
        // GET: Favori
        public ActionResult Index()
        {

            int id = Outil.ConvertirCookie(Request.Cookies["Id"]);


            List<Vehicule> listeVehiculeFavori = Favori.RecupererFavoriParIdClient(2);

            return View(listeVehiculeFavori);
        }

        [HttpGet]
        public ActionResult AjouterUnFavori(int pIdVehicule)
        {
            Boolean valide = Favori.ValideUnFavori(pIdVehicule);


            if (Request.Cookies["Id"] != null && !valide)
            {
                // string 

                // Favori.Sauvegarder(pIdVehicule, );

                //TempData["FormMessage"] = "Ajout réussi!";

                // ModelState.Clear();

                return RedirectToAction("Index");




            }
            else
            {
                if (!valide)
                {
                    TempData["FormMessage"] = "Favori déja présent";
                    return RedirectToAction("Index");
                }
                ModelState.AddModelError("", "Une erreur niveau propriete");

                return View(/*pFavoriModele*/);
            }
        }
    }
}