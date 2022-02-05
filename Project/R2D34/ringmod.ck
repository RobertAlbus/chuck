public class RingMod extends Chugen {
  MidiNotes _notes;

  SqrOsc osc => ADSR adsr => Gain oscMix => blackhole;
  SqrOsc mod => Gain modMix => blackhole;

  // GLOBAL VARS
  _notes.F2 => float baseNote;
  1 => float oscRatio;
  1 => float modRatio;


  fun float tick(float in) {
    // <<< oscRatio, modRatio, osc.freq(),mod.freq()>>>;
    return oscMix.last() * modMix.last();
  }

  fun void keyOn(float note) {
    note => baseNote;
    setFreqs();
    adsr.keyOn();
  }

  fun void keyOff() {
    adsr.keyOff();
  }

  fun void setRatio_Osc(float ratio){
    ratio => oscRatio;
    setFreqs();
  }
  fun void setRatio_Mod(float ratio){
    ratio => modRatio;
    setFreqs();
  }

  fun void setFreqs() {
    baseNote * oscRatio => osc.freq;
    baseNote * modRatio => mod.freq;
  }

}