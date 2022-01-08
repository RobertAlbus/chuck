public class StepSequencer
{
  int steps[];

  fun void play(int step) {
    if (steps == null) { return; }
    step % steps.size() => step;

    if (steps[step]) {
      <<<"bingo">>>;
    } else {
      <<<"no">>>;
    }
  }
}
