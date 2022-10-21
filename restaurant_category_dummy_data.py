import sys

sys.stdin = open('restaurant_categories.txt','r')

print("insert into restaurant_category values")
for i in range(5):
    category = input()
    id = str(i).rjust(20,'0')
    print(f"('{id}','{category}'),")