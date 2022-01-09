public class StepSequencerEnv extends StepSequencer {

  int steps[];
  Envelope @ env;

  fun void play(int step) {
    if (validate() == 0 ) { return; }
    step % steps.size() => int patternStep;

    if (steps[patternStep]) {
      env.keyOn();
    } else {
      env.keyOff();
    }
  }

  fun int validate() {
    if (
      steps.size()  > 0,
      env  != null
    ) {
      return 1;
    } 
    <<< "StepSeqencerEnv invalid state" >>>;
    return 0;
  }
}
