public class Wacko extends Chugen {

  SinOsc selector => blackhole;
  Gain output1 => blackhole;
  Gain output2 => blackhole;
  SinOsc osc1 => output1;
  SqrOsc osc2 => output2;

  0.2 => float lowerBound;
  0.4 => float upperBound;

  320 => selector.freq;
  160 => osc1.freq;
  40 => osc2.freq;

  fun float tick( float in ) {
    selector.last() => float selectorPos;

    if(selectorPos > lowerBound && selectorPos < upperBound) {
      return output1.last();
    } else {
      return output2.last();
    }
  }

}