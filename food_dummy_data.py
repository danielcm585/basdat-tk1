import sys 

sys.stdin = open('foods.txt','r')

food_names = []
food_descs = []
while (True):
    try:
        food = input()
        if (len(food) == 0): continue
        if (food[0] in '0123456789'):
            food_name = food.split('. ')[1]
            input()
            food_desc = input()
            food_names.append(food_name)
            food_descs.append(food_desc)
    except (EOFError):
        break

sys.stdin = open('prev_foods_sql.txt','r')

print("insert into food values")
for i in range(30):
    food = input()
    food = food.replace("’","'")

    old_food_name = food.split("'")[5].split("'")[0]

    food = food.replace(old_food_name,food_names[i])
    food = food.replace('x',food_descs[i])

    print(food)
