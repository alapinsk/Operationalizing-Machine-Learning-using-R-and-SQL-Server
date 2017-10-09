using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace RESTapi.Models
{
    public class ForecastItem
    {
        [Key]
        public DateTime Time { get; set; }
        public double? Actual { get; set; }
        public double? Forecast { get; set; }
        public double? Lo95 { get; set; }
        public double? Hi95 { get; set; }
    }
}
