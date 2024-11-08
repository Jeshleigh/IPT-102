using System.ComponentModel.DataAnnotations;

namespace ProductLibrary
{
    public class Product
    {
        [Required]
        public string Name { get; set; }
        public string Color { get; set; }
        [Range(0, 10000)]
        public decimal Price { get; set; }
        [Range(0, 100)]
        public int Quantity { get; set; }
    }
}
