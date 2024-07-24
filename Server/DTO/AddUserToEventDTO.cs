namespace Server.DTO
{
    public class AddUserToEventDTO{
        public string Id { get; set; }
        public string Name { get; set; } = null!;
        public string DateOfBirth { get; set; }
    }
}
