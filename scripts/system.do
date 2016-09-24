onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/DUT/CPU/DP/CLK
add wave -noupdate /system_tb/DUT/CPU/CLK
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/instr
add wave -noupdate -radix binary /system_tb/DUT/CPU/DP/CU/rinstrop
add wave -noupdate /system_tb/DUT/CPU/DP/memif/reg_wro
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate /system_tb/DUT/CPU/DP/excif/wdato
add wave -noupdate -radix binary /system_tb/DUT/CPU/DP/CU/iinstrop
add wave -noupdate /system_tb/DUT/CPU/DP/RU/register
add wave -noupdate /system_tb/DUT/CPU/DP/memif/WENo
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1645278 ps} 0}
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
WaveRestoreZoom {0 ps} {3125662 ps}
