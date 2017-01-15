#!/usr/local/bin/gawk -f

BEGIN {
    f1=1
    f2=2
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
        w=ARGV[3]
        delete ARGV[3]
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
    n1[$f1]+=wg
    n2[$f2]+=wg
    nt[$f1,$f2]+=wg
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

    # By column
    print "By column"
    header="-"
    for (j in ns2) header=header","ns2[j]
    header=header",Total"
    print header
    for (i in ns1) {
        line=ns1[i]
        for (j in ns2) {
            line=line","sprintf("%.2f%s",nt[ns1[i],ns2[j]]*100/n1[ns1[i]],"%")
        }
        line=line","sprintf("%.2f%s",n1[ns1[i]]*100/n1[ns1[i]],"%")
        print line
    }
    tail="Total"
    for (j in ns2) 
        tail=tail","sprintf("%.2f%s",n2[ns2[j]]*100/nr,"%")
    tail=tail",100.00%"
    print tail

    # By row
    print "By row"
    header="-"
    for (j in ns2) header=header","ns2[j]
    header=header",Total"
    print header
    for (i in ns1) {
        line=ns1[i]
        for (j in ns2) {
            line=line","sprintf("%.2f%s",nt[ns1[i],ns2[j]]*100/n2[ns2[j]],"%")
        }
        line=line","sprintf("%.2f%s",n1[ns1[i]]*100/nr,"%")
        print line
    }
    tail="Total"
    for (j in ns2) 
        tail=tail","sprintf("%.2f%s",n2[ns2[j]]*100/n2[ns2[j]],"%")
    tail=tail",100.00%"
    print tail

}
