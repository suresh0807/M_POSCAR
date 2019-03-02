#!/bin/bash
#extracts energy from OUTCAR and plots it with gnuplot. Run it in the vasp run folder
grep 'free  energy   TOTEN  =' OUTCAR | awk '{print $5}' > energy
gnuplot <<- EOF
p 'energy' w l
pause mouse close
