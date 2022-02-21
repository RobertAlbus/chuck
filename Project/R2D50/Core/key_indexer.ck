public class KeyIndexer {
  0 => int value;
  0 => int maxValue;
  float keys[];

  fun void set(
    float _keys[],
    int _initialValue
  ) {
    _keys @=> keys;
    _keys.size() => maxValue;
    _initialValue => value;
  }

  fun void set(
    int _value
  ) {
    _value => value;
  }

  fun int getVal(MidiMsg msg) {
    for (0 => int i; i < keys.size(); i++) {
      if(msg.data2 == keys[i]) {
        i => value;
        return safeValue();
      }
    }
    return safeValue();
  }

  fun int safeValue() {
    return Math.min(value, maxValue) $ int;
  }
}