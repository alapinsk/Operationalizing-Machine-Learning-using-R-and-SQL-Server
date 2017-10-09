using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace RESTapi.Models
{
    public class ForecastingContext : DbContext
    {
        public ForecastingContext(DbContextOptions<ForecastingContext> options) : base(options)
        {
        }

        public DbSet<ForecastItem> ForecastItems { get; set; }

    }
}
