#!/bin/bash
#must have vasp_energy.sh in your PATH. run it in the main folder to list final energies of the structures in all subfolders
for i in */
do
cd $i
a=`vasp_energy.sh`
echo "$i $a"
cd ..
done
