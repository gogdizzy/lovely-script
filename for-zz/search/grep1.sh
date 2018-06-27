# 每行的第2列是起始点
# 第8列是 END=xxx 表示终点
# 每个区间没有重叠
# 找一个点位位于哪一行，输出该行

awk '{ if( $1 == "'"$1"'" ) { \
  end = $2;
  if( $8 ~ /^END=/ ) {
    split( $8, a, "=");
    end = a[2];
  }
  if( $2 <= '"$2"' && '"$2"' <= end ) { print $0; exit; } } }' $3

