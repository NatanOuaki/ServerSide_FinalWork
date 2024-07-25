namespace Server.DTO
{
    public class UpdateEventDTO
    {
        public int id { get; set; }
        public string title { get; set; }
        public string startDate { get; set; }
        public string endDate { get; set; }
        public int maxRegistrations { get; set; }
        public string location { get; set; }
    }
}
