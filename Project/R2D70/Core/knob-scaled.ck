public class KnobScaled {
  0 => float value;
  0 => float range;
  0 => float offset;
  0 => int channel;

  fun void set(
    int _channel,
    float _range,
    float _offset
  ) {
    _channel => channel;
    _range => range;
    _offset => offset;
    _offset => value;
  }

  fun float getVal(MidiMsg msg) {
    if(msg.data2 == channel) {
      (msg.data3 / 127.0 * range) + offset => value;
    }
    return value;
  }
}