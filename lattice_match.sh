head -n 8 POSCAR1 > POSCAR2-tmp
x=`awk 'NR==3{print $1/2}' POSCAR1`
y=`awk 'NR==4{print $2/2}' POSCAR1`
z=`awk 'NR==5{print $3/2}' POSCAR1`
echo "$x $y $z"

tail -n +9 POSCAR1 > a
tail -n +9 POSCAR2 > b
paste a b > c
awk -v xx="$x" -v yy="$y" -v zz="$z" '{if( ($1-$7)>xx && ($2-$8)>yy ) print "  "$7+(xx*2)" "$8+(yy*2)" "$9" "$10" "$11" "$12; else if( ($1-$7)>xx && ($2-$8)<yy ) print "  "$7+(xx*2)" "$8" "$9" "$10" "$11" "$12; else if( ($1-$7)<xx && ($2-$8)>yy ) print "  "$7" "$8+(yy*2)" "$9" "$10" "$11" "$12; else if( ($1-$7)>xx && ($2-$8)<-yy ) print "  "$7+(xx*2)" "$8-(yy*2)" "$9" "$10" "$11" "$12; else if( ($1-$7)<xx && ($2-$8)<-yy ) print "  "$7" "$8-(yy*2)" "$9" "$10" "$11" "$12; else if( ($1-$7)<-xx && ($2-$8)>yy ) print "  "$7-(xx*2)" "$8+(yy*2)" "$9" "$10" "$11" "$12; else if( ($1-$7)<-xx && ($2-$8)<yy ) print "  "$7-(xx*2)" "$8" "$9" "$10" "$11" "$12; else if( ($1-$7)<-xx && ($2-$8)<-yy ) print "  "$7-(xx*2)" "$8-(yy*2)" "$9" "$10" "$11" "$12; else if( (($1-$7)>-xx && ($2-$8)>-yy) || (($1-$7)<xx && ($2-$8)<yy) ) print "  "$7" "$8" "$9" "$10" "$11" "$12; }' c >> POSCAR2-tmp

rm a b c
