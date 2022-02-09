public class AdsrController {
  Step basis => ADSR adsr => Gain modMix => blackhole;
  1 => basis.next;

  fun float last() {
    return modMix.last();
  }

  fun void keyOn() {
    adsr.keyOn();
  }
  
  fun void keyOff() {
    adsr.keyOff();
  }

  fun void set(dur A, dur D, float S, dur R){
    (A,D,S,R) => adsr.set;
  }
}