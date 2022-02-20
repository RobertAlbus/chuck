MidiIn midi;
MidiMsg msg;
"Midi Through Port-0" => string midiThrough;
"Axiom A.I.R. Mini32" => string axiom;
"" => string KijijiMidi;
if (midi.open(axiom) == false) me.exit();
<<< "midi device", midi.name(), "ready" >>>;

while(true) {
  midi.recv(msg);
  <<<msg.data1,msg.data2,msg.data3>>>;

  midi=>now;
}
