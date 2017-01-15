#!/usr/local/bin/gawk -f

BEGIN {
    f1=1
    f2=2
    f3=3
    w=0
    if (ARGV[1]!="") {
        f1=ARGV[1]
        delete ARGV[1]
    }
    if (ARGV[2]!="") {
        f2=ARGV[2]
        delete ARGV[2]
    }
    if (ARGV[3]!="") {
        f3=ARGV[3]
        delete ARGV[3]
    }
    if (ARGV[4]!="") {
        w=ARGV[4]
        delete ARGV[4]
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
    nr+=wg
    tr+=wg*$(f3)
    n1[$f1]+=wg
    n2[$f2]+=wg
    nt[$f1,$f2]+=wg
    t1[$f1]+=wg*$(f3)
    t2[$f2]+=wg*$(f3)
    tt[$f1,$f2]+=wg*$(f3)
} END {
    asorti(n1,ns1)
    asorti(n2,ns2)
    # Totals
    print "Total"
    header="-"
    for (j in ns2) header=header","ns2[j]
    header=header",Total"
    print header
    for (i in ns1) {
        line=ns1[i]
        for (j in ns2) {
            line=line","sprintf("%d",nt[ns1[i],ns2[j]])
        }
        line=line","sprintf("%d",n1[ns1[i]])
        print line
    }
    tail="Total"
    for (j in ns2) 
        tail=tail","sprintf("%d",n2[ns2[j]])
    tail=tail","sprintf("%d",nr)
    print tail

    # Sum
    print "Sum"
    header="-"
    for (j in ns2) header=header","ns2[j]
    header=header",Total"
    print header
    for (i in ns1) {
        line=ns1[i]
        for (j in ns2) {
            line=line","sprintf("%d",tt[ns1[i],ns2[j]])
        }
        line=line","sprintf("%d",t1[ns1[i]])
        print line
    }
    tail="Total"
    for (j in ns2) 
        tail=tail","sprintf("%d",t2[ns2[j]])
    tail=tail","sprintf("%d",tr)
    print tail

    # Mean
    print "Mean"
    header="-"
    for (j in ns2) header=header","ns2[j]
    header=header",Total"
    print header
    for (i in ns1) {
        line=ns1[i]
        for (j in ns2) {
            line=line","sprintf("%.2f",nt[ns1[i],ns2[j]]/tt[ns1[i],ns2[j]])
        }
        line=line","sprintf("%.2f",n1[ns1[i]]/t1[ns1[i]])
        print line
    }
    tail="Total"
    for (j in ns2) 
        tail=tail","sprintf("%.2f",n2[ns2[j]]/t2[ns2[j]])
    tail=tail","sprintf("%.2f",nr/tr)
    print tail

}
