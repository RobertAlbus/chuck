public class SingleOscSynth extends Chugen {
  ////////
  // TODO
  /*
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
  _osc => ADSR _oscEnv => LPF _filter => Gain _output => blackhole;

  0 => float _note;
  
  0 => float _tuneSemi;
  0 => float _tuneCent;

  // Filter Envelope
  AdsrController _filterEnv;
  float _filterCutoff;
  float _filterEnvAmount;

  init();

  fun float tick( float in ) {
    tickFilter();
    return _output.last();
  }

  fun void tickFilter() {
    (_filterEnvAmount * _filterEnv.last()) + _filterCutoff => _filter.freq;
  }

  fun void init() {
    note(_notes.C5);
    20000 => _filterCutoff;
    0 => _filterEnvAmount;
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
    return _tuneSemi;
  }
  fun float tuneSemi(int semitones) {
    semitones => _tuneSemi;
    _setFreq();
    return _tuneSemi;
  }

  fun float tuneCent() {
    return _tuneCent;
  }
  fun float tuneCent(float semitones) {
    semitones => _tuneCent;
    _setFreq();
    return _tuneCent;
  }

  fun void _setFreq() {
    Std.mtof(_note + _tuneSemi + (_tuneCent / 100)) => _osc.freq;
  }

  // KEY CONTROL
  fun void keyOn() {
    _oscEnv.keyOn();
    _filterEnv.keyOn();
  }
  fun void keyOn(int midiNote) {
    note(midiNote);
    _oscEnv.keyOn();
    _filterEnv.keyOn();
  }
  fun void keyOff() {
    _oscEnv.keyOff();
    _filterEnv.keyOff();
  }

  // SET ADSRs
  fun void setAdsr_Amp(dur A, dur D, float S, dur R) {
    _oscEnv.set(A,D,S,R);
  }
  fun void setAdsr_Filt(dur A, dur D, float S, dur R) {
    _filterEnv.adsr.set(A,D,S,R);
  }
}