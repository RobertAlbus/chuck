Time _time;
_time.setBpm(160);

MidiIn midi;
MidiMsg msg;

if (midi.open("Axiom A.I.R. Mini32") == false) me.exit();
<<< "midi device", midi.name(), "ready" >>>;

Badboy badboy => Gain master => dac;
0.5 => master.gain;


// RANGES

KnobSet filtFmFreq;

while(true) {


  // NOTE: trying to determine note off... not going well
  // is my controller not sending a "velocity 0" or "note off" signal?
  // is there some other method to detect how long a note is held? what is this garbage? hahaha

  midi.recv(msg);
  <<<msg.data1, msg.data2, msg.data3>>>;


  samp=>now;


}
