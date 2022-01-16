public class DelayLine {
  Time _time;

  Gain input => Delay delay => LPF lpf => HPF hpf => Gain output;
  16::_time.beat => delay.max;
  setTime(3::_time.quat);

  1000 => lpf.freq;
  0.9 => lpf.Q;

  300 => hpf.freq;
  0.9 => hpf.Q;

  0.85 => output.gain;

  fun void setTime(dur duration) {
    duration => delay.delay;
  }
  fun void log(string msg) {
    <<< msg >>>;
    <<< "max in quats", delay.max() / _time.quat>>>;
    <<< "delay in quats", delay.delay() / _time.quat >>>;
  }
  fun void log() {
    log("");
  }
}