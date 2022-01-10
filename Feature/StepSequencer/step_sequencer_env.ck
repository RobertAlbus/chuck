public class StepSequencerEnv extends StepSequencer {
  Envelope @ envs[];

  fun void play(int step) {
    step % steps.size() => int patternStep;

    if (steps[patternStep]) {
      on();
    } else {
      off();
    }
  }

  fun void on() {
    for ( 0 => int i; i < envs.size(); i++ ){
      envs[i].keyOn();
    }
  }
  fun void off() {
    for ( 0 => int i; i < envs.size(); i++ ){
      envs[i].keyOff();
    }
  }
}
