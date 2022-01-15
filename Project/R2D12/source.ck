// Reference
// https://electro-music.com/forum/topic-31708.html


Time _time;
_time.setBpm(160);

MidiNotes _notes;
MidiScales _scales;

BlitSaw osc => LPF lpf => dac;
Std.mtof(_notes.F2) => osc.freq;
8 => lpf.Q;
30 => int filterFreqBottom;
1000 => int filterFreqTop;
filterFreqTop - filterFreqBottom => int filterRange;

Step full => ADSR adsr => Gain modmix => blackhole;
// full signal
1 => full.next;

1::_time.quat => dur A;
0.5::_time.quat => dur D;
0.7 => float S;
2.5::_time.quat => dur R;

adsr.set(A,D,S,R);

while(now / _time.bar < 2 )
{
  if (_time.isStartOfUnit(_time.quat)){
    _time.currentUnit(_time.quat) => int step;

    if (step % 4 == 0) {
      adsr.keyOn();
    }

    if (step % 4 == 1) {
      adsr.keyOff();
    }
  }

  (filterRange * modmix.last()) + filterFreqBottom => lpf.freq ;
  _time.advance();
}

_time.advance(R);
