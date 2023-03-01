#!/bin/bash
area0=500
nodes0=40
flows0=20
speed0=10
pkt0=200

str1="CSVs-mod/Area1"
str2="CSVs-mod/Area2"
str3="CSVs-mod/Area3"
str4="CSVs-mod/Area4"
str5="CSVs-mod/Nodes1"
str6="CSVs-mod/Nodes2"
str7="CSVs-mod/Nodes3"
str8="CSVs-mod/Nodes4"
str9="CSVs-mod/Flows1"
str10="CSVs-mod/Flows2"
str11="CSVs-mod/Flows3"
str12="CSVs-mod/Flows4"
str13="CSVs-mod/Speed1"
str14="CSVs-mod/Speed2"
str15="CSVs-mod/Speed3"
str16="CSVs-mod/Speed4"
str17="CSVs-mod/Pkt1"
str18="CSVs-mod/Pkt2"
str19="CSVs-mod/Pkt3"
str20="CSVs-mod/Pkt4"

str21="CSVs-mod/Area5"
str22="CSVs-mod/Area6"
str23="CSVs-mod/Nodes5"
str24="CSVs-mod/Nodes6"
str25="CSVs-mod/Flows5"
str26="CSVs-mod/Flows6"
str27="CSVs-mod/Speed5"
str28="CSVs-mod/Speed6"
str29="CSVs-mod/Pkt5"
str30="CSVs-mod/Pkt6"
for j in {1..10}
do
    cd CSVs-mod

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
        #ns 1805002_802.15.4.tcl $area $nodes0 $flows0 $speed0 $pkt0
        #awk -v num=$area -v str1=$str1 -v str2=$str2 -v str3=$str3 -v str4=$str4 -v str5=$str21 -v str6=$str22 -f parse.awk trace.tr
        
        echo "#########"
        echo "i = $i: params = Area: $area0, Nodes: $nodes, Flows: $flows0, Speed: $speed0, pkts: $pkt0"
        ns 1805002_802.15.4.tcl $area0 $nodes $flows0 $speed0 $pkt0
        awk -v num=$nodes -v str1=$str5 -v str2=$str6 -v str3=$str7 -v str4=$str8 -v str5=$str23 -v str6=$str24 -f parse.awk trace.tr

        echo "#########"
        echo "i = $i: params = Area: $area0, Nodes: $nodes0, Flows: $flows, Speed: $speed0, pkts: $pkt0"
        ns 1805002_802.15.4.tcl $area0 $nodes0 $flows $speed0 $pkt0
        awk -v num=$flows -v str1=$str9 -v str2=$str10 -v str3=$str11 -v str4=$str12 -v str5=$str25 -v str6=$str26 -f parse.awk trace.tr
        
        echo "#########"
        echo "i = $i: params = Area: $area0, Nodes: $nodes0, Flows: $flows0, Speed: $speed, pkts: $pkt0"
        ns 1805002_802.15.4.tcl $area0 $nodes0 $flows0 $speed $pkt0
        awk -v num=$speed -v str1=$str13 -v str2=$str14 -v str3=$str15 -v str4=$str16 -v str5=$str27 -v str6=$str28 -f parse.awk trace.tr

        echo "#########"
        echo "i = $i: params = Area: $area0, Nodes: $nodes0, Flows: $flows0, Speed: $speed0, pkts: $pkt"
        ns 1805002_802.15.4.tcl $area0 $nodes0 $flows0 $speed0 $pkt
        awk -v num=$pkt -v str1=$str17 -v str2=$str18 -v str3=$str19 -v str4=$str20 -v str5=$str29 -v str6=$str30 -f parse.awk trace.tr
        
        area=$(( $area + 250 ))
        nodes=$(( $nodes + 20 ))
        flows=$(( $flows + 10 ))
        speed=$(( $speed + 5 ))
        pkt=$(( $pkt + 100 ))

    done


    cd CSVs-mod

    cat Area1.csv >> ../avg-mod/Area1.csv
    cat Area2.csv >> ../avg-mod/Area2.csv
    cat Area3.csv >> ../avg-mod/Area3.csv
    cat Area4.csv >> ../avg-mod/Area4.csv
    cat Area5.csv >> ../avg-mod/Area5.csv
    cat Area6.csv >> ../avg-mod/Area6.csv

    cat Nodes1.csv >> ../avg-mod/Nodes1.csv
    cat Nodes2.csv >> ../avg-mod/Nodes2.csv
    cat Nodes3.csv >> ../avg-mod/Nodes3.csv
    cat Nodes4.csv >> ../avg-mod/Nodes4.csv
    cat Nodes5.csv >> ../avg-mod/Nodes5.csv
    cat Nodes6.csv >> ../avg-mod/Nodes6.csv

    cat Flows1.csv >> ../avg-mod/Flows1.csv
    cat Flows2.csv >> ../avg-mod/Flows2.csv
    cat Flows3.csv >> ../avg-mod/Flows3.csv
    cat Flows4.csv >> ../avg-mod/Flows4.csv
    cat Flows5.csv >> ../avg-mod/Flows5.csv
    cat Flows6.csv >> ../avg-mod/Flows6.csv

    cat Speed1.csv >> ../avg-mod/Speed1.csv
    cat Speed2.csv >> ../avg-mod/Speed2.csv
    cat Speed3.csv >> ../avg-mod/Speed3.csv
    cat Speed4.csv >> ../avg-mod/Speed4.csv
    cat Speed5.csv >> ../avg-mod/Speed5.csv
    cat Speed6.csv >> ../avg-mod/Speed6.csv

    cat Pkt1.csv >> ../avg-mod/Pkt1.csv
    cat Pkt2.csv >> ../avg-mod/Pkt2.csv
    cat Pkt3.csv >> ../avg-mod/Pkt3.csv
    cat Pkt4.csv >> ../avg-mod/Pkt4.csv
    cat Pkt5.csv >> ../avg-mod/Pkt5.csv
    cat Pkt6.csv >> ../avg-mod/Pkt6.csv

    cd ..
done