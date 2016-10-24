onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/state
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/dcif/indx
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/dcif/offset
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/dcif/dREN
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/dcif/dhit
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/dcif/tag
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/dcif/dWEN
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/dcif/memout
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/dcif/halt
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/dcif/dstore
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/dcif/flushed
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/dcif/datomic
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/replace
add wave -noupdate /system_tb/DUT/CPU/CM/ICACHE/icif/dREN
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/nextstate
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/RU/register
add wave -noupdate /system_tb/DUT/CPU/DP/pcif/ladd
add wave -noupdate /system_tb/DUT/CPU/CM/dcif/imemaddr
add wave -noupdate /system_tb/DUT/CPU/CM/icaif/address
add wave -noupdate /system_tb/DUT/CPU/CM/ICACHE/icif/ihit
add wave -noupdate /system_tb/DUT/CPU/CM/ICACHE/icif/memout
add wave -noupdate /system_tb/DUT/CPU/dcif/halt
add wave -noupdate /system_tb/DUT/CPU/DP/fif/fetch_opcodei
add wave -noupdate /system_tb/DUT/CPU/DP/excif/execute_opcodeo
add wave -noupdate /system_tb/DUT/CPU/DP/dcif/decode_opcodeo
add wave -noupdate /system_tb/DUT/CPU/DP/memif/memory_opcodeo
add wave -noupdate /system_tb/DUT/CPU/DP/memif/memory_opcodeo
add wave -noupdate /system_tb/DUT/CPU/CM/CLK
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/cif/dREN
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {260000 ps} 0}
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
WaveRestoreZoom {0 ps} {1681334 ps}
