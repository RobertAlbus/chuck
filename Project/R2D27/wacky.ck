public class Wacko extends Chugen {

  SinOsc selector => blackhole;
  SinOsc filterFM => blackhole;

  800 => float filtFmRange;
  200 => float filtFmBottom;

  LPF lpf;
  SinOsc osc1 => lpf => Gain output1 => blackhole;
  SawOsc osc2 => lpf => Gain output2 => blackhole;

  0.2 => float lowerBound;
  0.4 => float upperBound;

  320 => selector.freq;
  160 => osc1.freq;
  40 => osc2.freq;
  126 => filterFM.freq;

  fun float tick( float in ) {
    selector.last() => float selectorPos;
    (((filterFM.last() + 1) / 2) * filtFmRange) + filtFmBottom => float filtCut;

    filtCut => lpf.freq;

    if(selectorPos > lowerBound && selectorPos < upperBound) {
      return output1.last();
    } else {
      return output2.last();
    }

  }

}