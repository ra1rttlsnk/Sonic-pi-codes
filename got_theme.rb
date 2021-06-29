tempo = 2.5
beat = 1.0/tempo
h = :G-12

#synths used use_synth :
pieces_synth = :blade
main_voice = :blade

define :piece1 do
  use_synth pieces_synth
  play_pattern_timed [h,h-7,h-7+3,h-7+5],
    [beat,beat,beat/2,beat/2], attack: beat/4, sustain: beat/4, release: beat
end

define :piece2 do
  use_synth pieces_synth
  play_pattern_timed [h,h-7,h-7+4,h-7+5], [beat,beat,beat/2,beat/2],attack: beat/4, sustain: beat/4, release: beat
end

define :piece3 do
  use_synth pieces_synth
  play_pattern_timed [h-5,h-12,h-12+3,h-12+5], [beat,beat,beat/2,beat/2], attack: beat/4, sustain: beat/4, release: beat
end

define :piece4 do
  use_synth pieces_synth
  play_pattern_timed [h-7,h-14,h-12+1,h-12+3], [beat,beat,beat/2,beat/2], attack: beat/4, sustain: beat/4, release: beat
end

define :piece5 do
  use_synth pieces_synth
  play_pattern_timed [h+5, h, h+1, h+3],
    [beat, beat, beat/2, beat/2], attack: beat/4, sustain: beat/2, release: beat*2
end

voice_1 = [h,h-7,h-7+3,h-7+5,h,h-7,h-7+3,h-7+5,h-7+2]
voice_1_time = [beat*3,beat*3,beat/2,beat/2,beat*2,beat*2,beat/2,beat/2,0]

voice_2 = [h-2,h-9,h-5,h-4,h-2,h-9,h-4,h-5,h-7]
voice_2_time = [beat*3,beat*3,beat/2,beat/2,beat*2,beat*2,beat/2,beat/2,0]

voice_3 = [h+5,h+3,h-7,h,h-11,h-4,h-2,h]
voice_3_time = [beat*6,beat*6,beat*6,beat*6,beat*6,beat*3,beat*3,0]

define :main_voice_1 do
  use_synth main_voice
  play_pattern_timed voice_1,
    voice_1_time, attack: beat/4, sustain: beat/2, release: beat*3
end

define :main_voice_2 do
  use_synth main_voice
  play_pattern_timed voice_2,
    voice_2_time, attack: beat/4, sustain: beat/2, release: beat*3
end

define :main_voice_3 do
  use_synth main_voice
  play_pattern_timed voice_3,
    voice_3_time, attack: beat/4, sustain: beat/2, release: beat
end

define :main_voice_3_backing do
  use_synth main_voice
  #with_fx :reverb, room: 0.5, mix: 0.75, amp: 2 do
  #with_fx :echo, phase: beat/2, decay: beat, mix: 0.5 do
  v = [h+5, h-4, h+1,h+3, h+5, h-4]
  v_time = [beat, beat, beat/2, beat/2, beat]
  play_pattern_timed v, v_time
  v2 = [h+1,h+5,h+3,h-4,h,h+1,h+3,h-4,h,h+3]
  v2_time = [beat/2, beat/2, beat, beat, beat/2,beat/2, beat, beat, beat/2, beat/2]
  play_pattern_timed v2, v2_time
  v3 = [h+1,h-7,h-2,h,h+1,h-7,h-2,h+1]
  v3_time = [beat, beat, beat/2, beat/2, beat,beat, beat/2, beat/2]
  play_pattern_timed v3, v3_time
  v4 = [h,h-7,h-4,h-2]
  v4_time = [beat, beat, beat/2, beat/2]
  2.times do play_pattern_timed v4, v4_time end
  v5 = [h-4,h-11,h-7,h-5,h-4,h-11,h-7,h-4,h-5,h-12,h-8,h-7,h-5,h-12,h-8,h-7]
  v5_time = [beat,beat,beat/2,beat/2,beat,beat,beat/2,beat/2,beat,beat,beat/2,beat/2,beat,beat,beat/2,beat/2]
  play_pattern_timed v5, v5_time
  #end
  #end
end


define :main do
  with_fx :reverb, room: 0.5, mix: 0.75, amp: 2 do
    with_fx :echo, phase: beat/2, decay: beat, mix: 0.5 do
      
      in_thread(name: :main) do
        cue :drums1
        4.times do piece1 end
        4.times do piece2 end
        
        play h
        sample :drum_bass_hard, rate: 0.75
        sleep beat
        cue :drums2
        2.times do
          
          main_voice_1
          3.times do piece3 end
          play_pattern_timed [h-5,h-12,h-12+3], [beat,beat,beat,beat]
          
          main_voice_2
          3.times do piece4 end
          
          play_pattern_timed [h-7,h-14,h-12+1], [beat,beat,beat,beat]
          
        end
        
        cue :drums3
        2.times do
          in_thread do
            main_voice_3_backing
          end
          main_voice_3
          
          4.times do piece5 end
        end
      end
    end
  end
end



#main_voice_3_backing
#main

sh = :drum_bass_hard
ss = :drum_bass_soft
r = 0.75
define :got_drums_1 do
  sample sh, rate: r
  sleep beat
  sample ss, rate: r
  sleep beat
  sample ss, rate: r
  sleep beat/2
  sample ss, rate: r
  sleep beat/2
  
end

define :got_drums_2 do
  sample sh, rate: r
  sleep beat
  sample sh, rate: r
  sleep beat/2
  sample ss, rate: r
  sleep beat/2
  sample sh, rate: r
  sleep beat/2
  sample ss, rate: r
  sleep beat/2
  sample sh, rate: r
  sleep beat
  sample sh, rate: r
  sleep beat
  sample sh, rate: r
  sleep beat
  
end

with_fx :reverb, room: 0.5, mix: 0.75, amp: 3 do
  in_thread do
    sync :drums1
    8.times do got_drums_1 end
  end
end

with_fx :reverb, room: 0.5, mix: 0.75, amp: 3 do
  in_thread do
    sync :drums2
    16.times do got_drums_2 end
  end
end

with_fx :reverb, room: 0.5, mix: 0.75, amp: 5 do
  in_thread do
    sync :drums3
    32.times do got_drums_1 end
  end
end
#in_thread do
#  sleep 0.001
#  loop do
#
#  main_voice_3
#end

#end

in_thread(name: :back) do
  sync :foo
  main_voice_3_backing
end
use_synth :blade
main
