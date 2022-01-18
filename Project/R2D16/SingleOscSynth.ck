public class SingleOscSynth extends Chugen {
  Time _time;
  MidiNotes _notes;

  // Osc and Amp
  Osc osc;
  SqrOsc sin @=> osc; 
  osc => ADSR osc_env;

  _notes.C5 => float _note;
  0 => float _tune_semi;
  0 => float _tune_cent;

  // Filter Envelope
  AdsrController filter_env;
  30 => int filerFreqBase;
  600 => int filterFreqTop;
  filterFreqTop - filerFreqBase => int filterRange;


  osc_env => LPF lpf => Gain output => blackhole;

  init();

  fun float tick( float in ) {
    (filterRange * filter_env.last()) + filerFreqBase => lpf.freq;
    return output.last();
  }

  fun void init() {
    setAdsr_Amp(
      0.1::_time.quat,
      4::_time.quat,
      0.5,
      2::_time.quat
    );
    setAdsr_Filt(
      0::_time.quat,
      3::_time.quat,
      0.1,
      2::_time.quat
    );
  }

  // NOTE
  fun float note() {
    return Std.ftom(osc.freq());
  }

  fun float note(float midiNote) {
    midiNote => _note;
    _setFreq();
    return Std.ftom(osc.freq());
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
  fun float tuneSemi(float semitones) {
    semitones => _tune_cent;
    _setFreq();
    return _tune_cent;
  }

  fun void _setFreq() {
    Std.mtof(_note + _tune_semi + (_tune_cent / 100)) => osc.freq;
  }

  // KEY CONTROL
  fun void keyOn() {
    osc_env.keyOn();
    filter_env.keyOn();
  }
  fun void keyOn(int midiNote) {
    note(midiNote);
    osc_env.keyOn();
    filter_env.keyOn();
  }
  fun void keyOff() {
    osc_env.keyOff();
    filter_env.keyOff();
  }

  // SET ADSRs
  fun void setAdsr_Amp(dur A, dur D, float S, dur R) {
    osc_env.set(A,D,S,R);
  }
  fun void setAdsr_Filt(dur A, dur D, float S, dur R) {
    filter_env.adsr.set(A,D,S,R);
  }
}