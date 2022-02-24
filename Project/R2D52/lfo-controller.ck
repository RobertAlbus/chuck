public class LfoController extends Chugen {

  float amount;
  float centerVal;
  SinOsc osc => Gain out => blackhole;
  
  fun float tick(float in) {
    return getVal();
  }

  fun void set(
    dur _rate,
    float _centerVal,
    float _amount
  ) {
    _rate => rate;
    _amount => amount;
    _centerVal => centerVal;
  }

  fun float getVal() {
    return centerVal + (out.last() * amount);
  }

  fun dur rate(dur _rate) {
    _rate => osc.period;
    return rate();
  }
  fun dur rate() {
    return osc.period();
  }

  fun void retrigger() {
    osc.phase(0);
  }
}