public class StepSequencerEnv extends StepSequencer {
  Envelope @ env;

  fun void play(int step) {
    step % steps.size() => int patternStep;

    if (steps[patternStep]) {
      env.keyOn();
    } else {
      env.keyOff();
    }
  }

  fun void end() {
    env.keyOff();
  }
}
