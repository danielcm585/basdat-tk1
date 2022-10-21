import sys

sys.stdin = open('ingredients.txt','r')

print("insert into ingredient values")
for i in range(20):
    ingredient = input()
    id = str(i).rjust(25,'0')
    print(f"('{id}','{ingredient}'),")