Time _time;
_time.setBpm(80);

6::_time.quat/samp => float maxDur;
0.5::_time.quat/samp => float minDur;
6 => int oscQuantity;
400 => float fundamental;
16 => float maxRatio;
4 => float minRatio;

12000 => float maxCut;
8000 => float minCut;
1 => float maxReso;
3 => float minReso;


MidiNotes _notes;

// MidiIn midi;
// MidiMsg msg;
// "Midi Through Port-0" => string midiThrough;
// "Axiom A.I.R. Mini32" => string axiom;
// if (midi.open(axiom) == false) me.exit();
// <<< "midi device", midi.name(), "ready" >>>;

// OSC AND MOD
Gain oscSum;
RingMod oscs[oscQuantity];
for (0 => int i; i < oscs.size(); i++ ){
  oscs[i] => oscSum;
  (0::ms, 0::ms, 1, 0::ms) => oscs[i].adsr.set;
}
1.0/(oscs.size() $float) => oscSum.gain;

oscSum => ADSR adsr => BPF bpf => HPF hpf => Gain master => dac;
adsr.set(0::samp,40::ms, 0.2, 4::ms);
1 => master.gain;

fun void keyOn() {
  for (0 => int i; i < oscs.size(); i++ ){
    oscs[i].keyOn(_notes.F2);
  }
  adsr.keyOn();
}
fun void keyOff() {
  for (0 => int i; i < oscs.size(); i++ ){
    oscs[i].keyOff();
  }
  adsr.keyOff();
}
fun void randomize() {
    Math.random2f(minCut,maxCut)   => float bpfCut => bpf.freq;
    Math.random2f(minReso,maxReso) => float bpfRes => bpf.Q;

    Math.random2f(minCut,maxCut)   => float hpfCut => hpf.freq;
    Math.random2f(minReso,maxReso) => float hpfRes => hpf.Q;

    for (0 => int i; i < oscs.size(); i++ ){
      Math.random2f( minRatio, maxRatio ) * fundamental => oscs[i].setRatio_Osc;
      Math.random2f( minRatio, maxRatio ) * fundamental => oscs[i].setRatio_Mod;

      Math.random2f( minDur, maxDur )::samp => dur decay;
      (0::ms, decay, 0, 20::ms) => oscs[i].adsr.set;
    }
}

while(true) {
  (now/1::_time.beat) => float currentBeat;

  if(currentBeat % 4.0 == 0) {
    randomize();
  }

  if(currentBeat % 1.0 == 0) {
    keyOn();
    3::_time.quat => now;
    keyOff();
    _time.quat-samp => now;
  }

  samp=>now;
}
