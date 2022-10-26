import sys
import random

sys.stdin = open('food_ingredients.txt','r')

ingredients = [str(i).rjust(25,'0') for i in range(20)]

print("insert into food_ingredients values")
for i in range(30):
    row = input()
    row += f"{random.choice(ingredients)}),"
    print(row)