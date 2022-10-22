import sys
import random
import requests
import re
from random_address import real_random_address

sys.stdin = open('transaction_actors_emails.txt','r')

emails = []
for i in range(20):
    transaction_actor = input()
    email = transaction_actor[2:].split("'")[0]
    emails.append(email)

categories = []
for i in range(5):
    category_id = str(i).rjust(20,'0')
    categories.append(category_id)

sys.stdin = open('restaurant_names.txt','r')

names = []
for i in range(40):
    name = input()
    names.append(name)

print("insert into restaurant values")
for i in range(40):
    resp = requests.get('https://api.namefake.com/')
    data = resp.json()

    phone = data.get('phone_h')
    phone = re.sub(r'[^0-9]','',phone)[:15]

    address = real_random_address()
    street = address.get('address1')
    district = address.get('state')
    city = address.get('city')
    province = address.get('state')
    rating = random.choice(range(11))
    category = random.choice(categories)

    name = names[i]

    print(f"('{name}','{city}','{random.choice(emails)}','{phone}','{street}','{district}','{city}','{province}','{rating}','{category}'),")