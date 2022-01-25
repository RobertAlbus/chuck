Time _time;
_time.setBpm(160);

StringUtils _string;
MidiNotes _notes;
MidiScales _scales;

OscSynthSinglePresets _presets;
KeyValueStore preset;
preset.deserialize(_presets.default);

OscSynthSingle osc => Gain synthChannel => Gain master => dac;

osc.preset(preset);

// osc.tuneSemi(0);
// osc.oscType("sine");
// osc.setAdsr_Amp(0.01::_time.quat, 0::_time.quat, 1, 0.05::_time.quat);
// osc.setAdsr_Filt(0::_time.quat, 0::_time.quat, 1, 0.05::_time.quat);
// osc.setAdsr_Pitch(0::_time.quat, 0::_time.quat, 0, 0.05::_time.quat);
// 22000   => osc._filterCutoff;
// 0  => osc._filterEnvAmount;
// 0  => osc._pitchEnvAmount;
// "default" => osc.patchName;

// <<<osc.preset().serialize()>>>;

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