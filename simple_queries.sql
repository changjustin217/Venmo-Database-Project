-- ============== Query A ==============
\echo List of Top 3 Friends with Largest Balances
  SELECT i.userid, b.balance
    FROM Individual i
    JOIN User_Balance b
      ON i.userid = b.userid
    JOIN Friend f
      ON i.userid = f.friend2id
  WHERE f.friend1id = 10000
ORDER BY b.balance DESC
   LIMIT 3;

-- ============== Query B ==============
\echo Average Transaction Amount to Business
  SELECT b.businessName, AVG(t.amount) AS "Average"
    FROM Transaction t
    JOIN Business b
      ON b.userid = t.receiverid
   WHERE b.userid = 10008
GROUP BY b.userid;

-- ============== Query E ==============
\echo History of a Users Payments
   SELECT time, amount, description, payerid, receiverid
     FROM Transaction
    WHERE (payerid = 10000 OR receiverid = 10000)
 ORDER BY time DESC;

-- ============== Query F ==============
\echo Largest Payment Made by User
  SELECT amount AS "Largest Payment", description, receiverid
    FROM Transaction
   WHERE payerid = 10001
ORDER BY amount DESC
   LIMIT 1;

-- ============== Query H ==============
\echo Number of Transactions within Price Range
  SELECT COUNT(transactionid) AS "# of Transactions Between $30 and $100"
    FROM Transaction
   WHERE 30 < amount AND amount < 100;

-- ============== Query I ==============
\echo Average Amount Paid to All Businesses
  SELECT b.businessName, AVG(t.amount) AS "Average"
    FROM Transaction t
    JOIN Business b
      ON b.userid = t.receiverid
GROUP BY b.userid;


