//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Tp.Models.EF
{
    using System;
    using System.Collections.Generic;
    
    public partial class Commentaire
    {
        public int IdCommentaire { get; set; }
        public int IdVehicule { get; set; }
        public int IdClient { get; set; }
        public Nullable<System.DateTime> DateCommentaire { get; set; }
        public Nullable<int> Cote { get; set; }
        public string Commentaire1 { get; set; }
    
        public virtual Client Client { get; set; }
        public virtual Vehicule Vehicule { get; set; }
    }
}
