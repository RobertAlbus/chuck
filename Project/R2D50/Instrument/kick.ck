public class Kick extends Instrument {

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
  }

  fun void keyOn(float _note) {
    for (0 => int i; i < synths.size(); i++) {
      synths[i].keyOn(_note);
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

  fun void note(float n) {
    
  }
}
