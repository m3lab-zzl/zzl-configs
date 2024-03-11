"""
暂停、重启或终止并行计算任务
"""
import os

name = input("job name:")

os.system("ps -C %s" % name)
# it's better to check them manually
a = int(input("mimimum PID: "))
b = int(input("maximum PID: "))
while True:
    aim = input("Pause or Continue or Kill jobs?")
    for i in range(a, b + 1):
        if aim.startswith("P") or aim.startswith("p"):
            os.system("kill -STOP %d" % i)
        elif aim.startswith("C") or aim.startswith("c"):
            os.system("kill -CONT %d" % i)
        elif aim.startswith("K") or aim.startswith("k"):
            os.system("kill %d" % i)
        else:
            print("  -->you should only input (P)p or (C)c or (K)k\n" + "-" * 20)
            break
    if aim.startswith("P") or aim.startswith("p"):
        print("job paused")
        break
    elif aim.startswith("C") or aim.startswith("c"):
        print("job continued")
        break
    elif aim.startswith("K") or aim.startswith("k"):
        print("job killed")
        break
    else:
        continue
print("please use htop command to check status...")
