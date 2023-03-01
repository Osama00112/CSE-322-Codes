set ns [new Simulator]

set area        [lindex $argv 0]
set nodes       [lindex $argv 1]
set flows       [lindex $argv 2]
set speed       [lindex $argv 3]
set pktPerSec   [lindex $argv 4]

# ======================================================================
# Define options
set val(chan)         Channel/WirelessChannel   ;# channel type
set val(prop)         Propagation/TwoRayGround  ;# radio-propagation model
set val(ant)          Antenna/OmniAntenna       ;# Antenna type
set val(ll)           LL                        ;# Link layer type
set val(ifq)          Queue/DropTail/PriQueue   ;# Interface queue type
set val(ifqlen)       50                        ;# max packet in ifq
set val(netif)        Phy/WirelessPhy           ;# network interface type
set val(mac)          Mac/802_11                ;# MAC type
set val(rp)           AODV                      ;# ad-hoc routing protocol 
set val(nn)           $nodes                    ;# number of mobilenodes
set val(energymodel_11)    			EnergyModel     ;
set val(initialenergy_11)  			1000            ;# Initial energy in Joules
set val(idlepower_11) 				900e-3			;#Stargate (802.11b) 
set val(rxpower_11) 				925e-3			;#Stargate (802.11b)
set val(txpower_11) 				1425e-3			;#Stargate (802.11b)
set val(sleeppower_11) 				300e-3			;#Stargate (802.11b)
set val(transitionpower_11) 		200e-3			;#Stargate (802.11b)	?
set val(transitiontime_11) 			3				;#Stargate (802.11b)

#set nowValue [Phy/WirelessPhy set Pt_]              ;#   0.001
#puts "INSIDE TCL FILE, INITIAL VALUE of Pt_ = $nowValue of Pt_"
#set newValue_Pt [expr $coefficientOfTX * $coefficientOfTX * $nowValue];	#To change coverage area, multiply with coefficient^2 X Pt_
#Phy/WirelessPhy set Pt_ 			$newValue_Pt;	
# =======================================================================

# trace file
set trace_file [open trace.tr w]
$ns trace-all $trace_file

# nam file
set nam_file [open animation.nam w]
$ns namtrace-all-wireless $nam_file $area $area

# topology: to keep track of node movements
set topo [new Topography]
$topo load_flatgrid $area $area ;# 500m x 500m area

# general operation director for mobilenodes
create-god $val(nn)

$ns node-config -adhocRouting $val(rp) \
                -llType $val(ll) \
                -macType $val(mac) \
                -ifqType $val(ifq) \
                -ifqLen $val(ifqlen) \
                -antType $val(ant) \
                -propType $val(prop) \
                -phyType $val(netif) \
                -topoInstance $topo \
                -channelType $val(chan) \
                -agentTrace ON \
                -routerTrace ON \
                -macTrace OFF \
                -movementTrace OFF \
                -energyModel $val(energymodel_11) \
                -idlePower $val(idlepower_11) \
                -rxPower $val(rxpower_11) \
                -txPower $val(txpower_11) \
                -sleepPower $val(sleeppower_11) \
                -transitionPower $val(transitionpower_11) \
                -transitionTime $val(transitiontime_11) \
                -initialEnergy $val(initialenergy_11)
                
                #\
                #-energyModel "EnergyModel" \
                #-rxPower (in W) \
                #-txPower (in W) \
                #-initialEnergy (in Joules)

# a procedure for getting random number. sourc: https://stackoverflow.com/questions/30121920/generate-random-number-within-specified-range-without-redundancy-in-tcl
proc myRandInt {min max} {
    set range [expr {$max - $min + 1}]
    return [expr {$min + int(rand() * $range)}]
}

proc myRandFloat {min max} {
    set range [expr {$max - $min + 1}]
    return [expr {$min + (rand() * $range)}]
}

# create nodes
for {set i 0} {$i < $val(nn) } {incr i} {
    set node($i) [$ns node]
    $node($i) random-motion 0       ;# disable random motion

    set areaMinusOne [expr {$area - 1}]

    set x0          [myRandFloat 0.1 $areaMinusOne]
    set y0          [myRandFloat 0.1 $areaMinusOne]
    set x1          [myRandFloat 0.1 $areaMinusOne]
    set y1          [myRandFloat 0.1 $areaMinusOne]

    set time        [myRandFloat 0.5 49.5]
    set velocity    [myRandFloat 1 5]

    $node($i) set X_ $x0
    $node($i) set Y_ $y0
    $node($i) set Z_ 0

    $ns at $time "$node($i) setdest $x1 $y1 $speed"
    $ns initial_node_pos $node($i) 20
} 

#set val(nf)         [expr {$nodes/2}]                ;# number of flows
for {set i 0} {$i < $flows} {incr i} {
    set src -1
    set dest -1

    set flag 1

    while {$flag == 1} {
        set src [myRandInt 0 [expr {$nodes - 1}]]
        #puts "src is $src"
        set dest [myRandInt 0 [expr {$nodes - 1}]]
        #puts "dest is $dest"

        if { $src != $dest} {
            set flag 0
        } else {
            set flag 1
        }
    }
    
    # create agent
    set tcp [new Agent/TCP]
    set tcp_sink [new Agent/TCPSink]
    # attach to nodes
    $ns attach-agent $node($src) $tcp
    $ns attach-agent $node($dest) $tcp_sink
    # connect agents
    $ns connect $tcp $tcp_sink
    $tcp set fid_ $i

    # Traffic generator
    set ftp [new Application/FTP]
    # attach to agent
    $ftp attach-agent $tcp
    $ftp set rate_ $pktPerSec


    #set udp0 [new Agent/UDP]
    #$ns attach-agent $node($src) $udp0

    # Create a CBR traffic source and attach it to udp0
    #set cbr0 [new Application/Traffic/CBR]
    #$cbr0 set packetSize_ 64
    #$cbr0 set interval_ 0.005
    #$cbr0 set random_ false
    #$cbr0 attach-agent $udp0

    #Create a Null agent (a traffic sink) and attach it to node n(3)
    #set null0 [new Agent/Null]
    #$ns attach-agent $node($dest) $null0

    #Connect the traffic source with the traffic sink
    #$ns connect $udp0 $null0  

    #Schedule events for the CBR agent and the network dynamics
    $ns at 0.5 "$ftp start"
    $ns at 49.5 "$ftp stop"    
}


# Stop nodes
for {set i 0} {$i < $val(nn)} {incr i} {
    $ns at 50.0 "$node($i) reset"
}

# call final function
proc finish {} {
    global ns trace_file nam_file
    $ns flush-trace
    close $trace_file
    close $nam_file
}

proc halt_simulation {} {
    global ns
    puts "Simulation ending"
    $ns halt
}

$ns at 50.0001 "finish"
$ns at 50.0002 "halt_simulation"

# Run simulation
puts "Simulation starting"
$ns run

