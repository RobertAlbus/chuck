public class SingleOscSynth extends Chugen {
  Time _time;
  MidiNotes _notes;

  // Osc and Amp
  Osc osc;
  SqrOsc sin @=> osc; 
  osc => ADSR osc_env;

  -24 => int tune_semi;
  0 => int tune_cent;

  // Filter Envelope
  Step filterBasis => ADSR filt_env => Gain filterModMix => blackhole;
  1 => filterBasis.next;
  30 => int filerFreqBase;
  600 => int filterFreqTop;
  filterFreqTop - filerFreqBase => int filterRange;


  osc_env => LPF lpf => Gain output => blackhole;

  init();

  fun float tick( float in ) {
    (filterRange * filterModMix.last()) + filerFreqBase => lpf.freq;
    return output.last();
  }

  fun void init() {
    note(_notes.F4);
    setAdsr_Amp(
      0.1::_time.quat,
      4::_time.quat,
      0.5,
      2::_time.quat
    );
    setAdsr_Filt(
      2::_time.quat,
      1::_time.quat,
      0.1,
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
    filt_env.keyOn();
  }
  fun void keyOff() {
    osc_env.keyOff();
    filt_env.keyOff();
  }

  fun void setAdsr_Amp(dur A, dur D, float S, dur R) {
    osc_env.set(A,D,S,R);
  }
  fun void setAdsr_Filt(dur A, dur D, float S, dur R) {
    filt_env.set(A,D,S,R);
  }
}