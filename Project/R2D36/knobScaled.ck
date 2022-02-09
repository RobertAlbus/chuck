public class KnobScaled {
  0 => float value;
  0 => float range;
  0 => int channel;

  fun void set(
    int _channel,
    float _range
  ) {
    _channel => channel;
    _range => range;
  }

  fun float getVal(MidiMsg msg) {
    if(msg.data2 == channel) {
      msg.data3 / 127.0 * range => value;
    }
    return value;
  }
}