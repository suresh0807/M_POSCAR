#with ase installed, use 'python D2C.py XXX' to convert direct coordinated XXX to cartesian. It is similar to opening the POSCAR in ASE and saving it.
from ase import Atoms
from ase.io import read,write
print ("converting ",sys.argv[1]," to POSCAR")
a = read(sys.argv[1])
write('POSCAR', a)
