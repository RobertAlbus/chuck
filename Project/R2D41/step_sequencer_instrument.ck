public class StepSequencerEnv extends StepSequencer {
  Instrument @ instruments[];

  fun void play(int step) {
    step % steps.size() => int patternStep;

    if (steps[patternStep]) {
      on(steps[patternStep]);
    } else {
      off();
    }
  }

  fun void on(float note) {
    for ( 0 => int i; i < envs.size(); i++ ){
      instruments[i].keyOn(baseNote + note);
    }
  }
  fun void off() {
    for ( 0 => int i; i < envs.size(); i++ ){
      instruments[i].keyOff();
    }
  }
}
