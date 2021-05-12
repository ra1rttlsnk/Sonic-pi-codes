# Welcome to Sonic Pi
beat = 0.4
segment_interval = 0.0125
home = 45
beat_number = 0
measure = 12
sus = 1
with_fx :reverb, mix: 0.6, room: 0.9 do
  live_loop :sonata do
    use_synth :piano
    if beat_number%measure < 4 then
      play home, sustain: sus, release: beat
      sleep beat
      play home+5, sustain: sus, release: beat
      sleep beat
      play home+5+3, sustain: sus, release: beat
    elsif beat_number%measure < 8
      play home+1, sustain: beat, release: beat
      sleep beat
      play home+5, sustain: sus, release: beat
      sleep beat
      play home+5+3, sustain: sus, release: beat
    elsif beat_number%measure < 10
      play home+1, sustain: sus, release: beat
      sleep beat
      play home+5, sustain: sus, release: beat
      sleep beat
      play home+5+5, sustain: sus, release: beat
    elsif beat_number%measure < 11
      play home, sustain: sus, release: beat
      sleep beat
      play home+5, sustain: sus, release: beat
      sleep beat
      play home+5+3, sustain: sus, release: beat
    else
      play home, sustain: sus, release: beat
      sleep beat
      play home+4, sustain: sus, release: beat
      sleep beat
      play home+5+2, sustain: sus, release: beat
    end
    beat_number += 1
    sleep beat+segment_interval
  end
end
