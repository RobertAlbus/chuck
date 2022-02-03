Time _time;
_time.setBpm(160);

MidiNotes _notes;

MidiIn midi;
MidiMsg msg;
"Midi Through Port-0" => string midiThrough;
"Axiom A.I.R. Mini32" => string axiom;
if (midi.open(axiom) == false) me.exit();
<<< "midi device", midi.name(), "ready" >>>;

Badboy badboy => Gain master => dac;
1 => master.gain;

badboy.adsr.set(0::samp, 1::_time.quat, 0.7, 3::_time.quat);
badboy.lpfEnv.adsr.set(0::samp, 1::_time.quat, 0, 3::_time.quat);

KnobSet pitchRatio;
KnobSet modRatio;
KnobScaled modRange;
KnobScaled modOffset;
KnobScaled lpfEnvAmount;
KnobScaled lpfCutoff;

pitchRatio.set(5, 8, 1, 0.5, 0);
modRatio.set(6, 8, 2, 0.5, 0);
modRange.set(7, 10000);
modOffset.set(3, 10000);
lpfEnvAmount.set(4, 10000);
lpfCutoff.set(8, 10000);

[
  _notes.F5,
  _notes.Ab4,
  _notes.C5,
  _notes.Eb5,
  _notes.G5,
  _notes.Eb5
] @=> int arp[];

while(true) {
  (now/2::_time.quat) % arp.size() => float currentStep;

  if(currentStep % 2 == 0) {
    // badboy.keyOn(arp[currentStep $ int] - 24);
    badboy.keyOn(arp[0] - 24);
  }

  if(currentStep % 2 == 1) {
    // badboy.keyOn(arp[currentStep $ int] - 24);
    badboy.keyOff();
  }

  midi.recv(msg);
  // <<<msg.data1, msg.data2, msg.data3>>>;

  pitchRatio.getValAdd(msg) => badboy.setRatio_Pitch;
  // <<< pitchRatio.getValAdd(msg) >>>;
  modRatio.getValAdd(msg) => badboy.setRatio_Mod;

  modRange.getVal(msg) => badboy.modAmount;
  modOffset.getVal(msg) => badboy.modOffset;

  lpfEnvAmount.getVal(msg) => badboy.lpfEnvAmount;
  lpfCutoff.getVal(msg) => badboy.lpfFreq;

  samp=>now;

}
