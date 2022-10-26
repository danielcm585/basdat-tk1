import sys

sys.stdin = open('transaction_actor_sql.txt','r')

emails = []
for i in range(40):
    row = input()
    email = row.split("'")[1].split("'")[0]
    emails.append(email)

sys.stdin = open('customer_sql.txt','r')

customer_emails = []
for i in range(20):
    row = input()
    email = row.split("'")[1].split("'")[0]
    if (email not in emails): print('customer woy')
    customer_emails.append(email)

sys.stdin = open('courier_sql.txt','r')

courier_emails = []
for i in range(10):
    row = input()
    email = row.split("'")[1].split("'")[0]
    if (email not in emails): print('courier woy')
    if (email in customer_emails): print('courier not disjoint')
    customer_emails.append(email)

sys.stdin = open('restaurant_sql.txt','r')

restaurant_emails = []
j = 0
for i in range(10):
    row = input()
    tmp = row.split('@')[0].split("'")
    old_email = tmp[len(tmp)-1] + '@gmail.com'
    if (old_email not in emails): print('restaurant woy', old_email)
    if (old_email in customer_emails or old_email in courier_emails): 
        while (emails[j] in customer_emails or emails[j] in courier_emails): 
            j += 1
        row.replace(old_email,emails[j])
        emails.append(emails[j])
        j += 1
    else: 
        emails.append(old_email)
    print(row) 
    