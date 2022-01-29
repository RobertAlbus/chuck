public class ChugenClipper extends Chugen {

  1 => float thresh;
  0 => float pregain;
  0 => float postgain;
  Impulse _input => blackhole;

  fun float tick( float in ) {

    in => Std.sgn => float sign;
    in => Std.fabs => float val;

    pregain + val => float gain1;

    0 => float clipped;
    if (gain1 > thresh) {
      thresh => clipped;
    } else {
      gain1 => clipped;
    }

    postgain + clipped => float gain2;

    return gain2;
  }

}
