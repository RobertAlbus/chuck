// Reference
// https://electro-music.com/forum/topic-31708.html


Time _time;
_time.setBpm(160);

MidiNotes _notes;
MidiScales _scales;

// Synth Channel
SingleOscSynth osc => Gain synthChannel => Gain master => dac;

osc.tuneSemi(-12);
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

// Mix
0.9 => echoSendAmount.gain;
0.6 => echoChannel.gain;
0.4 => synthChannel.gain;
0.5 => master.gain;

// Run
while(true) {
  osc.keyOn(_notes.F4);
  _time.advance(1::_time.quat);
  osc.keyOff();
  _time.advance(1::_time.quat);
  osc.keyOn(_notes.Ab4);
  _time.advance(1::_time.quat);
  osc.keyOff();
  _time.advance(1::_time.quat);
  osc.keyOn(_notes.C5);
  _time.advance(1::_time.quat);
  osc.keyOff();
  _time.advance(1::_time.quat);
  osc.keyOn(_notes.Eb5);
  _time.advance(1::_time.quat);
  osc.keyOff();
  _time.advance(1::_time.quat);
}
