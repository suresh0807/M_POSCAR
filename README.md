# M_POSCAR
Set of scripts to reorder a POSCAR file and combine two POSCAR files for VASP

rePOS.sh: Reposition the element order in POSCAR file.

Usage e.g.: ./rePOS.sh 3 W O H


combPOS.sh: Combine two POSCAR files. Adding a template structure(s) to multiple POSCARS and a ./rePOS.sh maybe needed after it. Ideal if the two poscars have the same box dimensions. Coordinates are not adjusted in this program, so you may have to adjust your template POSCAR accordingly.

Usage: ./combPOS.sh POSCAR1 POSCAR2 POSCAR3
