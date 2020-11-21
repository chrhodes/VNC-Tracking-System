using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace HIS.DAL
{
    public interface ISchemaDAL
    {
        IDataReader Fetch();
    }
}
