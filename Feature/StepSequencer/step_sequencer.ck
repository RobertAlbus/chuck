public class StepSequencer
{
  int triggerSteps[];

  fun void play(int step) {
    step % triggerSteps.size() => int triggerStep;

    if (triggerSteps[step]) {
      <<<"bingo">>>;
    } else {
      <<<"no">>>;
    }
  }


}
