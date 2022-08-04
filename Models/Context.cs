namespace Defter.Models
{
    using System;

    public partial class Context
    {
        public int Id { get; set; }
        public Nullable<System.DateTime> tarih { get; set; }
        public string Aciklama { get; set; }
        public Nullable<float> giren_miktar { get; set; }
        public Nullable<float> cikan_miktar { get; set; }
        public string Tur { get; set; }
    }
}
