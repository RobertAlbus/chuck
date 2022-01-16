// Reference
// https://electro-music.com/forum/topic-31708.html


Time _time;
_time.setBpm(160);

MidiNotes _notes;
MidiScales _scales;

SawOsc osc => ADSR env => Gain g;
Std.mtof(_notes.D2) => osc.freq;

0.25::_time.quat => dur A;
2::_time.quat => dur D;
0 => float S;
0.5::_time.quat => dur R;
env.set(A,D,S,R);

Gain d_input => Delay d => LPF d_lpf_filt => HPF d_hpf_filt => Gain d_output;
3::_time.quat => d.max => d.delay;
1000 => d_lpf_filt.freq;
0.9 => d_lpf_filt.Q;

300 => d_hpf_filt.freq;
0.9 => d_hpf_filt.Q;

0.85 => d_output.gain;

g => d_input;
d_output => g;



Gain master => dac;
g => master;

0.05 => master.gain;
while(true) {
  env.keyOn();
  _time.advance(1::_time.beat);
  env.keyOff();
  _time.advance(3::_time.beat);

}











// while(now / _time.bar < 8 )
// {
//   if (_time.isStartOfUnit(_time.quat)){
//     _time.currentUnit(_time.quat) => int step;

//     if (step % 4 == 0) {

//     }
//     if (step % 4 == 1) {

//     }
//     if (step % 4 == 2) {

//     }
//     if (step % 4 == 3) {

//     }
//   }

//   _time.advance();
// }

// _time.advance(_time.beat);
