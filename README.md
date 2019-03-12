# M_POSCAR
Set of scripts to manipulate POSCAR files for VASP

rePOS.sh: Reposition the element order/ remove an element in POSCAR file. Needs element names in the first line and atom numbers in the 6th line. Can also work when selective dynamics is on.

Usage: ./rePOS.sh 3 W O H


combPOS.sh: Combine two POSCAR files. Adding a template structure(s) to multiple POSCARS and a ./rePOS.sh maybe needed after it. Ideal if the two poscars have the same box dimensions. Coordinates are not adjusted in this program, so you may have to adjust your template POSCAR accordingly.

Usage: ./combPOS.sh POSCAR1 POSCAR2 POSCAR3


lattice_match.sh: Match the positions of the atoms at the edge of the periodic box between two POSCAR files (POSCAR1 and POSCAR2). It is very useful in obtaining consistent end point geometries needed for a nudged elastic band calculation - for interpolation points. Need the coordinates to be in cartesian and selective dynamics turned on. At present only works for the slab models with vacuum along the z direction. The two POSCARS must have the same periodic box dimensions and atoms in the same order. If needed, use rePOS.sh script before running lattice match. The script can be easily modified to include other usage scenarios. Needs POSCAR1 and POSCAR2 to be in the folder where the script is called.

Usage: ./lattice_match.sh
