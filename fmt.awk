#!/usr/bin/awk -f

BEGIN {
    if (maxlen=="") maxlen=15
    fmtfile=ARGV[1]
    nt=1;
    while((getline<fmtfile)>0) {
        line[nt]=$0
        nt++
    }
    delete ARGV[1]
    if (FS==" ")
        FS="[|,]"
} {
    for(i=1; i<=nt-1; i++) line[i]=line[i] FS substr($i,1,maxlen)
} END {
    for (i=1; i<=nt-1; i++) print line[i]
}


