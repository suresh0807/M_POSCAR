#USAGE: multirattle.sh POSCAR 2 2 2

mx=$2
my=$3
mz=$4

cat << EOF > multiply.py
from ase.io import read,write
import sys
a=read(sys.argv[1])
multi=[int(sys.argv[2]),int(sys.argv[3]),int(sys.argv[4])]
a=a.repeat(multi)
name=sys.argv[1]+sys.argv[2]+sys.argv[3]+sys.argv[3]
write(name,a,format='vasp')
EOF

python multiply.py $1 $2 $3 $4

RATTLEPOS.x ${1}${2}${3}${4} 1 10 0.1 -1 0.95 1.05
