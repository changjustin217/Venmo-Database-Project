import psycopg2
import sys
import matplotlib.pyplot as plt

#-----------------------------------------------------------------
# Graph the Trends of the Number of Transactions Each Month
#-----------------------------------------------------------------

def graph_trends():
    tmpl = '''
          SELECT EXTRACT(month from time), COUNT(*)
            FROM Transaction
        GROUP BY EXTRACT(month from time);
    '''
    cur.execute(tmpl)
    data = cur.fetchall()
    months = ['Jan','Feb','Mar','Apr','May','June',
              'July','Aug','Sep','Oct','Nov','Dec']
    new = [(int(x[0])-1,x[1]) for x in data]
    new.sort(key=lambda y: y[0])
    dates  = [x[0] for x in new]
    counts = [y[1] for y in new] 
    plt.xticks(dates, months)
    plt.plot(dates, counts)
    plt.title("Transactions By Month")
    plt.show()


if __name__ == '__main__':
    try:
        db, user = 'venmo', sys.argv[1]
        conn = psycopg2.connect(database=db, user=user)
        conn.autocommit = True
        cur = conn.cursor()
        graph_trends()
    except psycopg2.Error as e:
        print("Unable to open connection: %s" % (e,))


