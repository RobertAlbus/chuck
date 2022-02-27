public class LfoController extends Chugen {

  float range;
  float centerVal;
  SinOsc osc => Gain out => blackhole;
  
  fun float tick(float in) {
    return getVal();
  }

  fun void set(
    dur _rate,
    float _centerVal,
    float _range,
    float _amount
  ) {
    _rate => rate;
    _range => range;
    _centerVal => centerVal;
  }

  fun float getVal() {
    return centerVal + (out.last() * (range / 2));
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