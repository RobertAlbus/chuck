// Reference
// https://electro-music.com/forum/topic-31708.html


Time _time;
_time.setBpm(160);

MidiNotes _notes;
MidiScales _scales;

// Synth Channel
OscSynthMulti osc => Gain synthChannel => Gain master => dac;

osc._oscs[0].tuneSemi(-24);
osc._oscs[0].oscType("saw");
osc._oscs[0].setAdsr_Amp(0::_time.quat, 1::_time.quat, 0.7, 2::_time.quat);
osc._oscs[0].setAdsr_Filt(0::_time.quat, 1::_time.quat, 0, 2::_time.quat);
osc._oscs[0].setAdsr_Pitch(0::_time.quat, 0.1::_time.quat, 0, 0::_time.quat);
300   => osc._oscs[0]._filterCutoff;
3000  => osc._oscs[0]._filterEnvAmount;
1000  => osc._oscs[0]._pitchEnvAmount;

osc._oscs[1].tuneSemi(-19);
osc._oscs[1].oscType("saw");
osc._oscs[1].setAdsr_Amp(2::_time.quat, 0::_time.quat, 1, 4::_time.quat);
osc._oscs[1].setAdsr_Filt(2::_time.quat, 0::_time.quat, 1, 2::_time.quat);
osc._oscs[1].setAdsr_Pitch(0::_time.quat, 0::_time.quat, 0, 1::_time.quat);
300   => osc._oscs[1]._filterCutoff;
3000  => osc._oscs[1]._filterEnvAmount;

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

"" => string myVar;
// "       " +=> myVar;
// ";" +=> myVar;
// "      " +=> myVar;
// 4500.000000 +=> myVar;
// ";" +=> myVar;
// 1::samp/samp +=> myVar;
// ";" +=> myVar;
// <<< myVar.length() >>>;
// <<< myVar.substring(8, 8).toFloat()::samp == 9::samp >>>;

1::_time.quat/samp +=> myVar;
<<< myVar >>>;
<<< _time.quat >>>;


osc._oscs[0].memento().serialize() => string preset;
<<< preset >>>;

// Run
while(true) {
  for (0 => int i; i < arp.size(); i++ ) {
    osc.keyOn(arp[i]);
    _time.advance(1::_time.quat);
    osc.keyOff();
    _time.advance(1::_time.quat);
  }
}
