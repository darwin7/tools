#!/usr/bin/awk -f

BEGIN {
    f=0
    if (argv[1]!="") {
        f=argv[1]
        delete argv[1]
    }
} {
    nr++
    n[$f]+=1
} END {
    for (i in n) 
        printf("%s,%d,%.2f%s\n",i,n[i],n[i]*100/nr,"%")
}
