onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Sine_tb/Clk_i
add wave -noupdate /Sine_tb/Angle_i
add wave -noupdate /Sine_tb/Start_i
add wave -noupdate -radix unsigned /Sine_tb/Sine_inst/Sine_o
add wave -noupdate -radix unsigned /Sine_tb/Sine_inst/Cos_o
add wave -noupdate /Sine_tb/Sine_inst/x
add wave -noupdate /Sine_tb/Sine_inst/y
add wave -noupdate /Sine_tb/Sine_inst/z
add wave -noupdate /Sine_tb/Sine_inst/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {376 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 60
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
WaveRestoreZoom {0 ns} {859 ns}
