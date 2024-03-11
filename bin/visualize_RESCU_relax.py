import os
import pkgutil
pkgutil.find_loader("dspawpy") or os.system("pip install dspawpy")
pkgutil.find_loader("pymatgen") or os.system("pip install pymatgen")
pkgutil.find_loader("numpy") or os.system("pip install numpy")

from dspawpy.io.write import to_file
from pymatgen.core.structure import Molecule
import numpy as np

with open("relaxationprocess.txt") as rp:
    lines = rp.readlines()
    eles = []
    poses = []
    for i, line in enumerate(lines):
        if i % 307 in [0, 1, 2, 3, 4, 5, 305, 306]:
            continue
        ll = line.split()
        eles.append(ll[1].removesuffix(":"))
        poses.append([float(ll[2]), float(ll[3]), float(ll[4])])
    eles = np.split(np.array(eles), len(eles) / 299)
    poses = np.split(np.array(poses), len(poses) / 299)

    ss = []
    for i, (ele, pos) in enumerate(zip(eles, poses)):
        s = Molecule(ele, pos)
        ss.append(s)
    to_file(ss, "relaxationprocess.pdb")

with open("fixed_Atom.xyz") as fa:
    lines = fa.readlines()
    eles = []
    poses = []
    fixes = []
    for i, line in enumerate(lines):
        if i < 2:
            continue
        ll = line.split()
        poses.append([float(ll[1]), float(ll[2]), float(ll[3])])
        fixes.append(int(ll[-1]))
        if int(ll[-1]) == 1:
            eles.append("C")
        else:
            eles.append(ll[0])

    s = Molecule(eles, poses)
    to_file(s, "fixed_Atom.pdb")
