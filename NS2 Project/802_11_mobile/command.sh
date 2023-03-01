#!/bin/bash
area0=500
nodes0=40
flows0=20
speed0=10
pkt0=200

str1="CSVs/Area1"
str2="CSVs/Area2"
str3="CSVs/Area3"
str4="CSVs/Area4"
str5="CSVs/Nodes1"
str6="CSVs/Nodes2"
str7="CSVs/Nodes3"
str8="CSVs/Nodes4"
str9="CSVs/Flows1"
str10="CSVs/Flows2"
str11="CSVs/Flows3"
str12="CSVs/Flows4"
str13="CSVs/Speed1"
str14="CSVs/Speed2"
str15="CSVs/Speed3"
str16="CSVs/Speed4"
str17="CSVs/Pkt1"
str18="CSVs/Pkt2"
str19="CSVs/Pkt3"
str20="CSVs/Pkt4"

str21="CSVs/Area5"
str22="CSVs/Area6"
str23="CSVs/Nodes5"
str24="CSVs/Nodes6"
str25="CSVs/Flows5"
str26="CSVs/Flows6"
str27="CSVs/Speed5"
str28="CSVs/Speed6"
str29="CSVs/Pkt5"
str30="CSVs/Pkt6"
for j in {1..10}
do
    cd CSVs

    echo "Area,Throughput">Area1.csv
    echo "Area,AvgDelay">Area2.csv
    echo "Area,DeliveryRatio">Area3.csv
    echo "Area,DropRatio">Area4.csv
    echo "Area,Energy/Pkt">Area5.csv
    echo "Area,Energy/Byte">Area6.csv

    echo "Nodes,Throughput">Nodes1.csv
    echo "Nodes,AvgDelay">Nodes2.csv
    echo "Nodes,DeliveryRatio">Nodes3.csv
    echo "Nodes,DropRatio">Nodes4.csv
    echo "Nodes,Energy/Pkt">Nodes5.csv
    echo "Nodes,Energy/Byte">Nodes6.csv

    echo "Flows,Throughput">Flows1.csv
    echo "Flows,AvgDelay">Flows2.csv
    echo "Flows,DeliveryRatio">Flows3.csv
    echo "Flows,DropRatio">Flows4.csv
    echo "Flows,Energy/Pkt">Flows5.csv
    echo "Flows,Energy/Byte">Flows6.csv

    echo "Speed,Throughput">Speed1.csv
    echo "Speed,AvgDelay">Speed2.csv
    echo "Speed,DeliveryRatio">Speed3.csv
    echo "Speed,DropRatio">Speed4.csv
    echo "Speed,Energy/Pkt">Speed5.csv
    echo "Speed,Energy/Byte">Speed6.csv

    echo "Pkt,Throughput">Pkt1.csv
    echo "Pkt,AvgDelay">Pkt2.csv
    echo "Pkt,DeliveryRatio">Pkt3.csv
    echo "Pkt,DropRatio">Pkt4.csv
    echo "Pkt,Energy/Pkt">Pkt5.csv
    echo "Pkt,Energy/Byte">Pkt6.csv

    cd ..

    area=$area0
    nodes=$nodes0
    flows=$flows0
    speed=$speed0
    pkt=$pkt0
    area=$(( $area - 250 ))
    nodes=$(( $nodes - 20 ))
    flows=$(( $flows - 10 ))
    speed=$(( $speed - 5 ))
    pkt=$(( $pkt - 100 ))

    for i in {1..5}
    do
        #echo "#########"
        #echo "i = $i: params = Area: $area, Nodes: $nodes0, Flows: $flows0, Speed: $speed0, pkts: $pkt0"
        #ns 1805002.tcl $area $nodes0 $flows0 $speed0 $pkt0
        #awk -v num=$area -v str1=$str1 -v str2=$str2 -v str3=$str3 -v str4=$str4 -v str5=$str21 -v str6=$str22 -f parse.awk trace.tr
        
        echo "#########"
        echo "i = $i: params = Area: $area0, Nodes: $nodes, Flows: $flows0, Speed: $speed0, pkts: $pkt0"
        ns 1805002.tcl $area0 $nodes $flows0 $speed0 $pkt0
        awk -v num=$nodes -v str1=$str5 -v str2=$str6 -v str3=$str7 -v str4=$str8 -v str5=$str23 -v str6=$str24 -f parse.awk trace.tr

        echo "#########"
        echo "i = $i: params = Area: $area0, Nodes: $nodes0, Flows: $flows, Speed: $speed0, pkts: $pkt0"
        ns 1805002.tcl $area0 $nodes0 $flows $speed0 $pkt0
        awk -v num=$flows -v str1=$str9 -v str2=$str10 -v str3=$str11 -v str4=$str12 -v str5=$str25 -v str6=$str26 -f parse.awk trace.tr
        
        echo "#########"
        echo "i = $i: params = Area: $area0, Nodes: $nodes0, Flows: $flows0, Speed: $speed, pkts: $pkt0"
        ns 1805002.tcl $area0 $nodes0 $flows0 $speed $pkt0
        awk -v num=$speed -v str1=$str13 -v str2=$str14 -v str3=$str15 -v str4=$str16 -v str5=$str27 -v str6=$str28 -f parse.awk trace.tr

        echo "#########"
        echo "i = $i: params = Area: $area0, Nodes: $nodes0, Flows: $flows0, Speed: $speed0, pkts: $pkt"
        ns 1805002.tcl $area0 $nodes0 $flows0 $speed0 $pkt
        awk -v num=$pkt -v str1=$str17 -v str2=$str18 -v str3=$str19 -v str4=$str20 -v str5=$str29 -v str6=$str30 -f parse.awk trace.tr
        
        area=$(( $area + 250 ))
        nodes=$(( $nodes + 20 ))
        flows=$(( $flows + 10 ))
        speed=$(( $speed + 5 ))
        pkt=$(( $pkt + 100 ))

    done


    cd CSVs

    cat Area1.csv >> ../avg/Area1.csv
    cat Area2.csv >> ../avg/Area2.csv
    cat Area3.csv >> ../avg/Area3.csv
    cat Area4.csv >> ../avg/Area4.csv
    cat Area5.csv >> ../avg/Area5.csv
    cat Area6.csv >> ../avg/Area6.csv

    cat Nodes1.csv >> ../avg/Nodes1.csv
    cat Nodes2.csv >> ../avg/Nodes2.csv
    cat Nodes3.csv >> ../avg/Nodes3.csv
    cat Nodes4.csv >> ../avg/Nodes4.csv
    cat Nodes5.csv >> ../avg/Nodes5.csv
    cat Nodes6.csv >> ../avg/Nodes6.csv

    cat Flows1.csv >> ../avg/Flows1.csv
    cat Flows2.csv >> ../avg/Flows2.csv
    cat Flows3.csv >> ../avg/Flows3.csv
    cat Flows4.csv >> ../avg/Flows4.csv
    cat Flows5.csv >> ../avg/Flows5.csv
    cat Flows6.csv >> ../avg/Flows6.csv

    cat Speed1.csv >> ../avg/Speed1.csv
    cat Speed2.csv >> ../avg/Speed2.csv
    cat Speed3.csv >> ../avg/Speed3.csv
    cat Speed4.csv >> ../avg/Speed4.csv
    cat Speed5.csv >> ../avg/Speed5.csv
    cat Speed6.csv >> ../avg/Speed6.csv

    cat Pkt1.csv >> ../avg/Pkt1.csv
    cat Pkt2.csv >> ../avg/Pkt2.csv
    cat Pkt3.csv >> ../avg/Pkt3.csv
    cat Pkt4.csv >> ../avg/Pkt4.csv
    cat Pkt5.csv >> ../avg/Pkt5.csv
    cat Pkt6.csv >> ../avg/Pkt6.csv

    cd ..
done