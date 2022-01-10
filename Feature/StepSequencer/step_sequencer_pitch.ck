public class StepSequencerPitch extends StepSequencer {

  0 => int holdOnZero;
  int baseNote;
  Osc @ oscs[];

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
    for ( 0 => int i; i < oscs.size(); i++ ){
      Std.mtof(midiNote) => oscs[i].freq;
    }
  }
}
