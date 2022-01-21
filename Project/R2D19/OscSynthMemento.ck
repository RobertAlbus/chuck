public class OscSynthMemento {

  // TODO
  /*
  - filt and pitch release are providing `-nan` value!
  - this is because sustain is set to 0. weird bug.
    - I don't like the conditional check. It's lossy, we have no R value now even if it was set.
    - when creating the memento, we should hold the old S value, switch it to 1, record Release, swap back
    - does this work?
  
  */ 

  string oscType;

  float note;
  float tuneSemi;
  float tuneCent;

  float filterCutoff;
  float filterEnvAmount;
  float pitchEnvAmount; 

  dur amp_A;
  dur amp_D;
  float amp_S;
  dur amp_R;

  dur filt_A;
  dur filt_D;
  float filt_S;
  dur filt_R;

  dur pitch_A;
  dur pitch_D;
  float pitch_S;
  dur pitch_R;

  fun string serialize() {
    // TODO: why is there a nan value for filter release??
    ";" => string serial;
    
    note +=> serial;
    ";" +=> serial;
    tuneSemi +=> serial;
    ";" +=> serial;
    tuneCent +=> serial;
    ";" +=> serial;
    filterCutoff +=> serial;
    ";" +=> serial;
    filterEnvAmount +=> serial;
    ";" +=> serial;
    pitchEnvAmount +=> serial;
    ";" +=> serial;

    amp_A/samp +=> serial;
    ";" +=> serial;
    amp_D/samp +=> serial;
    ";" +=> serial;
    amp_S +=> serial;
    ";" +=> serial;
    if (Math.isnan(amp_R/samp)){
      0.0000 +=> serial;
    } else {
      amp_R/samp +=> serial;
    }
    amp_R/samp +=> serial;
    ";" +=> serial;
    filt_A/samp +=> serial;
    ";" +=> serial;
    filt_D/samp +=> serial;
    ";" +=> serial;
    filt_S +=> serial;
    if (Math.isnan(filt_R/samp)){
      0.0000 +=> serial;
    } else {
      filt_R/samp +=> serial;
    }
    ";" +=> serial;
    filt_R/samp +=> serial;
    ";" +=> serial;
    pitch_A/samp +=> serial;
    ";" +=> serial;
    pitch_D/samp +=> serial;
    ";" +=> serial;
    pitch_S +=> serial;
    ";" +=> serial;
    if (Math.isnan(filt_R/samp)){
      0.0000 +=> serial;
    } else {
      pitch_R/samp +=> serial;
    }
    ";" +=> serial;
    
    return serial;
  } 

}