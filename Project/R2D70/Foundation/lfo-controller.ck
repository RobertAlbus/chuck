public class LfoController extends Chugen {
  OscPicker _picker;

  float modRange;
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
    osc => out;
    _rate => rate;
    _range => modRange;
    _centerVal => centerVal;
  }

  fun void setMinMax(
    dur _rate,
    float min,
    float max,
    string oscType
  ) {
    _picker.pick(oscType) @=> osc;
    osc => out;
    _rate => rate;
    max - min => modRange;
    (modRange * 0.5) + min => centerVal;
  }

  fun float min() {
    return centerVal - ( modRange / 2 );
  }
  fun float min(float _min) {
    min() - _min => float difference;
    difference +=> modRange;
    ( _min / 2 ) +=> centerVal;
  }
  fun float max() {
    return centerVal + ( modRange / 2 );
  }
  fun float max(float _max) {
    _max - max() => float difference;
    difference +=> modRange;
    ( _max / 2 ) +=> centerVal;
  }
  fun float range() {
    return modRange;
  }
  fun float range(float _range) {
    _range => modRange;
  }
  fun float center() {
    return centerVal;
  }
  fun float center(float _center) {
    _center => centerVal;
  }

  fun float getVal() {
    return centerVal + (out.last() * (modRange / 2));
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
  fun void retrigger(float phase) {
    osc.phase(phase);
  }
}
