using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ContactBook.Models;

namespace ContactBook.Controllers
{ 
    public class PersonController : Controller
    {
		//This is a change in my test branch.Added a new feature branch.
		//Changes to develop after merging feature into develop.
		//commit 1 of feature branch
		//commit 2 of feature branch
		//making a change in develop and pushing in github.Changed
		//Trying a push to assembla.

        private PersonDbContext db = new PersonDbContext();

        //
        // GET: /Person/

        public ViewResult Index()
        {
            //displays the first 10 latest records.
            List<Person> data = (from p in db.Person orderby p.Id descending
                        select p).Take(10).ToList();
                return View(data);
        }

		[HttpPost]
		public ActionResult Results(string searchText)
		{
			searchText = searchText.ToUpper();
			List<Person> data = (from p in db.Person where p.FirstName.ToUpper().StartsWith(searchText) orderby p.Id descending
			                     select p).ToList();
			return View(data);        
		}
	

        //
        // GET: /Person/Create

        public ActionResult Create()
        {
            return PartialView("Create");
        } 

        //
        // POST: /Person/Create

        [HttpPost]
        public ActionResult Create(Person person)
        {
            if (ModelState.IsValid)
            {              
                db.Person.Add(person);
                db.SaveChanges();
                return Content(Boolean.TrueString);

            }
            else
            {
                return Content("Please review your form");
            }
        }


        //
        // GET: /Person/Edit/5
 
        public ActionResult Edit(int id)
        {
            Person person = db.Person.Find(id);
            return PartialView(person);
        }

        //
        // POST: /Person/Edit/5

        [HttpPost]
        public ActionResult Edit(Person person)
        {
            if (ModelState.IsValid)
            {
                db.Entry(person).State = EntityState.Modified;
                db.SaveChanges();
                return Content(Boolean.TrueString);
                
            }
             else {
                //can go into details and display the messages returned by the model.
                 return Content("Please review your form");
            }
        }
        

        //
        // GET: /Person/Delete/5


        //
        // POST: /Person/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {            
            try
            {
                Person person = db.Person.Find(id);
                db.Person.Remove(person);
                db.SaveChanges();
                return Content(Boolean.TrueString);
            }
           catch{
               return Content(Boolean.FalseString);
           }
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}