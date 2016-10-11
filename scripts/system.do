onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -radix binary /system_tb/DUT/CPU/DP/cuif/rt
add wave -noupdate -radix binary /system_tb/DUT/CPU/DP/cuif/rs
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -radix binary /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -radix binary /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate /system_tb/DUT/CPU/DP/RU/register
add wave -noupdate /system_tb/DUT/CPU/DP/haz/write2
add wave -noupdate /system_tb/DUT/CPU/DP/haz/write1
add wave -noupdate /system_tb/DUT/CPU/DP/haz/read2
add wave -noupdate /system_tb/DUT/CPU/DP/haz/read1
add wave -noupdate /system_tb/DUT/CPU/DP/HZ/enable
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1571817 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 218
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
WaveRestoreZoom {1221300 ps} {1899800 ps}
