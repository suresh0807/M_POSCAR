#!/bin/bash
#run it inside the vasp run folder to extract energy
grep ' free  energy   TOTEN  =' OUTCAR | awk '{print $5}' | tail -n 1
