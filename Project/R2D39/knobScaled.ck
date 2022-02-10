public class KnobScaled {
  0 => int channel;
  0 => float range;
  0 => float offset;
  0 => float value;

  fun void set(
    int _channel,
    float _range,
    float _offset
  ) {
    _channel => channel;
    _range => range;
    _offset => offset;
  }

  fun float getVal(MidiMsg msg) {
    if(msg.data2 == channel) {
      (msg.data3 / 127.0 * range) + offset => value;
    }
    return value;
  }
}