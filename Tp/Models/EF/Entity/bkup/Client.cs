﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace Tp.Models.EF
{
    public partial class Client
    {
        [Required]
        [Display(Name = "User name")]
        public string UserName { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm password")]
        [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }

        public static void Save(Client pModel)
        {
            using (DbConcessionnaireEntities bd = new DbConcessionnaireEntities())
            {
                bd.Clients.Attach(pModel);
                bd.Clients.Add(pModel);
                bd.SaveChanges();
            }
        }

    }

    
}