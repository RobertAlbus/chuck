////////
// CHORDS

public class LibR2D10 {

  Create create;

  fun int isFinalSampleOf(dur duration) {
    duration / samp => float durationSamples;
    durationSamples - 1 => float finalSample;
    
    now / samp => float currentSample;
    return currentSample == finalSample;
  }
}

class Create {
  MidiScales _scales;

  fun Osc[] Oscs(int quantity) {
    Osc oscs[0];

    for (0 => int i; i < quantity; i++) {
      SqrOsc osc;
      oscs << osc;
    }

    return oscs;
  }

  fun ADSR[] ADSRs(int quantity) {
    ADSR adsrs[0];

    for (0 => int i; i < quantity; i++) {
      ADSR adsr;
      adsrs << adsr;
    }

    return adsrs;
  }

  fun StepSequencerEnv[] STSQ_Es(int quantity) {
    StepSequencerEnv stsqs[0];

    for (0 => int i; i < quantity; i++) {
      StepSequencerEnv stsq;
      stsqs << stsq;
    }

    return stsqs;
  }

  fun StepSequencerPitch[] STSQ_Ps(int quantity) {
    StepSequencerPitch stsqs[0];

    for (0 => int i; i < quantity; i++) {
      StepSequencerPitch stsq;
      stsqs << stsq;
    }

    return stsqs;
  }

  fun int[][] scales(int tonics[], int modes[], int tonespace[]) {
    int scales[0][0];

    for(0 => int i; i < tonics.size(); i++){
      _scales.generateMode(modes[i], tonics[i], tonespace) @=> int scale[];
      scales << scale;

    }
    
    return scales;
  }
}
