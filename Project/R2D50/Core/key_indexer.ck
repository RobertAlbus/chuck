public class KeyIndexer {
  0 => int value;
  float keys[];

  fun void set(
    float _keys[],
    int _initialValue
  ) {
    _keys @=> keys;
    _initialValue => value;
  }

  fun int getVal(MidiMsg msg) {
    for (0 => int i; i < keys.size(); i++) {
      if(msg.data2 == keys[i]) {
        i => value;
        return value;
      }
    }
    return value;
  }
}