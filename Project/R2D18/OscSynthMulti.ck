public class OscSynthMulti extends OscSynthBase {
  Time _time;
  MidiNotes _notes;
  OscSynthMementos _mementos;
  Gain _output => blackhole;

  OscSynthSingle _oscs[0];
  _oscs << new OscSynthSingle;
  _oscs << new OscSynthSingle;

  for (0 => int i; i < _oscs.size(); i++) {
    _oscs[i] => _output;
  }

  fun float tick(float in) {
    return _output.last();
  }

  fun void keyOn() {
    for (0 => int i; i < _oscs.size(); i++) {
      _oscs[i].keyOn();
    }
  }
  fun void keyOn(int midiNote) {
    for (0 => int i; i < _oscs.size(); i++) {
      _oscs[i].keyOn(midiNote);
    }
  }
  fun void keyOff() {
    for (0 => int i; i < _oscs.size(); i++) {
      _oscs[i].keyOff();
    }
  }


  

}