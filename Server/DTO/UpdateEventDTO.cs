namespace Server.DTO
{
    public class UpdateEventDTO
    {
        public int id { get; set; }
        public string title { get; set; }
        public DateTime startDate { get; set; }
        public DateTime endDate { get; set; }
        public int maxRegistrations { get; set; }
        public string location { get; set; }
    }
}
