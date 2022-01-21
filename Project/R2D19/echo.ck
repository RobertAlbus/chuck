public class ChugenEcho extends Chugen {
  Time _time;

  Impulse _input => Gain _feedbackInsert => Delay _delay => Gain _output => blackhole;
  _output => Gain _feedback => _feedbackInsert;
  0.8 => _feedback.gain;

  16::_time.beat => _delay.max;
  3::_time.quat => _delay.delay;

  fun float tick( float in ) {
    _input.next(in);
    return _output.last();
  }

  fun dur delay(dur delayTime) {
    delayTime => _delay.delay;
    return _delay.delay();
  }

  fun dur delay() {
    return _delay.delay();
  }

  fun float feedback(float gain) {
    gain => _feedback.gain;
    return _feedback.gain();
  }

  fun float feedback() {
    return _feedback.gain();
  }
}
