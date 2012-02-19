using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Management_Tool_V002.Model
{

    public partial class addresses
    {
        public bool isNew
        {
            get { return !(this.adr_id > 0); }
        }
    }

    public partial class dictionary
    {
        public bool isNew
        {
            get { return !(this.dict_id>0);}
        }
    }

    public partial class mtdb_reference
    {
        public bool isNew
        {
            get { return !(this.re_id> 0); }
        }
    }

    public partial class persons
    {
        public bool isNew
        {
            get { return !(this.pe_id > 0); }
        }
    }

    public partial class phones
    {
        public bool isNew
        {
            get { return !(this.ph_id > 0); }
        }
    }

    public partial class rights
    {
        public bool isNew
        {
            get { return !(this.ri_id > 0); }
        }
    }

    public partial class roles
    {
        public bool isNew
        {
            get { return !(this.ro_id > 0); }
        }
    }

    public partial class users
    {
        public bool isNew
        {
            get { return !(this.us_id > 0); }
        }
    }

    public partial class www
    {
        public bool isNew
        {
            get { return !(this.www_id > 0); }
        }
    }
}
