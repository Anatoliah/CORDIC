onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Sine_tb/Clk_i
add wave -noupdate /Sine_tb/Sine_inst/Rst_i
add wave -noupdate /Sine_tb/Sine_inst/Start_i
add wave -noupdate -radix hexadecimal /Sine_tb/Sine_inst/Cos_o
add wave -noupdate -radix decimal /Sine_tb/Sine_inst/Sine_o
add wave -noupdate /Sine_tb/Sine_inst/xPipe
add wave -noupdate /Sine_tb/Sine_inst/yPipe
add wave -noupdate /Sine_tb/Sine_inst/Sign
add wave -noupdate /Sine_tb/Sine_inst/start_flag
add wave -noupdate /Sine_tb/Sine_inst/SignPrev
add wave -noupdate /Sine_tb/Sine_inst/Angle_i
add wave -noupdate /Sine_tb/Sine_inst/phaseDiffPipe
add wave -noupdate -radix decimal -childformat {{{/Sine_tb/Sine_inst/currPhase[15]} -radix decimal} {{/Sine_tb/Sine_inst/currPhase[14]} -radix decimal} {{/Sine_tb/Sine_inst/currPhase[13]} -radix decimal} {{/Sine_tb/Sine_inst/currPhase[12]} -radix decimal} {{/Sine_tb/Sine_inst/currPhase[11]} -radix decimal} {{/Sine_tb/Sine_inst/currPhase[10]} -radix decimal} {{/Sine_tb/Sine_inst/currPhase[9]} -radix decimal} {{/Sine_tb/Sine_inst/currPhase[8]} -radix decimal} {{/Sine_tb/Sine_inst/currPhase[7]} -radix decimal} {{/Sine_tb/Sine_inst/currPhase[6]} -radix decimal} {{/Sine_tb/Sine_inst/currPhase[5]} -radix decimal} {{/Sine_tb/Sine_inst/currPhase[4]} -radix decimal} {{/Sine_tb/Sine_inst/currPhase[3]} -radix decimal} {{/Sine_tb/Sine_inst/currPhase[2]} -radix decimal} {{/Sine_tb/Sine_inst/currPhase[1]} -radix decimal} {{/Sine_tb/Sine_inst/currPhase[0]} -radix decimal}} -subitemconfig {{/Sine_tb/Sine_inst/currPhase[15]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/currPhase[14]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/currPhase[13]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/currPhase[12]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/currPhase[11]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/currPhase[10]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/currPhase[9]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/currPhase[8]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/currPhase[7]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/currPhase[6]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/currPhase[5]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/currPhase[4]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/currPhase[3]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/currPhase[2]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/currPhase[1]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/currPhase[0]} {-height 15 -radix decimal}} /Sine_tb/Sine_inst/currPhase
add wave -noupdate /Sine_tb/Sine_inst/phaseAcc
add wave -noupdate /Sine_tb/Sine_inst/SignPipe
add wave -noupdate -divider Rotator
add wave -noupdate -radix unsigned /Sine_tb/Sine_inst/i
add wave -noupdate -radix decimal -childformat {{{/Sine_tb/Sine_inst/xPipe[16]} -radix decimal} {{/Sine_tb/Sine_inst/xPipe[15]} -radix decimal} {{/Sine_tb/Sine_inst/xPipe[14]} -radix decimal} {{/Sine_tb/Sine_inst/xPipe[13]} -radix decimal} {{/Sine_tb/Sine_inst/xPipe[12]} -radix decimal} {{/Sine_tb/Sine_inst/xPipe[11]} -radix decimal} {{/Sine_tb/Sine_inst/xPipe[10]} -radix decimal} {{/Sine_tb/Sine_inst/xPipe[9]} -radix decimal} {{/Sine_tb/Sine_inst/xPipe[8]} -radix decimal} {{/Sine_tb/Sine_inst/xPipe[7]} -radix decimal} {{/Sine_tb/Sine_inst/xPipe[6]} -radix decimal} {{/Sine_tb/Sine_inst/xPipe[5]} -radix decimal} {{/Sine_tb/Sine_inst/xPipe[4]} -radix decimal} {{/Sine_tb/Sine_inst/xPipe[3]} -radix decimal} {{/Sine_tb/Sine_inst/xPipe[2]} -radix decimal} {{/Sine_tb/Sine_inst/xPipe[1]} -radix decimal} {{/Sine_tb/Sine_inst/xPipe[0]} -radix decimal}} -subitemconfig {{/Sine_tb/Sine_inst/xPipe[16]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/xPipe[15]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/xPipe[14]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/xPipe[13]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/xPipe[12]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/xPipe[11]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/xPipe[10]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/xPipe[9]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/xPipe[8]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/xPipe[7]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/xPipe[6]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/xPipe[5]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/xPipe[4]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/xPipe[3]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/xPipe[2]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/xPipe[1]} {-height 15 -radix decimal} {/Sine_tb/Sine_inst/xPipe[0]} {-height 15 -radix decimal}} /Sine_tb/Sine_inst/xPipe
add wave -noupdate -radix decimal /Sine_tb/Sine_inst/yPipe
add wave -noupdate -radix decimal -childformat {{{/Sine_tb/Sine_inst/phaseDiffPipe[15]} -radix decimal} {{/Sine_tb/Sine_inst/phaseDiffPipe[14]} -radix decimal} {{/Sine_tb/Sine_inst/phaseDiffPipe[13]} -radix decimal} {{/Sine_tb/Sine_inst/phaseDiffPipe[12]} -radix decimal} {{/Sine_tb/Sine_inst/phaseDiffPipe[11]} -radix decimal} {{/Sine_tb/Sine_inst/phaseDiffPipe[10]} -radix decimal} {{/Sine_tb/Sine_inst/phaseDiffPipe[9]} -radix decimal} {{/Sine_tb/Sine_inst/phaseDiffPipe[8]} -radix decimal} {{/Sine_tb/Sine_inst/phaseDiffPipe[7]} -radix decimal} {{/Sine_tb/Sine_inst/phaseDiffPipe[6]} -radix decimal} {{/Sine_tb/Sine_inst/phaseDiffPipe[5]} -radix decimal} {{/Sine_tb/Sine_inst/phaseDiffPipe[4]} -radix decimal} {{/Sine_tb/Sine_inst/phaseDiffPipe[3]} -radix decimal} {{/Sine_tb/Sine_inst/phaseDiffPipe[2]} -radix decimal} {{/Sine_tb/Sine_inst/phaseDiffPipe[1]} -radix decimal} {{/Sine_tb/Sine_inst/phaseDiffPipe[0]} -radix decimal}} -expand -subitemconfig {{/Sine_tb/Sine_inst/phaseDiffPipe[15]} {-radix decimal} {/Sine_tb/Sine_inst/phaseDiffPipe[14]} {-radix decimal} {/Sine_tb/Sine_inst/phaseDiffPipe[13]} {-radix decimal} {/Sine_tb/Sine_inst/phaseDiffPipe[12]} {-radix decimal} {/Sine_tb/Sine_inst/phaseDiffPipe[11]} {-radix decimal} {/Sine_tb/Sine_inst/phaseDiffPipe[10]} {-radix decimal} {/Sine_tb/Sine_inst/phaseDiffPipe[9]} {-radix decimal} {/Sine_tb/Sine_inst/phaseDiffPipe[8]} {-radix decimal} {/Sine_tb/Sine_inst/phaseDiffPipe[7]} {-radix decimal} {/Sine_tb/Sine_inst/phaseDiffPipe[6]} {-radix decimal} {/Sine_tb/Sine_inst/phaseDiffPipe[5]} {-radix decimal} {/Sine_tb/Sine_inst/phaseDiffPipe[4]} {-radix decimal} {/Sine_tb/Sine_inst/phaseDiffPipe[3]} {-radix decimal} {/Sine_tb/Sine_inst/phaseDiffPipe[2]} {-radix decimal} {/Sine_tb/Sine_inst/phaseDiffPipe[1]} {-radix decimal} {/Sine_tb/Sine_inst/phaseDiffPipe[0]} {-radix decimal}} /Sine_tb/Sine_inst/phaseDiffPipe
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9679 ns} 0}
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
WaveRestoreZoom {9632 ns} {10020 ns}
