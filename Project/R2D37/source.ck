Time _time;
_time.setBpm(80);

MidiNotes _notes;

MidiIn midi;
MidiMsg msg;
"Midi Through Port-0" => string midiThrough;
"Axiom A.I.R. Mini32" => string axiom;
if (midi.open(axiom) == false) me.exit();
<<< "midi device", midi.name(), "ready" >>>;

HH808 hats => Gain master => dac;
1 => master.gain;
hats.randomize();

while(true) {
  midi.recv(msg);
  if(msg.data2 == 40 && msg.data3 > 0) {
    hats.randomize();
    0 => msg.data3; // force to 0 to avoid the bug with my controller not sending note-off.
  }

  (now/1::_time.beat) => float currentBeat;
  if(currentBeat % 1.0 == 0) {
    hats.keyOn();
  }
  if(currentBeat % 1.0 == 0.75) {
    hats.keyOff();
  }

  samp=>now;
}
