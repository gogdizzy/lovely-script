
# remove bom and useless char

perl -e 's/\xef\xbb\xbf//;' -pi $1
perl -e 's/\r//g;' -pi $1
perl -e 's/ //g;' -pi $1
