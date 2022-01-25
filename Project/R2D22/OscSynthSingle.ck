public class OscSynthSingle extends OscSynthBase {
  ////////
  // TODO
  /*
  - create LfoController
    - might want an ADSR over top of the Lfo for more advanced articulation? 
  - Add ADSR for filter resonance
  - can I add delay/offset to an ADSR?
    - probably yeah, with a Delay ugen

  */

  Time _time;
  MidiNotes _notes;
  "OscSynthSingle" => string _constructName;
  string patchName;
  //OscSynthSinglePresets _presets;

  // Osc, amplitude, filter
  Osc _osc;
  string _oscType;

  ADSR _oscEnv => LPF _filter => Gain _output => blackhole;

  // Pitch 
  AdsrController _pitchEnv;
  float _pitchEnvAmount; // hz
  float _note;
  float _tuneSemi;
  float _tuneCent;

  // Filter Envelope
  AdsrController _filterCutoffEnv;
  float _filterCutoff;
  float _filterCutoffEnvAmount;

  init();

  fun float tick( float in ) {
    tickFilter();
    tickPitch();
    return _output.last();
  }

  fun void tickFilter() {
    (_filterCutoffEnvAmount * _filterCutoffEnv.last()) + _filterCutoff => _filter.freq;
  }
  fun void tickPitch() {
    _note + _tuneSemi + (_tuneCent / 100) => float tunedNote;
    _pitchEnv.last() * _pitchEnvAmount => float envOffset;
    Std.mtof(tunedNote)  + envOffset => _osc.freq;
  }

  fun void init() {
    // TODO: add default preset and initialize with it
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

  fun float output() {
    return _output.gain();  
  }
  fun float output(float g) {
    _output.gain(g);
    return _output.gain();  
  }

  // KEY CONTROL
  fun void keyOn() {
    _oscEnv.keyOn();
    _filterCutoffEnv.keyOn();
    _pitchEnv.keyOn();
  }
  fun void keyOn(int midiNote) {
    note(midiNote);
    _oscEnv.keyOn();
    _filterCutoffEnv.keyOn();
    _pitchEnv.keyOn();
  }
  fun void keyOff() {
    _oscEnv.keyOff();
    _filterCutoffEnv.keyOff();
    _pitchEnv.keyOff();
  }

  // SET ADSRs
  fun void setAdsr_Amp(dur A, dur D, float S, dur R) {
    _oscEnv.set(A,D,S,R);
  }
  fun void setAdsr_Filt(dur A, dur D, float S, dur R) {
    _filterCutoffEnv.adsr.set(A,D,S,R);
  }
  fun void setAdsr_Pitch(dur A, dur D, float S, dur R) {
    _pitchEnv.adsr.set(A,D,S,R);
  }

  fun string oscType(string oscType) {
    oscType.lower() => oscType;
    oscType.lower() => _oscType;

    _osc @=> Osc _oldOsc;
    _disconnectOsc();
    if (oscType == "sine" || oscType == "sin") {
      new SinOsc @=> _osc;
    }
    else if (oscType == "saw") {
      new SawOsc @=> _osc;
    }
    else if (oscType == "square" || oscType == "sqr") {
      new SqrOsc @=> _osc;
    }
    else if (oscType == "triangle" || oscType == "tri") {
      new TriOsc @=> _osc;
    }
    else {
      _oldOsc @=> _osc;
    }
    _connectOsc();
  }

  fun string oscType() {
    return _oscType;
  }

  fun void _disconnectOsc() {
    _osc =< _oscEnv;
  }
  fun void _connectOsc() {
    _osc => _oscEnv;
  }

  fun KeyValueStore preset() {
    KeyValueStore preset;

    preset.set("patchName", patchName);
    preset.set("for", _constructName);

    preset.set("oscType", _oscType);
    preset.set("gain", output());

    preset.set("note", _note);
    preset.set("tuneSemi", _tuneSemi);
    preset.set("tuneCent", _tuneCent);

    preset.set("filterCutoff", _filterCutoff);

    preset.set("filterEnvAmount", _filterCutoffEnvAmount);
    preset.set("pitchEnvAmount", _pitchEnvAmount);

    preset.set("ampEnv_A", _oscEnv.attackTime());
    preset.set("ampEnv_D", _oscEnv.decayTime());
    preset.set("ampEnv_S", _oscEnv.sustainLevel());
    preset.set("ampEnv_R", _oscEnv.releaseTime());

    preset.set("filterEnv_A", _filterCutoffEnv.adsr.attackTime());
    preset.set("filterEnv_D", _filterCutoffEnv.adsr.decayTime());
    preset.set("filterEnv_S", _filterCutoffEnv.adsr.sustainLevel());
    preset.set("filterEnv_R", _filterCutoffEnv.adsr.releaseTime());    

    preset.set("pitchEnv_A", _pitchEnv.adsr.attackTime());
    preset.set("pitchEnv_D", _pitchEnv.adsr.decayTime());
    preset.set("pitchEnv_S", _pitchEnv.adsr.sustainLevel());
    preset.set("pitchEnv_R", _pitchEnv.adsr.releaseTime());

    return preset;
  }

  fun KeyValueStore preset(string presetString) {
    KeyValueStore presetObject;
    presetObject.deserialize(presetString);
    preset(presetObject);
  }
  
  fun KeyValueStore preset(KeyValueStore preset) {

    if ( preset.get("for") != _constructName ) {
      <<< "Cannot open preset for", _constructName, "because it does not have a \"for\" property that matches " >>>;
      me.exit();
    }

    preset.get("patchName") => patchName;

    preset.get("oscType") =>  _oscType;
    oscType(_oscType);
    preset.getF("gain") => output;

    preset.getF("note") =>  _note;
    preset.getF("tuneSemi") =>  _tuneSemi;
    preset.getF("tuneCent") =>  _tuneCent;

    preset.getF("filterCutoff") =>  _filterCutoff;

    preset.getF("filterEnvAmount") =>  _filterCutoffEnvAmount;
    preset.getF("pitchEnvAmount") =>  _pitchEnvAmount;

    _oscEnv.set(
      preset.getD("ampEnv_A"),
      preset.getD("ampEnv_D"),
      preset.getF("ampEnv_S"),
      preset.getD("ampEnv_R")
    );

    _filterCutoffEnv.adsr.set(
      preset.getD("filterEnv_A"),
      preset.getD("filterEnv_D"),
      preset.getF("filterEnv_S"),
      preset.getD("filterEnv_R")
    );

    _pitchEnv.adsr.set(
      preset.getD("pitchEnv_A"),
      preset.getD("pitchEnv_D"),
      preset.getF("pitchEnv_S"),
      preset.getD("pitchEnv_R")
    );
  }

}
