#POSCAR must have elements in the 1st line
#POSCAR must have number of atoms of elements in the 6th line
#usage ./rePOS.sh 4 W Ru N P

cp POSCAR POSCAR_backup
nelt=`head -n 1 POSCAR | awk '{print NF}'`

seldyn=`grep 'Selective dynamics' POSCAR_backup`
cart=`grep 'Cartesian' POSCAR_backup`
dirt=`grep 'Direct' POSCAR_backup`

echo "save elts $nelt"

for((i=1;i<=$nelt;i++))
do
        A[$i]=`awk -v ii=$i 'NR==1{print $ii}' POSCAR_backup`
        n[$i]=`awk -v ii=$i 'NR==6{print $ii}' POSCAR_backup`
        echo "${A[$i]} ${n[$i]}"
done

echo "save cart"
if [ $cart == "Cartesian" ]
then
        sed -e '1,/Cartesian/d' POSCAR_backup > cart
else
        sed -e '1,/Direct/d' POSCAR_backup > cart
fi

for((i=1;i<=$nelt;i++))
do
        head -n ${n[$i]} cart >> ${A[$i]}.cart
        sed -i 1,${n[$i]}d cart
done



echo "write POSCAR"
rm POSCAR
for((i=2;i<=$1+1;i++))
do
        printf "${!i} " >> POSCAR
done

printf "\n" >> POSCAR
head -n 5 POSCAR_backup | tail -n 4 >> POSCAR

for((i=2;i<=$1+1;i++))
do
        numi=`wc -l < ${!i}.cart`
        printf "$numi " >> POSCAR  
done
printf "\n" >> POSCAR
if [ $seldyn == "Selective dynamics" ]
then
        printf "Selective Dynamics \n" >> POSCAR
fi

if [ $cart == "Cartesian" ]
then
        printf "Cartesian \n" >> POSCAR
else
        printf "Direct \n" >> POSCAR
fi

for((i=2;i<=$1+1;i++))
do
        cat ${!i}.cart >> POSCAR
done


rm cart *.cart
