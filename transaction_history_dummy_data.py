import sys 
import random

sys.stdin = open('transaction_actors_emails.txt','r')

emails = []
for i in range(30):
    email = input()
    emails.append(email)

statuses = [str(i).rjust(25,'0') for i in range(5)]

sys.stdin = open('prev_transaction_history_sql.txt','r')

for i in range(10):
    row = input()
    old_email = row.split("'")[1].split("'")[0]
    row = row.replace(old_email,random.choice(emails))
    row += f"'{random.choice(statuses)}'),"
    print(row)