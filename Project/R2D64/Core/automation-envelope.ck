public class AutomationEnvelope {

  Envelope env => blackhole;

  fun void set(float target, dur changeRate) {
    env.duration(changeRate);
    env.target(target);
  }

  fun void set(float target) {
    env.target(target);
    env.value(target);
  }

  fun float getVal() {
    return env.value();
  }
}
