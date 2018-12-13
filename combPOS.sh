#works only for Cartesian coordinates now
#removes selective dynamics as well!! sorry I was lazy!!

echo "backing up POSCAR..."
cp $1 $1-backup

echo "Checking the number of headers..."
first=`awk 'NR==1{print $1}' $1`
count=`grep -c "$first" $1`
if [ $count == "1" ]
then
aaa=`awk 'NR==6{print}' $1`
bbb=`awk 'NR==6{print}' $2`
elif [ $count == "2" ]
then
aaa=`awk 'NR==7{print}' $1`
bbb=`awk 'NR==7{print}' $2`
fi

echo "$aaa $bbb"
echo "getting the coordinates of the second file"
sed -e '1,/Cartesian/ d' $2 > a
#sed -e '1,/cartesian/ d' $2 > a
#sed -e '1,/cart/ d' $2 > a
#sed -e '1,/direct/ d' $2 > a
#sed -e '1,/Direct/ d' $2 > a

echo "counting the number of atoms to be added"
num=`wc -l < a`

aa=`head -n 1 $1`
bb=`head -n 1 $2`
sed -i 's/'"$aa"'/'"$aa $bb"'/g' $1
sed -i 's/'"$aaa"'/'"$aaa $bbb"'/g' $1

echo "adding the atoms to the first file and update indices"
cat $1 a > b && mv b $1

sed -i '/Sel/d' $1
rm a
