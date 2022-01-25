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

osc.tuneSemi(-36);
osc.oscType("saw");
osc.setAdsr_Amp(0.01::_time.quat, 1::_time.quat, 0.7, 2::_time.quat);
osc.setAdsr_FiltCutoff(0::_time.quat, 1::_time.quat, 0, 0.05::_time.quat);
osc.setAdsr_FiltQ(0::_time.quat, 0.2::_time.quat, 1, 1::_time.quat);
osc.setAdsr_Pitch(0::_time.quat, 0.1::_time.quat, 0, 0.05::_time.quat);
200   => osc._filterCutoff;
1000  => osc._filterCutoffEnvAmount;
1  => osc._filterQ;
2  => osc._filterQEnvAmount;
200  => osc._pitchEnvAmount;
"default" => osc.patchName;

<<<osc.preset().serialize()>>>;

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