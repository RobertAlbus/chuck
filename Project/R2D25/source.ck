Time _time;
_time.setBpm(160);

StringUtils _string;
MidiNotes _notes;
MidiScales _scales;

OscSynthSinglePresets _presets;
KeyValueStore preset;
preset.deserialize(_presets.default);

OscSynthMulti osc1 => Gain synthChannel => Gain master => dac;
osc1._oscs[0].tuneSemi(0);
osc1._oscs[1].tuneSemi(-12);
osc1._oscs[2].tuneSemi(-24);
for( 0=> int i; i < 3; i++) {
  osc1._oscs[i].preset(preset);
  osc1._oscs[i].oscType("saw");
  200 => osc1._oscs[i]._filterCutoff;
  2000 => osc1._oscs[i]._filterCutoffEnvAmount;
  2 => osc1._oscs[i]._filterQ;
  osc1._oscs[i].setAdsr_Amp       (0::samp, 1::_time.quat, 0.8, 2::_time.quat);
  osc1._oscs[i].setAdsr_FiltCutoff(0::samp, 1::_time.quat, 0.1, 2::_time.quat);
  osc1._oscs[i].setAdsr_Pitch     (0::samp, 0.1::_time.quat, 0.0, 2::_time.quat);
  200 => osc1._oscs[i]._pitchEnvAmount;
}
osc1.tuneSemi(-36);


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
  (now/2::_time.quat) % arp.size() => float currentStep;

  if( currentStep == 0) {
    osc1.keyOff();
    osc1.keyOn(arp[currentStep $int]);
  }
  if( currentStep == 1) {
    osc1.keyOff();
    osc1.keyOn(arp[currentStep $int]);
  }
  if( currentStep == 2) {
    osc1.keyOff();
    osc1.keyOn(arp[currentStep $int]);
  }
  if( currentStep == 3) {
    osc1.keyOff();
    osc1.keyOn(arp[currentStep $int]);
  }
  if( currentStep == 4) {
    osc1.keyOff();
    osc1.keyOn(arp[currentStep $int]);
  }
  if( currentStep == 5) {
    osc1.keyOff();
    osc1.keyOn(arp[currentStep $int]);
  }
  
    _time.advance(1::samp);
}