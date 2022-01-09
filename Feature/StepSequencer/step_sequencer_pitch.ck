public class StepSequencerPitch extends StepSequencer {

  0 => int holdOnZero;
  int steps[];
  int baseNote;
  Osc @ osc;

  fun void play(int step) {
    if (validate() == 0 ) { return; }
    step % steps.size() => int patternStep;

    steps[patternStep] + baseNote => int midiNote;

    if (holdOnZero) {
      if (steps[patternStep]) {
        setNote(midiNote);
      }
    } else {
      setNote(midiNote);
    }
  }

  fun void setNote(int midiNote) {
    Std.mtof(midiNote) => osc.freq;
  }

  fun int validate() {
    if (
      steps.size()  > 0,
      osc != null
    ) {
      return 1;
    } 
    <<< "StepSeqencerEnv invalid state" >>>;
    return 0;
  }
}
