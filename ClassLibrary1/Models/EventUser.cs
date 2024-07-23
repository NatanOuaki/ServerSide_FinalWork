using System;
using System.Collections.Generic;

namespace ClassLibrary1.Models;

public partial class EventUser
{
    public int EventRef { get; set; }

    public int UserRef { get; set; }

    public DateTime Creation { get; set; }

    public virtual Event EventRefNavigation { get; set; } = null!;

    public virtual User UserRefNavigation { get; set; } = null!;
}
