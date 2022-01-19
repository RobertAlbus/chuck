public class SingleOscSynth extends Chugen {
  ////////
  // TODO
  /*
  - add methods for changing the Osc type
  - create LfoController
    - might want an ADSR over top of the Lfo for more advanced articulation? 
  - create a base class OscSynth that Single and Multi versions can inherit from
    - can add all the requite methods that print a string with the method name
    - this will help me see if I haven't implemented a method on a subclass 
    - should the Mutli version have master filter/envelopes/etc? - not for now
    - create polyphonic version of MultiOscSynth
  - create "presets" functionality with memoization
    - create a minimal class called SingleOscSynthPatch for all props
    - create an init function that accepts an arg of this type
  */

  Time _time;
  MidiNotes _notes;

  // Osc, amplitude, filter
  Osc _osc;

  SqrOsc sin @=> _osc; 
  _osc => ADSR _oscEnv => LPF _filter => Gain _output => blackhole;

  // Pitch 
  AdsrController _pitchEnv;
  float _pitchEnvAmount; // hz
  float _note;
  float _tuneSemi;
  float _tuneCent;

  // Filter Envelope
  AdsrController _filterEnv;
  float _filterCutoff;
  float _filterEnvAmount;

  init();

  fun float tick( float in ) {
    tickFilter();
    tickPitch();
    return _output.last();
  }

  fun void tickFilter() {
    (_filterEnvAmount * _filterEnv.last()) + _filterCutoff => _filter.freq;
  }
  fun void tickPitch() {
    _note + _tuneSemi + (_tuneCent / 100) => float tunedNote;
    _pitchEnv.last() * _pitchEnvAmount => float envOffset;
    Std.mtof(tunedNote)  + envOffset => _osc.freq;
  }

  fun void init() {
    note(_notes.C5);
    200 => _filterCutoff;
    2000 => _filterEnvAmount;
    0 => _pitchEnvAmount;
    setAdsr_Amp(
      0.01::_time.quat,
      2::_time.quat,
      0.8,
      0.1::_time.quat
    );
    setAdsr_Filt(
      0::_time.quat,
      2::_time.quat,
      0.4,
      0.1::_time.quat
    );
    setAdsr_Pitch(
      0::_time.quat,
      0::_time.quat,
      0,
      0.1::_time.quat
    );
  }

  // NOTE
  fun float note() {
    return Std.ftom(_osc.freq());
  }

  fun float note(float midiNote) {
    midiNote => _note;
    return Std.ftom(_osc.freq());
  }

  // TUNING
  fun float tuneSemi() {
    return _tuneSemi;
  }
  fun float tuneSemi(int semitones) {
    semitones => _tuneSemi;
    return _tuneSemi;
  }

  fun float tuneCent() {
    return _tuneCent;
  }
  fun float tuneCent(float semitones) {
    semitones => _tuneCent;
    return _tuneCent;
  }


  // KEY CONTROL
  fun void keyOn() {
    _oscEnv.keyOn();
    _filterEnv.keyOn();
    _pitchEnv.keyOn();
  }
  fun void keyOn(int midiNote) {
    note(midiNote);
    _oscEnv.keyOn();
    _filterEnv.keyOn();
    _pitchEnv.keyOn();
  }
  fun void keyOff() {
    _oscEnv.keyOff();
    _filterEnv.keyOff();
    _pitchEnv.keyOff();
  }

  // SET ADSRs
  fun void setAdsr_Amp(dur A, dur D, float S, dur R) {
    _oscEnv.set(A,D,S,R);
  }
  fun void setAdsr_Filt(dur A, dur D, float S, dur R) {
    _filterEnv.adsr.set(A,D,S,R);
  }
  fun void setAdsr_Pitch(dur A, dur D, float S, dur R) {
    _pitchEnv.adsr.set(A,D,S,R);
  }
}