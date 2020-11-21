using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ODB.DAL
{
    public interface IDALManager : IDisposable
    {
        T GetProvider<T>() where T : class;
    }
}
