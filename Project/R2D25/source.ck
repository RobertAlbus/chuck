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