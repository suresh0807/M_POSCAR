#with ase installed, use this script as 'python POSCAR2xyz.py' to convert POSCAR in the folder to POSCAR.xyz
from ase import Atoms
from ase.io import read,write
a = read('POSCAR')
write('POSCAR.xyz', a)
