import sys 
import random
import datetime

sys.stdin = open('transaction_actors_emails.txt','r')

emails = []
for i in range(20):
    transaction_actor = input()
    email = transaction_actor[2:].split("'")[0]
    emails.append(email)

start_date = datetime.date(1970,2,1)
end_date = datetime.date(2008,3,1)
time_between_dates = end_date - start_date
days_between_dates = time_between_dates.days

gender = ['M','F']

print("insert into customer values")
for email in emails:
    random_number_of_days = random.randrange(days_between_dates)
    random_date = start_date + datetime.timedelta(days=random_number_of_days)
    print(f"('{email}','{random_date}','{random.choice(gender)}),")