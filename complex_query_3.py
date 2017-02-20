import psycopg2
import sys

def print_rows(rows):
    for row in rows:
        print(row[0])

#-----------------------------------------------------------------
# Comment Thank You on All Transactions From Customers
#-----------------------------------------------------------------

def alreadyCommented(transactionid, businessid):
    # Tells us if the business has already commented on the transaction
    tmpl = '''
          SELECT comment
            FROM Transaction
           WHERE transactionid = %s;
    '''
    cmd = cur.mogrify(tmpl, (transactionid,))
    cur.execute(cmd)
    comment = cur.fetchall()[0][0]
    if comment == None:
        return False
    elif str(businessid) in comment:
        return True
    else:
        return False

def thank_customers(businessid):
    # Thank customers of specific business for purchases
    tmpl = '''
        SELECT transactionid
          FROM Transaction
         WHERE receiverid = %s;
    '''
    cmd = cur.mogrify(tmpl, [businessid])
    cur.execute(cmd)
    data = cur.fetchall()

    print "Comments before thank you automation:"

    for transaction in data:
        cur.execute(cur.mogrify("SELECT comment FROM Transaction WHERE transactionid=%s;"),(transaction,))
        print_rows(cur.fetchall())

    for transaction in data:
        transactionid = transaction
        if not alreadyCommented(transactionid,businessid):
            update = '''
                UPDATE Transaction
                   SET comment = %s
                 WHERE transactionid = %s;
            '''
            cur.execute(cur.mogrify("SELECT comment FROM Transaction WHERE transactionid=%s;"),(transaction,))
            current = cur.fetchall()[0][0]
            # NOTE: We have formatted the comment field as follows:
            # (userid) Comment --- (userid) Comment
            # It is represented as one long string containing the entire conversation
            if current == None:
                newComment = "(" + str(businessid) + ")" + " Thank you for your purhcase" 
            else:
             newComment = current + " --- " + "(" + str(businessid) + ")" + " Thank you for your purhcase"             
            cmd = cur.mogrify(update, (newComment, transactionid))
            cur.execute(cmd)
    
    print "Comments after thank you automation:"
    for transaction in data:
        cur.execute(cur.mogrify("SELECT comment FROM Transaction WHERE transactionid=%s;"),(transaction,))
        print_rows(cur.fetchall())




if __name__ == '__main__':
    try:
        db, user = 'venmo', sys.argv[1]
        conn = psycopg2.connect(database=db, user=user)
        conn.autocommit = True
        cur = conn.cursor()
        thank_customers(10008)
    except psycopg2.Error as e:
        print("Unable to open connection: %s" % (e,))

