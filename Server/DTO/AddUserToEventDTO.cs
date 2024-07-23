namespace Server.DTO
{
    public class AddUserToEventDTO{
        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public DateTime DateOfBirth { get; set; }
    }
}
