public class StepSequencer
{
  int triggerSteps[];

  fun void play(int step) {
    if (validate()) { return; }
    step % triggerSteps.size() => int triggerStep;

    if (triggerSteps[step]) {
      <<<"bingo">>>;
    } else {
      <<<"no">>>;
    }
  }

  fun int validate() {
    return triggerSteps.size() > 0;
  }

}
