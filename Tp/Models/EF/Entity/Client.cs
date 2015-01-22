using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace Tp.Models.EF
{

     [MetadataType(typeof(ClientMetadata))]
    public partial class Client
    {
        [NotMapped]
        public string UserName { get; set; }
         [NotMapped]
        public string Password { get; set; }
         [NotMapped]
        public string ConfirmPassword { get; set; }

        public static void Save(Client pModel)
        {
            using (DbConcessionnaireEntities bd = new DbConcessionnaireEntities())
            {
                if (pModel.IdClient > 0)
                {
                    Client ClientASauver = Client.GetById(pModel.IdClient, bd);
                    ClientASauver.Nom = pModel.Nom;
                    ClientASauver.Prenom = pModel.Prenom;
                    ClientASauver.Courriel = pModel.Courriel;
                    ClientASauver.Telephone = pModel.Telephone;
                    ClientASauver.NumeroCivique = pModel.NumeroCivique;
                    ClientASauver.Rue = pModel.Rue;
                    ClientASauver.Ville = pModel.Ville;
                    ClientASauver.Province = pModel.Province;
                    ClientASauver.CodePostal = pModel.CodePostal;
                    ClientASauver.NumeroPermis = pModel.NumeroPermis;
                    ClientASauver.Sexe = pModel.Sexe;
                    ClientASauver.Photo = pModel.Photo;
                    ClientASauver.AspNetUserId = pModel.AspNetUserId;
                }
                else
                {
                    bd.Clients.Add(pModel);
                }
                bd.SaveChanges();
            }
        }

        public static Client GetById(int id, DbConcessionnaireEntities pdb = null)
        {
            Boolean bdEstNull = false;
            if (pdb == null)
            {
                pdb = new DbConcessionnaireEntities();
                bdEstNull = true;
            }
            Client client = pdb.Clients.Where(i => i.IdClient == id).FirstOrDefault();
            if (bdEstNull)
            {
                pdb.Dispose();
            }

            return client;
        }
    }

  
    public class ClientMetadata
    {
        [Required]
        [Display(Name = "User name")]
        public string UserName { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "Les deux password doivent être identique.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm password")]
        [Compare("Password", ErrorMessage = "Les deux password doivent être indentique.")]
        public string ConfirmPassword { get; set; }

        [Required]
        [StringLength(25, ErrorMessage = "Maximum de 25 Caratère.", MinimumLength = 6)]
        public string Nom { get; set; }

        [Required]
        [StringLength(25, ErrorMessage = "Maximum de 25 Caratère.", MinimumLength = 6)]
        public string Prenom { get; set; }

        [Required]
        [StringLength(50, ErrorMessage = "Maximum de 50 Caratère.", MinimumLength = 6)]
        public string Courriel { get; set; }

        [Required]
        [StringLength(12, ErrorMessage = "Maximum de 12 Caratère.", MinimumLength = 6)]
        public string Telephone { get; set; }

        [Required]
        [StringLength(10, ErrorMessage = "Maximum de 10 Caratère.")]
        public string NumeroCivique { get; set; }

        [Required]
        [StringLength(50, ErrorMessage = "Maximum de 50 Caratère.")]
        public string Rue { get; set; }

        [Required]
        [StringLength(50, ErrorMessage = "Maximum de 50 Caratère.", MinimumLength = 6)]
        public string Ville { get; set; }

        [Required]
        [StringLength(25, ErrorMessage = "Maximum de 25 Caratère.", MinimumLength = 6)]
        public string Province { get; set; }

        [Required]
        [StringLength(7, ErrorMessage = "Vous devez avoir 7 caractère.", MinimumLength = 7)]
        public string CodePostal { get; set; }

        [Required]
        [StringLength(25, ErrorMessage = "Maximum de 25 Caratère.", MinimumLength = 6)]
        public string NumeroPermis { get; set; }

        [Required]
        public bool Sexe { get; set; }

        //[Required]
        //[StringLength(50, ErrorMessage = "Maximum de 50 Caratère.", MinimumLength = 6)]
        public string Photo { get; set; }
    }
}