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
StepSequencer stsq_k;
[1.0,0,0,0,1,0,0,0,1,0,0,0,1,0,1,0] @=> float kickTriggerSteps[];
kickTriggerSteps @=> stsq_k.triggerSteps;
[_notes.F4 $float] @=> float kickNoteSteps[];
kickNoteSteps @=> stsq_k.noteSteps;
[i_kick] @=> stsq_k.instruments;


StepSequencer stsq_hh;
[0.0,0,1,0] @=> float hhTriggerSteps[];
hhTriggerSteps @=> stsq_hh.triggerSteps;
[1 $float] @=> float hhNoteSteps[];
hhNoteSteps @=> stsq_hh.noteSteps;
[i_hat] @=> stsq_hh.instruments;

// 


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
