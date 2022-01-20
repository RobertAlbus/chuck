// Reference
// https://electro-music.com/forum/topic-31708.html


Time _time;
_time.setBpm(160);

MidiNotes _notes;
MidiScales _scales;

// Synth Channel
OscSynthMulti osc => Gain synthChannel => Gain master => dac;

osc._oscs[0].tuneSemi(-12);
osc._oscs[0].oscType("saw");

osc._oscs[1].tuneSemi(0);
osc._oscs[1].oscType("saw");

// FX Send
Gain echoSend => Chorus chorus => ChugenEcho echoer => LPF echoLpf => Gain echoReturn => Gain echoChannel => master;
echoReturn => Gain FxFeedback => echoSend;
0.2 => chorus.mix;
0 => echoer.feedback;
2000 => echoLpf.freq;
0.9 => echoLpf.Q;

// Link Synth to FX
synthChannel => Gain echoSendAmount => echoSend;

// Mix
0.9 => echoSendAmount.gain;
0.9 => FxFeedback.gain;

0.5 => echoChannel.gain;
0.4 => synthChannel.gain;
0.5 => master.gain;

[
  _notes.F5,
  _notes.Ab4,
  _notes.C5,
  _notes.Eb5,
  _notes.G5,
  _notes.Eb5
] @=> int arp[];

// Run
while(true) {
  for (0 => int i; i < arp.size(); i++ ) {
    osc.keyOn(arp[i]);
    _time.advance(1::_time.quat);
    osc.keyOff();
    _time.advance(1::_time.quat);
  }
}
