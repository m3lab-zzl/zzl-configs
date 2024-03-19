from ase.io import read, write
import numpy as np

a = float(input("a: "))
b = float(input("b: "))
c = float(input("c: "))

device = read("device.xyz")
poses = device.get_positions()
# sort by z
newposes = poses[poses[:, 2].argsort()] - np.array([a / 2, b / 2, c / 2])
device.set_positions(newposes)
print(device.get_positions())
write("device_sorted.xyz", device)
