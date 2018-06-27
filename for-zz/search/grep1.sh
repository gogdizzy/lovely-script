# 每行的第2列是起始点
# 第8列是 END=xxx 表示终点
# 每个区间没有重叠
# 找一个点位位于哪一行，输出该行

awk '{ split( $8, a, "="); if( $2 <= '"$1"' && '"$1"' <= a[2] ) { print $0; exit; } }' $2
