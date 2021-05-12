use_synth :blade
beat = 3.0
strum = beat/24
define :voice1 do
  with_fx :distortion, amp: 1, distort: 0.5, mix: 1 do
    live_loop :loop1 do
      play_pattern_timed chord(:B, :major7), [strum],release: beat*2
      sleep beat - strum*4
      play_pattern_timed chord(:A, :major7), [strum],release: beat*2
      sleep beat - strum*4
      play_pattern_timed chord(:G, :major7), [strum],release: beat*2
      sleep beat - strum*4
      play_pattern_timed chord(:C, :major7), [strum],release: beat*2
      sleep beat - strum*4
    end
    
  end
end
define :drum do
  sample :bd_pure
end
b = beat/8
define :voice2 do
  live_loop :loop2 do
    drum
    sleep b
    drum
    sleep b*3/2
    drum
    sleep b/2
    drum
    sleep b
  end
end

define :mif do
  use_synth :tech_saws
  h = :D4
  b = 0.4
  with_fx :distortion, distort: 0.3, mix: 0.9 do
    live_loop :mi do
      play_pattern_timed [h,h,h+3,h+5],
        [b,b,b/1.5,b/1.5]
      play_pattern_timed [h,h,h-2,h-1],
        [b,b,b/1.5,b/1.5]
    end
  end
end

define :party do
  h = 66
  b = 0.4
  sus = b/4
  use_synth :dsaw
  with_fx :reverb, mix: 0.5, room: 0.02 do
    live_loop :party_loop do
      play_pattern_timed [h,h,h-4,h-7,h-7],
        [b/2,b/2,b/2,b,b], sustain: sus
      play_pattern_timed [h-2,h-2,h-2,h+2,h+2,h+3,h+5],
        [b,b,b/2,b/2,b/2,b/2,b/2], sustain: sus
      play_pattern_timed [h+3,h+3,h+3,h,h-4],
        [b/2,b/2,b/2,b,b], sustain: sus
      play_pattern_timed [h,h,h,h-2,h-2,h,h-2],
        [b,b,b/2,b/2,b/2,b/2,b/2], sustain: sus
    end
  end
end

define :party2 do
  h = 54
  b = 0.4
  sus = b/2
  use_synth :fm
  with_fx :reverb, mix: 0.5, room: 0.5, amp: 1 do
    live_loop :party_loop2 do
      play_pattern_timed [h,h,h-4,h-7,h-7],
        [b/2,b/2,b/2,b,b], sustain: sus
      play_pattern_timed [h-2,h-2,h-2,h+2,h+3,h+5],
        [b,b,b/2,b,b/2,b/2], sustain: sus
      play_pattern_timed [h+3,h+3,h+3,h,h-4],
        [b/2,b/2,b/2,b,b], sustain: sus
      play_pattern_timed [h,h,h,h-2,h,h-2],
        [b,b,b/2,b,b/2,b/2], sustain: sus
    end
  end
end

define :party_drums do
  b = 0.4
  a1 = :drum_bass_soft
  a2 = :drum_bass_hard
  with_fx :reverb, amp: 1, mix: 0.5, room: 0.8 do
    live_loop :party_drums_loop do
      sample a1
      sleep b/2
      sample a1
      sleep b/2
      sample a1
      sleep b/2
      sample a2
      sleep b
      sample a2
      sleep b
      sample a1
      sleep b
      sample a1
      sleep b
      sample a1
      sleep b/2
      sample a2
      sleep b
      sample a1
      sleep b/2
      sample a2
      sleep b/2
    end
  end
end

party
party2
party_drums
