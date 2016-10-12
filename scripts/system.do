onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /system_tb/DUT/CPU/DP/fwd/write2
add wave -noupdate -radix unsigned /system_tb/DUT/CPU/DP/fwd/write1
add wave -noupdate -radix unsigned /system_tb/DUT/CPU/DP/fwd/read1
add wave -noupdate -radix unsigned /system_tb/DUT/CPU/DP/fwd/read2
add wave -noupdate -childformat {{{/system_tb/DUT/CPU/DP/RU/register[15]} -radix hexadecimal} {{/system_tb/DUT/CPU/DP/RU/register[6]} -radix hexadecimal}} -subitemconfig {{/system_tb/DUT/CPU/DP/RU/register[15]} {-height 17 -radix hexadecimal} {/system_tb/DUT/CPU/DP/RU/register[6]} {-height 17 -radix hexadecimal}} /system_tb/DUT/CPU/DP/RU/register
add wave -noupdate /system_tb/DUT/CPU/DP/fwd/forw_en5
add wave -noupdate /system_tb/DUT/CPU/DP/fwd/forw_en4
add wave -noupdate /system_tb/DUT/CPU/DP/memif/aluo
add wave -noupdate /system_tb/DUT/CPU/DP/aluf/input1
add wave -noupdate -radix decimal /system_tb/DUT/CPU/DP/aluf/input2
add wave -noupdate /system_tb/DUT/CPU/DP/aluf/output1
add wave -noupdate /system_tb/DUT/CPU/DP/dcif/decode_en
add wave -noupdate /system_tb/DUT/CPU/DP/haz/dhit
add wave -noupdate /system_tb/DUT/CPU/DP/excif/outputo
add wave -noupdate /system_tb/DUT/CPU/DP/excif/outputi
add wave -noupdate /system_tb/DUT/CPU/DP/dcif/rdat1o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {408281 ps} 0}
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
WaveRestoreZoom {0 ps} {678500 ps}
