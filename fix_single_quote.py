import sys

sys.stdin = open('prev_sql.txt','r')
sys.stdout = open('fixed_sql.txt','w')

while (True):
    try:
        row = input()
        row = row.replace("’","'")
        row = row.replace("‘","'")
        print(row)
    except (EOFError):
        break

