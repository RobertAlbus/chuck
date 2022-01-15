// Reference
// https://electro-music.com/forum/topic-31708.html


Time _time;
_time.setBpm(160);

MidiNotes _notes;
MidiScales _scales;

Gain main => dac;

////////
// wob bass
SqrOsc osc => LPF lpf => Gain bassChannel => main;
Std.mtof(_notes.F1) => osc.freq;
2 => lpf.Q;
30 => int filterFreqBottom;
1000 => int filterFreqTop;
filterFreqTop - filterFreqBottom => int filterRange;

Step filterBasis => ADSR filterAdsr => Gain filterModMix => blackhole;
// full signal
1 => filterBasis.next;

2::_time.quat => dur filt_A;
0.5::_time.quat => dur filt_D;
0 => float filt_S;
0.1::_time.quat => dur filt_R;
filterAdsr.set(filt_A ,filt_D ,filt_S ,filt_R );

////////
// kick
SinOsc kick => ADSR kickAmp => Gain kickChannel => LPF kickLPF => main;

0::_time.quat => dur ka_A;
2::_time.quat => dur ka_D;
0 => float ka_S;
0.5::_time.quat => dur ka_R;
kickAmp.set(ka_A ,ka_D ,ka_S ,ka_R );

300 => kickLPF.freq;

Step kickPitchBasis => ADSR kickPitchEnvelope => Gain KickModMix => blackhole;
1 => kickPitchBasis.next;

0.1::_time.quat => dur kp_A;
2::_time.quat => dur kp_D;
0 => float kp_S;
0.1::_time.quat => dur kp_R;
kickPitchEnvelope.set(kp_A, kp_D, kp_S, kp_R);

Std.mtof(_notes.F2) => float kickPitchBase;
kickPitchBase => kick.freq;
100 => float kickPitchPeak;
kickPitchPeak - kickPitchBase => float kickPitchRange;

0.8 => kickChannel.gain;
0.1 => bassChannel.gain;

while(now / _time.bar < 8 )
{
  if (_time.isStartOfUnit(_time.quat)){
    _time.currentUnit(_time.quat) => int step;

    if (step % 4 == 0) {
      kickPitchEnvelope.keyOn();
      kickAmp.keyOn();
    }
    if (step % 4 == 1) {
      kickAmp.keyOff();
      filterAdsr.keyOn();
    }
    if (step % 4 == 2) {
    }
    if (step % 4 == 3) {
      filterAdsr.keyOff();
      kickPitchEnvelope.keyOff();
    }
  }

  (filterRange * filterModMix.last()) + filterFreqBottom => lpf.freq ;
  (kickPitchRange * KickModMix.last()) + kickPitchBase => kick.freq ;
  _time.advance();
}

_time.advance(_time.beat);
