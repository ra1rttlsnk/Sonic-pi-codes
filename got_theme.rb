tempo = 2.5
beat = 1.0/tempo
h = :G-12

define :piece1 do
  use_synth :blade
  play_pattern_timed [h,h-7,h-7+3,h-7+5],
    [beat,beat,beat/2,beat/2], attack: beat/4, sustain: beat/4, release: beat
end

define :piece2 do
  use_synth :blade
  play_pattern_timed [h,h-7,h-7+4,h-7+5], [beat,beat,beat/2,beat/2],attack: beat/4, sustain: beat/4, release: beat
end

define :piece3 do
  use_synth :blade
  play_pattern_timed [h-5,h-12,h-12+3,h-12+5], [beat,beat,beat/2,beat/2], attack: beat/4, sustain: beat/4, release: beat
end

define :piece4 do
  use_synth :blade
  play_pattern_timed [h-7,h-14,h-12+1,h-12+3], [beat,beat,beat/2,beat/2], attack: beat/4, sustain: beat/4, release: beat
end

voice_1 = [h,h-7,h-7+3,h-7+5,h,h-7,h-7+3,h-7+5,h-7+2]
voice_1_time = [beat*3,beat*3,beat/2,beat/2,beat*2,beat*2,beat/2,beat/2,0]

voice_2 = [h-2,h-9,h-5,h-4,h-2,h-9,h-4,h-5,h-7]
voice_2_time = [beat*3,beat*3,beat/2,beat/2,beat*2,beat*2,beat/2,beat/2,0]

define :main_voice_1 do
  use_synth :blade
  play_pattern_timed voice_1,
    voice_1_time, attack: beat/4, sustain: beat/2, release: beat*3
end

define :main_voice_2 do
  use_synth :blade
  play_pattern_timed voice_2,
    voice_2_time, attack: beat/4, sustain: beat/2, release: beat*3
end

with_fx :reverb, room: 0.5, mix: 0.75, amp: 2 do
  with_fx :echo, phase: beat/2, decay: beat, mix: 0.5 do
    
    in_thread(name: :main) do
      
      4.times do piece1 end
      4.times do piece2 end
      play h
      sleep beat
      2.times do
        main_voice_1
        3.times do piece3 end
        play_pattern_timed [h-5,h-12,h-12+3], [beat,beat,beat,beat]
        
        main_voice_2
        3.times do piece4 end
        play_pattern_timed [h-7,h-14,h-12+1], [beat,beat,beat,beat]
      end
    end
  end
end
