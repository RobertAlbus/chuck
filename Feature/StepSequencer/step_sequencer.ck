public class StepSequencer
{
  int steps[];
  
  fun void play(int step) {
    step % steps.size() => int currentStep;

    if (steps[currentStep]) {
      <<<"bingo">>>;
    } else {
      <<<"no">>>;
    }
  }

  fun void end() {
    return;
  }
}
