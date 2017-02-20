-- Phase 2 Initialization

-- ============================================================

\c postgres
DROP DATABASE IF EXISTS venmo;

CREATE database venmo;
\c venmo

\i create.SQL

-- ============================================================

\copy User_Balance(userid, balance, password) FROM 'user_balance.csv' csv header
\copy User_Email(userid, email) FROM 'user_email.csv' csv header
\copy User_Credit(userid, creditCardNo) FROM 'user_credit.csv' csv header
\copy Individual(userid, fname, lname) FROM 'individual.csv' csv header
\copy Business(userid, businessName, transactionFee) FROM 'businesses.csv' csv header
\copy Transaction(transactionId, amount, description, time, location, likes, comment, payerId, receiverId) FROM 'transaction.csv' csv header
\copy Payment(transactionId) FROM 'payment.csv' csv header
\copy In_App_Purchase(transactionId, appName, businessName) FROM 'in_app_purchase.csv' csv header
\copy Request(transactionId, status, timeOfDecision) FROM 'request.csv' csv header
\copy Friend(friend1id, friend2id, dateOfFriendship, noOfInteractions) FROM 'friend.csv' csv header

-- ============================================================