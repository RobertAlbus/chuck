// Reference
// https://electro-music.com/forum/topic-31708.html


Time _time;
_time.setBpm(160);

MidiNotes _notes;
MidiScales _scales;

// Synth Channel
OscSynthMulti osc => Gain synthChannel => Gain master => dac;

osc._oscs[0].tuneSemi(-48);
osc._oscs[0].oscType("saw");
osc._oscs[0].setAdsr_Amp(0::_time.quat, 1::_time.quat, 0.7, 2::_time.quat);
osc._oscs[0].setAdsr_Filt(0::_time.quat, 1::_time.quat, 0, 2::_time.quat);
osc._oscs[0].setAdsr_Pitch(0::_time.quat, 0.1::_time.quat, 0, 0::_time.quat);
300   => osc._oscs[0]._filterCutoff;
3000  => osc._oscs[0]._filterEnvAmount;
1000  => osc._oscs[0]._pitchEnvAmount;

osc._oscs[1].tuneSemi(-48);
osc._oscs[1].oscType("saw");
osc._oscs[1].setAdsr_Amp(2::_time.quat, 0::_time.quat, 1, 4::_time.quat);
osc._oscs[1].setAdsr_Filt(2::_time.quat, 0::_time.quat, 1, 2::_time.quat);
osc._oscs[1].setAdsr_Pitch(0::_time.quat, 0::_time.quat, 0, 1::_time.quat);
300   => osc._oscs[1]._filterCutoff;
300  => osc._oscs[1]._filterEnvAmount;

0=> osc._oscs[2]._filterCutoff;

// FX Send
Gain echoSend => Chorus chorus => ChugenEcho echoer => HPF echoFilter => Gain echoReturn => Gain echoChannel => master;
echoReturn => Gain FxFeedback => echoSend;
0.2 => chorus.mix;
0 => echoer.feedback;
2000 => echoFilter.freq;
0.9 => echoFilter.Q;

// Link Synth to FX
synthChannel => Gain echoSendAmount => echoSend;

// Mix
0.9 => echoSendAmount.gain;
0.9 => FxFeedback.gain;

0.5 => echoChannel.gain;
0.4 => synthChannel.gain;
3.5 => master.gain;

[
  _notes.F5,
  _notes.Ab5,
  _notes.C6,
  _notes.Eb5,
  _notes.G5,
  _notes.Eb5
] @=> int arp[];


osc._oscs[0].memento().serialize() => string preset;

// Run
while(true) {
  for (0 => int i; i < arp.size(); i++ ) {
    osc.keyOn(arp[i]);
    _time.advance(1::_time.quat);
    osc.keyOff();
    _time.advance(1::_time.quat);
  }
}
