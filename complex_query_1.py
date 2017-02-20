import psycopg2
import sys
import random

def print_rows(rows):
    for row in rows:
        print(row)

#-----------------------------------------------------------------
# Send Money to Another User
#-----------------------------------------------------------------

def send_money(senderid, receiverid, amount):
    tmpl1 = '''
        SELECT balance
          FROM User_Balance AS u
         WHERE userid = %s;
    '''
    tmpl2 = '''
        SELECT balance
          FROM User_Balance AS u
         WHERE userid = %s;
    '''
    cmd = cur.mogrify(tmpl1, (senderid,))
    cur.execute(cmd)
    sender_balance = cur.fetchall()[0][0]
    cmd = cur.mogrify(tmpl2, (receiverid,))
    cur.execute(cmd)

    print "User Balances Before Transaction:"
    cur.execute(cur.mogrify("SELECT * FROM User_Balance WHERE userid=%s;"),(senderid,))
    print_rows(cur.fetchall())
    cur.execute(cur.mogrify("SELECT * FROM User_Balance WHERE userid=%s;"),(receiverid,))
    print_rows(cur.fetchall())

    if sender_balance < amount:
        print "Error: Transaction Amount Exceeds Account Balance"
    else:
        update = '''
            UPDATE User_Balance
               SET balance = balance + %s
             WHERE userid = %s;
        '''
        cmd = cur.mogrify(update, (amount,receiverid))
        cur.execute(cmd)
        update2 = '''
            UPDATE User_Balance
               SET balance = balance - %s
             WHERE userid = %s;
        '''
        cmd = cur.mogrify(update2, (amount,senderid))
        cur.execute(cmd)
        # Generate transactionid
        transactionId = random.randint(10000000,99999999)
        insert = '''
            INSERT INTO Transaction (transactionId,amount,description,time,location,likes,comment,payerId,receiverId)
            VALUES (%s,%s,%s,TIMESTAMP '2016-05-16 15:36:38',%s,%s,%s,%s,%s)
        '''
        cmd = cur.mogrify(insert, (transactionId,amount,"Food","Carnegie Mellon",0,"",senderid,receiverid))
        cur.execute(cmd)
        print "User Balances After Transaction:"
        cur.execute(cur.mogrify("SELECT * FROM User_Balance WHERE userid=%s;"),(senderid,))
        print_rows(cur.fetchall())
        cur.execute(cur.mogrify("SELECT * FROM User_Balance WHERE userid=%s;"),(receiverid,))
        print_rows(cur.fetchall())
        print "Newly Created Transaction"
        cur.execute(cur.mogrify("SELECT * FROM Transaction WHERE transactionId=%s;"),(transactionId,))
        print_rows(cur.fetchall())

if __name__ == '__main__':
    try:
        db, user = 'venmo', sys.argv[1]
        conn = psycopg2.connect(database=db, user=user)
        conn.autocommit = True
        cur = conn.cursor()
        send_money(10000,10001,5)
    except psycopg2.Error as e:
        print("Unable to open connection: %s" % (e,))