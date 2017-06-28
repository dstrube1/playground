using System.Web.Mvc;

namespace ClientServicesConsole_v0._1.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.Message = "Select an action.";

            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "This is the about page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "This is the contact page.";

            return View();
        }
    }
}
