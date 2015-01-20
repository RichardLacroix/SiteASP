using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Tp.Models.EF
{
    public partial class Commentaire
    {
        public static List<Commentaire> RecupereCommentaireParVehicule(int? Id)
        {
            using (DbConcessionnaireEntities bd = new DbConcessionnaireEntities())
            {
                if (Id.HasValue)
                {
                    List<Commentaire> listCommentaires = bd.Commentaires.Where(i => i.IdVehicule == Id).ToList();
                    return listCommentaires;
                }
                else
                {
                    List<Commentaire> listCommentaires = new List<Commentaire>();
                    return listCommentaires;
                }
            }
        }

        public static Commentaire RecuperCommentaireParId(int id, DbConcessionnaireEntities pbd = null)
        {
            Boolean wasNull = false;
            if (pbd == null)
            {
                pbd = new DbConcessionnaireEntities();
                wasNull = true;
            }
            Commentaire comment = pbd.Commentaires.Where(i => i.IdCommentaire == id).FirstOrDefault();
            if (wasNull)
            {
                pbd.Dispose();
            }
            return comment;
        }

        public static void DeleteCommentaire(int id)
        {
            using (DbConcessionnaireEntities bd = new DbConcessionnaireEntities())
            {
                Commentaire commentToDelete = bd.Commentaires.Where(i => i.IdCommentaire == id).FirstOrDefault();
                bd.Commentaires.Attach(commentToDelete);
                bd.Commentaires.Remove(commentToDelete);
                bd.SaveChanges();
            }
        }

        public static void AddCommentaire(Commentaire pModelForm)
        {
            using (DbConcessionnaireEntities bd = new DbConcessionnaireEntities())
            {
                if (pModelForm.IdClient > 0)
                {
                    Commentaire commentToSave = RecuperCommentaireParId(pModelForm.IdClient, bd);
                    commentToSave.IdClient = pModelForm.IdCommentaire;
                    commentToSave.IdVehicule = pModelForm.IdVehicule;
                    commentToSave.IdClient = pModelForm.IdClient;
                    commentToSave.DateCommentaire = pModelForm.DateCommentaire;
                    commentToSave.Cote = pModelForm.Cote;
                    commentToSave.Commentaire1 = pModelForm.Commentaire1;
                }
                else
                {
                    bd.Commentaires.Add(pModelForm);
                }
                bd.SaveChanges();
            }
        }
    }
}
