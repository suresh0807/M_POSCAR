# M_POSCAR
Set of scripts to reorder a POSCAR file and combine two POSCAR files for VASP

rePOS.sh: Reposition the element order/ remove an element in POSCAR file. Needs element names in the first line and atom numbers in the 6th line. Can also work when selective dynamics is on.

Usage e.g.: ./rePOS.sh 3 W O H


combPOS.sh: Combine two POSCAR files. Adding a template structure(s) to multiple POSCARS and a ./rePOS.sh maybe needed after it. Ideal if the two poscars have the same box dimensions. Coordinates are not adjusted in this program, so you may have to adjust your template POSCAR accordingly.

Usage: ./combPOS.sh POSCAR1 POSCAR2 POSCAR3
