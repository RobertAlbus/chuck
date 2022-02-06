Time _time;
_time.setBpm(80);

6::_time.quat/samp => float maxDur;
0.5::_time.quat/samp => float minDur;
6 => int oscQuantity;
400 => float fundamental;
0.4 => float maxRatio;
0.1 => float minRatio;

12000 => float maxCut;
4000 => float minCut;
1 => float maxReso;
3 => float minReso;


MidiNotes _notes;

MidiIn midi;
MidiMsg msg;
"Midi Through Port-0" => string midiThrough;
"Axiom A.I.R. Mini32" => string axiom;
if (midi.open(axiom) == false) me.exit();
<<< "midi device", midi.name(), "ready" >>>;


Plucker plucker => Gain master => dac;
1 => master.gain;

while(true) {
  midi.recv(msg);
  

  (now/1::_time.beat) => float currentBeat;
  if(currentBeat % 8.0 == 0) {
    plucker.pluck();
  }
  if(currentBeat % 1.0 == 0.75) {
  }

  samp=>now;
}
