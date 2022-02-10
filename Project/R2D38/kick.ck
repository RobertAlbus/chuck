public class Kick extends Chugen implements Keyable {

  OscSynthSingle synths[2];
  Gain synthBus => ADSR adsr => Gain out => blackhole;
  
  init();

  fun float tick(float in) {
    return out.last();
  }

  fun void init() {
    for (0 => int i; i < synths.size(); i++) {
      synths[i] => synthBus;
    } 
    1.0/synths.size() $float => synthBus.gain;

    (0::ms, 200::ms, 1, 20::ms) => adsr.set;

    (0::ms, 200::ms, 0, 20::ms) => synths[0].adsrAmp.set;
    (0::ms, 40::ms, 0, 20::ms)  => synths[0].adsrLpfCutoff.set;
    (0::ms, 10::ms, 0, 20::ms)  => synths[0].adsrPitch.set;
    1000  => synths[0].adsrPitchAmount;
    -36   => synths[0].tuneSemi;
    100   => synths[0].lpfCutoff;
    500   => synths[0].adsrLpfCutoffAmount;
    "sqr" => synths[0].oscType;

    (0::ms, 30::ms, 0, 20::ms)  => synths[1].adsrAmp.set;
    (0::ms, 40::ms, 0, 20::ms)  => synths[1].adsrLpfCutoff.set;
    (10::ms, 10::ms, 0, 20::ms) => synths[1].adsrPitch.set;
    10000  => synths[1].adsrPitchAmount;
    -28   => synths[1].tuneSemi;
    250   => synths[1].lpfCutoff;
    500   => synths[1].adsrLpfCutoffAmount;
    "saw" => synths[1].oscType;

    0.8 => out.gain;
  }

  fun void keyOn(float note) {
    for (0 => int i; i < synths.size(); i++) {
      synths[i].keyOn(note);
    }
    adsr.keyOn();
  }
  fun void keyOn() {
    for (0 => int i; i < synths.size(); i++) {
      synths[i].keyOn();
    }
    adsr.keyOn();
  }
  fun void keyOff() {
    for (0 => int i; i < synths.size(); i++) {
      synths[i].keyOff();
    }
    adsr.keyOff();
  }
}
