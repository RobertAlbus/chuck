public class STSQ_Runner {
  Time _time;
  StepSequencer stsqs[];
  dur triggerResolution;
  dur sectionTriggers[][];

  fun void process() {
    

  }

  fun void end() {

  }

  private fun int isFinalSampleOf(dur duration) {
    duration / samp => float durationSamples;
    durationSamples - 1 => float finalSample;
    
    now / samp => float currentSample;
    return currentSample == finalSample;
  }
}