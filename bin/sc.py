import os

a = input('min id: ')
b = input('max id: ')
for i in range(int(a), int(b) + 1):
    os.system(f'scancel {i}')
os.system('squeue')


