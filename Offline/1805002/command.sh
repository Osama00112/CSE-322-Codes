#!/bin/bash
area0=500
nodes0=40
flows0=20

area=$area0
nodes=$nodes0
flows=$flows0
area=$(( $area - 250 ))
nodes=$(( $nodes - 20 ))
flows=$(( $flows - 10 ))


echo "Area,Throughput">Area1.csv
echo "Area,AvgDelay">Area2.csv
echo "Area,DeliveryRatio">Area3.csv
echo "Area,DropRatio">Area4.csv

echo "Nodes,Throughput">Nodes1.csv
echo "Nodes,AvgDelay">Nodes2.csv
echo "Nodes,DeliveryRatio">Nodes3.csv
echo "Nodes,DropRatio">Nodes4.csv

echo "Flows,Throughput">Flows1.csv
echo "Flows,AvgDelay">Flows2.csv
echo "Flows,DeliveryRatio">Flows3.csv
echo "Flows,DropRatio">Flows4.csv

str1="Area1"
str2="Area2"
str3="Area3"
str4="Area4"
str5="Nodes1"
str6="Nodes2"
str7="Nodes3"
str8="Nodes4"
str9="Flows1"
str10="Flows2"
str11="Flows3"
str12="Flows4"


for i in {1..5}
do
    ns 1805002.tcl $area $nodes0 $flows0
    awk -v num=$area -v str1=$str1 -v str2=$str2 -v str3=$str3 -v str4=$str4 -f parse.awk trace.tr
    
    ns 1805002.tcl $area0 $nodes $flows0
    awk -v num=$nodes -v str1=$str5 -v str2=$str6 -v str3=$str7 -v str4=$str8 -f parse.awk trace.tr

    ns 1805002.tcl $area0 $nodes0 $flows
    awk -v num=$flows -v str1=$str9 -v str2=$str10 -v str3=$str11 -v str4=$str12 -f parse.awk trace.tr
    

    area=$(( $area + 250 ))
    nodes=$(( $nodes + 20 ))
    flows=$(( $flows + 10 ))

done

