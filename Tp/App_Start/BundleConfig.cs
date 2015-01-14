using System.Web;
using System.Web.Optimization;

namespace Tp
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.js",
                      "~/Scripts/respond.js"));

            bundles.Add(new StyleBundle("~/css").Include(  //Pourquoi ca fontionne meme si je change le lien du bundle
                      "~/Content/bootstrap.css",
                      "~/Content/site.css",
                      "~/Content/global.css",
                      "~/Content/lightbox.css",
                      "~/Content/style.css"));

            bundles.Add(new ScriptBundle("~/jquery").Include(
                      "~/Scripts/jquery.lightbox.js",
                      "~/Scripts/jquery-1.7.2.min.js",
                       "~/Scripts/slides.min.jquery.js"));
        }
    }
}
