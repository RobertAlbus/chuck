public class Badboy extends Chugen {

  SinOsc osc => Gain output => blackhole;

  fun float tick( float in ) {
    return output.last();
  }

}