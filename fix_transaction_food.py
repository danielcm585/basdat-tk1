import sys
import random

sys.stdin = open('transaction_actors_emails.txt','r')

emails = []
for i in range(30):
    email = input()
    emails.append(email)
    
sys.stdin = open('prev_transaction_food_sql.txt','r')

print("insert into transaction_food values")
for i in range(10):
    row = input()
    old_email = row.split("'")[1].split("'")[0]
    row = row.replace(old_email,random.choice(emails))
    print(row)