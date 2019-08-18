using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using almaximo_exam.entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace almaximo_exam.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TiipoController : ControllerBase
    {
        string connectionString = ConnString.ServerName;

        [HttpGet]
        public async Task<List<TipoDeProducto>> TipoDeProductosAsync()
        {
            List<TipoDeProducto> tipoDeProductos = new List<TipoDeProducto>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spObtenerTipoDeProductos", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    await conn.OpenAsync();

                    using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            TipoDeProducto tipoDeProducto = new TipoDeProducto
                            {
                                Nombre = reader["Nombre"].ToString()
                            };

                            tipoDeProductos.Add(tipoDeProducto);
                        }
                    }
                    conn.Close();
                }
            }

            return tipoDeProductos;
        }
    }
}