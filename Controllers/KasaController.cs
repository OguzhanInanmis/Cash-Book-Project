using Defter.Data;
using Defter.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Defter.Controllers
{
    public class PageItem
    {
        public List<Kasa> proc_filtrele = new List<Kasa>();
        public List<Kasa> proc_devir = new List<Kasa>();
    }
    public class KasaController : Controller
    {
        
        PageItem item = new PageItem();
        private readonly ApplicationDbContext _db;
        public KasaController(ApplicationDbContext db)
        {
            _db = db;
        }

        public IActionResult Index()
        {
            item.proc_devir = _db.Defter.FromSqlRaw("exec dbo.proc_devir 'Liste'").ToList();
            item.proc_filtrele = _db.Defter.FromSqlRaw("exec dbo.Proc_filtrele_tarih 'Liste', 0, '', ''  ").ToList();
            return View(item);
        }

        [HttpPost]
        public IActionResult Index(IFormCollection collection)
        {           
            string tur = collection["tur"];
            string ilkTarih = collection["ilkTarih"];
            string sonTarih = collection["sonTarih"];
            
            item.proc_devir = _db.Defter.FromSqlRaw("exec dbo.proc_devir 'Liste'").ToList();

            if (tur == "giren")
            {
                
                //item.proc_filtrele =_db.Defter.Where(x => x.Tarih >= ilkTarih & x.Tarih <= ilkTarih).ToList();
                item.proc_filtrele = _db.Defter.FromSqlRaw("exec dbo.Proc_filtrele_tarih 'ListeGiren', 0, '', '' ").ToList();
                if (ilkTarih != sonTarih)
                {
                    item.proc_filtrele = _db.Defter.FromSqlRaw("exec dbo.Proc_filtrele_tarih 'Tarihlistelegiren', 0, '" +ilkTarih+ "','" +sonTarih+"'").ToList();
                    
                }
                
            }
            else if (tur == "cikan")
            {
                item.proc_filtrele = _db.Defter.FromSqlRaw("exec dbo.Proc_filtrele_tarih 'ListeCikan', 0, '', '' ").ToList();
                if (ilkTarih != sonTarih)
                {
                    item.proc_filtrele = _db.Defter.FromSqlRaw("exec dbo.Proc_filtrele_tarih 'Tarihlistelecikan',0, '" +ilkTarih+ "','" +sonTarih+"'").ToList();
                }
            }
            else if (tur == "Hepsi")
             {
                item.proc_filtrele = _db.Defter.FromSqlRaw("exec dbo.Proc_filtrele_tarih 'Liste', 0, '', '' ").ToList();
                if (ilkTarih != sonTarih)
                {
                    item.proc_filtrele = _db.Defter.FromSqlRaw("exec dbo.Proc_filtrele_tarih 'Tarihlistele', 0,'" +ilkTarih+ "','" +sonTarih+"'").ToList();
                    
                }
            }

            
            return View(item);
        }

        public IActionResult Giren()
        {
            return View();
        }

        // POST

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Giren([Bind("Id,Aciklama,GirenMiktar,Tarih")] Kasa kasa)
        {            

            if (ModelState.IsValid)
            {
                kasa.Tur = "giren";
                _db.Add(kasa);
                await _db.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(kasa);
        }

        public IActionResult Cikan()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Cikan([Bind("Id,Aciklama,CikanMiktar,Tarih")] Kasa kasa)
        {

            if (ModelState.IsValid)
            {
                kasa.Tur = "cikan";
                _db.Add(kasa);
                await _db.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(kasa);
        }

        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _db.Defter == null)
            {
                return NotFound();
            }

            var kasa = await _db.Defter
                .FirstOrDefaultAsync(m => m.Id == id);
            if (kasa == null)
            {
                return NotFound();
            }

            return View(kasa);
        }

        // POST
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_db.Defter == null)
            {
                return Problem("Entity set 'ApplicationDbContext.Defter'  is null.");
            }
            var kasa = await _db.Defter.FindAsync(id);
            if (kasa != null)
            {
                _db.Defter.Remove(kasa);
            }

            await _db.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }
    }
}

