using System.Data;
using leTower.Models;
using Dapper;
using System.Collections.Generic;
using System.Linq;

namespace leTower.Repositories
{
  public class AccountsRepository
  {
    private readonly IDbConnection _db;

    public AccountsRepository(IDbConnection db)
    {
      _db = db;
    }

    // NOTE - GET ACCOUNTS FOR AN EVENT ("event/tickets")

    internal List<AccountTicket> GetAccountsByEvent(int eventId)
    {
      string sql = @"
        SELECT 
        a.*,
        t.id as ticketId
        FROM tickets t
        JOIN accounts a on t.accountId = a.id
        WHERE t.eventId = @eventId;";
      return _db.Query<AccountTicket>(sql, new { eventId }).ToList();
    }

    // NOTE [TICKETSREPOSITORY] - GET EVENTS FOR ACCOUNT

    internal List<EventTicket> GetEventsByTicketAccount(string accountId)
    {
      string sql = @"
        SELECT
        e.*,
        t.id AS ticketId,
        a.*
        FROM tickets t 
        JOIN events e ON t.eventId = e.id
        JOIN accounts a ON e.creatorId = a.id 
        WHERE t.accountId = @accountId;
        ";
      return _db.Query<EventTicket, Account, EventTicket>(sql, (et, a) =>
      {
        et.Creator = a;
        return et;
      }, new { accountId }).ToList();
    }

    internal Account GetByEmail(string userEmail)
    {
      string sql = "SELECT * FROM accounts WHERE email = @userEmail";
      return _db.QueryFirstOrDefault<Account>(sql, new { userEmail });
    }

    internal Account GetById(string id)
    {
      string sql = "SELECT * FROM accounts WHERE id = @id";
      return _db.QueryFirstOrDefault<Account>(sql, new { id });
    }

    internal Account Create(Account newAccount)
    {
      string sql = @"
            INSERT INTO accounts
              (name, picture, email, id)
            VALUES
              (@Name, @Picture, @Email, @Id)";
      _db.Execute(sql, newAccount);
      return newAccount;
    }

    internal Account Edit(Account update)
    {
      string sql = @"
            UPDATE accounts
            SET 
              name = @Name,
              picture = @Picture
            WHERE id = @Id;";
      _db.Execute(sql, update);
      return update;
    }
  }
}
