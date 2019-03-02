#with ase installed, use 'python D2C.py' in the folder with POSCAR to convert the direct coordinated to cartesian. It is similar to opening the POSCAR in ASE and saving it.
from ase import Atoms
from ase.io import read,write
a = read('POSCAR')
write('POSCAR', a)
