using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace almaximo_exam.api
{
    public static class ConnString
    {
        private static readonly string cName = 
            @"Data Source=.\SQLEXPRESS;Initial Catalog=db_almaximo;User ID=sa;Password=7soe600@";

        public static string ServerName
        {
            get => cName;
        }
    }
}
