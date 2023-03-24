
awk -F',' '
NR==1{ cols = NF; OFS=","; $1=$1; }
NR!=1{ 
  for( i = 1; i <= cols; ++i )
  {
    if($i=="") $i="NA";
  }
}1' "${1}"
