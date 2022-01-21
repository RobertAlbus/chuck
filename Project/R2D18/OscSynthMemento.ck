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
  float pitchEnvAmount; 
  float filterEnvAmount;

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

}