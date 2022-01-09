public class StepSequencerPitch extends StepSequencer {

  0 => int holdOnZero;
  int baseNote;
  Osc @ osc;

  fun void play(int step) {
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
}
