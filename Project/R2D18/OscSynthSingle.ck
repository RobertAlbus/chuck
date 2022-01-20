public class OscSynthSingle extends OscSynth {
  ////////
  // TODO
  /*
  - create LfoController
    - might want an ADSR over top of the Lfo for more advanced articulation? 
  - Add serialization and string parsing to memoization
  */

  Time _time;
  MidiNotes _notes;
  OscSynthMementos _mementos;

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
    memento(_mementos.default);
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

  fun string oscType(string oscType) {
    _osc @=> Osc _oldOsc;
    _disconnectOsc();
    oscType.lower() => _oscType;
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

  fun OscSynthMemento memento() {
    OscSynthMemento memo;
    
    _oscType        => memo.oscType;
    _note           => memo.note;
    _tuneSemi       => memo.tuneSemi;
    _tuneCent       => memo.tuneCent;
    _filterCutoff   => memo.filterCutoff;

    _pitchEnvAmount   => memo.pitchEnvAmount;
    _filterEnvAmount  => memo.filterEnvAmount;

    _oscEnv.attackTime()    => memo.amp_A;
    _oscEnv.decayTime()     => memo.amp_D;
    _oscEnv.sustainLevel()  => memo.amp_S;
    _oscEnv.releaseTime()   => memo.amp_R;

    _filterEnv.adsr.attackTime()    => memo.filt_A;
    _filterEnv.adsr.decayTime()     => memo.filt_D;
    _filterEnv.adsr.sustainLevel()  => memo.filt_S;
    _filterEnv.adsr.releaseTime()   => memo.filt_R;

    _pitchEnv.adsr.attackTime()   => memo.pitch_A;
    _pitchEnv.adsr.decayTime()    => memo.pitch_D;
    _pitchEnv.adsr.sustainLevel() => memo.pitch_S;
    _pitchEnv.adsr.releaseTime()  => memo.pitch_R;

    return memo;
  }
  fun OscSynthMemento memento(OscSynthMemento memo) {
    memo.oscType      => _oscType;
    oscType(_oscType);

    memo.note         => _note;
    memo.tuneSemi     => _tuneSemi;
    memo.tuneCent     => _tuneCent;
    memo.filterCutoff => _filterCutoff;

    memo.pitchEnvAmount  => _pitchEnvAmount;
    memo.filterEnvAmount => _filterEnvAmount;

    memo.amp_A => _oscEnv.attackTime;
    memo.amp_D => _oscEnv.decayTime;
    memo.amp_S => _oscEnv.sustainLevel;
    memo.amp_R => _oscEnv.releaseTime;

    _oscEnv.set(
      memo.amp_A,
      memo.amp_D,
      memo.amp_S,
      memo.amp_R
    );

    _filterEnv.adsr.set(
      memo.filt_A,
      memo.filt_D,
      memo.filt_S,
      memo.filt_R
    );

    _pitchEnv.adsr.set(
      memo.pitch_A,
      memo.pitch_D,
      memo.pitch_S,
      memo.pitch_R
    );

  }
}