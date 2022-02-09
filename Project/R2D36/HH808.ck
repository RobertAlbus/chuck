public class HH808 extends Chugen {
  MidiNotes _notes;

  10000::ms/ms=> float maxDur;
  100::ms/ms => float minDur;
  6 => int oscQuantity;
  400 => float fundamental;
  0.4 => float maxRatio;
  0.1 => float minRatio;

  12000 => float maxCut;
  4000 => float minCut;
  1 => float maxReso;
  3 => float minReso;

  RingMod oscs[0];
  Gain oscSum => ADSR adsr => BPF bpf => HPF hpf => Gain output => blackhole;

  init();

  fun float tick(float in) {
    return output.last();
  }

  fun void init() {
    6 => setOscQuantity;
    adsr.set(0::samp,40::ms, 0.6, 4::ms);
    randomize();
  }

  fun void setOscQuantity(int quantity) {
    RingMod newOscs[quantity] @=> oscs;
    for (0 => int i; i < oscs.size(); i++ ){
      oscs[i] => oscSum;
      (0::ms, 0::ms, 1, 0::ms) => oscs[i].adsr.set;
    }
    1.0/(oscs.size() $float) => oscSum.gain;
  }

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

      Math.random2f( minDur, maxDur )::ms => dur decay;
      (0::ms, decay, 0, 20::ms) => oscs[i].adsr.set;
    }
  }
}