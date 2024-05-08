from random import randint

n = randint(1, 3)

print(n)

for i in range(n):
    x = randint(0, (1 << 64) - 1)
    t = randint(1, 8)
    if t == 1:
        x = 0
    if t == 2:
        x = (1 << 64) - 1
#    if t > 0 and i == n - 1:
#        x = 1 << 63
#    else:
#        x = 0
    print(f'{x:064b}')

y = randint(-(1 << 63), (1 << 63) - 1)
y = randint(1, 8) * (-1 + 2 * randint(0, 1))
y = -1

print(y)
