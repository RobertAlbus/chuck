public class OscSynthMulti extends OscSynthBase {
  Time _time;
  MidiNotes _notes;
  OscSynthMementos _mementos;
  Gain _output => blackhole;

  OscSynthSingle _oscs[0];
  init();

  fun float tick(float in) {
    return _output.last();
  }

  fun void init() {
    createOscs(3);
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

  fun void createOscs(int quantity) {
    if (quantity > _oscs.size()) {
      quantity - _oscs.size() => quantity;
      for (0 => int i; i < quantity; i++) {
        _oscs << new OscSynthSingle;
      }
    } else if (quantity < _oscs.size()) {
      _oscs.size(quantity);
    }
    _connectOscs();
  }

  fun KeyValueStore[] memento() {
    KeyValueStore mementos[0];
    for (0 => int i; i < _oscs.size(); i++) {
      mementos << _oscs[i].memento();
    }

  }
  fun KeyValueStore[] memento(KeyValueStore mementos[]) {
    _disconnectOscs();
    createOscs(0);
    for (0 => int i; i < mementos.size(); i++) {
      OscSynthSingle newOsc;
      newOsc.memento(mementos[i]);
      _oscs << newOsc;
    }
    _connectOscs();
  }

  fun void _connectOscs() {
    for (0 => int i; i < _oscs.size(); i++) {
      _oscs[i] => _output;
    }
  }

  fun void _disconnectOscs() {
    for (0 => int i; i < _oscs.size(); i++) {
      _oscs[i] =< _output;
    }
  }

}