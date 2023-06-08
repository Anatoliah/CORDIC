onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SineWidnow_tb/SineWindow_inst/Clk_i
add wave -noupdate -format Analog-Step -height 74 -max 32375.0 -min -32375.0 -radix decimal /SineWidnow_tb/SineWindow_inst/X_i
add wave -noupdate -radix unsigned /SineWidnow_tb/SineWindow_inst/Sine_inst1/cnt
add wave -noupdate -format Analog-Step -height 74 -max 31729.0 -min -31733.0 -radix decimal /SineWidnow_tb/SineWindow_inst/Y_i
add wave -noupdate -format Analog-Step -height 74 -max 1023580000.0000001 -min -1023920000.0 -radix decimal /SineWidnow_tb/SineWindow_inst/Z_o
add wave -noupdate /SineWidnow_tb/SineWindow_inst/ValW_i
add wave -noupdate /SineWidnow_tb/SineWindow_inst/Sine_inst1/iter
add wave -noupdate -radix unsigned /SineWidnow_tb/SineWindow_inst/Sine_inst1/cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1510000 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {21 us}
