import psycopg2
import sys

def print_rows(rows):
    for row in rows:
        print(row)

#-----------------------------------------------------------------
# Reject all of my pending requests
#-----------------------------------------------------------------

def isPending(transactionid):
    # Tells us whether or not this transaction is pending
    tmpl = '''
        SELECT status
          FROM Request
         WHERE transactionid = %s;
    '''
    cmd = cur.mogrify(tmpl, [transactionid])
    cur.execute(cmd)
    status = cur.fetchall()[0][0]
    if status == 'Pending':
        return True
    return False

def reject_pending_requests(userid):
    # Rejects all of the pending requests for a user
    tmpl = '''
        SELECT r.transactionid
          FROM Request r
          JOIN Transaction t
            ON t.transactionid = r.transactionid
         WHERE receiverid = %s;
    '''
    cmd = cur.mogrify(tmpl, [userid])
    cur.execute(cmd)
    data = cur.fetchall()
    data = [x[0] for x in data]

    print "Pending Transacitons:"

    for transaction in data:
        cur.execute(cur.mogrify("SELECT * FROM Request WHERE transactionid=%s;"),(transaction,))
        print_rows(cur.fetchall())

    for transaction in data:
        if isPending(transaction):
            update = '''
                UPDATE Request
                   SET status = 'Rejected', timeOfDecision = TIMESTAMP '2016-05-16 15:36:38'
                 WHERE transactionid = %s;
                '''
            cmd = cur.mogrify(update, [transaction])
            cur.execute(cmd)  

    print "Transactions After Rejections:"

    for transaction in data:
        cur.execute(cur.mogrify("SELECT * FROM Request WHERE transactionid=%s;"),(transaction,))
        print_rows(cur.fetchall())


if __name__ == '__main__':
    try:
        db, user = 'venmo', sys.argv[1]
        conn = psycopg2.connect(database=db, user=user)
        conn.autocommit = True
        cur = conn.cursor()
        reject_pending_requests(10002)
    except psycopg2.Error as e:
        print("Unable to open connection: %s" % (e,))

