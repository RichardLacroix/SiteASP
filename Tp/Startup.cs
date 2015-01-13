using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Tp.Startup))]
namespace Tp
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
