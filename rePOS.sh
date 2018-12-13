cp POSCAR POSCAR-backup
a=`echo "$1"`
poscar2runner.sh < POSCAR > input.data
head -n 4 input.data > header
tail -n 3 input.data > footer
for((i=2;i<=$a+1;i++))
do
grep "${!i} " input.data > $i
done

cat header > input.new

for((i=2;i<=$a+1;i++))
do
cat $i >> input.new
rm $i
done

cat footer >> input.new


runner2poscar.bash input.new > POSCAR

rm input.data input.new header footer
