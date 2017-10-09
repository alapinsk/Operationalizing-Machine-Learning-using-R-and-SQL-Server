using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using RESTapi.Models;

namespace RESTapi.Controllers
{
    [Produces("application/json")]
    [Route("api/ForecastItems")]
    public class ForecastItemsController : Controller
    {
        private readonly ForecastingContext _context;

        public ForecastItemsController(ForecastingContext context)
        {
            _context = context;
        }

        // GET: api/ForecastItems
        [HttpGet]
        public async Task<IEnumerable<ForecastItem>> GetForecastItems()
        {
            return await _context.ForecastItems.FromSql("get_forecast").ToArrayAsync();
        }

        // GET: api/ForecastItems/1961-09-01
        [HttpGet("{id}")]
        public async Task<ForecastItem> GetForecastItem([FromRoute] DateTime id)
        {
            return await _context.ForecastItems.FromSql("get_forecast @p0", id.Date).FirstOrDefaultAsync();
        }
    }
}