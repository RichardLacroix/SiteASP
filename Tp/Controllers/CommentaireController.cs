using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Tp.Models.EF;

namespace Tp.Controllers
{
    public class CommentaireController : Controller
    {
        //
        // GET: /Commentaire/

        public ActionResult details(int? id)
        {
            int localId;
            if (id == null)
                localId = 0;
            else
                localId = (int)id;

            Vehicule chare = Vehicule.RecupererVehiculeParId(localId);
            List<Commentaire> commentaires = Commentaire.RecupereCommentaireParVehicule(localId);
            return View(commentaires);
        }
	}
}