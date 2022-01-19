public class SingleOscSynth extends Chugen {
  ////////
  // TODO
  /*
  - prefix all member variables with underscore
  - add getter and setter methods for required member variables
  - standardize on a variable naming scheme (camel case, underscore, etc)
  - add methods for changing the Osc type
  - add pitch ADSR
  - create LfoController
    - might want an ADSR over top of the Lfo for more advanced articulation? 
  - create a base class OscSynth that mono and poly versions can inherit from
    - can add all the requite methods that print a string with the method name
    - this will help me see if I haven't implemented a method on a subclass 
  */

  Time _time;
  MidiNotes _notes;

  // Osc, amplitude, filter
  Osc _osc;

  SqrOsc sin @=> _osc; 
  _osc => ADSR _osc_env => LPF _filter => Gain _output => blackhole;

  0 => float _note;
  
  0 => float _tune_semi;
  0 => float _tune_cent;

  // Filter Envelope
  AdsrController _filter_env;
  float _filter_freq_base;
  float _filter_freq_top;
  float _filter_freq_range;

  init();

  fun float tick( float in ) {
    tickFilter();
    return _output.last();
  }

  fun void tickFilter() {
    (_filter_freq_range * _filter_env.last()) + _filter_freq_base => _filter.freq;
  }

  fun void init() {
    note(_notes.C5);
    20000 => filterFreqBase;
    20000 => filterFreqTop;
    setAdsr_Amp(
      0.1::_time.quat,
      0::_time.quat,
      1,
      0.1::_time.quat
    );
    setAdsr_Filt(
      0.1::_time.quat,
      0::_time.quat,
      1,
      0.1::_time.quat
    );
  }

  // NOTE
  fun float note() {
    return Std.ftom(_osc.freq());
  }

  fun float note(float midiNote) {
    midiNote => _note;
    _setFreq();
    return Std.ftom(_osc.freq());
  }

  // TUNING
  fun float tuneSemi() {
    return _tune_semi;
  }
  fun float tuneSemi(int semitones) {
    semitones => _tune_semi;
    _setFreq();
    return _tune_semi;
  }

  fun float tuneCent() {
    return _tune_cent;
  }
  fun float tuneCent(float semitones) {
    semitones => _tune_cent;
    _setFreq();
    return _tune_cent;
  }

  fun void _setFreq() {
    Std.mtof(_note + _tune_semi + (_tune_cent / 100)) => _osc.freq;
  }

  // KEY CONTROL
  fun void keyOn() {
    _osc_env.keyOn();
    _filter_env.keyOn();
  }
  fun void keyOn(int midiNote) {
    note(midiNote);
    _osc_env.keyOn();
    _filter_env.keyOn();
  }
  fun void keyOff() {
    _osc_env.keyOff();
    _filter_env.keyOff();
  }

  // SET ADSRs
  fun void setAdsr_Amp(dur A, dur D, float S, dur R) {
    _osc_env.set(A,D,S,R);
  }
  fun void setAdsr_Filt(dur A, dur D, float S, dur R) {
    _filter_env.adsr.set(A,D,S,R);
  }
}