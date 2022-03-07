public class StereoChannel extends StereoProcessor {

  inL => Gain panL => Gain muteL => outL;
  inR => Gain panR => Gain muteR => outR;
      
  fun void pan(float panVal) {
    1  => float R;
    -1 => float L;
    0  => float C;

    Math.fabs(panVal) => float panAmount;
    Math.sgn(panVal) => float direction;
    if(direction == R) {
      1 - panAmount => panL.gain;
    } else if(direction == L) {
      1 - panAmount => panR.gain;
    }
  }

  fun void mute() {
    0 => muteL.gain;
    0 => muteR.gain;
  }
  fun void unmute() {
    1 => muteL.gain;
    1 => muteR.gain;
  }

  fun void gain(float g) {
    g => inL.gain;
    g => inR.gain;
  }

  fun void stereoMerge(float mergeAmount) {
    inL => Gain feedLR => inR; 
    inR => Gain feedRL => inL;

    mergeAmount => feedLR.gain;
    mergeAmount => feedRL.gain;
  }

  fun void update(float L, float R) {
    // nothing to do but must reimplement from base class 
  }

}