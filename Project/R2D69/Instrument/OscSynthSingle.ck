public class OscSynthSingle extends Instrument {

  Time _time;
  MidiNotes notes;
  string patchName;

  Osc osc;
  string _oscType;

  ADSR adsrAmp => LPF lpf => Gain output => blackhole;

  // Pitch 
  AdsrController adsrPitch;
  float adsrPitchAmount; // hz
  float _note;
  float tuneSemi;
  float tuneCent;

  // Filter Envelope
  AdsrController adsrLpfCutoff;
  float lpfCutoff;
  float adsrLpfCutoffAmount;

  AdsrController adsrLpfQ;
  1 => float lpfQ;
  float adsrLpfQAmount;

  1 => int shouldRetrigger;

  init();

  fun float tick( float in ) {
    tickFilter();
    tickPitch();
    return output.last();
  }

  fun void tickFilter() {
    (adsrLpfCutoffAmount * adsrLpfCutoff.last()) + lpfCutoff => lpf.freq;    
    (adsrLpfQAmount * adsrLpfQ.last()) + lpfQ => lpf.Q;
  }
  fun void tickPitch() {
    _note + tuneSemi + (tuneCent / 100) => float tunedNote;
    adsrPitch.last() * adsrPitchAmount => float envOffset;
    Std.mtof(tunedNote) + envOffset => osc.freq;
  }

  fun void init() {
    "sine" => oscType;
  }

  // NOTE
  fun void note(float midiNote) {
    midiNote => _note;
  }

  // KEY CONTROL
  fun void keyOn() {
    adsrAmp.keyOn();
    adsrLpfCutoff.keyOn();
    adsrLpfQ.keyOn();
    adsrPitch.keyOn();
    if(shouldRetrigger) osc.phase(0);
  }
  fun void keyOn(float midiNote) {
    note(midiNote);
    keyOn();
  }
  fun void keyOff() {
    adsrAmp.keyOff();
    adsrLpfCutoff.keyOff();
    adsrLpfQ.keyOff();
    adsrPitch.keyOff();
  }

  fun string oscType(string type) {
    type.lower() => _oscType;

    osc @=> Osc _oldOsc;
    _disconnectOsc();
    if (_oscType == "sine" || _oscType == "sin") {
      new SinOsc @=> osc;
    }
    else if (_oscType == "saw") {
      new SawOsc @=> osc;
    }
    else if (_oscType == "square" || _oscType == "sqr") {
      new SqrOsc @=> osc;
    }
    else if (_oscType == "triangle" || _oscType == "tri") {
      new TriOsc @=> osc;
    }
    else {
      _oldOsc @=> osc;
    }
    _connectOsc();
  }

  fun void _disconnectOsc() {
    osc =< adsrAmp;
  }
  fun void _connectOsc() {
    osc => adsrAmp;
  }

}
