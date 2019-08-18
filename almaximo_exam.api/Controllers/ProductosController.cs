using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using almaximo_exam.entities;
using Microsoft.AspNetCore.Mvc;

namespace almaximo_exam.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductosController : ControllerBase
    {
        string connectionString = ConnString.ServerName;

        [HttpGet]
        public async Task<List<Producto>> GetProductos()
        {
            List<Producto> lsProductos = new List<Producto>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spObtenerProductos", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();

                    using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                    {
                        while (reader.Read())
                        {

                            Producto producto = new Producto
                            {
                                Clave = reader.GetString(0),
                                Nombre = reader.GetString(1),
                                Tipo_producto = reader.GetString(2),
                                Costo = reader.GetDecimal(3),
                                Estatus = reader.GetString(4),
                                Proveedor = reader["Proveedor"].ToString()
                            };

                            lsProductos.Add(producto);
                        }
                    }
                    conn.Close();
                }
            }

            return lsProductos;
        }

        [HttpPut] 
        public async Task<int> InsertProductos([FromBody] List<Producto> json)
        {
            int res = 0;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                foreach (var item in json)
                {
                    using (SqlCommand cmd = new SqlCommand("spInsertarProducto", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("@Clave", SqlDbType.NVarChar).Value = item.Clave;
                        cmd.Parameters.Add("@Nombre", SqlDbType.NVarChar).Value = item.Nombre;
                        cmd.Parameters.Add("@Tipo", SqlDbType.NVarChar).Value = item.Tipo_producto;
                        cmd.Parameters.Add("@Costo", SqlDbType.Decimal).Value = item.Costo;
                        cmd.Parameters.Add("@Estatus", SqlDbType.NVarChar).Value = item.Estatus;
                        cmd.Parameters.Add("@Proveedor", SqlDbType.NVarChar).Value = item.Proveedor;

                        conn.Open();

                        var r = await cmd.ExecuteNonQueryAsync();

                        try
                        {
                            if (r != 0)
                                res = 1;
                            else
                                res = 0;
                        }
                        catch (SqlException e)
                        {
                            Console.Out.WriteLine("ErrorSQL: " + e);
                            conn.Close();
                        }

                    }
                    conn.Close();
                }
            }

            return res;
        }

    }
}