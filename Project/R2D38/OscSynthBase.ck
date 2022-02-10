public class OscSynthBase extends Chugen implements Keyable {


  fun float tick( float in ) {
    <<< "OscSynth: tick" >>>;
    return 0.0;
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

  // KEY CONTROL
  fun void keyOn() {
    <<< "OscSynth: set key on" >>>;
  }
  fun void keyOn(float midiNote) {
    <<< "OscSynth: set key on with note" >>>;
  }
  fun void keyOff() {
    <<< "OscSynth: set key off" >>>;
  }

}