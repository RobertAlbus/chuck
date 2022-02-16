public class StepSequencer {
  0 => int OFF;
  1 => int ON;
  2 => int SUS;
  // could avoid a SUS condition if I had a "previous step" lookup
  // - would require a mode flag for "retrigger always" or "hold subsequent"
  // could also flag for "always trigger on step 0"

  // TODO: add validation to any method that touches `instruments[]` to ensure that we're not getting a null pointer

  float noteSteps[];
  float triggerSteps[];

  Instrument @ instruments[];

  fun void play(int step) {
    step % noteSteps.size() => int noteStepIndex;
    noteSteps[noteStepIndex] => float noteStep;

    step % triggerSteps.size() => int triggerStepIndex;
    triggerSteps[triggerStepIndex] => float triggerStep;

    if (triggerStep == ON) {

      if(noteStep){ // should be "if nan/null/etc" 
        keyOn(noteStep);
      } else {
        keyOn();
      }
    } else if (triggerStep == SUS) {
    <<<"7">>>;

      if (noteStep) { // should be "if nan/null/etc"
        note(noteStep);
      }
    } else if (triggerStep == OFF) {
    <<<"8">>>;

      keyOff();
    } else {
      <<<"non-op passed to step sequencer trigger step array:", triggerStep>>>;
    }
  }

  fun void keyOn() {
    for ( 0 => int i; i < instruments.size(); i++ ){
      instruments[i].keyOn();
    }
  }

  fun void keyOn(float note) {
    for ( 0 => int i; i < instruments.size(); i++ ){
      instruments[i].keyOn(note);
    }
  }

  fun void note(float _note) {
    for ( 0 => int i; i < instruments.size(); i++ ){
      instruments[i].note(_note);
    }
  }

  fun void keyOff() {
    for ( 0 => int i; i < instruments.size(); i++ ){
      instruments[i].keyOff();
    }
  }

}
