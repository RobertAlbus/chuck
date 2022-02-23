public class LfoController extends Chugen {

  float amount;
  SinOsc osc => Gain out => blackhole;
  
  fun float tick(float in) {
    return out.last() * amount;
  }

  fun void set(
    dur _rate,
    float _amount
  ) {
    _rate => osc.period;
    _amount => amount;
  }

  fun void retrigger() {
    <<<"retrigger">>>;
    osc.phase(0);
  }
}