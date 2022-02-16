Time2 _time;
Time2.setBpm(160);

MidiNotes _notes;

// MidiIn midi;
// MidiMsg msg;
// "Midi Through Port-0" => string midiThrough;
// "Axiom A.I.R. Mini32" => string axiom;
// if (midi.open(axiom) == false) me.exit();
// <<< "midi device", midi.name(), "ready" >>>;

Gain master => dac;
1 => master.gain;

HH808 hats => Gain hatChannel => master;
Kick kick => Gain kickChannel => master; 

hats.randomize();
hats $ Instrument @=> Instrument i_hat;
kick $ Instrument @=> Instrument i_kick;

// set up step sequencer
0 => float X; // keyOff
1 => float I; // keyOn
2 => float _; // pass
StepSequencer stsq_k;
StepSequencer stsq_hh;
[i_kick] @=> stsq_k.instruments;
[i_hat] @=> stsq_hh.instruments;

[I,_,_,_,I,_,_,_,I,_,_,_,I,_,I,_] @=> stsq_k.triggerSteps;
[X,_,I,_,_,_,I,_,_,_,I,_,_,_,I,_] @=> stsq_hh.triggerSteps;
[_notes.F4 $float] @=> stsq_k.noteSteps;
[1.0] @=> stsq_hh.noteSteps;

while(true) {
  (now/1::_time.quat) => float currentStep;
  if (currentStep % 1.00 == 0) {
    stsq_hh.play(currentStep $int);
    stsq_k.play(currentStep $int);

  }

  // if(currentBeat % 0.125 == 0) {
  //   hats.randomize();
  // }
  // if(currentBeat % 1.0 == 0) {
  //   // i_kick.keyOn(_notes.F4);
  //   i_hat.keyOff();
  // }
  // if(currentBeat % 1.0 == 0.5) {
  //   // i_kick.keyOff();
  //   i_hat.keyOn();
  // }
  // if(currentBeat % 8.0 == 7.5) {
  // }
  // if(currentBeat % 1.0 == 0.75) {
  // }

  samp=>now;
}
