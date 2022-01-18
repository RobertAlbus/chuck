// Reference
// https://electro-music.com/forum/topic-31708.html


Time _time;
_time.setBpm(160);

MidiNotes _notes;
MidiScales _scales;

// Synth Channel
SingleOscSynth osc => Gain synthChannel => Gain master => dac;

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
1 => echoSendAmount.gain;
0.6 => echoChannel.gain;
0.6 => synthChannel.gain;

// Run
while(true) {
  osc.keyOn();
  _time.advance(1::_time.beat);
  osc.keyOff();
  _time.advance(3::_time.beat);
}
