using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Tp.Models.EF;

namespace Tp.Controllers
{
    public class VehiculeController : Controller
    {
        public ActionResult Index()
        {
            List<Vehicule> listeVehicule = Vehicule.RecupererTousVehicule();

            List<CategorieVehicule> listeCategorie = CategorieVehicule.RecupererTouteCategorie();

            ViewBag.listeCategorie = new List<CategorieVehicule>(listeCategorie);

            return View(listeVehicule);
        }

        public ActionResult RemplirListeVehicule(int? idCategorie)
        {
            if (Request.IsAjaxRequest())
            {
                List<Vehicule> listeVehicule;

                if (idCategorie > 0)
                {
                    listeVehicule = Vehicule.RecupererVehiculeParCategorie(idCategorie);
                }
                else
                {
                    listeVehicule = Vehicule.RecupererTousVehicule();
                }
                return PartialView("_InventairePartielle", listeVehicule);
            }
            return View();
        }

        public ActionResult Detail(int pIdVehicule)
        {
            Vehicule vehicule = Vehicule.RecupererVehiculeParId(pIdVehicule);

            return View(vehicule);
        }

        public ActionResult Modifier(int? pIdVehicule)
        {
            Vehicule vehicule = Vehicule.RecupererVehiculeParId(pIdVehicule);

            return View(vehicule);
        }

        [HttpGet]
        public ActionResult Ajouter()
        {
            Vehicule vehicule = new Vehicule();

            return View(vehicule);
        }

        [HttpPost]
        public ActionResult ModifierOuAjouter(Vehicule pVehiculeModele)
        {
            if (ModelState.IsValid)
            {
                Vehicule.Sauvegarder(pVehiculeModele);

                TempData["FormMessage"] = "Sauvegarde réussi!";

                ModelState.Clear();

                return RedirectToAction("Index");
            }
            else
            {
                ModelState.AddModelError("", "Une erreur niveau propriete");

                return View(pVehiculeModele);
            }
        }

        [HttpGet]
        public ActionResult SupprimerUnVehicule(int pIdVehicule)
        {
            Vehicule.Supprimer(pIdVehicule);

            TempData["FormMessage"] = "Suppression réussi!";

            return RedirectToAction("Index");
        }

    }
}