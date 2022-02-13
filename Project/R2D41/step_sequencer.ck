public class StepSequencer
{
  60 => float baseNote;
  float steps[];

  fun void play(int step) {
    step % steps.size() => int currentStep;

    if (steps[currentStep]) {
      on(steps[currentStep]);
    } else {
      off();
    }
  }

  fun void on(float note) {}  
  fun void off() {}
}
