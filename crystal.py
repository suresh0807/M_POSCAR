#edit space group, symbols, basis and cell parameters below and choose preferred surface plane and layers
#You could get the above information by using the aflow online wrapper and using poscar to wyccar

import sys
from ase.spacegroup import crystal
from ase.visualize import view
from ase import Atoms
from ase.build import surface
from ase.io import write


atoms = crystal(spacegroup=189,
                symbols=['N','Ta','Ta'],
                basis=[[0,0.3926,0],[0,0,0],[0.6667,0.3333,0.5]],
                cellpar=[5.2278,5.2278,2.9194,90.0,90.0,120.0])

s1 = surface(atoms, (0, 1, 1), 5)
s1.center(vacuum=6, axis=2)

write('POSCAR',s1,format='vasp')
