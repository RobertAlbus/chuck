public class OscSynthMemento {

  // TODO
  /*
  - filt and pitch release are providing `-nan` value!
  - this is because sustain is set to 0. weird bug.
    - I don't like the conditional check. It's lossy, we have no R value now even if it was set.
    - when creating the memento, we should hold the old S value, switch it to 1, record Release, swap back
    - does this work?

    fixed this by just checking for nan
  */

  ////////
  // NEW VERSION
  string _propNames[0];
  string _properties[0];

  fun void set(string key, string value) {
    _propNames << key;
    value => _properties[key];
  }

  fun void set(string key, float value) {
    string stringifiedValue;
    value +=> stringifiedValue;
    set(key, stringifiedValue);
  }

  fun void set(string key, dur value) {
    string stringifiedValue;
    value/samp => float samples; 

    if (Math.isnan(samples)) {
      0.0000 +=> stringifiedValue;
    } else {
      samples +=> stringifiedValue;
    }
    set(key, stringifiedValue);
  }

  fun string get(string key) {
    return _properties[key];
  }
  fun float getF(string key) {
    return get(key).toFloat();
  }
  fun int getI(string key) {
    return get(key).toInt();
  }
  fun dur getD(string key) {
    return get(key).toFloat()::samp;
  }

  fun string serialize2() {
    ";" => string preset;
    for (0 => int i; i < _propNames.size(); i++) {
      _propNames[i] => string key;
      _properties[key] => string value;

      key +=> preset;
      "=" +=> preset;
      value +=> preset;
      ";" +=> preset;
    }
    return preset;
  }

  fun void deserialize(string preset) {
    // ;gain=0.5000;cutoff=200.0000;name=Ruthless;for=OscSynthSingle;

    // split on delimiters ';';
    // split on assigner '='

    //  split(myPreset, ";") @=> string settings[];
    //  settings.foreach=>  split(setting, "=")[0] => string key;
    //                      split(setting, "=")[1] => string value;
    //                      value => _properties[key];

  }

  ////////
  // OLD VERSION (IN USE BY OscSynthSingle)
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
    if (Math.isnan(filt_R/samp)) {
      0.0000 +=> serial;
    } else {
      filt_R/samp +=> serial;
    }
    ";" +=> serial;
    
    pitch_A/samp +=> serial;
    ";" +=> serial;
    pitch_D/samp +=> serial;
    ";" +=> serial;
    pitch_S +=> serial;
    ";" +=> serial;
    if (Math.isnan(pitch_R/samp)){
      0.0000 +=> serial;
    } else {
      pitch_R/samp +=> serial;
    }
    ";" +=> serial;
    
    return serial;
  } 

}