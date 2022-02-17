public class StepSequencer {
  0 => float OFF;
  1 => float ON;
  2 => float SUS;
  // could avoid a SUS condition if I had a "previous step" lookup
  // - would require a mode flag for "retrigger always" or "hold subsequent"
  // could also flag for "always trigger on step 0"

  // TODO: add validation to any method that touches `instruments[]` to ensure that we're not getting a null pointer
  // TODO: add validation before accessing step arrays

  float noteSteps[0];
  float triggerSteps[0];

  Instrument @ instruments[];

  fun void play(int step) {

    safeStep(noteSteps, step) => float noteStep;
    safeStep(triggerSteps, step) => float triggerStep;

    if (triggerStep == ON) {

      if(noteStep){ // should be "if nan/null/etc" 
        keyOn(noteStep);
      } else {
        keyOn();
      }
    } else if (triggerStep == SUS) {
      if (noteStep) { // should be "if nan/null/etc"
        note(noteStep);
      }
    } else if (triggerStep == OFF) {
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

  fun int safeModulo(int a, int b) {
    if (b == 0) {
      return a % 1;
    }
    return a % b;
  }

  fun float safeStep(float steps[], int step) {
    if (steps.size() != 0) {
      safeModulo(step, steps.size()) => int stepIndex;
      return steps[stepIndex];
    }
  }

}
