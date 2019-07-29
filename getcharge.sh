nions=`grep NIONS OUTCAR | awk '{print $12}'`
sed -n '/\# of ion       s       p       d       tot/,/--------------------------------------------------/p' OUTCAR | tail -n +3 | head -n $nions | awk '{print $5}'> b
python ~/bin/POSCAR2xyz.py
tail -n+3 POSCAR.xyz | awk '{print $1 " " $4}' | awk 'NF' > a
paste a b > charge
rm a b
