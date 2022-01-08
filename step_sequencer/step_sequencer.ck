public class StepSequencer
{
  int triggerSteps[];
  fun void trigger() {
    <<<"bingo">>>;
  }

  fun void stop() {
    <<<"no">>>;
  }

  fun void play(int step) {
    if (triggerSteps == null) { return; }
    step % triggerSteps.size() => int triggerStep;

    if (triggerSteps[step]) {
      trigger();
    } else {
      stop();
    }
  }

  fun int validate() {
    if (
      triggerSteps != null
    ) {
      return 1;
    }
    return 0;
  }

}
