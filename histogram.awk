#!/usr/local/bin/gawk -f

BEGIN {
    f=0
    w=0
    if (ARGV[1]!="") {
        f=ARGV[1]
        delete ARGV[1]
    }
    if (ARGV[1]!="") {
        w=ARGV[1]
        delete ARGV[1]
    }
    if (FS==" ")
        FS="[|,]"
    if (ARGV[1]=="")
        ARGV[1]="/dev/stdin"
} {
    if (w==0)
        wg=1
    else
        wg=$w
    n[$f]+=wg
    nr+=wg
} END {
    asorti(n,ns)
    for (i in ns) 
        printf("%s,%d,%.2f%s\n",ns[i],n[ns[i]],n[ns[i]]*100/nr,"%")
}
