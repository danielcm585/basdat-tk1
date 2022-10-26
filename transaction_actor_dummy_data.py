import sys

sys.stdin = open('user_emails.txt','r')
sys.stdout = open('transaction_actors_emails.txt','w')

user_emails = []
admin_emails = []
for i in range(30):
    email = input()
    if (i < 5): admin_emails.append(email)
    user_emails.append(email)

sys.stdin = open('dummy_nik.txt','r')

niks = []
for i in range(30):
    inp = input()
    nik = inp.split()[1]
    niks.append(nik)

banks = ['BCA','Mandiri','BNI','BRI']

print("insert into transaction_actor values")
for i in range(30):
    bank_acc = "1234"
    resto_pay = "2345"
    print(f"('{user_emails[i]}','{niks[i]}','{banks[i%4]}','{bank_acc}','{resto_pay}','{admin_emails[i%5]}')")