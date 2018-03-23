
# stat 8 kinds of papers for each
# $1 is name file, each name per line
# $2 is paper info, 包括: 一作,通讯作者,类型,杂志缩写
# e.g.
# 吴焕文,刘彤华,论著,M
# 鲁涛,钟定荣,论著,T

for name in `cat $1`
do
  awk -F"," 'BEGIN{ OFS=","; v["论著"]=0; v["综述"]=1; v["述评"]=1; v["病例报告"]=2; v["其它"]=3; o["S"] = 4; o["M"]=o["F"]=o["T"]=0; }
                 { m = 0;
                   split( $1, a, "=" ); for( i in a ) if( a[i] == "'"$name"'" ) ++m;
                   split( $1, a, "，" ); for( i in a ) if( a[i] == "'"$name"'" ) ++m;
                   split( $2, b, "=" ); for( i in b ) if( b[i] == "'"$name"'" ) ++m;
                   split( $2, b, "，" ); for( i in b ) if( b[i] == "'"$name"'" ) ++m;
                   if( m > 0 ) ++x[o[$4]+v[$3]]; }
             END{ print "'"$name"'", x[0], x[1], x[2], x[3], x[4], x[5], x[6], x[7]; }' $2;
done
