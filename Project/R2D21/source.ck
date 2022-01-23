Time _time;
_time.setBpm(160);

StringUtils _string;
MidiNotes _notes;
MidiScales _scales;


"for=OscSynthSingle;oscType=saw;note=0.0000;tuneSemi=-48.0000;tuneCent=0.0000;filterCutoff=300.0000;filterEnvAmount=3000.0000;pitchEnvAmount=1000.0000;ampEnv_A=0.0000;ampEnv_D=4500.0000;ampEnv_S=0.7000;ampEnv_R=9000.0000;filterEnv_A=0.0000;filterEnv_D=4500.0000;filterEnv_S=0.0000;filterEnv_R=9000.0000;pitchEnv_A=0.0000;pitchEnv_D=450.0000;pitchEnv_S=0.0000;pitchEnv_R=0.0000" => string presetString;

KeyValueStore preset;
preset.deserialize(presetString);

OscSynthSingle osc => Gain synthChannel => Gain master => dac;

osc.preset(preset);

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
