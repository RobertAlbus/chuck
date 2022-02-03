Time _time;
_time.setBpm(160);

MidiNotes _notes;

MidiIn midi;
MidiMsg msg;
"Midi Through Port-0" => string midiThrough;
"Axiom A.I.R. Mini32" => string axiom;
if (midi.open(axiom) == false) me.exit();
<<< "midi device", midi.name(), "ready" >>>;

// OSC AND MOD
RingMod ringer => LPF lpf => Gain master => dac;
15000 => lpf.freq;

// KOBS
KnobSet pitchRatio;
KnobSet modRatio;

pitchRatio.set(5, 16, 1, 1, 0);
modRatio.set(6, 16, 2, 1, 0);

// PROGRAM
0.5 => master.gain;
ringer.keyOn(_notes.F2);

while(true) {
  (now/2::_time.quat) => float currentStep;

  if(currentStep % 2 == 0) {
  }

  if(currentStep % 2 == 1) {
  }

  midi.recv(msg);
  pitchRatio.getValAdd(msg) => ringer.setRatio_Osc;
  modRatio.getValAdd(msg) => ringer.setRatio_Mod;

  samp=>now;

}
