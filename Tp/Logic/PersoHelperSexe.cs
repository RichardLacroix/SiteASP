using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Tp.Logic
{
    public static class PersoHelperSexe
    {
        //name = (nom du label), text = (text a afficher), 
        public static HtmlString SexCheck(string pName, string pText, Boolean pSelected)
        {
            return new HtmlString(String.Format(@"<label id='{0}' class='col-md-2 control-label' for='{1}'>{1}</label><input id='{1}' class='form-control' name='{1}' type='checkbox' {2} /><input name='{1}' type='hidden' value='false' />", pName, pText, (pSelected ? @" checked='checked'" : "")));
        }
    }
}