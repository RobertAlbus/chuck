public class Wacko extends Chugen {

  SinOsc selector => blackhole;
  SinOsc filterFM => blackhole;

  300 => float filtFmRange;
  200 => float filtFmOffset;

  LPF lpf ;
  Gain output;
  SinOsc osc1 => Gain oscChannel1 => lpf => output => blackhole; 
  SawOsc osc2 => Gain oscChannel2 => lpf => output => blackhole;

  0.2 => float lowerBound;
  0.4 => float upperBound;

  320 => selector.freq;
  120 => osc1.freq;
  40 => osc2.freq;
  41 => filterFM.freq;

  1.4 => lpf.Q;

  fun float tick( float in ) {
    selector.last() => float selectorPos;
    (((filterFM.last() + 1) / 2) * filtFmRange) + filtFmOffset => float filtCut;

    filtCut => lpf.freq;

    if(selectorPos > lowerBound && selectorPos < upperBound) {
      1 => oscChannel1.gain;
      0 => oscChannel2.gain;
    } else {
      0 => oscChannel1.gain;
      1 => oscChannel2.gain;
    }

    return output.last();

  }

}