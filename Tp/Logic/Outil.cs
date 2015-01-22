using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Tp.Logic
{
    public static class Outil
    {
        public static int ConvertirCookie(HttpCookie cookie)
        {
            int id = int.Parse(cookie.Value);

            return id;
        }
    }
}