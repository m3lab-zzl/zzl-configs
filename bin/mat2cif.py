# -*- coding: utf-8 -*-
"""
Extract lattice vectors and atom info from saved mat file
"""
import os
import pkgutil
pkgutil.find_loader("pymatreader") or os.system("pip install pymatreader")
pkgutil.find_loader("ase") or os.system("pip install ase")

from ase.atoms import Atom, Atoms
from ase.io import write
from pymatreader import read_mat

a = read_mat("H_scf.mat")
latvec = a["domain"]["latvec"]
poses = a["atom"]["xyz"]  # np.ndarray
ele_ind_list = a["atom"]["element"]  # [1,1,2,2]
ele_species_list = a["element"]["species"]  # ['H','Li']

atom_list = []
for i in range(len(ele_ind_list)):
    atom = Atom(ele_species_list[int(ele_ind_list[i]) - 1], poses[i])
    atom_list.append(atom)
ats = Atoms(atom_list, cell=latvec)
print(ats)
print("--> Writing to atoms.cif file...")
write("atoms.cif", ats)
