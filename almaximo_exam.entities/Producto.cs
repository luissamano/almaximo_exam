using System;
using System.Collections.Generic;
using System.Text;

namespace almaximo_exam.entities
{
    public class Producto
    {
        public string Clave { get; set; }
        public string Nombre { get; set; }
        public string Tipo_producto { get; set; }
        public decimal Costo { get; set; }
        public string Estatus { get; set; }
        public string Proveedor { get; set; }
    }
}
