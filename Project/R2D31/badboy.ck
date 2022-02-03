public class Badboy extends Chugen {

  60 => float basenote;

  float _oscRatio;
  SawOsc osc => LPF modLpf => LPF envLpf => ADSR adsr => Gain output => blackhole;
  AdsrController lpfEnv;
  1 => float lpfEnvAmount;
  1000 => float lpfFreq;

  1 => float _modRatio;
  500 => float modAmount;
  500 => float modOffset;
  SawOsc mod => Gain modSum => blackhole;

  fun float tick( float in ) {
    // set lpf cutoff from mod value
    Math.max(
      (modSum.last() * modAmount) + modOffset,
      0
     ) => modLpf.freq;

    (lpfEnvAmount * lpfEnv.last()) + lpfFreq => envLpf.freq;

    return output.last();
  }

  fun void keyOn(float note) {
    note => basenote;
    _setFreq_Osc();
    _setFreq_Mod();
    adsr.keyOn();
    lpfEnv.keyOn();
  }
  fun void keyOff() {
    adsr.keyOff();
  }

  fun void setRatio_Pitch(float ratio) {
    ratio => _oscRatio;
    _setFreq_Osc(); 
  }
  fun void setRatio_Mod(float ratio) {
    ratio => _modRatio;
    _setFreq_Mod();
  }
  fun void setGain_Mod(float g) {
    g => modSum.gain;
  }

  fun void _setFreq_Osc() {
    Std.mtof(basenote) * _oscRatio => osc.freq; 
  }
  fun void _setFreq_Mod() {
    Std.mtof(basenote) * _modRatio => mod.freq;
  }

}