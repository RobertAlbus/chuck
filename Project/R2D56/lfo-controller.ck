public class LfoController extends Chugen {
  OscPicker _picker;

  float range;
  float centerVal;
  Osc osc => Gain out => blackhole;
  
  fun float tick(float in) {
    return getVal();
  }

  fun void set(
    dur _rate,
    float _centerVal,
    float _range,
    string oscType
  ) {
    _picker.pick(oscType) @=> osc;
    connectOsc();
    _rate => rate;
    _range => range;
    _centerVal => centerVal;
  }

  fun void setMinMax(
    dur _rate,
    float min,
    float max,
    string oscType
  ) {
    _picker.pick(oscType) @=> osc;
    connectOsc();
    _rate => rate;
    max - min => range;
    (range * 0.5) + min => centerVal;
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

  fun void connectOsc() {
    osc => out;
  }
}