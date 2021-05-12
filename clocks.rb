h = 80
beat = 0.23

define :pattern do |n, sus, rel|
  play_pattern_timed [h, h-1, h-n], [beat], sustain: sus, release: rel
end

define :voice1 do
  use_synth :piano
  with_fx :reverb, mix: 0.8, room: 0.9, amp: 2 do
    live_loop :loop1 do
      
      2.times do
        pattern 5, beat, beat
      end
      play_pattern_timed [h, h-1], [beat]
      
      2.times do
        2.times do
          pattern 7, beat, beat
        end
        play_pattern_timed [h, h-1], [beat]
      end
      
      2.times do
        pattern 8, beat, beat
      end
      play_pattern_timed [h, h-1], [beat]
      
    end
  end
  
end

define :voice2 do
  with_fx :reverb, amp: 0.5, room: 0.9, mix: 0.5 do
    live_loop :boom do
      2.times do
        sample :drum_snare_hard
        sleep beat
        2.times do
          sample :drum_snare_soft
          sleep beat
        end
      end
      
      
      sample :drum_snare_hard
      sleep beat
      sample :drum_snare_soft
      sleep beat
      
    end
  end
  
end

home = 63
define :pattern2 do |a,b,c,s,r|
  play_pattern_timed [home-a, home-b, home-c], [beat], sustain: s, release: r
end

define :pattern3 do |a,b,s,r|
  play_pattern_timed [home-a, home-b], [beat], sustain: s, release: r
end

define :voice3 do
  use_synth :piano
  with_fx :reverb, mix: 0.7, room: 0.9, amp: 1.5 do
    live_loop :loop2 do
      
      2.times do
        pattern2 0, 5, 8, beat, beat
      end
      pattern3 0, 5, beat, beat
      
      2.times do
        2.times do
          pattern2 2, 5, 10, beat, beat
        end
        pattern3 2, 5, beat, beat
      end
      
      2.times do
        pattern2 3, 7, 12, beat, beat
      end
      pattern3 3, 7, beat, beat
      
    end
  end
  
end

voice2
voice1
voice3
