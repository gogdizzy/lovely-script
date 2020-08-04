
awk -F',' 'NR==1{ cols = NF; OFS=","; } NR!=1{ for( i = 1; i <= cols; ++i ) if($i=="") $i="NULL"; }1' ${1}
