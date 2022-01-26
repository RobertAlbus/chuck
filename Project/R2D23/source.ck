Time _time;
_time.setBpm(160);

StringUtils _string;
MidiNotes _notes;
MidiScales _scales;

OscSynthSinglePresets _presets;
KeyValueStore preset;
preset.deserialize(_presets.default);

OscSynthMulti osc1 => Gain synthChannel1 => Gain master => dac;
OscSynthMulti osc2 => Gain synthChannel2 => master;

osc1._oscs[0].preset(preset);
osc1._oscs[1].preset(preset);
osc1._oscs[2].preset(preset);
osc1._oscs[0].tuneSemi(0);
osc1._oscs[1].tuneSemi(-12);
osc1._oscs[2].tuneSemi(-24);

osc1.preset().serialize() => string OscSynthMultiPresetString;
osc2.preset(OscSynthMultiPresetString);

// osc2._oscs[0].tuneSemi(-5);
// osc2._oscs[1].tuneSemi(7);
// osc2._oscs[2].tuneSemi(12);
for ( 0 => int i; i < 3; i++ ) {
  osc2._oscs[i].oscType("saw");

  osc2._oscs[i].setAdsr_Amp(        0::samp,   1::_time.quat, 0.7,  2::_time.quat);
  osc2._oscs[i].setAdsr_FiltCutoff( 0::samp,   1::_time.quat, 0,    2::_time.quat);
  osc2._oscs[i].setAdsr_Pitch(      0::samp, 0.5::_time.quat, 0,    0::samp);
}

0.15 => master.gain;
0.5 => synthChannel2.gain;

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
    osc1.keyOn(arp[i]);
    osc2.keyOn(arp[(i + 2) % arp.size() ]);
    _time.advance(1::_time.quat);
    osc1.keyOff();
    osc2.keyOff();
    _time.advance(1::_time.quat);
  }
}