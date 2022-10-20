import sys
import requests
import random

sys.stdin = open('user_emails.txt','r')

emails = []
for i in range(30):
    email = input()
    emails.append(email)

print("insert into courier values")
for i in range(20):
    resp = requests.get('https://randomlicenseplate.com/license-plate')
    resp = resp.text
    plate_num = resp.split('License Plate">')[1].split('<')[0]
    vehicle_brand = resp.split('Make')[1].split('<td>')[1].split('</td>')[0]
    vehicle_type = resp.split('Description')[1].split('<td>')[1].split('</td>')[0]
    drivers_license = str(i).rjust(14,'0')
    print(f"('{emails[i]}','{plate_num}','{drivers_license}','{vehicle_type}','{vehicle_brand}'),")