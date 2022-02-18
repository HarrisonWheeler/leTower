namespace leTower.Models
{
  public class Event
  {
    public string Location { get; set; }
    public int Id { get; set; }
    public string Name { get; set; }
    public bool IsCancelled { get; set; }
    public string CreatorId { get; set; }
    public Account Creator { get; set; }
  }

  public class EventTicket : Event
  {
    public int TicketId { get; set; }
  }
}