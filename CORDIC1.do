onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Analog-Step -height 74 -max 32375.0 -min -32375.0 -radix decimal /Sine_tb/Cordic_instO/cos_o
add wave -noupdate -format Analog-Step -height 74 -max 32375.0 -min -32375.0 -radix decimal /Sine_tb/Cordic_instO/sin_o
add wave -noupdate -radix decimal /Sine_tb/Cordic_instO/precompAngle
add wave -noupdate /Sine_tb/Cordic_instO/phase_inc_i
add wave -noupdate -radix decimal /Sine_tb/Cordic_instO/current_phase
add wave -noupdate -expand /Sine_tb/Cordic_instO/x_pipe
add wave -noupdate /Sine_tb/Cordic_instO/y_pipe
add wave -noupdate {/Sine_tb/Cordic_instO/cordic_pipe[15]/cordic_rotation_inst/X_i}
add wave -noupdate {/Sine_tb/Cordic_instO/cordic_pipe[15]/cordic_rotation_inst/shiftedInX}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {290000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 155
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
WaveRestoreZoom {0 ps} {1248340 ps}
