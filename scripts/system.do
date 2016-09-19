onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/instr
add wave -noupdate /system_tb/DUT/CPU/DP/pcif/ladd
add wave -noupdate /system_tb/DUT/CPU/DP/PCS/new_pc
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate /system_tb/DUT/CPU/DP/RU/register
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate /system_tb/DUT/CPU/DP/rqif/dhiti
add wave -noupdate /system_tb/DUT/CPU/DP/rqif/iREN
add wave -noupdate /system_tb/DUT/CPU/DP/rqif/ihiti
add wave -noupdate /system_tb/DUT/CPU/DP/rqif/pcenable
add wave -noupdate /system_tb/DUT/CPU/DP/RQ/state
add wave -noupdate /system_tb/DUT/CPU/DP/RQ/old
add wave -noupdate /system_tb/DUT/CPU/DP/rqif/instr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {864373 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {623800 ps} {1019800 ps}
