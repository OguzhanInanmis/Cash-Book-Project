using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Defter.Data;
using Defter.Models;

namespace Defter.Controllers
{
    public class KasasController : Controller
    {
        private readonly ApplicationDbContext _context;

        public KasasController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Kasas
        public async Task<IActionResult> Index()
        {
              return _context.Defter != null ? 
                          View(await _context.Defter.ToListAsync()) :
                          Problem("Entity set 'ApplicationDbContext.Defter'  is null.");
        }

        // GET: Kasas/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Defter == null)
            {
                return NotFound();
            }

            var kasa = await _context.Defter
                .FirstOrDefaultAsync(m => m.Id == id);
            if (kasa == null)
            {
                return NotFound();
            }

            return View(kasa);
        }

        // GET: Kasas/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Kasas/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,Aciklama,GirenMiktar,Tarih")] Kasa kasa)
        {
            kasa.Tur = "Giren";
            
            if (ModelState.IsValid)
            {
                _context.Add(kasa);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(kasa);
        }

        // GET: Kasas/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Defter == null)
            {
                return NotFound();
            }

            var kasa = await _context.Defter.FindAsync(id);
            if (kasa == null)
            {
                return NotFound();
            }
            return View(kasa);
        }

        // POST: Kasas/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,Aciklama,Tur,GirenMiktar,CikanMiktar,Tarih")] Kasa kasa)
        {

            if (id != kasa.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(kasa);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!KasaExists(kasa.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(kasa);
        }

        // GET: Kasas/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.Defter == null)
            {
                return NotFound();
            }

            var kasa = await _context.Defter
                .FirstOrDefaultAsync(m => m.Id == id);
            if (kasa == null)
            {
                return NotFound();
            }

            return View(kasa);
        }

        // POST: Kasas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Defter == null)
            {
                return Problem("Entity set 'ApplicationDbContext.Defter'  is null.");
            }
            var kasa = await _context.Defter.FindAsync(id);
            if (kasa != null)
            {
                _context.Defter.Remove(kasa);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool KasaExists(int id)
        {
          return (_context.Defter?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}
