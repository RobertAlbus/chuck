public class StepSequencer
{

  int steps[];

  // fun void nothing() { return;}
  // nothing => fun triggerAction;
  // nothing => fun releaseAction;

  fun void play(int step) {
    if (steps == null) { return; }
    if (steps.size() < step) { return; }
    if (steps[step]) {
      // triggerAction();
      <<<"bingo">>>;
    } else {
      <<<"no">>>;
      // releaseAction();
    }
  }

}
