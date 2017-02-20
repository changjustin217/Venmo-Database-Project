-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2016-12-06 02:51:06.315

-- tables
-- Table: Business
CREATE TABLE Business (
    userid int  NOT NULL,
    businessName varchar(100)  NOT NULL,
    transactionFee int  NOT NULL,
    CONSTRAINT Business_pk PRIMARY KEY (userid)
);

-- Table: Friend
CREATE TABLE Friend (
    friend1id int  NOT NULL,
    friend2id int  NOT NULL,
    dateOfFriendship date  NOT NULL,
    noOfInteractions int  NOT NULL,
    CONSTRAINT Friend_pk PRIMARY KEY (friend1id,friend2id)
);

-- Table: In_App_Purchase
CREATE TABLE In_App_Purchase (
    transactionid int  NOT NULL,
    appName varchar(100)  NOT NULL,
    businessName varchar(100)  NOT NULL,
    CONSTRAINT In_App_Purchase_pk PRIMARY KEY (transactionid)
);

-- Table: Individual
CREATE TABLE Individual (
    userid int  NOT NULL,
    fname varchar(15)  NOT NULL,
    lname varchar(15)  NOT NULL,
    CONSTRAINT Individual_pk PRIMARY KEY (userid)
);

-- Table: Payment
CREATE TABLE Payment (
    transactionid int  NOT NULL,
    CONSTRAINT Payment_pk PRIMARY KEY (transactionid)
);

-- Table: Request
CREATE TABLE Request (
    transactionid int  NOT NULL,
    status varchar(100)  NOT NULL,
    timeOfDecision timestamp  NULL,
    CONSTRAINT Request_pk PRIMARY KEY (transactionid)
);

-- Table: Transaction
CREATE TABLE Transaction (
    transactionid int  NOT NULL,
    amount decimal(7,2)  NOT NULL,
    description varchar(100)  NOT NULL,
    time timestamp  NOT NULL,
    location varchar(100)  NULL,
    likes int  NOT NULL,
    comment text  NULL,
    payerid int  NOT NULL,
    receiverid int  NOT NULL,
    CONSTRAINT Transaction_pk PRIMARY KEY (transactionid)
);

-- Table: User_Balance
CREATE TABLE User_Balance (
    userid int  NOT NULL,
    balance decimal(7,2)  NOT NULL,
    password varchar(30)  NOT NULL,
    CONSTRAINT User_Balance_pk PRIMARY KEY (userid)
);

-- Table: User_Credit
CREATE TABLE User_Credit (
    userid int  NOT NULL,
    creditCardNo char(16)  NOT NULL,
    CONSTRAINT User_Credit_pk PRIMARY KEY (userid)
);

-- Table: User_Email
CREATE TABLE User_Email (
    userid int  NOT NULL,
    email varchar(100)  NOT NULL,
    CONSTRAINT User_Email_pk PRIMARY KEY (userid)
);

-- foreign keys
-- Reference: Business_User_Balance (table: Business)
ALTER TABLE Business ADD CONSTRAINT Business_User_Balance
    FOREIGN KEY (userid)
    REFERENCES User_Balance (userid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Friend_User_Balance (table: Friend)
ALTER TABLE Friend ADD CONSTRAINT Friend_User_Balance
    FOREIGN KEY (friend2id)
    REFERENCES User_Balance (userid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Friend_User_Balance2 (table: Friend)
ALTER TABLE Friend ADD CONSTRAINT Friend_User_Balance2
    FOREIGN KEY (friend1id)
    REFERENCES User_Balance (userid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: In_App_Purchase_Transaction (table: In_App_Purchase)
ALTER TABLE In_App_Purchase ADD CONSTRAINT In_App_Purchase_Transaction
    FOREIGN KEY (transactionid)
    REFERENCES Transaction (transactionid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Individual_User_Balance (table: Individual)
ALTER TABLE Individual ADD CONSTRAINT Individual_User_Balance
    FOREIGN KEY (userid)
    REFERENCES User_Balance (userid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Payment_Transaction (table: Payment)
ALTER TABLE Payment ADD CONSTRAINT Payment_Transaction
    FOREIGN KEY (transactionid)
    REFERENCES Transaction (transactionid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Request_Transaction (table: Request)
ALTER TABLE Request ADD CONSTRAINT Request_Transaction
    FOREIGN KEY (transactionid)
    REFERENCES Transaction (transactionid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Transaction_User_Balance (table: Transaction)
ALTER TABLE Transaction ADD CONSTRAINT Transaction_User_Balance
    FOREIGN KEY (payerid)
    REFERENCES User_Balance (userid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Transaction_User_Balance2 (table: Transaction)
ALTER TABLE Transaction ADD CONSTRAINT Transaction_User_Balance2
    FOREIGN KEY (receiverid)
    REFERENCES User_Balance (userid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: User_Credit_User_Balance (table: User_Credit)
ALTER TABLE User_Credit ADD CONSTRAINT User_Credit_User_Balance
    FOREIGN KEY (userid)
    REFERENCES User_Balance (userid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: User_Email_User_Balance (table: User_Email)
ALTER TABLE User_Email ADD CONSTRAINT User_Email_User_Balance
    FOREIGN KEY (userid)
    REFERENCES User_Balance (userid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

