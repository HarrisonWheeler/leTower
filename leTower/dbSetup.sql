CREATE TABLE IF NOT EXISTS accounts(
  id VARCHAR(255) NOT NULL primary key COMMENT 'primary key',
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Time Created',
  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last Update',
  name varchar(255) COMMENT 'User Name',
  email varchar(255) COMMENT 'User Email',
  picture varchar(255) COMMENT 'User Picture'
) default charset utf8 COMMENT '';

CREATE TABLE IF NOT EXISTS events(
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  location VARCHAR(255) NOT NULL,
  isCancelled TINYINT DEFAULT 0,
  creatorId VARCHAR(255) NOT NULL,

  FOREIGN KEY(creatorId) REFERENCES accounts(id) ON DELETE CASCADE
) default charset utf8 COMMENT '';

CREATE TABLE IF NOT EXISTS tickets(
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  eventId int NOT NULL,
  accountId VARCHAR(255) NOT NULL, 

  FOREIGN KEY(eventId) REFERENCES events(id) ON DELETE CASCADE,
  FOREIGN KEY(accountId) REFERENCES accounts(id) ON DELETE CASCADE
)  default charset utf8 COMMENT '';


DROP TABLE events;


INSERT INTO accounts
(id, email, name, picture)
VALUES
("chilling", "bingchilling@cena.com", "cena", "http://thiscatdoesnotexist.com");

INSERT INTO accounts
(id, email, name, picture)
VALUES
("dwayne", "trock@therock.rock", "dj", "http://thiscatdoesnotexist.com");

INSERT INTO events
(creatorId, location, name)
VALUES
("dwayne", "saudi arabia", "wrestlemania X" );
INSERT INTO events
(creatorId, location, name)
VALUES
("chilling", "beijing", "fast 9 preview" );

INSERT INTO tickets
(eventId, accountId)
VALUES
(2, "dwayne");
INSERT INTO tickets
(eventId, accountId)
VALUES
(3, "chilling");

SELECT * FROM events;

SELECT * FROM tickets;

-- GET ACCOUNTS BY EVENT ID --

SELECT 
a.*,
t.id as ticketId
FROM tickets t
JOIN accounts a on t.accountId = a.id
WHERE t.eventId = 2;

-- GET EVENTS BY ACCOUNT ID --

SELECT
e.*,
t.id AS ticketId
FROM tickets t 
JOIN events e ON t.eventId = e.id 
WHERE t.accountId = "dwayne";


