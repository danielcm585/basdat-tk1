import sys
import random
import requests
import re

sys.stdin = open('transaction_actors_emails.txt','r')

emails = []
for i in range(20):
    transaction_actor = input()
    email = transaction_actor[2:].split("'")[0]
    emails.append(email)

sys.stdin = open('restaurant_categories.txt','r')

categories = []
for i in range(5):
    category = input()
    categories.append(category)

resp = requests.get('https://api.fungenerators.com/name/generate?category=restaurant&limit=40')
data = resp.json()
names = data.get('contents').get('names')

print("insert into restaurant values")
for i in range(40):
    resp = requests.get('https://api.fungenerators.com/identity/person')
    data = resp.json()
    print(data)
    
    phone = data.get('contents').get('phone')
    phone = re.sub(r'[^0-9]','',phone)[:15]

    street = data.get('contents').get('address').get('address')
    district = data.get('contents').get('address').get('state')
    city = data.get('contents').get('address').get('city')
    province = data.get('contents').get('address').get('state')
    rating = random.choice(range(11))
    category = random.choice(categories)

    name = names[i]

    print(f"('{names}','{city}','{random.choice(emails)}','{phone}','{street}','{district}','{city}','{province}','{rating}','{category}'),")