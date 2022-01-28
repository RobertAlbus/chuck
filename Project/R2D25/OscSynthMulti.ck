public class OscSynthMulti extends OscSynthBase {
  Time _time;
  MidiNotes _notes;
  Gain _output => blackhole;

  OscSynthSingle _oscs[0];

  float _tuneSemi;
  float _tuneCent;

  init();

  fun float tick(float in) {
    return _output.last();
  }

  fun void init() {
    createOscs(3);
    _oscs[0].tuneSemi(0);
    _oscs[1].tuneSemi(-12);
    _oscs[2].tuneSemi(-24);
  }

  fun void keyOn() {
    for (0 => int i; i < _oscs.size(); i++) {
      _oscs[i].keyOn();
    }
  }
  fun void keyOn(float midiNote) {
    for (0 => int i; i < _oscs.size(); i++) {
      _oscs[i].keyOn(midiNote + _tuneSemi + (_tuneCent / 100));
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

  fun KeyValueStore preset() {
    KeyValueStore preset;
    preset.configure("|", ":");

    for (0 => int i; i < _oscs.size(); i++) {
      "" => string key;
      i +=> key;
      preset.set(key, _oscs[i].preset().serialize()) ;
    }

    return preset;
  }

  fun KeyValueStore preset(string presetString) {
    KeyValueStore presetObject;
    presetObject.configure("|", ":");
    presetObject.deserialize(presetString);
    preset(presetObject);
  }

  fun KeyValueStore preset(KeyValueStore presetObject) {
    _disconnectOscs();
    createOscs(0);
    presetObject.configure("|", ":");
    for (0 => int i; i < presetObject.size(); i++) {
      OscSynthSingle newOsc;
      newOsc.preset(presetObject.get(i));
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