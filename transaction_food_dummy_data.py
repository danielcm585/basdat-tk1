import sys
import random

sys.stdin = open('transaction_foods.txt','r')

notes = ['No chili','Extra sauce please','Less sugar','']
amounts = [i for i in range(15)]

print("insert into transaction_food values")
for i in range(10):
    row = input()
    row += f"{random.choice(amounts)},'{random.choice(notes)}'),"
    print(row)