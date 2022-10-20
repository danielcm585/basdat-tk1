import requests
import re

emails = []

print("insert into user values")
for i in range(30):
    resp = requests.get('https://api.namefake.com/')
    data = resp.json()

    f_name = data['name'].split()[0]
    l_name = data['name'].split()[1]
    email = f"{f_name}_{l_name}@gmail.com"
    password = data['password']
    phone_num = re.sub(r'[^0-9]', '', data['phone_h'])[:15]

    emails.append(email)

    print(f"('{email}','{password}','{phone_num}','{f_name}','{l_name}'),")

for email in emails: print(email)