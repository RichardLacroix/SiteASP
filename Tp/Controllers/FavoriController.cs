using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Tp.Models.EF;

namespace Tp.Controllers
{
    public class FavoriController : Controller
    {
        // GET: Favori
        public ActionResult RecupererFavori()
        {
           //String c;
            //int b;
           
                //c = Request.Cookies["Id"].ToString();
                //b = int.Parse(c);
           
            List<Favori> listeFavori = Favori.RecupererFavoriParIdClient(2);


            return PartialView("_FavoriPartielle", listeFavori);
        }
    }
}