public class StepSequencerOsc extends StepSequencer {

  Osc @ osc;
  int basePitch;
  int pitchSteps[];

  float baseVelocity;
  float velocitySteps[];

  fun void play(int step) {
    if (validate() == 0 ) { return; }
    step % triggerSteps.size() => int triggerStep;
    triggerSteps[triggerStep];

    if (triggerSteps[triggerStep]) {
      step % pitchSteps.size() => int pitchStep;
      pitchSteps[pitchStep] + basePitch => int midiNote;
      Std.mtof(midiNote) => osc.freq;

      step % velocitySteps.size() => int velocityStep;
      velocitySteps[velocityStep] + baseVelocity => float velocity;
      velocity => osc.gain;
    } else {
      0 => osc.gain;
    }
  }

  fun int validate() {
    if (
      triggerSteps != null,
      pitchSteps != null,
      velocitySteps != null,
      osc != null
    ) {
      return 1;
    } 
    <<< "StepSeqencerOsc invalid state" >>>;
    return 0;
  }
}
