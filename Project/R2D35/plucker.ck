public class Plucker extends Chugen {
  MidiNotes _notes;

  Impulse osc => Gain oscMix => blackhole;

  oscMix => Gain g1 => Inverter i1 => LPF lpf1 => Delay d1 => oscMix;
  1 => g1.gain;
  1::second => d1.max;
  333::samp => d1.delay;
  20000 => lpf1.freq;
  1.2 => lpf1.Q;

  fun float tick(float in) {
    return oscMix.last();
  }

  fun void pluck() {
    osc.next(2);
  }

}