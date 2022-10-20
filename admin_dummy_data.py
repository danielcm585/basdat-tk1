import sys

sys.stdin = open('user_emails.txt','r')

print("insert into admin values")
for i in range(5):
    email = input()
    print(f"('{email}'),")