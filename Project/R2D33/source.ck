Time _time;
_time.setBpm(160);

MidiNotes _notes;

// MidiIn midi;
// MidiMsg msg;
// "Midi Through Port-0" => string midiThrough;
// "Axiom A.I.R. Mini32" => string axiom;
// if (midi.open(axiom) == false) me.exit();
// <<< "midi device", midi.name(), "ready" >>>;

// OSC AND MOD
Gain oscSum;
1.0/6.0 => oscSum.gain;
SqrOsc osc1 => oscSum;
SqrOsc osc2 => oscSum;
SqrOsc osc3 => oscSum;
SqrOsc osc4 => oscSum;
SqrOsc osc5 => oscSum;
SqrOsc osc6 => oscSum;

40 => float fundamental;
2 * fundamental => osc1.freq;
3 * fundamental => osc2.freq;
4.16 * fundamental => osc3.freq;
5.43 * fundamental => osc4.freq;
6.79 * fundamental => osc5.freq;
8.21 * fundamental => osc6.freq;

oscSum => ADSR adsr => BPF bpf => HPF hpf => Gain master => dac;
adsr.set(0::samp,40::ms, 0.2, 4::ms);
(10000, 1.5) => bpf.set;
(7000, 1) => hpf.set;

// PROGRAM
2 => master.gain;

while(true) {
  (now/0.5::_time.quat) => float currentStep;

  if(currentStep % 2.0 == 0) {
    adsr.keyOn();
    20::ms=> now;
    adsr.keyOff();
  }

  samp=>now;
}
