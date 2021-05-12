tempo = 1.6
b = 1.0/tempo
h = 57+12

define :interstellar_piano do
  use_synth :piano
  
  2.times do
    play_pattern_timed [h, h+7, h], [b],
      attack: b/8, sustain: b/2, release: b*3
  end
  
  2.times do
    play_pattern_timed [h+2, h+7, h+2], [b],
      attack: b/8, sustain: b/2, release: b*3
  end
  
  2.times do
    play_pattern_timed [h+3, h+7, h+3], [b],
      attack: b/8, sustain: b/2, release: b*3
  end
  
  
  play_pattern_timed [h+5, h+7, h+5, h+5, h+7, h+2], b,
    attack: b/8, sustain: b/2, release: b*3
  
end


define :bg_synth do
  use_synth :saw
  h_s = h-12*1
  play chord(h_s-4,:major), attack: b/4, sustain: b*4, release: b*6
  sleep 3*b*2
  play chord(h_s-2,:major), attack: b/4, sustain: b*4, release: b*6
  sleep 3*b*2
  play chord(h_s,:minor), attack: b/4, sustain: b*4, release: b*6
  sleep 3*b*2
  play chord(h_s-2,:major), attack: b/4, sustain: b*4, release: b*6
  sleep 3*b*2
end
live_loop :piano1 do
  with_fx :reverb, mix: 0.9, room: 0.5, amp: 1 do
    interstellar_piano
  end
end

live_loop :synth do
  with_fx :reverb, mix: 0.9, room: 0.8, amp: 1 do
    bg_synth
  end
end
