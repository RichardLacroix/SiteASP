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
    
    public partial class Paiement
    {
        public int IdPaiement { get; set; }
        public int IdVente { get; set; }
        public string NumeroCarteCredit { get; set; }
        public System.DateTime DateExpirationCarte { get; set; }
    
        public virtual Vente Vente { get; set; }
    }
}
