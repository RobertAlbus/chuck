// TODO: Deprecate this in favour of using multiple purpose-built STSQ

public class StepSequencerOsc extends StepSequencer {
  Osc @ osc;

  int baseNote;
  int pitchSteps[];

  float baseVelocity;
  float velocitySteps[];

  fun void play(int step) {
    step % steps.size() => int currentStep;

    if (steps[currentStep]) {
      step % pitchSteps.size() => int pitchStep;
      pitchSteps[pitchStep] + baseNote => int midiNote;
      Std.mtof(midiNote) => osc.freq;

      step % velocitySteps.size() => int velocityStep;
      velocitySteps[velocityStep] + baseVelocity => float velocity;
      velocity => osc.gain;
    } else {
      0 => osc.gain;
    }
  }
}
