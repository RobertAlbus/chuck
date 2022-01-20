public class OscSynth extends Chugen {


  fun float tick( float in ) {
    <<< "OscSynth: tick" >>>;
  }

  fun void tickFilter() {
    <<< "OscSynth: tick filter" >>>;
  }
  fun void tickPitch() {
    <<< "OscSynth: tick pitch" >>>;
  }

  fun void init() {
    <<< "OscSynth: init" >>>;
  }

  // NOTE
  fun float note() {
    <<< "OscSynth: get note" >>>;
  }

  fun float note(float midiNote) {
    <<< "OscSynth: set note" >>>;
  }

  // TUNING
  fun float tuneSemi() {
    <<< "OscSynth: get semitone tuning" >>>;
  }
  fun float tuneSemi(int semitones) {
    <<< "OscSynth: set semitone tuning" >>>;
  }

  fun float tuneCent() {
    <<< "OscSynth: get cent tuning" >>>;
  }
  fun float tuneCent(float semitones) {
    <<< "OscSynth: set cent tuning" >>>;
  }

  // KEY CONTROL
  fun void keyOn() {
    <<< "OscSynth: set key on" >>>;
  }
  fun void keyOn(int midiNote) {
    <<< "OscSynth: set key on with note" >>>;
  }
  fun void keyOff() {
    <<< "OscSynth: set key off" >>>;
  }

  fun OscSynthMemento memento() {
    <<< "OscSynth: get memento" >>>;
  }
  fun OscSynthMemento memento(OscSynthMemento memo) {
    <<< "OscSynth: set from memento" >>>;
  }

}