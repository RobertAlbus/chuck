Time _time;
_time.setBpm(160);

StringUtils _string;
MidiNotes _notes;
MidiScales _scales;

OscSynthSinglePresets _presets;
KeyValueStore preset;
preset.deserialize(_presets.default);

OscSynthMulti osc1 => Gain synthChannel => Gain master => dac;
// new OscSynthMulti @=> OscSynthMulti osc2;
// new OscSynthMulti @=> OscSynthMulti osc3;
osc1._oscs[0].preset(preset);
osc1._oscs[1].preset(preset);
osc1._oscs[2].preset(preset);
osc1._oscs[0].tuneSemi(0);
osc1._oscs[1].tuneSemi(-12);
osc1._oscs[2].tuneSemi(-24);

////
// initialize with string preset
// doesn't run

// osc1.preset().serialize() => string OscSynthMultiPresetString;

// osc2.preset(OscSynthMultiPresetString);
// osc2 => synthChannel;
// osc3.preset(OscSynthMultiPresetString);
// osc3 => synthChannel;


////
// initialize with KVS preset
// doesn't run

// osc1.preset() @=> KeyValueStore OscSynthMultiPreset;

// osc2.preset(OscSynthMultiPreset);
// osc2 => synthChannel;
// osc3.preset(OscSynthMultiPreset);
// osc3 => synthChannel;


////
// experiment with cross-shred object messaging
// does not work

// fun void playDuration(float midiNote, dur duration) {
//   OscSynthMulti osc;
//   osc.preset(OscSynthMultiPresetString);
//   osc => dac;
//   osc.keyOn(midiNote);
//   duration => now;
//   osc.keyOff();
// }

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