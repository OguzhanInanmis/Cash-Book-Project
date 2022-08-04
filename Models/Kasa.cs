using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace Defter.Models
{
    public class Kasa
    {
        [Key]
        public int Id { get; set; }        
        public string Aciklama { get; set; }=String.Empty;
        public string Tur { get; set; } = String.Empty;
        [DisplayName("Giren Miktar")]        
        public float GirenMiktar { get; set; } 
        [DisplayName("Çıkan Miktar")]
        public float CikanMiktar { get; set; }
        public DateTime Tarih { get; set; } = DateTime.Now;
        
    }
}
