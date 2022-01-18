// Reference
// https://electro-music.com/forum/topic-31708.html


Time _time;
_time.setBpm(160);

MidiNotes _notes;
MidiScales _scales;

// Synth Channel
SawOsc osc => ADSR env => Gain synthChannel => Gain master => dac;

// FX Send
Gain echoSend => Chorus chorus => ChugenEcho echoer => LPF echoLpf => Gain echoReturn => Gain echoChannel => master;
echoReturn => Gain FxFeedback => echoSend;
1 => FxFeedback.gain;
0.5 => chorus.mix;
0 => echoer.feedback;
4000 => echoLpf.freq;
0.8 => echoLpf.Q;

// Link Synth to FX
synthChannel => Gain echoSendAmount => echoSend;
1 => echoSendAmount.gain;

Std.mtof(0.5 + _notes.F2) => osc.freq;
0.25::_time.quat => dur A;
1::_time.beat => dur D;
0 => float S;
0.5::_time.quat => dur R;
env.set(A,D,S,R);

while(true) {
  env.keyOn();
  _time.advance(1::_time.beat);
  env.keyOff();
  _time.advance(3::_time.beat);
}
