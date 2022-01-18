public class SingleOscSynth extends Chugen {
  Time _time;
  MidiNotes _notes;

  Osc osc;
  SinOsc sin @=> osc; 
  osc => ADSR osc_env => Gain output => blackhole;

  0 => int tune_semi;
  0 => int tune_cent;

  init();

  fun float tick( float in ) {
    return output.last();
  }

  fun void init() {
    note(_notes.F4);
    setAdsr(
      1::_time.quat,
      2::_time.quat,
      0.5,
      2::_time.quat
    );
  }

  fun float note() {
    return Std.ftom(osc.freq());
  }

  fun float note(float midiNote) {
    Std.mtof(midiNote + tune_semi + (tune_cent / 100)) => osc.freq;
    return Std.ftom(osc.freq());
  }

  fun void keyOn() {
    osc_env.keyOn();
  }
  fun void keyOff() {
    osc_env.keyOff();
  }

  fun void setAdsr(dur A, dur D, float S, dur R) {
    osc_env.set(A,D,S,R);
  }
}