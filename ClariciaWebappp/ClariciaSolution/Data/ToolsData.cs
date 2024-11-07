using Clariciaclass.Interfaces;
using Clariciaclass.Models;

namespace ClariciaWebappp.Data
{
    public class ToolsData : ITools
    {
        public string Name { get; set; }
        public string Address { get; set; }
        public string Color { get; set; }
    }
}
