public class StepSequencer
{
  int steps[];

  fun void play(int step) {
    step % steps.size() => int currentStep;

    if (steps[currentStep]) {
      on();
    } else {
      off();
    }
  }

  fun void on() {}  
  fun void off() {}
}
