using DeluxeApp.Models.Entities;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;


namespace DeluxeApp.Controllers
{
    public class EmpleadoController : Controller
    {
        DeluxeDBEntities DeluxeDB = new DeluxeDBEntities();
        // GET: Empleado
        public ActionResult Index()
        {
            List<Empleado> Empleados = new List<Empleado>();

            Empleados = DeluxeDB.Empleado.ToList();

            return View(Empleados);
        }

        public ActionResult Guardar(Empleado e)
        {
            if (e.Id == 0)
            {
                DeluxeDB.Empleado.Add(e);
            }
            else
            {
              DeluxeDB.Empleado.Attach(e);
                 DeluxeDB.Entry(e).State = System.Data.Entity.EntityState.Modified;
            }
            DeluxeDB.SaveChanges();

            return RedirectToAction("Index");

        }

        public ActionResult Actualizar(int Id) {
            Empleado empleado = DeluxeDB.Empleado.Find(Id);
            return View("ModificarEmpleado",empleado);            

        }

        public ActionResult Eliminar(int Id) {
            Empleado empleado = DeluxeDB.Empleado.Find(Id);
            DeluxeDB.Empleado.Remove(empleado);
            DeluxeDB.SaveChanges();

            return RedirectToAction("Index");

        }
        
    }
}