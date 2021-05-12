# Welcome to Sonic Pi
measure = 32
c = 0
beat = 0.28
b = 10
a = 1
s = :drum_tom_lo_soft
d = 2
home = :D4
amp = 2

define :foo do |b|
  7.times do
    sample :drum_snare_soft
    sleep b
    sample :drum_snare_soft
    sleep b
    sample :drum_snare_hard
    sleep b
    sample :drum_snare_soft
    sleep b
    
  end
  
  
  sample :drum_snare_soft
  sleep b/2
  sample :drum_snare_hard
  sleep b/2
  sample :drum_snare_soft
  sleep b
  sample :drum_snare_hard
  sleep b
  sample :drum_snare_soft
  sleep b
  
end

live_loop :loop1 do
  use_synth :fm
  if c >= 2*measure then
    if c%measure < measure/4 then
      play home-12, amp: amp, release: beat*1.5
    elsif c%measure < 2*measure/4 then
      play home-5-12, amp: amp, release: beat*1.5
    elsif c%measure < 3*measure/4 then
      play home-3-12, amp: amp, release: beat*1.5
    else
      play home-7-12, amp: amp, release: beat*1.5
    end
  end
  c += 1
  
  sleep beat
end

live_loop :drums1 do
  foo beat
end

live_loop :drums2 do
  sample :drum_heavy_kick, sustain: 2, release: 2, amp: 1
  sleep beat*4
end

synth_amp = 2
current = 0
live_loop :chording do
  use_synth :hollow
  if current%measure < measure/4 then
    play_chord chord(:D5, :major), sustain: beat, amp: synth_amp
  elsif current%measure < 2*measure/4
    play_chord chord(:A4, :major), sustain: beat, amp: synth_amp
  elsif current%measure < 3*measure/4
    play_chord chord(:B4, :minor), sustain: beat, amp: synth_amp
  elsif current%measure < 4*measure/4
    play_chord chord(:G4, :major), sustain: beat, amp: synth_amp
  end
  current += 1
  sleep beat
end
