Time _time;
_time.setBpm(160);

// MidiIn midi;
// MidiMsg msg;
// "Midi Through Port-0" => string midiThrough;
// "Axiom A.I.R. Mini32" => string axiom;
// if (midi.open(axiom) == false) me.exit();
// <<< "midi device", midi.name(), "ready" >>>;

Gain master => dac;
1 => master.gain;

while(true) {
  // midi.recv(msg);

  (now/1::_time.beat) => float currentBeat;
  if(currentBeat % 1.0 == 0) {
  }
  if(currentBeat % 1.0 == 0.5) {
  }
  if(currentBeat % 8.0 == 7.5) {
  }
  if(currentBeat % 1.0 == 0.75) {
  }

  samp=>now;
}
