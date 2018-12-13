#!/bin/bash
#Thanks to Tobias Moraweitz

bohr2ang=0.529177249

i=0

for file in `grep atom $1 | awk '{print $5}' | uniq`
do
	i=`echo $i +1 | bc -ql`

	elem[$i]=$file
	elem_count[$i]=`grep atom $1 | grep "$file " | wc -l`
done

n_elems=${#elem[@]}

echo ${elem[@]}
printf "   1.00\n"
grep lattice $1 | awk -v bohr2ang=$bohr2ang '{printf "%18.8f %18.8f %18.8f\n", $2*bohr2ang, $3*bohr2ang, $4*bohr2ang}'
echo ${elem_count[@]}
printf "CARTESIAN\n"

for file in `echo ${elem[@]}`
do
	grep atom $1 | grep "$file " | awk -v bohr2ang=$bohr2ang '{printf "%18.8f %18.8f %18.8f\n", $2*bohr2ang, $3*bohr2ang, $4*bohr2ang}'
done

