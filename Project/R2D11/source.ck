// Reference
// https://electro-music.com/forum/topic-31708.html


Time _time;
_time.setBpm(100);

MidiNotes _notes;
MidiScales _scales;

BlitSaw osc => LPF lpf => dac;
Std.mtof(_notes.F2) => osc.freq;

//base the moduation on a centre frequency
Step centre => Gain modmix => blackhole;
//..with a variable offset around it
SinOsc LFO => modmix;

//centre frequency
200 => centre.next;
//determines the modulation range
200 => LFO.gain;
1::_time.trip => LFO.period;

8 => lpf.Q;

while(now / _time.bar < 2 )
{
  modmix.last() => lpf.freq;
  _time.advance();
}
