Time _time;
_time.setBpm(160);

StringUtils _string;
MidiNotes _notes;
MidiScales _scales;

OscSynthSinglePresets _presets;
KeyValueStore preset;
preset.deserialize(_presets.default);

OscSynthMulti osc1 => Gain synthChannel => Gain master => dac;
osc1._oscs[0].preset(preset);
osc1._oscs[1].preset(preset);
osc1._oscs[2].preset(preset);
osc1._oscs[0].tuneSemi(0);
osc1._oscs[1].tuneSemi(-12);
osc1._oscs[2].tuneSemi(-24);


0.15 => master.gain;
1.0 => synthChannel.gain;

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
    // spork ~ playDuration(arp[i], 4::_time.quat);
    osc1.keyOn(arp[i]);
    _time.advance(1::_time.quat);
    osc1.keyOff();
    _time.advance(1::_time.quat);
  }
}