Time _time;
_time.setBpm(120);

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
  (now/1::_time.beat) => float currentBeat;

  if(currentBeat % 4.0 == 0) {

    Math.random2f(8000,12000)           => float bpfCut => bpf.freq;
    Math.random2f(2,3)                  => float bpfRes => bpf.Q;

    Math.random2f(8000,12000)           => float hpfCut => hpf.freq;
    Math.random2f(2,3)                  => float hpfRes => hpf.Q;

    // 16 => float maxRatio; // Cym styled
    9 => float maxRatio; // HH styled
    Math.random2f( 2, maxRatio ) * fundamental => float osc1Freq => osc1.freq;
    Math.random2f( 2, maxRatio ) * fundamental => float osc2Freq => osc2.freq;
    Math.random2f( 2, maxRatio ) * fundamental => float osc3Freq => osc3.freq;
    Math.random2f( 2, maxRatio ) * fundamental => float osc4Freq => osc4.freq;
    Math.random2f( 2, maxRatio ) * fundamental => float osc5Freq => osc5.freq;
    Math.random2f( 2, maxRatio ) * fundamental => float osc6Freq => osc6.freq;
    <<<
    "bpfCut: ", bpfCut, "  |  ",
    "bpfRes: ", bpfRes, "  |  ",
    "hpfCut: ", hpfCut, "  |  ",
    "hpfRes: ", hpfRes, "  |  ",
    "osc1Freq: ", osc1Freq, "  |  ",
    "osc2Freq: ", osc2Freq, "  |  ",
    "osc3Freq: ", osc3Freq, "  |  ",
    "osc4Freq: ", osc4Freq, "  |  ",
    "osc5Freq: ", osc5Freq, "  |  ",
    "osc6Freq: ", osc6Freq, "  |  ">>>;

  }

  if(currentBeat % 1.0 == 0) {
    adsr.keyOn();
    3::_time.quat => now;
    adsr.keyOff();
    _time.quat-samp => now;
  }

  samp=>now;
}
