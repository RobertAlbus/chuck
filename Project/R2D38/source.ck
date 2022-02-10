Time _time;
_time.setBpm(160);

MidiNotes _notes;

MidiIn midi;
MidiMsg msg;
"Midi Through Port-0" => string midiThrough;
"Axiom A.I.R. Mini32" => string axiom;
if (midi.open(axiom) == false) me.exit();
<<< "midi device", midi.name(), "ready" >>>;

Gain master => dac;
HH808 hats => Gain hatChannel => master; 
Kick kick => Gain kickChannel => master; 
1 => master.gain;
hats.randomize();
// hats $ Keyable @=> Keyable k_hat; // invalid casting
hats $ Object $ Keyable @=> Keyable k_hat; // questionable casting
kick $ Object $ Keyable @=> Keyable k_kick;// questionable casting

while(true) {
  midi.recv(msg);
  if(msg.data2 == 40 && msg.data3 > 0) {
    hats.randomize();
    0 => msg.data3; // force to 0 to avoid the bug with my controller not sending note-off.
  }

  (now/1::_time.beat) => float currentBeat;
  if(currentBeat % 1.0 == 0) {
    // segfaults here, presumably due to the questionable casting above
    k_kick.keyOn(_notes.F4);
    k_hat.keyOff();
  }
  if(currentBeat % 1.0 == 0.5) {
    k_hat.keyOn();
  }
  if(currentBeat % 8.0 == 7.5) {
    k_kick.keyOn();
  }
  if(currentBeat % 1.0 == 0.75) {
    k_kick.keyOff();
  }

  samp=>now;
}
