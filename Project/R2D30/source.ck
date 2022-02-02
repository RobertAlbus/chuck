Time _time;
_time.setBpm(160);

MidiIn midi;
MidiMsg msg;
"Midi Through Port-0" => string midiThrough;
"Axiom A.I.R. Mini32" => string axiom;
if (midi.open(midiThrough) == false) me.exit();
<<< "midi device", midi.name(), "ready" >>>;

Badboy badboy => Gain master => dac;
0.5 => master.gain;

while(true) {

  midi.recv(msg);
  <<<msg.data1, msg.data2, msg.data3>>>;

  midi=>now;

}
