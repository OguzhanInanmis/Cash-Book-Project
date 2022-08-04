using Defter.Models;
using Microsoft.EntityFrameworkCore;

namespace Defter.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {

        }
        public DbSet<Kasa> Defter { get; set; }
        //public DbSet<Context> proc_filtrele { get; set; }
        
    }
}
