public class MyChugen extends Chugen {

  SinOsc osc => blackhole;
  880 => osc.freq;
  fun float tick( float in ) {
    // Math.sgn(in) => float sgn;
    // return (Math.fabs(in) / 4) * sgn;
    return osc.last();
  }
}
