using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(DeluxeApp.Startup))]
namespace DeluxeApp
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
