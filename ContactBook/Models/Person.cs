using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using System.ComponentModel.DataAnnotations;

namespace ContactBook.Models
{
    public class Person
    {
        public int Id { get; set; }
        
        [Required, StringLength(100)]
        public string FirstName { get; set; }

        [Required, StringLength(100)]
        public string LastName { get; set; }

        [Required, RegularExpression(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*")]
        public string Email { get; set; }

        public int Phone { get; set; }

        [Url]
        public string Web { get; set; }
    }

    public class PersonDbContext : DbContext
    {
        public DbSet<Person> Person { get; set; }
    }
}