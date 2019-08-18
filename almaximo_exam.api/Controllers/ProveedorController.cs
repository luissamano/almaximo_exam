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
    public class ProveedorController : ControllerBase
    {
        string connectionString = ConnString.ServerName;

        [HttpGet]
        public async Task<List<Proveedor>> TipoDeProductosAsync()
        {
            List<Proveedor> lsProveedor = new List<Proveedor>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spObtenerProveedores", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    await conn.OpenAsync();

                    using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            Proveedor proveedor = new Proveedor
                            {
                                Nombre = reader["Nombre"].ToString()
                            };

                            lsProveedor.Add(proveedor);
                        }
                    }
                    conn.Close();
                }
            }

            return lsProveedor;
        }
    }
}